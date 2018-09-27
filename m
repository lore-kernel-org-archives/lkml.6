Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17132C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7102156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7102156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeI0PYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:24:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeI0PYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:24:50 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 178411112;
        Thu, 27 Sep 2018 09:07:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 07/88] udp4: fix IP_CMSG_CHECKSUM for connected sockets
Date:   Thu, 27 Sep 2018 11:02:48 +0200
Message-Id: <20180927090301.435535838@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 2b5a921740a55c00223a797d075b9c77c42cb171 ]

commit 2abb7cdc0dc8 ("udp: Add support for doing checksum
unnecessary conversion") left out the early demux path for
connected sockets. As a result IP_CMSG_CHECKSUM gives wrong
values for such socket when GRO is not enabled/available.

This change addresses the issue by moving the csum conversion to a
common helper and using such helper in both the default and the
early demux rx path.

Fixes: 2abb7cdc0dc8 ("udp: Add support for doing checksum unnecessary conversion")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |   49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2128,6 +2128,28 @@ static inline int udp4_csum_init(struct
 							 inet_compute_pseudo);
 }
 
+/* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
+ * return code conversion for ip layer consumption
+ */
+static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
+			       struct udphdr *uh)
+{
+	int ret;
+
+	if (inet_get_convert_csum(sk) && uh->check && !IS_UDPLITE(sk))
+		skb_checksum_try_convert(skb, IPPROTO_UDP, uh->check,
+					 inet_compute_pseudo);
+
+	ret = udp_queue_rcv_skb(sk, skb);
+
+	/* a return value > 0 means to resubmit the input, but
+	 * it wants the return to be -protocol, or 0
+	 */
+	if (ret > 0)
+		return -ret;
+	return 0;
+}
+
 /*
  *	All we need to do is get the socket, and then do a checksum.
  */
@@ -2174,14 +2196,9 @@ int __udp4_lib_rcv(struct sk_buff *skb,
 		if (unlikely(sk->sk_rx_dst != dst))
 			udp_sk_rx_dst_set(sk, dst);
 
-		ret = udp_queue_rcv_skb(sk, skb);
+		ret = udp_unicast_rcv_skb(sk, skb, uh);
 		sock_put(sk);
-		/* a return value > 0 means to resubmit the input, but
-		 * it wants the return to be -protocol, or 0
-		 */
-		if (ret > 0)
-			return -ret;
-		return 0;
+		return ret;
 	}
 
 	if (rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
@@ -2189,22 +2206,8 @@ int __udp4_lib_rcv(struct sk_buff *skb,
 						saddr, daddr, udptable, proto);
 
 	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
-	if (sk) {
-		int ret;
-
-		if (inet_get_convert_csum(sk) && uh->check && !IS_UDPLITE(sk))
-			skb_checksum_try_convert(skb, IPPROTO_UDP, uh->check,
-						 inet_compute_pseudo);
-
-		ret = udp_queue_rcv_skb(sk, skb);
-
-		/* a return value > 0 means to resubmit the input, but
-		 * it wants the return to be -protocol, or 0
-		 */
-		if (ret > 0)
-			return -ret;
-		return 0;
-	}
+	if (sk)
+		return udp_unicast_rcv_skb(sk, skb, uh);
 
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto drop;



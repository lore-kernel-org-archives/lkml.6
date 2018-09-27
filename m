Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34389C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6942152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6942152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeI0Pgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:36:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeI0Pgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:36:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D7C8110D;
        Thu, 27 Sep 2018 09:19:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/64] udp6: add missing checks on edumux packet processing
Date:   Thu, 27 Sep 2018 11:03:26 +0200
Message-Id: <20180927090251.011414762@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit eb63f2964dbe36f26deac77d3016791675821ded ]

Currently the UDPv6 early demux rx code path lacks some mandatory
checks, already implemented into the normal RX code path - namely
the checksum conversion and no_check6_rx check.

Similar to the previous commit, we move the common processing to
an UDPv6 specific helper and call it from both edemux code path
and normal code path. In respect to the UDPv4, we need to add an
explicit check for non zero csum according to no_check6_rx value.

Reported-by: Jianlin Shi <jishi@redhat.com>
Suggested-by: Xin Long <lucien.xin@gmail.com>
Fixes: c9f2c1ae123a ("udp6: fix socket leak on early demux")
Fixes: 2abb7cdc0dc8 ("udp: Add support for doing checksum unnecessary conversion")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/udp.c |   65 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -780,6 +780,28 @@ static void udp6_sk_rx_dst_set(struct so
 	}
 }
 
+/* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
+ * return code conversion for ip layer consumption
+ */
+static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
+				struct udphdr *uh)
+{
+	int ret;
+
+	if (inet_get_convert_csum(sk) && uh->check && !IS_UDPLITE(sk))
+		skb_checksum_try_convert(skb, IPPROTO_UDP, uh->check,
+					 ip6_compute_pseudo);
+
+	ret = udpv6_queue_rcv_skb(sk, skb);
+
+	/* a return value > 0 means to resubmit the input, but
+	 * it wants the return to be -protocol, or 0
+	 */
+	if (ret > 0)
+		return -ret;
+	return 0;
+}
+
 int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
@@ -831,13 +853,14 @@ int __udp6_lib_rcv(struct sk_buff *skb,
 		if (unlikely(sk->sk_rx_dst != dst))
 			udp6_sk_rx_dst_set(sk, dst);
 
-		ret = udpv6_queue_rcv_skb(sk, skb);
-		sock_put(sk);
+		if (!uh->check && !udp_sk(sk)->no_check6_rx) {
+			sock_put(sk);
+			goto report_csum_error;
+		}
 
-		/* a return value > 0 means to resubmit the input */
-		if (ret > 0)
-			return ret;
-		return 0;
+		ret = udp6_unicast_rcv_skb(sk, skb, uh);
+		sock_put(sk);
+		return ret;
 	}
 
 	/*
@@ -850,30 +873,13 @@ int __udp6_lib_rcv(struct sk_buff *skb,
 	/* Unicast */
 	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
 	if (sk) {
-		int ret;
-
-		if (!uh->check && !udp_sk(sk)->no_check6_rx) {
-			udp6_csum_zero_error(skb);
-			goto csum_error;
-		}
-
-		if (inet_get_convert_csum(sk) && uh->check && !IS_UDPLITE(sk))
-			skb_checksum_try_convert(skb, IPPROTO_UDP, uh->check,
-						 ip6_compute_pseudo);
-
-		ret = udpv6_queue_rcv_skb(sk, skb);
-
-		/* a return value > 0 means to resubmit the input */
-		if (ret > 0)
-			return ret;
-
-		return 0;
+		if (!uh->check && !udp_sk(sk)->no_check6_rx)
+			goto report_csum_error;
+		return udp6_unicast_rcv_skb(sk, skb, uh);
 	}
 
-	if (!uh->check) {
-		udp6_csum_zero_error(skb);
-		goto csum_error;
-	}
+	if (!uh->check)
+		goto report_csum_error;
 
 	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard;
@@ -894,6 +900,9 @@ short_packet:
 			    ulen, skb->len,
 			    daddr, ntohs(uh->dest));
 	goto discard;
+
+report_csum_error:
+	udp6_csum_zero_error(skb);
 csum_error:
 	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 discard:



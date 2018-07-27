Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D671EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE522089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE522089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbeG0Lbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:31:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0Lbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:31:45 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16F49CB7;
        Fri, 27 Jul 2018 10:10:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 04/33] ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull
Date:   Fri, 27 Jul 2018 12:08:45 +0200
Message-Id: <20180727100827.833022084@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 2efd4fca703a6707cad16ab486eaab8fc7f0fd49 ]

Syzbot reported a read beyond the end of the skb head when returning
IPV6_ORIGDSTADDR:

  BUG: KMSAN: kernel-infoleak in put_cmsg+0x5ef/0x860 net/core/scm.c:242
  CPU: 0 PID: 4501 Comm: syz-executor128 Not tainted 4.17.0+ #9
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
  Google 01/01/2011
  Call Trace:
    __dump_stack lib/dump_stack.c:77 [inline]
    dump_stack+0x185/0x1d0 lib/dump_stack.c:113
    kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
    kmsan_internal_check_memory+0x138/0x1f0 mm/kmsan/kmsan.c:1219
    kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
    copy_to_user include/linux/uaccess.h:184 [inline]
    put_cmsg+0x5ef/0x860 net/core/scm.c:242
    ip6_datagram_recv_specific_ctl+0x1cf3/0x1eb0 net/ipv6/datagram.c:719
    ip6_datagram_recv_ctl+0x41c/0x450 net/ipv6/datagram.c:733
    rawv6_recvmsg+0x10fb/0x1460 net/ipv6/raw.c:521
    [..]

This logic and its ipv4 counterpart read the destination port from
the packet at skb_transport_offset(skb) + 4.

With MSG_MORE and a local SOCK_RAW sender, syzbot was able to cook a
packet that stores headers exactly up to skb_transport_offset(skb) in
the head and the remainder in a frag.

Call pskb_may_pull before accessing the pointer to ensure that it lies
in skb head.

Link: http://lkml.kernel.org/r/CAF=yD-LEJwZj5a1-bAAj2Oy_hKmGygV6rsJ_WOrAYnv-fnayiQ@mail.gmail.com
Reported-by: syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_sockglue.c |    7 +++++--
 net/ipv6/datagram.c    |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -135,15 +135,18 @@ static void ip_cmsg_recv_dstaddr(struct
 {
 	struct sockaddr_in sin;
 	const struct iphdr *iph = ip_hdr(skb);
-	__be16 *ports = (__be16 *)skb_transport_header(skb);
+	__be16 *ports;
+	int end;
 
-	if (skb_transport_offset(skb) + 4 > (int)skb->len)
+	end = skb_transport_offset(skb) + 4;
+	if (end > 0 && !pskb_may_pull(skb, end))
 		return;
 
 	/* All current transport protocols have the port numbers in the
 	 * first four bytes of the transport header and this function is
 	 * written with this assumption in mind.
 	 */
+	ports = (__be16 *)skb_transport_header(skb);
 
 	sin.sin_family = AF_INET;
 	sin.sin_addr.s_addr = iph->daddr;
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -694,13 +694,16 @@ void ip6_datagram_recv_specific_ctl(stru
 	}
 	if (np->rxopt.bits.rxorigdstaddr) {
 		struct sockaddr_in6 sin6;
-		__be16 *ports = (__be16 *) skb_transport_header(skb);
+		__be16 *ports;
+		int end;
 
-		if (skb_transport_offset(skb) + 4 <= (int)skb->len) {
+		end = skb_transport_offset(skb) + 4;
+		if (end <= 0 || pskb_may_pull(skb, end)) {
 			/* All current transport protocols have the port numbers in the
 			 * first four bytes of the transport header and this function is
 			 * written with this assumption in mind.
 			 */
+			ports = (__be16 *)skb_transport_header(skb);
 
 			sin6.sin6_family = AF_INET6;
 			sin6.sin6_addr = ipv6_hdr(skb)->daddr;



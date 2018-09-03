Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726D8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A7E20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A7E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeICVYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:24:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeICVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:24:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A957CF5;
        Mon,  3 Sep 2018 17:03:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eyal Birger <eyal.birger@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 001/107] vti6: fix PMTU caching and reporting on xmit
Date:   Mon,  3 Sep 2018 18:55:25 +0200
Message-Id: <20180903165637.361669156@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eyal Birger <eyal.birger@gmail.com>

[ Upstream commit d6990976af7c5d8f55903bfb4289b6fb030bf754 ]

When setting the skb->dst before doing the MTU check, the route PMTU
caching and reporting is done on the new dst which is about to be
released.

Instead, PMTU handling should be done using the original dst.

This is aligned with IPv4 VTI.

Fixes: ccd740cbc6 ("vti6: Add pmtu handling to vti6_xmit.")
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -480,10 +480,6 @@ vti6_xmit(struct sk_buff *skb, struct ne
 		goto tx_err_dst_release;
 	}
 
-	skb_scrub_packet(skb, !net_eq(t->net, dev_net(dev)));
-	skb_dst_set(skb, dst);
-	skb->dev = skb_dst(skb)->dev;
-
 	mtu = dst_mtu(dst);
 	if (!skb->ignore_df && skb->len > mtu) {
 		skb_dst(skb)->ops->update_pmtu(dst, NULL, skb, mtu);
@@ -498,9 +494,14 @@ vti6_xmit(struct sk_buff *skb, struct ne
 				  htonl(mtu));
 		}
 
-		return -EMSGSIZE;
+		err = -EMSGSIZE;
+		goto tx_err_dst_release;
 	}
 
+	skb_scrub_packet(skb, !net_eq(t->net, dev_net(dev)));
+	skb_dst_set(skb, dst);
+	skb->dev = skb_dst(skb)->dev;
+
 	err = dst_output(t->net, skb->sk, skb);
 	if (net_xmit_eval(err) == 0) {
 		struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);



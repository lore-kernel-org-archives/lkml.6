Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911ECC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69849218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfBBAIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:08:13 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:53874 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfBBAIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:08:13 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 43A164C007D;
        Sat,  2 Feb 2019 00:08:12 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:08:08 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH v2 4/4] net: core: use a dynamic_call for
 pt_prev->list_func() in list RX path
To:     <namit@vmware.com>, <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Message-ID: <bbd0597c-e117-a28b-78e6-45bf450b2719@solarflare.com>
Date:   Sat, 2 Feb 2019 00:08:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24400.005
X-TM-AS-Result: No-1.439700-4.000000-10
X-TMASE-MatchedRID: icnKRxfRUvGHYS4ybQtcOomfV7NNMGm+lV2LeD3ayQ9aW2Ktn+I8/sCS
        2AMm1nQCeR3niegaOQ/1OL35ZxMCyoJrRWPc34Z+A9lly13c/gGXYX34rFl3x/uoLVXE/uWaLMn
        zP2AaqkymuE8sHNH+0b0YCPFWdc3lyO17Z2gPUCscsSroYI5AVn0tCKdnhB58vqq8s2MNhPCZMP
        CnTMzfOiq2rl3dzGQ1GpeevGsoI5fBIOFd328YBL3WVxaRKdFeiwsNxMTHzcg2qBy2Fxx8nfC+O
        io+/vdTFU0pzJYD24xRHPth62aQGki07t+6+hrgRYse5epR3i9azAigVxdXeiNlTYIDFiQj+C4I
        K5rEYL08DQfgROz55X7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.439700-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24400.005
X-MDID: 1549066092-0JYaXF1wtikh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently only two possible callees, ip_list_rcv and
 ipv6_list_rcv.  Even when more are added, most packets will typically
 follow one of a small number of callees on any given system.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 net/core/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7b38a33689d8..ecf41618a279 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5006,6 +5006,9 @@ int netif_receive_skb_core(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netif_receive_skb_core);
 
+DYNAMIC_CALL_3(void, deliver_skb_list, struct list_head *, struct packet_type *,
+	       struct net_device *);
+
 static inline void __netif_receive_skb_list_ptype(struct list_head *head,
 						  struct packet_type *pt_prev,
 						  struct net_device *orig_dev)
@@ -5017,7 +5020,8 @@ static inline void __netif_receive_skb_list_ptype(struct list_head *head,
 	if (list_empty(head))
 		return;
 	if (pt_prev->list_func != NULL)
-		pt_prev->list_func(head, pt_prev, orig_dev);
+		dynamic_deliver_skb_list(pt_prev->list_func, head, pt_prev,
+					 orig_dev);
 	else
 		list_for_each_entry_safe(skb, next, head, list)
 			dynamic_deliver_skb(pt_prev->func, skb, skb->dev,

Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F0C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444E321479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBBAHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:07:47 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:53032 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfBBAHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:07:47 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 4F86D4C007B;
        Sat,  2 Feb 2019 00:07:46 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:07:42 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH v2 2/4] net: core: use a dynamic_call for pt_prev->func()
 in RX path
To:     <namit@vmware.com>, <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Message-ID: <29064c76-5938-7070-dd1d-c36504bee03c@solarflare.com>
Date:   Sat, 2 Feb 2019 00:07:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24400.005
X-TM-AS-Result: No-0.056600-4.000000-10
X-TMASE-MatchedRID: AHaZm2SNi6foSitJVour/afOxh7hvX71pfVcx39Kq+7YpRv5miLGfL6p
        xbTOjavylSYn8sPpshV1VOt17I0SpZ4JPQewVPBvjWe5HOFKvuMK3n1SHen81ek9QK6zMDVaHVY
        j66eqnnnpmopVSa8PAL8aMgcvOfsGKQ54kjEfuxUcsSroYI5AVn0tCKdnhB58vqq8s2MNhPAir3
        kOMJmHTHYJEUfDojP/wrbXMGDYqV/6CZXLlV1mSXhkXc0sNwMdLj2qXch3MkpLGCpMY06Icw2D9
        RO/h2F506H+Y9srUPxikzcxh3jFdf+QiMYnP6XYPEscq6aYHFhn+1nzumrDgHzm6hivSaZZop2l
        f3StGhISt1bcvKF7ZKbNmFZyaXzY
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.056600-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24400.005
X-MDID: 1549066066-pT4-25Ei0zeP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically a small number of callees, such as ip[v6]_rcv or packet_rcv,
 will cover most packets.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 net/core/dev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8e276e0192a1..7b38a33689d8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -146,6 +146,7 @@
 #include <net/udp_tunnel.h>
 #include <linux/net_namespace.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/dynamic_call.h>
 
 #include "net-sysfs.h"
 
@@ -1949,6 +1950,9 @@ int dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(dev_forward_skb);
 
+DYNAMIC_CALL_4(int, deliver_skb, struct sk_buff *, struct net_device *,
+	       struct packet_type *, struct net_device *);
+
 static inline int deliver_skb(struct sk_buff *skb,
 			      struct packet_type *pt_prev,
 			      struct net_device *orig_dev)
@@ -1956,7 +1960,7 @@ static inline int deliver_skb(struct sk_buff *skb,
 	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC)))
 		return -ENOMEM;
 	refcount_inc(&skb->users);
-	return pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+	return dynamic_deliver_skb(pt_prev->func, skb, skb->dev, pt_prev, orig_dev);
 }
 
 static inline void deliver_ptype_list_skb(struct sk_buff *skb,
@@ -4970,7 +4974,8 @@ static int __netif_receive_skb_one_core(struct sk_buff *skb, bool pfmemalloc)
 
 	ret = __netif_receive_skb_core(skb, pfmemalloc, &pt_prev);
 	if (pt_prev)
-		ret = pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+		ret = dynamic_deliver_skb(pt_prev->func, skb, skb->dev, pt_prev,
+					  orig_dev);
 	return ret;
 }
 
@@ -5015,7 +5020,8 @@ static inline void __netif_receive_skb_list_ptype(struct list_head *head,
 		pt_prev->list_func(head, pt_prev, orig_dev);
 	else
 		list_for_each_entry_safe(skb, next, head, list)
-			pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+			dynamic_deliver_skb(pt_prev->func, skb, skb->dev,
+					    pt_prev, orig_dev);
 }
 
 static void __netif_receive_skb_list_core(struct list_head *head, bool pfmemalloc)


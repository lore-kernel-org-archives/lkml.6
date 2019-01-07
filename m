Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25682173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bJMinMIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfAGWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:36:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42233 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfAGWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:36:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so2350148qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8jfjinw++IFIMmRHPaT37Ermd7hK2DH7YkMhFayk7vY=;
        b=bJMinMIo6kSd7skgNNDHtlQPXsyoJ/eSP5RWYsFNFOyFlwVuoBQLg4wGt8t/KUAErn
         UVnHVWMg5FXpbYA7Agh30CQklqW3iueNOlVSTFM8OlvxSR+R5GpG/KY01qMYpg7uZ4QC
         yWiOd6sH6zkk+/4YOUWicMBpirX+E0ItyZ2CByIgeQn1EZrydaS//oWS3HcDxGqw7ZGJ
         fhITloxdx2p29dOe1MgwUcsxpSjyLIwSW2UcIWJl5tffbqFjk1RzC2wnW6FCpJXO8RRy
         nBEcme7ylS9gu8KkMsVU0cmVF5B9UO3xF9FXvX6CZlr+he8Iveq6hskXJ1ZIh13GwO4c
         zmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8jfjinw++IFIMmRHPaT37Ermd7hK2DH7YkMhFayk7vY=;
        b=aW232TQCHWlbSajSgdj499r+DQ8cp2bQlE8981o/ubuQG2NwRWuBGW8QK+N3vLVvmx
         TYBtxx6CiIwOQ1BR5x7X7weprfHLrSAMBhcXblghldcEUsYMjZUGlf+0/JY8iFORE/yV
         XPRfb0u6ld1WLgmwW2zyr3KczfpjZzDukLrD2PiHrQ/a9iiDekFPHn+boo5ABQ/2FD4f
         XRaoG3zhc3+wG/4Egg48SBvBudLiv/EsXk7MpL3ibuee3Dz2KAFHhSU0mndtb1qOlSGq
         ThXj+z/3jtAnwTpl31PCOgiNKcvGAXyxCwNKRnDn1Tw4XFqtJY2LeNb99r89JmqeRusd
         OP6w==
X-Gm-Message-State: AA+aEWY0POETECR3QEty8ar08kplTIvrs2xjQlifY+vtkSSh2zVW1v5L
        W3Z2aD5df2sQ2kmDrRrBl7QkU2B356GH6Q==
X-Google-Smtp-Source: ALg8bN4DYlUupxi9QG/Y1uD5XxzuQ/fHsI8byQNM7PdVDFy7ZVaZGl5msl0hwNqRl5hDC8/4nbLWCQ==
X-Received: by 2002:aed:2249:: with SMTP id o9mr62630513qtc.13.1546900608296;
        Mon, 07 Jan 2019 14:36:48 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b6sm27936850qtq.29.2019.01.07.14.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:36:47 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] page_poison: plays nicely with KASAN
Date:   Mon,  7 Jan 2019 17:36:36 -0500
Message-Id: <20190107223636.80593-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN does not play well with the page poisoning
(CONFIG_PAGE_POISONING). It triggers false positives in the allocation
path,

BUG: KASAN: use-after-free in memchr_inv+0x2ea/0x330
Read of size 8 at addr ffff88881f800000 by task swapper/0
CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1+ #54
Call Trace:
 dump_stack+0xe0/0x19a
 print_address_description.cold.2+0x9/0x28b
 kasan_report.cold.3+0x7a/0xb5
 __asan_report_load8_noabort+0x19/0x20
 memchr_inv+0x2ea/0x330
 kernel_poison_pages+0x103/0x3d5
 get_page_from_freelist+0x15e7/0x4d90

because KASAN has not yet unpoisoned the shadow page for allocation
before it checks memchr_inv() but only found a stale poison pattern.

Also, false positives in free path,

BUG: KASAN: slab-out-of-bounds in kernel_poison_pages+0x29e/0x3d5
Write of size 4096 at addr ffff8888112cc000 by task swapper/0/1
CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1+ #55
Call Trace:
 dump_stack+0xe0/0x19a
 print_address_description.cold.2+0x9/0x28b
 kasan_report.cold.3+0x7a/0xb5
 check_memory_region+0x22d/0x250
 memset+0x28/0x40
 kernel_poison_pages+0x29e/0x3d5
 __free_pages_ok+0x75f/0x13e0

due to KASAN adds poisoned redzones around slab objects, but the page
poisoning needs to poison the whole page, so simply unpoision the shadow
page before running the page poison's memset.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_alloc.c  | 2 +-
 mm/page_poison.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..906250a9b89c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1945,8 +1945,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	arch_alloc_page(page, order);
 	kernel_map_pages(page, 1 << order, 1);
-	kernel_poison_pages(page, 1 << order, 1);
 	kasan_alloc_pages(page, order);
+	kernel_poison_pages(page, 1 << order, 1);
 	set_page_owner(page, order, gfp_flags);
 }
 
diff --git a/mm/page_poison.c b/mm/page_poison.c
index f0c15e9017c0..e546b70e592a 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -6,6 +6,7 @@
 #include <linux/page_ext.h>
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
+#include <linux/kasan.h>
 
 static bool want_page_poisoning __read_mostly;
 
@@ -40,6 +41,7 @@ static void poison_page(struct page *page)
 {
 	void *addr = kmap_atomic(page);
 
+	kasan_unpoison_shadow(addr, PAGE_SIZE);
 	memset(addr, PAGE_POISON, PAGE_SIZE);
 	kunmap_atomic(addr);
 }
-- 
2.17.2 (Apple Git-113)


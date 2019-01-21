Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE99BC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD4D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfAUJi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:38:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:7371 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726133AbfAUJi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:38:26 -0500
X-UUID: e39555a8435f4724bbf3fb08b876d1b3-20190121
X-UUID: e39555a8435f4724bbf3fb08b876d1b3-20190121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1215981584; Mon, 21 Jan 2019 17:38:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 17:38:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 17:38:12 +0800
From:   <miles.chen@mediatek.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] mm/slub: use WARN_ON() for some slab errors
Date:   Mon, 21 Jan 2019 17:38:10 +0800
Message-ID: <1548063490-545-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 22854B56D5FA26CFEBB0D7CFF0AD17A8FEB7B10791F002CBBB518968530C57542000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

When debugging with slub.c, sometimes we have to trigger a panic in
order to get the coredump file. To do that, we have to modify slub.c and
rebuild kernel. To make debugging easier, use WARN_ON() for these slab
errors so we can dump stack trace by default or set panic_on_warn to
trigger a panic.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1e3d0ec4e200..e48c3bb30c93 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -684,7 +684,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 		print_section(KERN_ERR, "Padding ", p + off,
 			      size_from_object(s) - off);
 
-	dump_stack();
+	WARN_ON(1);
 }
 
 void object_err(struct kmem_cache *s, struct page *page,
@@ -705,7 +705,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
 	va_end(args);
 	slab_bug(s, "%s", buf);
 	print_page_info(page);
-	dump_stack();
+	WARN_ON(1);
 }
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
@@ -1690,7 +1690,7 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 		flags &= ~GFP_SLAB_BUG_MASK;
 		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
 				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
+		WARN_ON(1);
 	}
 
 	return allocate_slab(s,
-- 
2.18.0


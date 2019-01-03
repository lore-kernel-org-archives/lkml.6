Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB6CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4072B2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfACPA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:00:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:32868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730747AbfACPAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:00:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E690ADE2;
        Thu,  3 Jan 2019 15:00:18 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/vmalloc: do not call kmemleak_free() on not yet accounted memory
Date:   Thu,  3 Jan 2019 15:59:53 +0100
Message-Id: <20190103145954.16942-3-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103145954.16942-1-rpenyaev@suse.de>
References: <20190103145954.16942-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vmalloc_area_node() calls vfree() on error path, which in turn calls
kmemleak_free(), but area is not yet accounted by kmemleak_vmalloc().

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Joe Perches <joe@perches.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmalloc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2cd24186ba84..dc6a62bca503 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1565,6 +1565,14 @@ void vfree_atomic(const void *addr)
 	__vfree_deferred(addr);
 }
 
+static void __vfree(const void *addr)
+{
+	if (unlikely(in_interrupt()))
+		__vfree_deferred(addr);
+	else
+		__vunmap(addr, 1);
+}
+
 /**
  *	vfree  -  release memory allocated by vmalloc()
  *	@addr:		memory base address
@@ -1591,10 +1599,8 @@ void vfree(const void *addr)
 
 	if (!addr)
 		return;
-	if (unlikely(in_interrupt()))
-		__vfree_deferred(addr);
-	else
-		__vunmap(addr, 1);
+
+	__vfree(addr);
 }
 EXPORT_SYMBOL(vfree);
 
@@ -1709,7 +1715,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	warn_alloc(gfp_mask, NULL,
 			  "vmalloc: allocation failure, allocated %ld of %ld bytes",
 			  (area->nr_pages*PAGE_SIZE), area->size);
-	vfree(area->addr);
+	__vfree(area->addr);
 	return NULL;
 }
 
-- 
2.19.1


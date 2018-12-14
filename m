Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B624EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762E720811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762E720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeLNHol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:44:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:32906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeLNHol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:44:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2C09AF65;
        Fri, 14 Dec 2018 07:44:02 +0000 (UTC)
From:   Benjamin Poirier <bpoirier@suse.com>
To:     linux-mm@kvack.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc.c: Allow error injection
Date:   Fri, 14 Dec 2018 16:43:30 +0900
Message-Id: <20181214074330.18917-1-bpoirier@suse.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Model call chain after should_failslab(). Likewise, we can now use a kprobe
to override the return value of should_fail_alloc_page() and inject
allocation failures into alloc_page*().

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 include/asm-generic/error-injection.h |  1 +
 mm/page_alloc.c                       | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 296c65442f00..95a159a4137f 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -8,6 +8,7 @@ enum {
 	EI_ETYPE_NULL,		/* Return NULL if failure */
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
 	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
+	EI_ETYPE_TRUE,		/* Return true if failure */
 };
 
 struct error_injection_entry {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ec9cc407216..64861d79dc2d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3053,7 +3053,7 @@ static int __init setup_fail_page_alloc(char *str)
 }
 __setup("fail_page_alloc=", setup_fail_page_alloc);
 
-static bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+static bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	if (order < fail_page_alloc.min_order)
 		return false;
@@ -3103,13 +3103,19 @@ late_initcall(fail_page_alloc_debugfs);
 
 #else /* CONFIG_FAIL_PAGE_ALLOC */
 
-static inline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return false;
 }
 
 #endif /* CONFIG_FAIL_PAGE_ALLOC */
 
+static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	return __should_fail_alloc_page(gfp_mask, order);
+}
+ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
+
 /*
  * Return true if free base pages are above 'mark'. For high-order checks it
  * will return true of the order-0 watermark is reached and there is at least
-- 
2.19.2


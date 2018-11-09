Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C12086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQCCDU5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645C12086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeKIQ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:27:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45609 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeKIQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:27:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so435697pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4TesSbGB62xA3TfNct4mvP8iyx81/GNoDwFhQH3EAIk=;
        b=EQCCDU5jq8dKBb9Bx2axPP3NPwImXWLIPPUpv6FEDxDH6cnYuYAEup/9e1nd1HT5N8
         PrN6eCPerDhFcP0D3dfwCsuegvm/ltXibHwfpR33+gfOu09iv9sELlZWny6hu+Lh/Sr+
         W9hCcUKUeeguNjMo0Rw68BNVGO+y1udwMd4/FgcMNnM8BAygV6TYK7tSZ93c5GaMXaPW
         nArAMbBHt61uPNwtg43oGpRHRI/cfPOZHANtnpon5Hbhhy8ejsy/UGu5F22z4rue0hAe
         3qrpRMZ2WUJMmtsiuyVdGN6UD/PETdMFvaMhwgpg/AlwrYVL0KzJgjPa84BkSLYlzKGc
         8O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4TesSbGB62xA3TfNct4mvP8iyx81/GNoDwFhQH3EAIk=;
        b=OSlw5A8oqm8yd3vgRf5bf/MBiMvxJi5exalli6LVtzzAFg0FzftA6QEBEDIwBVoUkS
         Jj99KKt6dSIW+cEBa/EFfm+DbBJUWjBC3rN77yb+FBZvwX3odriPQkeTSaROgUdQ+1s0
         W5ZQNZ5metaVZ5ASzoKQoIjSUdx62bWDXoFs0N9yRppboDl5pN0/87bO8GbSb/H6nOmn
         Y/XuxWq6G0CdaWH5rK5VMXFUSAehADwBwUMYmfg49PlI+3SjtCUdMYMxnbr7n2BwzdsH
         R7ocvzY6U/M4TmBJ3+5jOc/Y9LH4SGm9V3uP+QDNu0juOjbaY1zNpp+eM1eCI9KywIu7
         qgUw==
X-Gm-Message-State: AGRZ1gKEMi8amzWi1guBZMZJQWLbwtZk5eSHZED2Y9ClGsglIZy5Uv0A
        UEFjRPSzWgaAefQ/li4qIQ==
X-Google-Smtp-Source: AJdET5e+UNfklH05dKVCHvqkkKfrITeoZS/A79nDLAMCoHowK8sSI9VuqNMTbZy8PQiybkjee+Akew==
X-Received: by 2002:a62:2c16:: with SMTP id s22-v6mr7724641pfs.6.1541746073710;
        Thu, 08 Nov 2018 22:47:53 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:53 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 11/11] mm: hwpoison: introduce clear_hwpoison_free_buddy_page()
Date:   Fri,  9 Nov 2018 15:47:15 +0900
Message-Id: <1541746035-13408-12-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new function is a reverse operation of set_hwpoison_free_buddy_page()
to adjust unpoison_memory() to the new semantics.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 include/linux/page-flags.h |  8 +++++++-
 mm/memory-failure.c        |  5 +++--
 mm/page_alloc.c            | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/include/linux/page-flags.h v4.19-mmotm-2018-10-30-16-08_patched/include/linux/page-flags.h
index 50ce1bd..ab0bde0 100644
--- v4.19-mmotm-2018-10-30-16-08/include/linux/page-flags.h
+++ v4.19-mmotm-2018-10-30-16-08_patched/include/linux/page-flags.h
@@ -382,11 +382,17 @@ PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
 extern bool set_hwpoison_free_buddy_page(struct page *page);
+extern bool clear_hwpoison_free_buddy_page(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
 static inline bool set_hwpoison_free_buddy_page(struct page *page)
 {
-	return 0;
+	return false;
+}
+
+static inline bool clear_hwpoison_free_buddy_page(struct page *page)
+{
+	return false;
 }
 #define __PG_HWPOISON 0
 #endif
diff --git v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
index af541141..a0e1cd4 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
@@ -1590,8 +1590,9 @@ int unpoison_memory(unsigned long pfn)
 	}
 
 	if (!get_hwpoison_page(p)) {
-		if (TestClearPageHWPoison(p))
-			num_poisoned_pages_dec();
+		if (!clear_hwpoison_free_buddy_page(p))
+			return 0;
+		num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
 				 pfn, &unpoison_rs);
 		return 0;
diff --git v4.19-mmotm-2018-10-30-16-08/mm/page_alloc.c v4.19-mmotm-2018-10-30-16-08_patched/mm/page_alloc.c
index 27826b3..9a90f93 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/page_alloc.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/page_alloc.c
@@ -8270,4 +8270,25 @@ bool set_hwpoison_free_buddy_page(struct page *page)
 
 	return hwpoisoned;
 }
+
+/*
+ * Reverse operation of set_hwpoison_free_buddy_page(), which is expected
+ * to work only on error pages isolated from buddy allocator.
+ */
+bool clear_hwpoison_free_buddy_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	bool unpoisoned = false;
+
+	spin_lock(&zone->lock);
+	if (TestClearPageHWPoison(page)) {
+		unsigned long pfn = page_to_pfn(page);
+		int migratetype = get_pfnblock_migratetype(page, pfn);
+
+		__free_one_page(page, pfn, zone, 0, migratetype);
+		unpoisoned = true;
+	}
+	spin_unlock(&zone->lock);
+	return unpoisoned;
+}
 #endif
-- 
2.7.0


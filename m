Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87118C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5748C2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbfBMNk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:40:58 -0500
Received: from foss.arm.com ([217.140.101.70]:54146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731945AbfBMNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:40:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6F380D;
        Wed, 13 Feb 2019 05:40:58 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 250093F557;
        Wed, 13 Feb 2019 05:40:57 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix __dump_page() for poisoned pages
Date:   Wed, 13 Feb 2019 13:40:49 +0000
Message-Id: <dbbcd36ca1f045ec81f49c7657928a1cdf24872b.1550065120.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Evaluating page_mapping() on a poisoned page ends up dereferencing junk
and making PF_POISONED_CHECK() considerably crashier than intended. Fix
that by not inspecting the mapping until we've determined that it's
likely to be valid.

Fixes: 1c6fb1d89e73 ("mm: print more information about mapping in __dump_page")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 mm/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index 0abb987dad9b..1611cf00a137 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -44,7 +44,7 @@ const struct trace_print_flags vmaflag_names[] = {
 
 void __dump_page(struct page *page, const char *reason)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
 	int mapcount;
 
@@ -58,6 +58,8 @@ void __dump_page(struct page *page, const char *reason)
 		goto hex_only;
 	}
 
+	mapping = page_mapping(page);
+
 	/*
 	 * Avoid VM_BUG_ON() in page_mapcount().
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
-- 
2.20.1.dirty


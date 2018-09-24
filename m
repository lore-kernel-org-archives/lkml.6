Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BFFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F10521486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F10521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIXURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:17:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXURX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:17:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D0480D;
        Mon, 24 Sep 2018 07:15:02 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F266D3F5B7;
        Mon, 24 Sep 2018 07:15:00 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org
Subject: [PATCH] mm/migrate: Split only transparent huge pages when allocation fails
Date:   Mon, 24 Sep 2018 19:44:55 +0530
Message-Id: <1537798495-4996-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unmap_and_move[_huge_page] function fails due to lack of memory, the
splitting should happen only for transparent huge pages not for HugeTLB
pages. PageTransHuge() returns true for both THP and HugeTLB pages. Hence
the conditonal check should test PagesHuge() flag to make sure that given
pages is not a HugeTLB one.

Fixes: 94723aafb9 ("mm: unclutter THP migration")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d6a2e89..d2297fe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1411,7 +1411,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * we encounter them after the rest of the list
 				 * is processed.
 				 */
-				if (PageTransHuge(page)) {
+				if (PageTransHuge(page) && !PageHuge(page)) {
 					lock_page(page);
 					rc = split_huge_page_to_list(page, from);
 					unlock_page(page);
-- 
2.7.4


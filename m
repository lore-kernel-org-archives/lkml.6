Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEF0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3CB2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfBSMdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:33:53 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:41316 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:33:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D4D25184D9;
        Tue, 19 Feb 2019 13:33:50 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wdBCkFgbkWvd; Tue, 19 Feb 2019 13:33:48 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 45382184D4;
        Tue, 19 Feb 2019 13:33:48 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 141331E06E;
        Tue, 19 Feb 2019 13:33:48 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 089711E06A;
        Tue, 19 Feb 2019 13:33:48 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 13:33:47 +0100 (CET)
Received: from pc32929-1845.se.axis.com (pc32929-1845.se.axis.com [10.88.129.17])
        by thoth.se.axis.com (Postfix) with ESMTP id F02401C76;
        Tue, 19 Feb 2019 13:33:47 +0100 (CET)
Received: by pc32929-1845.se.axis.com (Postfix, from userid 20456)
        id EBF60409B8; Tue, 19 Feb 2019 13:33:47 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, Lars Persson <larper@axis.com>
Subject: [PATCH] mm: migrate: add missing flush_dcache_page for non-mapped page migrate
Date:   Tue, 19 Feb 2019 13:32:12 +0100
Message-Id: <20190219123212.29838-1-larper@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our MIPS 1004Kc SoCs were seeing random userspace crashes with SIGILL
and SIGSEGV that could not be traced back to a userspace code
bug. They had all the magic signs of an I/D cache coherency issue.

Now recently we noticed that the /proc/sys/vm/compact_memory interface
was quite efficient at provoking this class of userspace crashes.

Studying the code in mm/migrate.c there is a distinction made between
migrating a page that is mapped at the instant of migration and one
that is not mapped. Our problem turned out to be the non-mapped pages.

For the non-mapped page the code performs a copy of the page content
and all relevant meta-data of the page without doing the required
D-cache maintenance. This leaves dirty data in the D-cache of the CPU
and on the 1004K cores this data is not visible to the I-cache. A
subsequent page-fault that triggers a mapping of the page will happily
serve the process with potentially stale code.

What about ARM then, this bug should have seen greater exposure? Well
ARM became immune to this flaw back in 2010, see commit c01778001a4f
("ARM: 6379/1: Assume new page cache pages have dirty D-cache").

My proposed fix moves the D-cache maintenance inside move_to_new_page
to make it common for both cases.

Signed-off-by: Lars Persson <larper@axis.com>
---
 mm/migrate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d4fd680be3b0..80fc19e610b5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -248,10 +248,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 				pte = swp_entry_to_pte(entry);
 			} else if (is_device_public_page(new)) {
 				pte = pte_mkdevmap(pte);
-				flush_dcache_page(new);
 			}
-		} else
-			flush_dcache_page(new);
+		}
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (PageHuge(new)) {
@@ -995,6 +993,13 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		 */
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
+
+		if (unlikely(is_zone_device_page(newpage))) {
+			if (is_device_public_page(newpage))
+				flush_dcache_page(newpage);
+		} else
+			flush_dcache_page(newpage);
+
 	}
 out:
 	return rc;
-- 
2.11.0


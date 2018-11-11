Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D777C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA3020854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA3020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeKLGKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731963AbeKLGKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:09 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt3-0000l7-Dh; Sun, 11 Nov 2018 19:59:13 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001Ws-KM; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mark Williamson" <mwilliamson@undo-software.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Konstantin Khlebnikov" <khlebnikov@yandex-team.ru>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.15822061@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 124/366] pagemap: hide physical addresses from
 non-privileged users
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit 1c90308e7a77af6742a97d1021cca923b23b7f0d upstream.

This patch makes pagemap readable for normal users and hides physical
addresses from them.  For some use-cases PFN isn't required at all.

See http://lkml.kernel.org/r/1425935472-17949-1-git-send-email-kirill@shutemov.name

Fixes: ab676b7d6fbf ("pagemap: do not leak physical addresses to non-privileged userspace")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Mark Williamson <mwilliamson@undo-software.com>
Tested-by:  Mark Williamson <mwilliamson@undo-software.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Add the same check in the places where we look up a PFN
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/proc/task_mmu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -862,6 +862,7 @@ struct pagemapread {
 	int pos, len;		/* units: PM_ENTRY_BYTES, not bytes */
 	pagemap_entry_t *buffer;
 	bool v2;
+	bool show_pfn;
 };
 
 #define PAGEMAP_WALK_SIZE	(PMD_SIZE)
@@ -921,12 +922,13 @@ static int pagemap_pte_hole(unsigned lon
 static void pte_to_pagemap_entry(pagemap_entry_t *pme, struct pagemapread *pm,
 		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
-	u64 frame, flags;
+	u64 frame = 0, flags;
 	struct page *page = NULL;
 	int flags2 = 0;
 
 	if (pte_present(pte)) {
-		frame = pte_pfn(pte);
+		if (pm->show_pfn)
+			frame = pte_pfn(pte);
 		flags = PM_PRESENT;
 		page = vm_normal_page(vma, addr, pte);
 		if (pte_soft_dirty(pte))
@@ -966,7 +968,7 @@ static void thp_pmd_to_pagemap_entry(pag
 	 * This if-check is just to prepare for future implementation.
 	 */
 	if (pmd_present(pmd))
-		*pme = make_pme(PM_PFRAME(pmd_pfn(pmd) + offset)
+		*pme = make_pme((pm->show_pfn ? PM_PFRAME(pmd_pfn(pmd) + offset) : 0)
 				| PM_STATUS2(pm->v2, pmd_flags2) | PM_PRESENT);
 	else
 		*pme = make_pme(PM_NOT_PRESENT(pm->v2) | PM_STATUS2(pm->v2, pmd_flags2));
@@ -1075,7 +1077,7 @@ static void huge_pte_to_pagemap_entry(pa
 					pte_t pte, int offset, int flags2)
 {
 	if (pte_present(pte))
-		*pme = make_pme(PM_PFRAME(pte_pfn(pte) + offset)	|
+		*pme = make_pme((pm->show_pfn ? PM_PFRAME(pte_pfn(pte) + offset) : 0) |
 				PM_STATUS2(pm->v2, flags2)		|
 				PM_PRESENT);
 	else
@@ -1167,6 +1169,10 @@ static ssize_t pagemap_read(struct file
 		goto out_task;
 
 	pm.v2 = soft_dirty_cleared;
+
+	/* do not disclose physical addresses: attack vector */
+	pm.show_pfn = file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN);
+
 	pm.len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
 	pm.buffer = kmalloc(pm.len * PM_ENTRY_BYTES, GFP_TEMPORARY);
 	ret = -ENOMEM;
@@ -1241,9 +1247,6 @@ out:
 
 static int pagemap_open(struct inode *inode, struct file *file)
 {
-	/* do not disclose physical addresses: attack vector */
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	pr_warn_once("Bits 55-60 of /proc/PID/pagemap entries are about "
 			"to stop being page-shift some time soon. See the "
 			"linux/Documentation/vm/pagemap.txt for details.\n");


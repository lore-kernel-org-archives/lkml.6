Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EA8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E8020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E8020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeHATpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:45:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405721AbeHATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F11731356;
        Wed,  1 Aug 2018 17:13:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Michal Hocko <mhocko@suse.com>,
        Andrei Vagin <avagin@openvz.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 032/246] mm: /proc/pid/pagemap: hide swap entries from unprivileged users
Date:   Wed,  1 Aug 2018 18:49:02 +0200
Message-Id: <20180801165013.229069817@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <ying.huang@intel.com>

[ Upstream commit ab6ecf247a9321e3180e021a6a60164dee53ab2e ]

In commit ab676b7d6fbf ("pagemap: do not leak physical addresses to
non-privileged userspace"), the /proc/PID/pagemap is restricted to be
readable only by CAP_SYS_ADMIN to address some security issue.

In commit 1c90308e7a77 ("pagemap: hide physical addresses from
non-privileged users"), the restriction is relieved to make
/proc/PID/pagemap readable, but hide the physical addresses for
non-privileged users.

But the swap entries are readable for non-privileged users too.  This
has some security issues.  For example, for page under migrating, the
swap entry has physical address information.  So, in this patch, the
swap entries are hided for non-privileged users too.

Link: http://lkml.kernel.org/r/20180508012745.7238-1-ying.huang@intel.com
Fixes: 1c90308e7a77 ("pagemap: hide physical addresses from non-privileged users")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/task_mmu.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1275,8 +1275,9 @@ static pagemap_entry_t pte_to_pagemap_en
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		entry = pte_to_swp_entry(pte);
-		frame = swp_type(entry) |
-			(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
+		if (pm->show_pfn)
+			frame = swp_type(entry) |
+				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
 		flags |= PM_SWAP;
 		if (is_migration_entry(entry))
 			page = migration_entry_to_page(entry);
@@ -1327,11 +1328,14 @@ static int pagemap_pmd_range(pmd_t *pmdp
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		else if (is_swap_pmd(pmd)) {
 			swp_entry_t entry = pmd_to_swp_entry(pmd);
-			unsigned long offset = swp_offset(entry);
+			unsigned long offset;
 
-			offset += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-			frame = swp_type(entry) |
-				(offset << MAX_SWAPFILES_SHIFT);
+			if (pm->show_pfn) {
+				offset = swp_offset(entry) +
+					((addr & ~PMD_MASK) >> PAGE_SHIFT);
+				frame = swp_type(entry) |
+					(offset << MAX_SWAPFILES_SHIFT);
+			}
 			flags |= PM_SWAP;
 			if (pmd_swp_soft_dirty(pmd))
 				flags |= PM_SOFT_DIRTY;
@@ -1349,10 +1353,12 @@ static int pagemap_pmd_range(pmd_t *pmdp
 			err = add_to_pagemap(addr, &pme, pm);
 			if (err)
 				break;
-			if (pm->show_pfn && (flags & PM_PRESENT))
-				frame++;
-			else if (flags & PM_SWAP)
-				frame += (1 << MAX_SWAPFILES_SHIFT);
+			if (pm->show_pfn) {
+				if (flags & PM_PRESENT)
+					frame++;
+				else if (flags & PM_SWAP)
+					frame += (1 << MAX_SWAPFILES_SHIFT);
+			}
 		}
 		spin_unlock(ptl);
 		return err;



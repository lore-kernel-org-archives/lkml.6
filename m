Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F05C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C277E218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999321;
	bh=gu7M0Z5v+iM88bbNBvrHffzghDndUaCJKkTnI97OBVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tuKLkSaExrV6i1AgEJ+FOTWeuZn8HJK3sS6YGXbV3B8Aye0DtklPt9OU5pSG83ef9
	 orCjz10DK94fysSvrFh8lVEbDa1vsEo5R+dPlcjCtX4LpUCtEu769yuozsSUu+3Ivp
	 rf8NWUYd6J31Fc1L5wtQDg75NOJlbmyIcAMCCsGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeL1MPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbeL1MPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319D52087F;
        Fri, 28 Dec 2018 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999315;
        bh=gu7M0Z5v+iM88bbNBvrHffzghDndUaCJKkTnI97OBVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWMzxclvf8ThmaJJXN2CE1ZgUJPi9cAr1BJfCP9gfju102qP1Y1HsjsnJ58tD7bXB
         5WMFbjBMDNxb35og4WpdVtNTZf9IpOzFpYK8jK+P516LmxPC0wjREs86xLMXkw4s+m
         ASHZyovGNYaoBsMGDAUeCPT9Maf1ZoebSNMkXsOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 41/46] mm: thp: fix flags for pmd migration when split
Date:   Fri, 28 Dec 2018 12:52:35 +0100
Message-Id: <20181228113127.324147093@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Xu <peterx@redhat.com>

commit 2e83ee1d8694a61d0d95a5b694f2e61e8dde8627 upstream.

When splitting a huge migrating PMD, we'll transfer all the existing PMD
bits and apply them again onto the small PTEs.  However we are fetching
the bits unconditionally via pmd_soft_dirty(), pmd_write() or
pmd_yound() while actually they don't make sense at all when it's a
migration entry.  Fix them up.  Since at it, drop the ifdef together as
not needed.

Note that if my understanding is correct about the problem then if
without the patch there is chance to lose some of the dirty bits in the
migrating pmd pages (on x86_64 we're fetching bit 11 which is part of
swap offset instead of bit 2) and it could potentially corrupt the
memory of an userspace program which depends on the dirty bit.

Link: http://lkml.kernel.org/r/20181213051510.20306-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: <stable@vger.kernel.org>	[4.14+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2127,23 +2127,25 @@ static void __split_huge_pmd_locked(stru
 	 */
 	old_pmd = pmdp_invalidate(vma, haddr, pmd);
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	pmd_migration = is_pmd_migration_entry(old_pmd);
-	if (pmd_migration) {
+	if (unlikely(pmd_migration)) {
 		swp_entry_t entry;
 
 		entry = pmd_to_swp_entry(old_pmd);
 		page = pfn_to_page(swp_offset(entry));
-	} else
-#endif
+		write = is_write_migration_entry(entry);
+		young = false;
+		soft_dirty = pmd_swp_soft_dirty(old_pmd);
+	} else {
 		page = pmd_page(old_pmd);
+		if (pmd_dirty(old_pmd))
+			SetPageDirty(page);
+		write = pmd_write(old_pmd);
+		young = pmd_young(old_pmd);
+		soft_dirty = pmd_soft_dirty(old_pmd);
+	}
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	page_ref_add(page, HPAGE_PMD_NR - 1);
-	if (pmd_dirty(old_pmd))
-		SetPageDirty(page);
-	write = pmd_write(old_pmd);
-	young = pmd_young(old_pmd);
-	soft_dirty = pmd_soft_dirty(old_pmd);
 
 	/*
 	 * Withdraw the table only after we mark the pmd entry invalid.



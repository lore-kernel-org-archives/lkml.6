Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C86FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44F120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44F120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbeFRISB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:18:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbeFRIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:17:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D04AC75;
        Mon, 18 Jun 2018 08:17:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jerome Glisse" <jglisse@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 067/279] mm, pagemap: fix swap offset value for PMD migration entry
Date:   Mon, 18 Jun 2018 10:10:52 +0200
Message-Id: <20180618080611.597228873@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <ying.huang@intel.com>

[ Upstream commit 88c28f2469151b031f8cea9b28ed5be1b74a4172 ]

The swap offset reported by /proc/<pid>/pagemap may be not correct for
PMD migration entries.  If addr passed into pagemap_pmd_range() isn't
aligned with PMD start address, the swap offset reported doesn't
reflect this.  And in the loop to report information of each sub-page,
the swap offset isn't increased accordingly as that for PFN.

This may happen after opening /proc/<pid>/pagemap and seeking to a page
whose address doesn't align with a PMD start address.  I have verified
this with a simple test program.

BTW: migration swap entries have PFN information, do we need to restrict
whether to show them?

[akpm@linux-foundation.org: fix typo, per Huang, Ying]
Link: http://lkml.kernel.org/r/20180408033737.10897-1-ying.huang@intel.com
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Jerome Glisse" <jglisse@redhat.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/task_mmu.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1329,9 +1329,11 @@ static int pagemap_pmd_range(pmd_t *pmdp
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		else if (is_swap_pmd(pmd)) {
 			swp_entry_t entry = pmd_to_swp_entry(pmd);
+			unsigned long offset = swp_offset(entry);
 
+			offset += (addr & ~PMD_MASK) >> PAGE_SHIFT;
 			frame = swp_type(entry) |
-				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
+				(offset << MAX_SWAPFILES_SHIFT);
 			flags |= PM_SWAP;
 			if (pmd_swp_soft_dirty(pmd))
 				flags |= PM_SOFT_DIRTY;
@@ -1351,6 +1353,8 @@ static int pagemap_pmd_range(pmd_t *pmdp
 				break;
 			if (pm->show_pfn && (flags & PM_PRESENT))
 				frame++;
+			else if (flags & PM_SWAP)
+				frame += (1 << MAX_SWAPFILES_SHIFT);
 		}
 		spin_unlock(ptl);
 		return err;



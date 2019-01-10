Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66071C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38025214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfAJAvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:51:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:29409 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfAJAvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:51:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 16:51:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,459,1539673200"; 
   d="scan'208";a="108696460"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2019 16:51:22 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, leozinho29_eu@hotmail.com,
        Mike Galbraith <efault@gmx.de>,
        Adam Borowski <kilobyte@angband.pl>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] mm/mmu_notifier: mm/rmap.c: Fix a mmu_notifier range bug in try_to_unmap_one
Date:   Wed,  9 Jan 2019 16:51:17 -0800
Message-Id: <20190110005117.18282-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion to use a structure for mmu_notifier_invalidate_range_*()
unintentionally changed the usage in try_to_unmap_one() to init the
'struct mmu_notifier_range' with vma->vm_start instead of @address,
i.e. it invalidates the wrong address range.  Revert to the correct
address range.

Manifests as KVM use-after-free WARNINGs and subsequent "BUG: Bad page
state in process X" errors when reclaiming from a KVM guest due to KVM
removing the wrong pages from its own mappings.

Reported-by: leozinho29_eu@hotmail.com
Reported-by: Mike Galbraith <efault@gmx.de>
Reported-by: Adam Borowski <kilobyte@angband.pl>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

FWIW, I looked through all other calls to mmu_notifier_range_init() in
the patch and didn't spot any other unintentional functional changes.

 mm/rmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 68a1a5b869a5..0454ecc29537 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1371,8 +1371,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	 * Note that the page can not be free in this function as call of
 	 * try_to_unmap() must hold a reference on the page.
 	 */
-	mmu_notifier_range_init(&range, vma->vm_mm, vma->vm_start,
-				min(vma->vm_end, vma->vm_start +
+	mmu_notifier_range_init(&range, vma->vm_mm, address,
+				min(vma->vm_end, address +
 				    (PAGE_SIZE << compound_order(page))));
 	if (PageHuge(page)) {
 		/*
-- 
2.19.2


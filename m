Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B82C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2121476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/zOyM3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA2121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeJQBHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbeJQBHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:07:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA3520866;
        Tue, 16 Oct 2018 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710184;
        bh=4Xbuu5ecnBC8Tx66dEhaXfj6TzqrRqI2sFOB3DnZNcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/zOyM3R9yeB/FezM2VM5RFO/YdPVCxSf+lqCHMeuqxMaN9a2T6ZlHbDzCgMuqTSb
         d+JndomS0LvSGwVaSZEh3NrSZnrUc7U9kC3HS99PthSCS8jww/GW/l0DouXNmcwJpD
         F4rUkhlX6LyWkaLNuSSyBXEDeJZTkppRbQYIRtE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Nellans <dnellans@nvidia.com>,
        Ingo Molnar <mingo@elte.hu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.18 132/135] mm/thp: fix call to mmu_notifier in set_pmd_migration_entry() v2
Date:   Tue, 16 Oct 2018 19:06:02 +0200
Message-Id: <20181016170524.380240417@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jérôme Glisse <jglisse@redhat.com>

commit bfba8e5cf28f413aa05571af493871d74438979f upstream.

Inside set_pmd_migration_entry() we are holding page table locks and thus
we can not sleep so we can not call invalidate_range_start/end()

So remove call to mmu_notifier_invalidate_range_start/end() because they
are call inside the function calling set_pmd_migration_entry() (see
try_to_unmap_one()).

Link: http://lkml.kernel.org/r/20181012181056.7864-1-jglisse@redhat.com
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Zi Yan <zi.yan@cs.rutgers.edu>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Nellans <dnellans@nvidia.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2883,9 +2883,6 @@ void set_pmd_migration_entry(struct page
 	if (!(pvmw->pmd && !pvmw->pte))
 		return;
 
-	mmu_notifier_invalidate_range_start(mm, address,
-			address + HPAGE_PMD_SIZE);
-
 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
 	pmdval = *pvmw->pmd;
 	pmdp_invalidate(vma, address, pvmw->pmd);
@@ -2898,9 +2895,6 @@ void set_pmd_migration_entry(struct page
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
 	page_remove_rmap(page, true);
 	put_page(page);
-
-	mmu_notifier_invalidate_range_end(mm, address,
-			address + HPAGE_PMD_SIZE);
 }
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)



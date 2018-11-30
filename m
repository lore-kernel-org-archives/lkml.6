Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA1D20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA1D20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeLAJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:03:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:32118 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAJDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:03:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 13:52:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="114393636"
Received: from ahduyck-desk1.jf.intel.com (HELO ahduyck-desk1.amr.corp.intel.com) ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2018 13:52:48 -0800
Subject: [mm PATCH v6 0/7] Deferred page init improvements
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, alexander.h.duyck@linux.intel.com,
        rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz,
        khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com,
        alexander.h.duyck@linux.intel.com
Date:   Fri, 30 Nov 2018 13:52:48 -0800
Message-ID: <154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is essentially a refactor of the page initialization logic
that is meant to provide for better code reuse while providing a
significant improvement in deferred page initialization performance.

In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
memory per node I have seen the following. In the case of regular memory
initialization the deferred init time was decreased from 3.75s to 1.06s on
average. For the persistent memory the initialization time dropped from
24.17s to 19.12s on average. This amounts to a 253% improvement for the
deferred memory initialization performance, and a 26% improvement in the
persistent memory initialization performance.

I have called out the improvement observed with each patch.

Note: This patch set is meant as a replacment for the v5 set that is already
      in the MM tree.
      
      I had considered just doing incremental changes but Pavel at the time
      had suggested I submit it as a whole set, however that was almost 3
      weeks ago so if incremental changes are preferred let me know and
      I can submit the changes as incremental updates.

      I appologize for the delay in submitting this follow-on set. I had been
      trying to address the DAX PageReserved bit issue at the same time but
      that is taking more time than I anticipated so I decided to push this
      before the code sits too much longer.

      Commit bf416078f1d83 ("mm/page_alloc.c: memory hotplug: free pages as 
      higher order") causes issues with the revert of patch 7. It was
      necessary to replace all instances of __free_pages_boot_core with
      __free_pages_core.

v1->v2:
    Fixed build issue on PowerPC due to page struct size being 56
    Added new patch that removed __SetPageReserved call for hotplug
v2->v3:
    Rebased on latest linux-next
    Removed patch that had removed __SetPageReserved call from init
    Added patch that folded __SetPageReserved into set_page_links
    Tweaked __init_pageblock to use start_pfn to get section_nr instead of pfn
v3->v4:
    Updated patch description and comments for mm_zero_struct_page patch
        Replaced "default" with "case 64"
        Removed #ifndef mm_zero_struct_page
    Fixed typo in comment that ommited "_from" in kerneldoc for iterator
    Added Reviewed-by for patches reviewed by Pavel
    Added Acked-by from Michal Hocko
    Added deferred init times for patches that affect init performance
    Swapped patches 5 & 6, pulled some code/comments from 4 into 5
v4->v5:
    Updated Acks/Reviewed-by
    Rebased on latest linux-next
    Split core bits of zone iterator patch from MAX_ORDER_NR_PAGES init
v5->v6:
    Rebased on linux-next with previous v5 reverted
    Drop the "This patch" or "This change" from patch desriptions.
    Cleaned up patch descriptions for patches 3 & 4
    Fixed kerneldoc for __next_mem_pfn_range_in_zone
    Updated several Reviewed-by, and incorporated suggestions from Pavel
    Added __init_single_page_nolru to patch 5 to consolidate code
    Refactored iterator in patch 7 and fixed several issues

---

Alexander Duyck (7):
      mm: Use mm_zero_struct_page from SPARC on all 64b architectures
      mm: Drop meminit_pfn_in_nid as it is redundant
      mm: Implement new zone specific memblock iterator
      mm: Initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections
      mm: Move hot-plug specific memory init into separate functions and optimize
      mm: Add reserved flag setting to set_page_links
      mm: Use common iterator for deferred_init_pages and deferred_free_pages


 arch/sparc/include/asm/pgtable_64.h |   30 --
 include/linux/memblock.h            |   41 +++
 include/linux/mm.h                  |   50 +++
 mm/memblock.c                       |   64 ++++
 mm/page_alloc.c                     |  571 +++++++++++++++++++++--------------
 5 files changed, 498 insertions(+), 258 deletions(-)

--

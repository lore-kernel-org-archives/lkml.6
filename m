Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B56F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B56F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeIZCa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:30:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:6365 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeIZCa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:30:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 13:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="77230394"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2018 13:20:47 -0700
Subject: [PATCH v5 3/4] mm: Create non-atomic version of SetPageReserved for
 init use
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, dave.hansen@intel.com, jglisse@redhat.com,
        rppt@linux.vnet.ibm.com, dan.j.williams@intel.com,
        logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Tue, 25 Sep 2018 13:20:47 -0700
Message-ID: <20180925202018.3576.11607.stgit@localhost.localdomain>
In-Reply-To: <20180925200551.3576.18755.stgit@localhost.localdomain>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make much sense to use the atomic SetPageReserved at init time
when we are using memset to clear the memory and manipulating the page
flags via simple "&=" and "|=" operations in __init_single_page.

This patch adds a non-atomic version __SetPageReserved that can be used
during page init and shows about a 10% improvement in initialization times
on the systems I have available for testing. On those systems I saw
initialization times drop from around 35 seconds to around 32 seconds to
initialize a 3TB block of persistent memory. I believe the main advantage
of this is that it allows for more compiler optimization as the __set_bit
operation can be reordered whereas the atomic version cannot.

I tried adding a bit of documentation based on commit <f1dd2cd13c4> ("mm,
memory_hotplug: do not associate hotadded memory to zones until online").

Ideally the reserved flag should be set earlier since there is a brief
window where the page is initialization via __init_single_page and we have
not set the PG_Reserved flag. I'm leaving that for a future patch set as
that will require a more significant refactor.

Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

v4: Added comment about __set_bit vs set_bit to the patch description
v5: No change

 include/linux/page-flags.h |    1 +
 mm/page_alloc.c            |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 934f91ef3f54..50ce1bddaf56 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -303,6 +303,7 @@ static inline void page_init_poison(struct page *page, size_t size)
 
 PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 	__CLEARPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
+	__SETPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 	__CLEARPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 	__SETPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 511447ac02cf..926ad3083b28 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1238,7 +1238,12 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
 
-			SetPageReserved(page);
+			/*
+			 * no need for atomic set_bit because the struct
+			 * page is not visible yet so nobody should
+			 * access it yet.
+			 */
+			__SetPageReserved(page);
 		}
 	}
 }
@@ -5512,7 +5517,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
 		if (context == MEMMAP_HOTPLUG)
-			SetPageReserved(page);
+			__SetPageReserved(page);
 
 		/*
 		 * Mark the block movable so that blocks are reserved for


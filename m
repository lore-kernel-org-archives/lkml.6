Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A06C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C905520841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C905520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJLFqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:46:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:35657 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeJLFqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:46:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 15:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,370,1534834800"; 
   d="scan'208";a="80765696"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.157])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 15:13:28 -0700
Subject: [mm PATCH v2 0/6] Deferred page init improvements
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, alexander.h.duyck@linux.intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Date:   Thu, 11 Oct 2018 15:13:28 -0700
Message-ID: <20181011221237.1925.85591.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
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

In my testing I have seen a 60% reduction in the time needed for deferred
memory initialization on two different x86_64 based test systems I have. In
addition this provides a very slight improvement for the hotplug memory 
initialization, although the improvement doesn't exceed 5% from what I can
tell and that is to be expected since most of the changes related to
hotplug init are mostly just code clean-up to allow for reuse.

The biggest gains of this patchset come from not having to test each pfn
multiple times to see if it is valid and if it is actually a part of the
node being initialized.

v1->v2:
    Fixed build issue on PowerPC due to page struct size being 56
    Added new patch that removed __SetPageReserved call for hotplug

---

Alexander Duyck (6):
      mm: Use mm_zero_struct_page from SPARC on all 64b architectures
      mm: Drop meminit_pfn_in_nid as it is redundant
      mm: Use memblock/zone specific iterator for handling deferred page init
      mm: Do not set reserved flag for hotplug memory
      mm: Move hot-plug specific memory init into separate functions and optimize
      mm: Use common iterator for deferred_init_pages and deferred_free_pages


 arch/sparc/include/asm/pgtable_64.h |   30 --
 include/linux/memblock.h            |   58 ++++
 include/linux/mm.h                  |   34 ++
 mm/memblock.c                       |   63 ++++
 mm/page_alloc.c                     |  552 +++++++++++++++++++++--------------
 5 files changed, 483 insertions(+), 254 deletions(-)

--

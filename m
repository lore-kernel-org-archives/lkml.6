Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C452F21565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C452F21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeI0Fo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:44:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:33789 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeI0Fo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:44:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 16:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,308,1534834800"; 
   d="scan'208";a="86873123"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2018 16:28:20 -0700
Subject: [RFC mm PATCH 0/5] mm: Deferred page init improvements
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, alexander.h.duyck@linux.intel.com,
        dan.j.williams@intel.com, willy@infradead.org, mingo@kernel.org,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org, ldufour@linux.vnet.ibm.com,
        davem@davemloft.net, kirill.shutemov@linux.intel.com
Date:   Wed, 26 Sep 2018 16:28:20 -0700
Message-ID: <20180926232117.17365.72207.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is essentially a refactor of the page initialization logic
to provide for better code reuse while providing a significant improvement
in deferred page initialization performance.

In my testing I have seen a 3:1 reduction in the time needed for deferred
memory initialization on two different x86_64 based test systems I have.

In addition this provides a very slight improvement for the hotplug memory 
initialization, although the improvement doesn't exceed 5% from what I can
tell and that is to be expected since most of the changes related to
hotplug initialization are just code clean-up to allow for reuse. I had
been considering using a large memset for the entire pageblock I was
initializing which showed a significant speedup for persistent memory init
however that showed no improvements to a slight regression for regular
deferred initialization of standard memory.

---

Alexander Duyck (5):
      mm: Use mm_zero_struct_page from SPARC on all 64b architectures
      mm: Drop meminit_pfn_in_nid as it is redundant
      mm: Use memblock/zone specific iterator for handling deferred page init
      mm: Move hot-plug specific memory init into separate functions and optimize
      mm: Use common iterator for deferred_init_pages and deferred_free_pages


 arch/sparc/include/asm/pgtable_64.h |   30 --
 include/linux/memblock.h            |   58 ++++
 include/linux/mm.h                  |   33 ++
 mm/memblock.c                       |   63 ++++
 mm/page_alloc.c                     |  555 +++++++++++++++++++++--------------
 5 files changed, 485 insertions(+), 254 deletions(-)

--

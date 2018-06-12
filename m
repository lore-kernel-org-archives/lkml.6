Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B26DCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6780C208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6780C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934103AbeFLOm6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:42:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:45389 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933571AbeFLOjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:39:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="48384940"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2018 07:39:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 72F01B7; Tue, 12 Jun 2018 17:39:20 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 00/17] MKTME enabling
Date:   Tue, 12 Jun 2018 17:38:58 +0300
Message-Id: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multikey Total Memory Encryption (MKTME)[1] is a technology that allows
transparent memory encryption in upcoming Intel platforms. See overview
below.

Here's updated version of my patchset that brings support of MKTME.
Please review and consider applying.

The patchset provides in-kernel infrastructure for MKTME, but doesn't yet
have userspace interface.

First 4 patches are for core-mm. The rest is x86-specific.

The patchset is on top of page_ext cleanups I've posted earlier[2].

v3:
 - Kernel now can access encrypted pages via per-KeyID direct mapping.

 - Rework page allocation for encrypted memory to minimize overhead on
   non-encrypted pages. It comes with cost for allocation of encrypted
   pages: we have to flush cache on every time we allocate *and* free
   encrypted page. We will need to optimize it later.

v2:
 - Store KeyID of page in page_ext->flags rather than in anon_vma.
   anon_vma approach turned out to be problematic. The main problem is
   that anon_vma of the page is no longer stable after last mapcount has
   gone. We would like to preserve last used KeyID even for freed
   pages as it allows to avoid unneccessary cache flushing on allocation
   of an encrypted page. page_ext serves this well enough.

 - KeyID is now propagated through page allocator. No need in GFP_ENCRYPT
   anymore.

 - Patch "Decouple dynamic __PHYSICAL_MASK from AMD SME" has been fix to
   work with AMD SEV (need to be confirmed by AMD folks).

------------------------------------------------------------------------------

MKTME is built on top of TME. TME allows encryption of the entirety of
system memory using a single key. MKTME allows to have multiple encryption
domains, each having own key -- different memory pages can be encrypted
with different keys.

Key design points of Intel MKTME:

 - Initial HW implementation would support upto 63 keys (plus one default
   TME key). But the number of keys may be as low as 3, depending to SKU
   and BIOS settings

 - To access encrypted memory you need to use mapping with proper KeyID
   int the page table entry. KeyID is encoded in upper bits of PFN in page
   table entry.

 - CPU does not enforce coherency between mappings of the same physical
   page with different KeyIDs or encryption keys. We wound need to take
   care about flushing cache on allocation of encrypted page and on
   returning it back to free pool.

 - For managing keys, there's MKTME_KEY_PROGRAM leaf of the new PCONFIG
   (platform configuration) instruction. It allows load and clear keys
   associated with a KeyID. You can also ask CPU to generate a key for
   you or disable memory encryption when a KeyID is used.

[1] https://software.intel.com/sites/default/files/managed/a5/16/Multi-Key-Total-Memory-Encryption-Spec.pdf
[2] https://lkml.kernel.org/r/20180531135457.20167-1-kirill.shutemov@linux.intel.com

Kirill A. Shutemov (17):
  mm: Do no merge VMAs with different encryption KeyIDs
  mm/khugepaged: Do not collapse pages in encrypted VMAs
  mm/ksm: Do not merge pages with different KeyIDs
  mm/page_alloc: Handle allocation for encrypted memory
  x86/mm: Mask out KeyID bits from page table entry pfn
  x86/mm: Introduce variables to store number, shift and mask of KeyIDs
  x86/mm: Preserve KeyID on pte_modify() and pgprot_modify()
  x86/mm: Implement vma_is_encrypted() and vma_keyid()
  x86/mm: Implement page_keyid() using page_ext
  x86/mm: Implement prep_encrypted_page() and arch_free_page()
  x86/mm: Rename CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING
  x86/mm: Allow to disable MKTME after enumeration
  x86/mm: Detect MKTME early
  x86/mm: Introduce direct_mapping_size
  x86/mm: Implement sync_direct_mapping()
  x86/mm: Handle encrypted memory in page_to_virt() and __pa()
  x86: Introduce CONFIG_X86_INTEL_MKTME

 arch/alpha/include/asm/page.h        |   2 +-
 arch/x86/Kconfig                     |  21 +-
 arch/x86/include/asm/mktme.h         |  60 +++
 arch/x86/include/asm/page.h          |   1 +
 arch/x86/include/asm/page_64.h       |   3 +-
 arch/x86/include/asm/pgtable_types.h |   7 +-
 arch/x86/kernel/cpu/intel.c          |  40 +-
 arch/x86/kernel/head64.c             |   2 +
 arch/x86/mm/Makefile                 |   2 +
 arch/x86/mm/init_64.c                |   6 +
 arch/x86/mm/kaslr.c                  |  21 +-
 arch/x86/mm/mktme.c                  | 583 +++++++++++++++++++++++++++
 include/linux/gfp.h                  |  38 +-
 include/linux/migrate.h              |   8 +-
 include/linux/mm.h                   |  21 +
 include/linux/page_ext.h             |  11 +-
 mm/compaction.c                      |   4 +
 mm/khugepaged.c                      |   2 +
 mm/ksm.c                             |   3 +
 mm/mempolicy.c                       |  25 +-
 mm/migrate.c                         |   4 +-
 mm/mmap.c                            |   3 +-
 mm/page_alloc.c                      |  63 +++
 mm/page_ext.c                        |   3 +
 24 files changed, 893 insertions(+), 40 deletions(-)
 create mode 100644 arch/x86/include/asm/mktme.h
 create mode 100644 arch/x86/mm/mktme.c

-- 
2.17.1


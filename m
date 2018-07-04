Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F9CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEC423F16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEC423F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeGDVuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:50:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:59639 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752921AbeGDVuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:50:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="54485074"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2018 14:50:21 -0700
Subject: [PATCH v5 00/11] mm: Teach memory_failure() about ZONE_DEVICE pages
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:40:23 -0700
Message-ID: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 [1]:
* Rework dax_lock_page() to reuse get_unlocked_mapping_entry() (Jan)

* Change the calling convention to take a 'struct page *' and return
  success / failure instead of performing the pfn_to_page() internal to
  the api (Jan, Ross).

* Rename dax_lock_page() to dax_lock_mapping_entry() (Jan)

* Account for the case that a given pfn can be fsdax mapped with
  different sizes in different vmas (Jan)

* Update collect_procs() to determine the mapping size of the pfn for
  each page given it can be variable in the dax case.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2018-June/016279.html

---

As it stands, memory_failure() gets thoroughly confused by dev_pagemap
backed mappings. The recovery code has specific enabling for several
possible page states and needs new enabling to handle poison in dax
mappings.

In order to support reliable reverse mapping of user space addresses:

1/ Add new locking in the memory_failure() rmap path to prevent races
that would typically be handled by the page lock.

2/ Since dev_pagemap pages are hidden from the page allocator and the
"compound page" accounting machinery, add a mechanism to determine the
size of the mapping that encompasses a given poisoned pfn.

3/ Given pmem errors can be repaired, change the speculatively accessed
poison protection, mce_unmap_kpfn(), to be reversible and otherwise
allow ongoing access from the kernel.

A side effect of this enabling is that MADV_HWPOISON becomes usable for
dax mappings, however the primary motivation is to allow the system to
survive userspace consumption of hardware-poison via dax. Specifically
the current behavior is:

    mce: Uncorrected hardware memory error in user-access at af34214200
    {1}[Hardware Error]: It has been corrected by h/w and requires no further action
    mce: [Hardware Error]: Machine check events logged
    {1}[Hardware Error]: event severity: corrected
    Memory failure: 0xaf34214: reserved kernel page still referenced by 1 users
    [..]
    Memory failure: 0xaf34214: recovery action for reserved kernel page: Failed
    mce: Memory error not recovered
    <reboot>

...and with these changes:

    Injecting memory failure for pfn 0x20cb00 at process virtual address 0x7f763dd00000
    Memory failure: 0x20cb00: Killing dax-pmd:5421 due to hardware memory corruption
    Memory failure: 0x20cb00: recovery action for dax page: Recovered

Given all the cross dependencies I propose taking this through
nvdimm.git with acks from Naoya, x86/core, x86/RAS, and of course dax
folks.

---

Dan Williams (11):
      device-dax: Convert to vmf_insert_mixed and vm_fault_t
      device-dax: Enable page_mapping()
      device-dax: Set page->index
      filesystem-dax: Set page->index
      mm, madvise_inject_error: Let memory_failure() optionally take a page reference
      mm, memory_failure: Collect mapping size in collect_procs()
      filesystem-dax: Introduce dax_lock_mapping_entry()
      mm, memory_failure: Teach memory_failure() about dev_pagemap pages
      x86/mm/pat: Prepare {reserve,free}_memtype() for "decoy" addresses
      x86/memory_failure: Introduce {set,clear}_mce_nospec()
      libnvdimm, pmem: Restore page attributes when clearing errors


 arch/x86/include/asm/set_memory.h         |   42 ++++++
 arch/x86/kernel/cpu/mcheck/mce-internal.h |   15 --
 arch/x86/kernel/cpu/mcheck/mce.c          |   38 -----
 arch/x86/mm/pat.c                         |   16 ++
 drivers/dax/device.c                      |   75 +++++++----
 drivers/nvdimm/pmem.c                     |   26 ++++
 drivers/nvdimm/pmem.h                     |   13 ++
 fs/dax.c                                  |  125 +++++++++++++++++-
 include/linux/dax.h                       |   24 +++
 include/linux/huge_mm.h                   |    5 -
 include/linux/mm.h                        |    1 
 include/linux/set_memory.h                |   14 ++
 mm/huge_memory.c                          |    4 -
 mm/madvise.c                              |   18 ++-
 mm/memory-failure.c                       |  201 +++++++++++++++++++++++------
 15 files changed, 483 insertions(+), 134 deletions(-)

Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B02C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48CD20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfBAF1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:27:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:23107 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfBAF1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:27:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 21:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="134968239"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2019 21:27:49 -0800
Subject: [PATCH v10 0/3] mm: Randomize free memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com
Date:   Thu, 31 Jan 2019 21:15:12 -0800
Message-ID: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v9:
* Drop the include of "shuffle.h" in mm/memblock.c. This was a missed
  leftover from the cleanup afforded by the move to
  page_alloc_init_late() (Mike)
* Drop reference to deferred_init_memmap() in the changelog, no longer
  relevant (Michal)
* Clarify mm_shuffle_ctl naming with a code comment (Michal)
* Replace per-freearea rand state tracking with global state (Michal)
* Move shuffle.h from include/linux/ to mm/. (Andrew)
* Mark page_alloc_shuffle() __memint (Andrew)
* Drop shuffle_store() since the module parameter is not writable.
* Reflow and clarify comments (Andrew)
* Make add_to_free_area_random() stub a static inline. (Andrew)
* Fix compilation errors on trying to use pfn_valid() as a pfn_present()
  replacement. Unfortunately this requires a #define rather than a
  static inline due to header include dependencies (0day kbuild robot)

[1]: https://lkml.kernel.org/r/154882453052.1338686.16411162273671426494.stgit@dwillia2-desk3.amr.corp.intel.com

---

Hi Andrew,

This addresses all your comments except reworking the shuffling to be
dynamically enabled at runtime. I do think that could be useful, but I
think it needs to be driven via memory hot-unplug/replug to avoid
confusion with the shuffled state of memory relative to existing
allocations. I don't think I can turn that around in time for the v5.1
merge window.

Otherwise, if you disagree with my "shuffled state relative to active
allocations" concern it should be simple enough to enable a best effort
shuffle of the current free memory state. Again, though, I'm not sure
how useful that is since it can lead to pockets of in-order allocated
memory.

I went ahead and moved shuffle.h in-tact to mm/. The declaration of
page_alloc_shuffle() will eventually need to move to a public location.
I expect Keith will take care of that when he hooks up this shuffling
with his work-in-progress ACPI HMAT enabling.

0day has been chewing on this version for a few hours with no reports
so I think its clean from a build perspective.

---

Dan Williams (3):
      mm: Shuffle initial free memory to improve memory-side-cache utilization
      mm: Move buddy list manipulations into helpers
      mm: Maintain randomization of page free lists


 Documentation/admin-guide/kernel-parameters.txt |   10 +
 include/linux/list.h                            |   17 ++
 include/linux/mm.h                              |    3 
 include/linux/mm_types.h                        |    3 
 include/linux/mmzone.h                          |   59 +++++++
 init/Kconfig                                    |   23 +++
 mm/Makefile                                     |    7 +
 mm/compaction.c                                 |    4 
 mm/memory_hotplug.c                             |    3 
 mm/page_alloc.c                                 |   85 +++++-----
 mm/shuffle.c                                    |  193 +++++++++++++++++++++++
 mm/shuffle.h                                    |   64 ++++++++
 12 files changed, 421 insertions(+), 50 deletions(-)
 create mode 100644 mm/shuffle.c
 create mode 100644 mm/shuffle.h

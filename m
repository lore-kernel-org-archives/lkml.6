Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC99ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DA4214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DA4214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIOVyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 17:54:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:55758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIOVyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 17:54:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 09:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,377,1531810800"; 
   d="scan'208";a="80702375"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2018 09:34:44 -0700
Subject: [PATCH 0/3] mm: Randomize free memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 15 Sep 2018 09:23:02 -0700
Message-ID: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data exfiltration attacks via speculative execution and
return-oriented-programming attacks rely on the ability to infer the
location of sensitive data objects. The kernel page allocator, has
predictable first-in-first-out behavior for physical pages. Pages are
freed in physical address order when first onlined. There are also
mechanisms like CMA that can free large contiguous areas at once
increasing the predictability of allocations in physical memory.

In addition to the security implications this randomization also
stabilizes the average performance of direct-mapped memory-side caches.
This includes memory-side caches like the one on the Knights Landing
processor and those generally described by the ACPI HMAT (Heterogeneous
Memory Attributes Table [1]). Cache conflicts are spread over a random
distribution rather than localized.

Given the performance sensitivity of the page allocator this
randomization is only performed for MAX_ORDER (4MB by default) pages. A
kernel parameter, page_alloc.shuffle_page_order, is included to change
the page size where randomization occurs.

[1]: See ACPI 6.2 Section 5.2.27.5 Memory Side Cache Information Structure 

---

Dan Williams (3):
      mm: Shuffle initial free memory
      mm: Move buddy list manipulations into helpers
      mm: Maintain randomization of page free lists


 include/linux/list.h     |   17 +++
 include/linux/mm.h       |    5 -
 include/linux/mm_types.h |    3 +
 include/linux/mmzone.h   |   57 ++++++++++
 mm/bootmem.c             |    9 +-
 mm/compaction.c          |    4 -
 mm/nobootmem.c           |    7 +
 mm/page_alloc.c          |  267 +++++++++++++++++++++++++++++++++++++++-------
 8 files changed, 317 insertions(+), 52 deletions(-)

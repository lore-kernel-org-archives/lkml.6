Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C518C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7C92087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7C92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJJNdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:33:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:46532 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbeJJNdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:33:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 23:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,363,1534834800"; 
   d="scan'208";a="93850233"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2018 23:13:07 -0700
Subject: [PATCH v3 0/3] Randomize free memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Tue, 09 Oct 2018 23:01:19 -0700
Message-ID: <153915127964.632221.6049959208915289294.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2
* Clarify in the changelog why front-back randomization is not
  sufficient (Michal)
* Rebase on mmotm which results in dropping bootmem randomization and
  adding memblock randomization.

---

Some data exfiltration and return-oriented-programming attacks rely on
the ability to infer the location of sensitive data objects. The kernel
page allocator, especially early in system boot, has predictable
first-in-first out behavior for physical pages. Pages are freed in
physical address order when first onlined.

Quoting Kees:
    "While we already have a base-address randomization
     (CONFIG_RANDOMIZE_MEMORY), attacks against the same hardware and
     memory layouts would certainly be using the predictability of
     allocation ordering (i.e. for attacks where the base address isn't
     important: only the relative positions between allocated memory).
     This is common in lots of heap-style attacks. They try to gain
     control over ordering by spraying allocations, etc.

     I'd really like to see this because it gives us something similar
     to CONFIG_SLAB_FREELIST_RANDOM but for the page allocator."

Another motivation for this change is performance in the presence of a
memory-side cache. In the future, memory-side-cache technology will be
available on generally available server platforms. The proposed
randomization approach has been measured to improve the cache conflict
rate by a factor of 2.5X on a well-known Java benchmark. It avoids
performance peaks and valleys to provide more predictable performance.

The initial randomization in patch1 can be undone over time so patch3 is
introduced to inject entropy on page free decisions. It is reasonable to
ask if the page free entropy is sufficientm but not enough is due to the
in-order initial freeing of pages. At the start of that process putting
page1 in front or behind page0 still keeps them close together, page2 is
still near page1 and has a high chance of being adjacent. As more pages
are added ordering diversity improves, but there is still high page
locality for the low address pages and this leads to no significant
impact to the cache conflict rate.

More details in the patch1 commit message.

Dan Williams (3):
      mm: Shuffle initial free memory
      mm: Move buddy list manipulations into helpers
      mm: Maintain randomization of page free lists


 include/linux/list.h     |   17 +++
 include/linux/mm.h       |    8 +
 include/linux/mm_types.h |    3 +
 include/linux/mmzone.h   |   57 ++++++++++
 mm/compaction.c          |    4 -
 mm/memblock.c            |    9 +-
 mm/memory_hotplug.c      |    2 
 mm/page_alloc.c          |  267 +++++++++++++++++++++++++++++++++++++++-------
 8 files changed, 317 insertions(+), 50 deletions(-)

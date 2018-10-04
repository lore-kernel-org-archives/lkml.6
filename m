Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E0CC65BA7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D486021477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D486021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJDJSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:18:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:27083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJDJSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:18:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 19:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="76041204"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2018 19:27:06 -0700
Subject: [PATCH v2 0/3] Randomize free memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Wed, 03 Oct 2018 19:15:18 -0700
Message-ID: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
* Add support for shuffling hot-added memory (Andrew)
* Update cover letter and commit message to clarify the performance impact
  and relevance to future platforms

[1]: https://lkml.org/lkml/2018/9/15/366

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

More details in the patch1 commit message.

---

Dan Williams (3):
      mm: Shuffle initial free memory
      mm: Move buddy list manipulations into helpers
      mm: Maintain randomization of page free lists


 include/linux/list.h     |   17 +++
 include/linux/mm.h       |    8 +
 include/linux/mm_types.h |    3 +
 include/linux/mmzone.h   |   57 ++++++++++
 mm/bootmem.c             |    9 +-
 mm/compaction.c          |    4 -
 mm/memory_hotplug.c      |    2 
 mm/nobootmem.c           |    7 +
 mm/page_alloc.c          |  267 +++++++++++++++++++++++++++++++++++++++-------
 9 files changed, 321 insertions(+), 53 deletions(-)

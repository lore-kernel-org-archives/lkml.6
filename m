Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6EBC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE688208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE688208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeGIGeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:34:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:43811 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeGIGeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:34:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 23:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="69722800"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2018 23:34:03 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        <zi.yan@cs.rutgers.edu>, <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 01/21] mm, THP, swap: Enable PMD swap operations for CONFIG_THP_SWAP
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-2-ying.huang@intel.com>
        <CAA9_cmcwczyEb=+3F7HtDDqZA-3rdqgw=gkYipDtx5r+4Kd5Tw@mail.gmail.com>
        <87muv1kluq.fsf@yhuang-dev.intel.com>
        <CAPcyv4hxBwRx_XPt9MrDq6xgvFnCmQhJee_G3-k=c62vxYDv1A@mail.gmail.com>
Date:   Mon, 09 Jul 2018 14:34:02 +0800
In-Reply-To: <CAPcyv4hxBwRx_XPt9MrDq6xgvFnCmQhJee_G3-k=c62vxYDv1A@mail.gmail.com>
        (Dan Williams's message of "Sun, 8 Jul 2018 23:08:24 -0700")
Message-ID: <87bmbglxyd.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Sun, Jul 8, 2018 at 10:40 PM, Huang, Ying <ying.huang@intel.com> wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:

>>> Would that also allow us to clean up the usage of
>>> CONFIG_ARCH_ENABLE_THP_MIGRATION in fs/proc/task_mmu.c? In other
>>> words, what's the point of having nice ifdef'd alternatives in header
>>> files when ifdefs are still showing up in C files, all of it should be
>>> optionally determined by header files.
>>
>> Unfortunately, I think it is not a easy task to wrap all C code via
>> #ifdef in header files.  And it may be over-engineering to wrap them
>> all.  I guess this is why there are still some #ifdef in C files.
>
> That's the entire point. Yes, over-engineer the header files so the
> actual C code is more readable.

Take pagemap_pmd_range() in fs/proc/task_mmu.c as an example, to avoid
#ifdef, we may wrap all code between #ifdef/#endif into a separate
function, put the new function into another C file (which is compiled
only if #ifdef is true), then change header files for that too.

In this way, we avoid #ifdef/#endif, but the code is more complex and
tightly related code may be put into different files.  The readability
may be hurt too.

Maybe you have smarter way to change the code to avoid #ifdef and
improve code readability?

Best Regards,
Huang, Ying

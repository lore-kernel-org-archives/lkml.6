Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F0FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796DD2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796DD2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLDKLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:11:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:35688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbeLDKLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:11:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAEEDB0C3;
        Tue,  4 Dec 2018 10:11:00 +0000 (UTC)
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
To:     David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     ying.huang@intel.com, Michal Hocko <mhocko@suse.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz>
Date:   Tue, 4 Dec 2018 11:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 12:50 AM, David Rientjes wrote:
> This fixes a 13.9% of remote memory access regression and 40% remote
> memory allocation regression on Haswell when the local node is fragmented
> for hugepage sized pages and memory is being faulted with either the thp
> defrag setting of "always" or has been madvised with MADV_HUGEPAGE.
> 
> The usecase that initially identified this issue were binaries that mremap
> their .text segment to be backed by transparent hugepages on startup.
> They do mmap(), madvise(MADV_HUGEPAGE), memcpy(), and mremap().
> 
> This requires a full revert and partial revert of commits merged during
> the 4.20 rc cycle.  The full revert, of ac5b2c18911f ("mm: thp: relax
> __GFP_THISNODE for MADV_HUGEPAGE mappings"), was anticipated to fix large
> amounts of swap activity on the local zone when faulting hugepages by
> falling back to remote memory.  This remote allocation causes the access
> regression and, if fragmented, the allocation regression.
> 
> This patchset also fixes that issue by not attempting direct reclaim at
> all when compaction fails to free a hugepage.  Note that if remote memory
> was also low or fragmented that ac5b2c18911f ("mm: thp: relax
> __GFP_THISNODE for MADV_HUGEPAGE mappings") would only have compounded the
> problem it attempts to address by now thrashing all nodes instead of only
> the local node.
> 
> The reverts for the stable trees will be different: just a straight revert
> of commit ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE
> mappings") is likely needed.
> 
> Cross compiled for architectures with thp support and thp enabled:
> arc (with ISA_ARCV2), arm (with ARM_LPAE), arm64, i386, mips64, powerpc, 
> s390, sparc, x86_64.
> 
> Andrea, is this acceptable?

So, AFAIK, the situation is:

- commit 5265047ac301 in 4.1 introduced __GFP_THISNODE for THP. The
intention came a bit earlier in 4.0 commit 077fcf116c8c. (I admit acking
both as it seemed to make sense).
- The resulting node-reclaim-like behavior regressed Andrea's KVM
workloads, but reverting it (only for madvised or non-default
defrag=always THP by commit ac5b2c18911f) would regress David's
workloads starting with 4.20 to pre-4.1 levels.

If the decision is that it's too late to revert a 4.1 regression for one
kind of workload in 4.20 because it causes regression for another
workload, then I guess we just revert ac5b2c18911f (patch 1) for 4.20
and don't rush a different fix (patch 2) to 4.20. It's not a big
difference if a 4.1 regression is fixed in 4.20 or 4.21?

Because there might be other unexpected consequences of patch 2 that
testing won't be able to catch in the remaining 4.20 rc's. And I'm not
even sure if it will fix Andrea's workloads. While it should prevent
node-reclaim-like thrashing, it will still mean that KVM (or anyone)
won't be able to allocate THP's remotely, even if the local node is
exhausted of both huge and base pages.

> ---
>  drivers/gpu/drm/ttm/ttm_page_alloc.c     |    8 +++---
>  drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |    3 --
>  include/linux/gfp.h                      |    3 +-
>  include/linux/mempolicy.h                |    2 -
>  mm/huge_memory.c                         |   41 +++++++++++--------------------
>  mm/mempolicy.c                           |    7 +++--
>  mm/page_alloc.c                          |   16 ++++++++++++
>  7 files changed, 42 insertions(+), 38 deletions(-)
> 


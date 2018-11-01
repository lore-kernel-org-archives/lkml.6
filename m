Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6BD20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6BD20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeKAVXn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:23:43 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60599 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728414AbeKAVXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:23:43 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14313774-1500050 
        for multiple; Thu, 01 Nov 2018 12:20:16 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Kuo-Hsin Yang <vovoy@chromium.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <154097891543.4007.9898414288875202246@skylake-alporthouse-com>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
References: <20181031081945.207709-1-vovoy@chromium.org>
 <154097891543.4007.9898414288875202246@skylake-alporthouse-com>
Message-ID: <154107481370.4007.2421593962367820741@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
Date:   Thu, 01 Nov 2018 12:20:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2018-10-31 09:41:55)
> Quoting Kuo-Hsin Yang (2018-10-31 08:19:45)
> > The i915 driver uses shmemfs to allocate backing storage for gem
> > objects. These shmemfs pages can be pinned (increased ref count) by
> > shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> > wastes a lot of time scanning these pinned pages. In some extreme case,
> > all pages in the inactive anon lru are pinned, and only the inactive
> > anon lru is scanned due to inactive_ratio, the system cannot swap and
> > invokes the oom-killer. Mark these pinned pages as unevictable to speed
> > up vmscan.
> > 
> > Add check_move_lru_page() to move page to appropriate lru list.
> > 
> > This patch was inspired by Chris Wilson's change [1].
> > 
> > [1]: https://patchwork.kernel.org/patch/9768741/
> > 
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> > ---
> > The previous mapping_set_unevictable patch is worse on gem_syslatency
> > because it defers to vmscan to move these pages to the unevictable list
> > and the test measures latency to allocate 2MiB pages. This performance
> > impact can be solved by explicit moving pages to the unevictable list in
> > the i915 function.
> > 
> > Chris, can you help to run the "igt/benchmarks/gem_syslatency -t 120 -b -m"
> > test with this patch on your testing machine? I tried to run the test on
> > a Celeron N4000, 4GB Ram machine. The mean value with this patch is
> > similar to that with the mlock patch.
> 
> Will do. As you are confident, I'll try a few different machines. :)

I had one anomalous result with Ivybridge, but 3/4 different machines
confirm this is effective. I normalized the latency results from each
such that 0 is the baseline median latency (no i915 activity) and 1 is
the median latency with i915 running drm-tip.

    N           Min           Max        Median           Avg        Stddev
ivb 120      0.701641       2.79209       1.24469     1.3333911    0.40871825
byt 120     -0.108194     0.0777012     0.0485302    0.01343581   0.061524734
bxt 120     -0.262057       6.27002     0.0801667    0.15963388    0.63528121
kbl 120    -0.0891262       1.22326    -0.0245336   0.041492506    0.14929689

Just need to go back and check on ivb, perhaps running on a few older 
chipsets as well. But the evidence so far indicates that this eliminates
the impact of i915 activity on the performance of shrink_page_list,
reducing the amount of crippling stalls under mempressure and often
preventing them.
-Chris

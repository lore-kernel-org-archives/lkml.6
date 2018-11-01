Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2414204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2414204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKAWNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:13:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727644AbeKAWNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:13:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB16BADD6;
        Thu,  1 Nov 2018 13:10:11 +0000 (UTC)
Date:   Thu, 1 Nov 2018 14:09:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vovo Yang <vovoy@chromium.org>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        peterz@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181101130910.GI23921@dhcp22.suse.cz>
References: <20181031081945.207709-1-vovoy@chromium.org>
 <20181031142458.GP32673@dhcp22.suse.cz>
 <cc44aa53-8705-02ea-6c59-f311427d93af@intel.com>
 <20181031164231.GQ32673@dhcp22.suse.cz>
 <CAEHM+4pSkv_fD3Yb2KX1xFrOmRHU1e=+wCBrCyLAAMBG3zP75w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHM+4pSkv_fD3Yb2KX1xFrOmRHU1e=+wCBrCyLAAMBG3zP75w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-11-18 19:28:46, Vovo Yang wrote:
> On Thu, Nov 1, 2018 at 12:42 AM Michal Hocko <mhocko@kernel.org> wrote:
> > On Wed 31-10-18 07:40:14, Dave Hansen wrote:
> > > Didn't we create the unevictable lists in the first place because
> > > scanning alone was observed to be so expensive in some scenarios?
> >
> > Yes, that is the case. I might just misunderstood the code I thought
> > those pages were already on the LRU when unevictable flag was set and
> > we would only move these pages to the unevictable list lazy during the
> > reclaim. If the flag is set at the time when the page is added to the
> > LRU then it should get to the proper LRU list right away. But then I do
> > not understand the test results from previous run at all.
> 
> "gem_syslatency -t 120 -b -m" allocates a lot of anon pages, it consists of
> these looping threads:
>   * ncpu threads to alloc i915 shmem buffers, these buffers are freed by i915
> shrinker.
>   * ncpu threads to mmap, write, munmap an 2 MiB mapping.
>   * 1 thread to cat all files to /dev/null
> 
> Without the unevictable patch, after rebooting and running
> "gem_syslatency -t 120 -b -m", I got these custom vmstat:
>   pgsteal_kswapd_anon 29261
>   pgsteal_kswapd_file 1153696
>   pgsteal_direct_anon 255
>   pgsteal_direct_file 13050
>   pgscan_kswapd_anon 14524536
>   pgscan_kswapd_file 1488683
>   pgscan_direct_anon 1702448
>   pgscan_direct_file 25849
> 
> And meminfo shows large anon lru size during test.
>   # cat /proc/meminfo | grep -i "active("
>   Active(anon):     377760 kB
>   Inactive(anon):  3195392 kB
>   Active(file):      19216 kB
>   Inactive(file):    16044 kB
> 
> With this patch, the custom vmstat after test:
>   pgsteal_kswapd_anon 74962
>   pgsteal_kswapd_file 903588
>   pgsteal_direct_anon 4434
>   pgsteal_direct_file 14969
>   pgscan_kswapd_anon 2814791
>   pgscan_kswapd_file 1113676
>   pgscan_direct_anon 526766
>   pgscan_direct_file 32432
> 
> The anon pgscan count is reduced.

OK, so that explain my question about the test case. Even though you
generate a lot of page cache, the amount is still too small to trigger
pagecache mostly reclaim and anon LRUs are scanned as well.

Now to the difference with the previous version which simply set the
UNEVICTABLE flag on mapping. Am I right assuming that pages are already
at LRU at the time? Is there any reason the mapping cannot have the flag
set before they are added to the LRU?
-- 
Michal Hocko
SUSE Labs

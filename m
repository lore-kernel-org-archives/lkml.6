Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934857AbeEILrT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:47:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48887 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934758AbeEILrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:47:16 -0400
Date: Wed, 9 May 2018 13:47:12 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        Ocean HY1 He <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [External] [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM and
 fill into GFP_ZONE_TABLE
Message-ID: <20180509114712.GP32366@dhcp22.suse.cz>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-4-git-send-email-yehs1@lenovo.com>
 <HK2PR03MB1684653383FFEDAE9B41A548929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <ce3a6f37-3b13-0c35-6895-35156c7a290c@infradead.org>
 <HK2PR03MB16847B78265A033C7310DDCB92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR03MB16847B78265A033C7310DDCB92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-05-18 04:22:10, Huaisheng HS1 Ye wrote:
> 
> > On 05/07/2018 07:33 PM, Huaisheng HS1 Ye wrote:
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index c782e8f..5fe1f63 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -687,6 +687,22 @@ config ZONE_DEVICE
> > >
> > > +config ZONE_NVM
> > > +	bool "Manage NVDIMM (pmem) by memory management (EXPERIMENTAL)"
> > > +	depends on NUMA && X86_64
> > 
> > Hi,
> > I'm curious why this depends on NUMA. Couldn't it be useful in non-NUMA
> > (i.e., UMA) configs?
> > 
> I wrote these patches with two sockets testing platform, and there are two DDRs and two NVDIMMs have been installed to it.
> So, for every socket it has one DDR and one NVDIMM with it. Here is memory region from memblock, you can get its distribution.
> 
>  435 [    0.000000] Zone ranges:
>  436 [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>  437 [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>  438 [    0.000000]   Normal   [mem 0x0000000100000000-0x00000046bfffffff]
>  439 [    0.000000]   NVM      [mem 0x0000000440000000-0x00000046bfffffff]
>  440 [    0.000000]   Device   empty
>  441 [    0.000000] Movable zone start for each node
>  442 [    0.000000] Early memory node ranges
>  443 [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
>  444 [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000a69c2fff]
>  445 [    0.000000]   node   0: [mem 0x00000000a7654000-0x00000000a85eefff]
>  446 [    0.000000]   node   0: [mem 0x00000000ab399000-0x00000000af3f6fff]
>  447 [    0.000000]   node   0: [mem 0x00000000af429000-0x00000000af7fffff]
>  448 [    0.000000]   node   0: [mem 0x0000000100000000-0x000000043fffffff]	Normal 0
>  449 [    0.000000]   node   0: [mem 0x0000000440000000-0x000000237fffffff]	NVDIMM 0
>  450 [    0.000000]   node   1: [mem 0x0000002380000000-0x000000277fffffff]	Normal 1
>  451 [    0.000000]   node   1: [mem 0x0000002780000000-0x00000046bfffffff]	NVDIMM 1
> 
> If we disable NUMA, there is a result as Normal an NVDIMM zones will be overlapping with each other.
> Current mm treats all memory regions equally, it divides zones just by size, like 16M for DMA, 4G for DMA32, and others above for Normal.
> The spanned range of all zones couldn't be overlapped.

No, this is not correct. Zones can overlap.
-- 
Michal Hocko
SUSE Labs

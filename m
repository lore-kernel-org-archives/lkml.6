Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EFA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLRJLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:11:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbeLRJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:11:36 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBI94DJa128576
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:11:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pevdt4gud-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:11:31 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 18 Dec 2018 09:11:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 09:11:25 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBI9BOIM10354984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 09:11:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20499A405C;
        Tue, 18 Dec 2018 09:11:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64FB6A4054;
        Tue, 18 Dec 2018 09:11:23 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Dec 2018 09:11:23 +0000 (GMT)
Date:   Tue, 18 Dec 2018 11:11:21 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
References: <154483851047.1672629.15001135860756738866.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154483852617.1672629.2068988045031389440.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181216124335.GB30212@rapoport-lnx>
 <CAPcyv4hXPm4GnBheTZ5WN6s5Kiw02MW1aWA-s2qC8BqfthT3Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hXPm4GnBheTZ5WN6s5Kiw02MW1aWA-s2qC8BqfthT3Yg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18121809-0028-0000-0000-0000032C1921
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121809-0029-0000-0000-000023E8740B
Message-Id: <20181218091121.GA25499@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:56:36AM -0800, Dan Williams wrote:
> On Sun, Dec 16, 2018 at 4:43 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Fri, Dec 14, 2018 at 05:48:46PM -0800, Dan Williams wrote:
> > > Randomization of the page allocator improves the average utilization of
> > > a direct-mapped memory-side-cache. Memory side caching is a platform
> > > capability that Linux has been previously exposed to in HPC
> > > (high-performance computing) environments on specialty platforms. In
> > > that instance it was a smaller pool of high-bandwidth-memory relative to
> > > higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
> > > be found on general purpose server platforms where DRAM is a cache in
> > > front of higher latency persistent memory [1].
> [..]
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 185bfd4e87bb..fd617928ccc1 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -834,8 +834,16 @@ int __init_memblock memblock_set_sidecache(phys_addr_t base, phys_addr_t size,
> > >               return ret;
> > >
> > >       for (i = start_rgn; i < end_rgn; i++) {
> > > -             type->regions[i].cache_size = cache_size;
> > > -             type->regions[i].direct_mapped = direct_mapped;
> > > +             struct memblock_region *r = &type->regions[i];
> > > +
> > > +             r->cache_size = cache_size;
> > > +             r->direct_mapped = direct_mapped;
> >
> > I think this change can be merged into the previous patch
> 
> Ok, will do.
> 
> > > +             /*
> > > +              * Enable randomization for amortizing direct-mapped
> > > +              * memory-side-cache conflicts.
> > > +              */
> > > +             if (r->size > r->cache_size && r->direct_mapped)
> > > +                     page_alloc_shuffle_enable();
> >
> > It seems that this is the only use for ->direct_mapped in the memblock
> > code. Wouldn't cache_size != 0 suffice? I.e., in the code that sets the
> > memblock region attributes, the cache_size can be set to 0 for the non
> > direct mapped caches, isn't it?
> >
> 
> The HMAT specification allows for other cache-topologies, so it's not
> sufficient to just look for non-zero size when a platform implements a
> set-associative cache. The expectation is that a set-associative cache
> would not need the kernel to perform memory randomization to improve
> the cache utilization.
> 
> The check for memory size > cache-size is a sanity check for a
> platform BIOS or system configuration that mis-reports or mis-sizes
> the cache.

Apparently I didn't explain my point well.

The acpi_numa_memory_affinity_init() already knows whether the cache is
direct mapped or a set-associative. It can just skip calling
memblock_set_sidecache() for the set-associative case.

Another thing I've noticed only now, is that memory randomization is
enabled if there is at least one memory region with a direct mapped side
cache attached and once the randomization is on the cache size and the
mapping mode do not matter. So, I think it's not necessary to store them in
the memory region at all.

-- 
Sincerely yours,
Mike.


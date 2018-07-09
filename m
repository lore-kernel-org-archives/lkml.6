Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB33C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3E520873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3E520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeGIM4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754492AbeGIM4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:56:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33FB3ACEA;
        Mon,  9 Jul 2018 12:56:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BCE3D1E3C36; Mon,  9 Jul 2018 14:56:41 +0200 (CEST)
Date:   Mon, 9 Jul 2018 14:56:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Tony Luck <tony.luck@intel.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: Asynchronous + multithreaded memmap init for
 ZONE_DEVICE
Message-ID: <20180709125641.xpoq66p4r7dzsgyj@quack2.suse.cz>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-07-18 23:49:02, Dan Williams wrote:
> In order to keep pfn_to_page() a simple offset calculation the 'struct
> page' memmap needs to be mapped and initialized in advance of any usage
> of a page. This poses a problem for large memory systems as it delays
> full availability of memory resources for 10s to 100s of seconds.
> 
> For typical 'System RAM' the problem is mitigated by the fact that large
> memory allocations tend to happen after the kernel has fully initialized
> and userspace services / applications are launched. A small amount, 2GB
> of memory, is initialized up front. The remainder is initialized in the
> background and freed to the page allocator over time.
> 
> Unfortunately, that scheme is not directly reusable for persistent
> memory and dax because userspace has visibility to the entire resource
> pool and can choose to access any offset directly at its choosing. In
> other words there is no allocator indirection where the kernel can
> satisfy requests with arbitrary pages as they become initialized.
> 
> That said, we can approximate the optimization by performing the
> initialization in the background, allow the kernel to fully boot the
> platform, start up pmem block devices, mount filesystems in dax mode,
> and only incur the delay at the first userspace dax fault.
> 
> With this change an 8 socket system was observed to initialize pmem
> namespaces in ~4 seconds whereas it was previously taking ~4 minutes.
> 
> These patches apply on top of the HMM + devm_memremap_pages() reworks
> [1]. Andrew, once the reviews come back, please consider this series for
> -mm as well.
> 
> [1]: https://lkml.org/lkml/2018/6/19/108

One question: Why not (in addition to background initialization) have
->direct_access() initialize a block of struct pages around the pfn it
needs if it finds it's not initialized yet? That would make devices usable
immediately without waiting for init to complete...

								Honza
> 
> ---
> 
> Dan Williams (9):
>       mm: Plumb dev_pagemap instead of vmem_altmap to memmap_init_zone()
>       mm: Enable asynchronous __add_pages() and vmemmap_populate_hugepages()
>       mm: Teach memmap_init_zone() to initialize ZONE_DEVICE pages
>       mm: Multithread ZONE_DEVICE initialization
>       mm: Allow an external agent to wait for memmap initialization
>       filesystem-dax: Make mount time pfn validation a debug check
>       libnvdimm, pmem: Initialize the memmap in the background
>       device-dax: Initialize the memmap in the background
>       libnvdimm, namespace: Publish page structure init state / control
> 
> Huaisheng Ye (4):
>       nvdimm/pmem: check the validity of the pointer pfn
>       nvdimm/pmem-dax: check the validity of the pointer pfn
>       s390/block/dcssblk: check the validity of the pointer pfn
>       fs/dax: Assign NULL to pfn of dax_direct_access if useless
> 
> 
>  arch/ia64/mm/init.c             |    5 +
>  arch/powerpc/mm/mem.c           |    5 +
>  arch/s390/mm/init.c             |    8 +
>  arch/sh/mm/init.c               |    5 +
>  arch/x86/mm/init_32.c           |    8 +
>  arch/x86/mm/init_64.c           |   27 +++--
>  drivers/dax/Kconfig             |   10 ++
>  drivers/dax/dax-private.h       |    2 
>  drivers/dax/device-dax.h        |    2 
>  drivers/dax/device.c            |   16 +++
>  drivers/dax/pmem.c              |    5 +
>  drivers/dax/super.c             |   64 +++++++-----
>  drivers/nvdimm/nd.h             |    2 
>  drivers/nvdimm/pfn_devs.c       |   54 ++++++++--
>  drivers/nvdimm/pmem.c           |   17 ++-
>  drivers/nvdimm/pmem.h           |    1 
>  drivers/s390/block/dcssblk.c    |    5 +
>  fs/dax.c                        |   10 +-
>  include/linux/memmap_async.h    |   55 ++++++++++
>  include/linux/memory_hotplug.h  |   18 ++-
>  include/linux/memremap.h        |   31 ++++++
>  include/linux/mm.h              |    8 +
>  kernel/memremap.c               |   85 ++++++++-------
>  mm/memory_hotplug.c             |   73 ++++++++++---
>  mm/page_alloc.c                 |  215 +++++++++++++++++++++++++++++++++------
>  mm/sparse-vmemmap.c             |   56 ++++++++--
>  tools/testing/nvdimm/pmem-dax.c |   11 ++
>  27 files changed, 610 insertions(+), 188 deletions(-)
>  create mode 100644 include/linux/memmap_async.h
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

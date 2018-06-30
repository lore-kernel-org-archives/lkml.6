Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9066DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2BE21525
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2BE21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936233AbeF3CdF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 22:33:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755609AbeF3CdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 22:33:02 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A94F0891;
        Sat, 30 Jun 2018 02:33:01 +0000 (UTC)
Date:   Fri, 29 Jun 2018 19:33:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     david@fromorbit.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, dvyukov@google.com, glider@google.com
Subject: Re: [PATCH v2] kernel/memremap, kasan: Make ZONE_DEVICE with work
 with KASAN
Message-Id: <20180629193300.0ae0f25880a800bd27952b15@linux-foundation.org>
In-Reply-To: <20180629164932.740-1-aryabinin@virtuozzo.com>
References: <20180625170259.30393-1-aryabinin@virtuozzo.com>
        <20180629164932.740-1-aryabinin@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 19:49:32 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> KASAN learns about hot added memory via the memory hotplug notifier.
> The devm_memremap_pages() intentionally skips calling memory hotplug
> notifiers.

Why does it do that?

> So KASAN doesn't know anything about new memory added
> by devm_memremap_pages(). This causes to crash when KASAN tries to
> access non-existent shadow memory:
> 
>  BUG: unable to handle kernel paging request at ffffed0078000000
>  RIP: 0010:check_memory_region+0x82/0x1e0
>  Call Trace:
>   memcpy+0x1f/0x50
>   pmem_do_bvec+0x163/0x720
>   pmem_make_request+0x305/0xac0
>   generic_make_request+0x54f/0xcf0
>   submit_bio+0x9c/0x370
>   submit_bh_wbc+0x4c7/0x700
>   block_read_full_page+0x5ef/0x870
>   do_read_cache_page+0x2b8/0xb30
>   read_dev_sector+0xbd/0x3f0
>   read_lba.isra.0+0x277/0x670
>   efi_partition+0x41a/0x18f0
>   check_partition+0x30d/0x5e9
>   rescan_partitions+0x18c/0x840
>   __blkdev_get+0x859/0x1060
>   blkdev_get+0x23f/0x810
>   __device_add_disk+0x9c8/0xde0
>   pmem_attach_disk+0x9a8/0xf50
>   nvdimm_bus_probe+0xf3/0x3c0
>   driver_probe_device+0x493/0xbd0
>   bus_for_each_drv+0x118/0x1b0
>   __device_attach+0x1cd/0x2b0
>   bus_probe_device+0x1ac/0x260
>   device_add+0x90d/0x1380
>   nd_async_device_register+0xe/0x50
>   async_run_entry_fn+0xc3/0x5d0
>   process_one_work+0xa0a/0x1810
>   worker_thread+0x87/0xe80
>   kthread+0x2d7/0x390
>   ret_from_fork+0x3a/0x50
> 
> Add kasan_add_zero_shadow()/kasan_remove_zero_shadow() - post mm_init()
> interface to map/unmap kasan_zero_page at requested virtual addresses.
> And use it to add/remove the shadow memory for hotpluged/unpluged
> device memory.
> 
> Reported-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>

No cc:stable? Which kernel version(s) do you believe need the fix?

>  include/linux/kasan.h |  13 ++-
>  kernel/memremap.c     |  10 ++
>  mm/kasan/kasan_init.c | 316 +++++++++++++++++++++++++++++++++++++++++++++++---

It's a surprisingly large amount of ode to do something which KASAN
already does for hotplugged memory.  How come?


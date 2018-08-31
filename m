Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F74C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F9C20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F9C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeHaHCd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 03:02:33 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:39073 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeHaHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 03:02:33 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w7V2v9Ou019664
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Aug 2018 11:57:09 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7V2v9P0015769;
        Fri, 31 Aug 2018 11:57:09 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7V2v98X022734;
        Fri, 31 Aug 2018 11:57:09 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3223167; Fri, 31 Aug 2018 11:55:38 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Fri,
 31 Aug 2018 11:55:37 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] mm: zero remaining unavailable struct pages
Thread-Topic: [PATCH 2/2] mm: zero remaining unavailable struct pages
Thread-Index: AQHUOw61nBfwJ4oj8EuIYNq2qyyUlaTTr6mAgAKZ4ACAAlWoAA==
Date:   Fri, 31 Aug 2018 02:55:36 +0000
Message-ID: <20180831025536.GA29753@hori1.linux.bs1.fc.nec.co.jp>
References: <20180823182513.8801-1-msys.mizuma@gmail.com>
 <20180823182513.8801-2-msys.mizuma@gmail.com>
 <7c773dec-ded0-7a1e-b3ad-6c6826851015@microsoft.com>
 <484388a7-1e75-0782-fdfb-20345e1bda0d@gmail.com>
In-Reply-To: <484388a7-1e75-0782-fdfb-20345e1bda0d@gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <28F8C1C11C8CAF4DBC43C8E161F8BB11@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:16:30AM -0400, Masayoshi Mizuma wrote:
> Hi Horiguchi-san and Pavel
> 
> Thank you for your comments!
> The Pavel's additional patch looks good to me, so I will add it to this series.
> 
> However, unfortunately, the movable_node option has something wrong yet...
> When I offline the memory which belongs to movable zone, I got the following
> warning. I'm trying to debug it.
> 
> I try to describe the issue as following. 
> If you have any comments, please let me know.
> 
> WARNING: CPU: 156 PID: 25611 at mm/page_alloc.c:7730 has_unmovable_pages+0x1bf/0x200
> RIP: 0010:has_unmovable_pages+0x1bf/0x200
> ...
> Call Trace:
>  is_mem_section_removable+0xd3/0x160
>  show_mem_removable+0x8e/0xb0
>  dev_attr_show+0x1c/0x50
>  sysfs_kf_seq_show+0xb3/0x110
>  seq_read+0xee/0x480
>  __vfs_read+0x36/0x190
>  vfs_read+0x89/0x130
>  ksys_read+0x52/0xc0
>  do_syscall_64+0x5b/0x180
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fe7b7823f70
> ...
> 
> I added a printk to catch the unmovable page.
> ---
> @@ -7713,8 +7719,12 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>                  * is set to both of a memory hole page and a _used_ kernel
>                  * page at boot.
>                  */
> -               if (found > count)
> +               if (found > count) {
> +                       pr_info("DEBUG: %s zone: %lx page: %lx pfn: %lx flags: %lx found: %ld count: %ld \n",
> +                               __func__, zone, page, page_to_pfn(page), page->flags, found, count);
>                         goto unmovable;
> +               }
> ---
> 
> Then I got the following. The page (PFN: 0x1c0ff130d) flag is 
> 0xdfffffc0040048 (uptodate|active|swapbacked)
> 
> ---
> DEBUG: has_unmovable_pages zone: 0xffff8c0ffff80380 page: 0xffffea703fc4c340 pfn: 0x1c0ff130d flags: 0xdfffffc0040048 found: 1 count: 0 
> ---
> 
> And I got the owner from /sys/kernel/debug/page_owner.
> 
> Page allocated via order 0, mask 0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO)
> PFN 7532909325 type Movable Block 14712713 type Movable Flags 0xdfffffc0040048(uptodate|active|swapbacked)
>  __alloc_pages_nodemask+0xfc/0x270
>  alloc_pages_vma+0x7c/0x1e0
>  handle_pte_fault+0x399/0xe50
>  __handle_mm_fault+0x38e/0x520
>  handle_mm_fault+0xdc/0x210
>  __do_page_fault+0x243/0x4c0
>  do_page_fault+0x31/0x130
>  page_fault+0x1e/0x30
> 
> The page is allocated as anonymous page via page fault.
> I'm not sure, but lru flag should be added to the page...?

There is a small window of no PageLRU flag just after page allocation
until the page is linked to some LRU list.
This kind of unmovability is transient, so retrying can work.

I guess that this warning seems to be visible since commit 15c30bc09085
("mm, memory_hotplug: make has_unmovable_pages more robust")
which turned off the optimization based on the assumption that pages
under ZONE_MOVABLE are always movable.
I think that it helps developers find the issue that permanently
unmovable pages are accidentally located in ZONE_MOVABLE zone.
But even ZONE_MOVABLE zone could have transiently unmovable pages,
so the reported warning seems to me a false charge and should be avoided.
Doing lru_add_drain_all()/drain_all_pages() before has_unmovable_pages()
might be helpful?

Thanks,
Naoya Horiguchi

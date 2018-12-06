Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0530C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E0520989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E0520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeLFJCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:02:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFJCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:02:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6F6B307D85F;
        Thu,  6 Dec 2018 09:02:11 +0000 (UTC)
Received: from [10.36.117.102] (ovpn-117-102.ams2.redhat.com [10.36.117.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA636101961E;
        Thu,  6 Dec 2018 09:02:09 +0000 (UTC)
Subject: Re: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to
 be offlined
To:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <OSalvador@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
References: <20181203100309.14784-1-mhocko@kernel.org>
 <20181205122918.GL1286@dhcp22.suse.cz> <20181205165716.GS1286@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <7ebd7fd7-e53e-9cf3-500b-1fddd4466e33@redhat.com>
Date:   Thu, 6 Dec 2018 10:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181205165716.GS1286@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 06 Dec 2018 09:02:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.18 17:57, Michal Hocko wrote:
> On Wed 05-12-18 13:29:18, Michal Hocko wrote:
> [...]
>> After some more thinking I am not really sure the above reasoning is
>> still true with the current upstream kernel. Maybe I just managed to
>> confuse myself so please hold off on this patch for now. Testing by
>> Oscar has shown this patch is helping but the changelog might need to be
>> updated.
> 
> OK, so Oscar has nailed it down and it seems that 4.4 kernel we have
> been debugging on behaves slightly different. The underlying problem is
> the same though. So I have reworded the changelog and added "just in
> case" PageLRU handling. Naoya, maybe you have an argument that would
> make this void for current upstream kernels.
> 
> I have dropped all the reviewed tags as the patch has changed slightly.
> Thanks a lot to Oscar for his patience and testing he has devoted to
> this issue.
> 
> Btw. the way how we drop all the work on the first page that we cannot
> isolate is just goofy. Why don't we simply migrate all that we already
> have on the list and go on? Something for a followup cleanup though.
> ---
> From 909521051f41ae46a841b481acaf1ed9c695ae7b Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Mon, 3 Dec 2018 10:27:18 +0100
> Subject: [PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to be
>  offlined
> 
> We have received a bug report that an injected MCE about faulty memory
> prevents memory offline to succeed on 4.4 base kernel. The underlying
> reason was that the HWPoison page has an elevated reference count and
> the migration keeps failing. There are two problems with that. First
> of all it is dubious to migrate the poisoned page because we know that
> accessing that memory is possible to fail. Secondly it doesn't make any
> sense to migrate a potentially broken content and preserve the memory
> corruption over to a new location.
> 
> Oscar has found out that 4.4 and the current upstream kernels behave
> slightly differently with his simply testcase
> ===
> 
> int main(void)
> {
>         int ret;
>         int i;
>         int fd;
>         char *array = malloc(4096);
>         char *array_locked = malloc(4096);
> 
>         fd = open("/tmp/data", O_RDONLY);
>         read(fd, array, 4095);
> 
>         for (i = 0; i < 4096; i++)
>                 array_locked[i] = 'd';
> 
>         ret = mlock((void *)PAGE_ALIGN((unsigned long)array_locked), sizeof(array_locked));
>         if (ret)
>                 perror("mlock");
> 
>         sleep (20);
> 
>         ret = madvise((void *)PAGE_ALIGN((unsigned long)array_locked), 4096, MADV_HWPOISON);
>         if (ret)
>                 perror("madvise");
> 
>         for (i = 0; i < 4096; i++)
>                 array_locked[i] = 'd';
> 
>         return 0;
> }
> ===
> 
> + offline this memory.
> 
> In 4.4 kernels he saw the hwpoisoned page to be returned back to the LRU
> list
> kernel:  [<ffffffff81019ac9>] dump_trace+0x59/0x340
> kernel:  [<ffffffff81019e9a>] show_stack_log_lvl+0xea/0x170
> kernel:  [<ffffffff8101ac71>] show_stack+0x21/0x40
> kernel:  [<ffffffff8132bb90>] dump_stack+0x5c/0x7c
> kernel:  [<ffffffff810815a1>] warn_slowpath_common+0x81/0xb0
> kernel:  [<ffffffff811a275c>] __pagevec_lru_add_fn+0x14c/0x160
> kernel:  [<ffffffff811a2eed>] pagevec_lru_move_fn+0xad/0x100
> kernel:  [<ffffffff811a334c>] __lru_cache_add+0x6c/0xb0
> kernel:  [<ffffffff81195236>] add_to_page_cache_lru+0x46/0x70
> kernel:  [<ffffffffa02b4373>] extent_readpages+0xc3/0x1a0 [btrfs]
> kernel:  [<ffffffff811a16d7>] __do_page_cache_readahead+0x177/0x200
> kernel:  [<ffffffff811a18c8>] ondemand_readahead+0x168/0x2a0
> kernel:  [<ffffffff8119673f>] generic_file_read_iter+0x41f/0x660
> kernel:  [<ffffffff8120e50d>] __vfs_read+0xcd/0x140
> kernel:  [<ffffffff8120e9ea>] vfs_read+0x7a/0x120
> kernel:  [<ffffffff8121404b>] kernel_read+0x3b/0x50
> kernel:  [<ffffffff81215c80>] do_execveat_common.isra.29+0x490/0x6f0
> kernel:  [<ffffffff81215f08>] do_execve+0x28/0x30
> kernel:  [<ffffffff81095ddb>] call_usermodehelper_exec_async+0xfb/0x130
> kernel:  [<ffffffff8161c045>] ret_from_fork+0x55/0x80
> 
> And that later confuses the hotremove path because an LRU page is
> attempted to be migrated and that fails due to an elevated reference
> count. It is quite possible that the reuse of the HWPoisoned page is
> some kind of fixed race condition but I am not really sure about that.
> 
> With the upstream kernel the failure is slightly different. The page
> doesn't seem to have LRU bit set but isolate_movable_page simply fails
> and do_migrate_range simply puts all the isolated pages back to LRU and
> therefore no progress is made and scan_movable_pages finds same set of
> pages over and over again.
> 
> Fix both cases by explicitly checking HWPoisoned pages before we even
> try to get a reference on the page, try to unmap it if it is still
> mapped. As explained by Naoya
> : Hwpoison code never unmapped those for no big reason because
> : Ksm pages never dominate memory, so we simply didn't have strong
> : motivation to save the pages.
> 
> Also put WARN_ON(PageLRU) in case there is a race and we can hit LRU
> HWPoison pages which shouldn't happen but I couldn't convince myself
> about that.
> 
> Debugged-by: Oscar Salvador <osalvador@suse.com>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memory_hotplug.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c6c42a7425e5..cfa1a2736876 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -34,6 +34,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/memblock.h>
>  #include <linux/compaction.h>
> +#include <linux/rmap.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -1366,6 +1367,21 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			pfn = page_to_pfn(compound_head(page))
>  				+ hpage_nr_pages(page) - 1;
>  
> +		/*
> +		 * HWPoison pages have elevated reference counts so the migration would
> +		 * fail on them. It also doesn't make any sense to migrate them in the
> +		 * first place. Still try to unmap such a page in case it is still mapped
> +		 * (e.g. current hwpoison implementation doesn't unmap KSM pages but keep
> +		 * the unmap as the catch all safety net).
> +		 */
> +		if (PageHWPoison(page)) {
> +			if (WARN_ON(PageLRU(page)))
> +				isolate_lru_page(page);
> +			if (page_mapped(page))
> +				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
> +			continue;
> +		}
> +
>  		if (!get_page_unless_zero(page))
>  			continue;
>  		/*
> 

Complicated stuff. With or without the LRU handling

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5299C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724CB20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724CB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeICNT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:19:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbeICNT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:19:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E09B5AEF7;
        Mon,  3 Sep 2018 09:00:13 +0000 (UTC)
Date:   Mon, 3 Sep 2018 11:00:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jslaby@suse.cz" <jslaby@suse.cz>
Subject: Re: [PATCH] mm: Disable deferred struct page for 32-bit arches
Message-ID: <20180903090011.GB14951@dhcp22.suse.cz>
References: <20180831150506.31246-1-pavel.tatashin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831150506.31246-1-pavel.tatashin@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-08-18 15:05:09, Pavel Tatashin wrote:
> Deferred struct page init is needed only on systems with large amount of
> physical memory to improve boot performance. 32-bit systems do not benefit
> from this feature.
> 
> Jiri reported a problem where deferred struct pages do not work well with
> x86-32:
> 
> [    0.035162] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.035725] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.036269] Initializing CPU#0
> [    0.036513] Initializing HighMem for node 0 (00036ffe:0007ffe0)
> [    0.038459] page:f6780000 is uninitialized and poisoned
> [    0.038460] raw: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
> [    0.039509] page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
> [    0.040038] ------------[ cut here ]------------
> [    0.040399] kernel BUG at include/linux/page-flags.h:293!
> [    0.040823] invalid opcode: 0000 [#1] SMP PTI
> [    0.041166] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc1_pt_jiri #9
> [    0.041694] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
> [    0.042496] EIP: free_highmem_page+0x64/0x80
> [    0.042839] Code: 13 46 d8 c1 e8 18 5d 83 e0 03 8d 04 c0 c1 e0 06 ff 80 ec 5f 44 d8 c3 8d b4 26 00 00 00 00 ba 08 65 28 d8 89 d8 e8 fc 71 02 00 <0f> 0b 8d 76 00 8d bc 27 00 00 00 00 ba d0 b1 26 d8 89 d8 e8 e4 71
> [    0.044338] EAX: 0000003c EBX: f6780000 ECX: 00000000 EDX: d856cbe8
> [    0.044868] ESI: 0007ffe0 EDI: d838df20 EBP: d838df00 ESP: d838defc
> [    0.045372] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210086
> [    0.045913] CR0: 80050033 CR2: 00000000 CR3: 18556000 CR4: 00040690
> [    0.046413] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    0.046913] DR6: fffe0ff0 DR7: 00000400
> [    0.047220] Call Trace:
> [    0.047419]  add_highpages_with_active_regions+0xbd/0x10d
> [    0.047854]  set_highmem_pages_init+0x5b/0x71
> [    0.048202]  mem_init+0x2b/0x1e8
> [    0.048460]  start_kernel+0x1d2/0x425
> [    0.048757]  i386_start_kernel+0x93/0x97
> [    0.049073]  startup_32_smp+0x164/0x168
> [    0.049379] Modules linked in:
> [    0.049626] ---[ end trace 337949378db0abbb ]---
> 
> We free highmem pages before their struct pages are initialized:
> 
> mem_init()
>  set_highmem_pages_init()
>   add_highpages_with_active_regions()
>    free_highmem_page()
>     .. Access uninitialized struct page here..
> 
> Because there is no reason to have this feature on 32-bit systems, just
> disable it.
> 
> Fixes: 2e3ca40f03bb ("mm: relax deferred struct page requirements")
> Cc: stable@vger.kernel.org
> 
> Reported-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

I would swear something like this has been already proposed.
Anyway, looks good to me. I guess we could fix 32b but there is no good
reason to complicate 32b code just to allow for an optimization which is
not worth it.

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a550635ea5c3..de64ea658716 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -637,6 +637,7 @@ config DEFERRED_STRUCT_PAGE_INIT
>  	depends on NO_BOOTMEM
>  	depends on SPARSEMEM
>  	depends on !NEED_PER_CPU_KM
> +	depends on 64BIT
>  	help
>  	  Ordinarily all struct pages are initialised during early boot in a
>  	  single thread. On very large machines this can take a considerable
> -- 
> 2.18.0

-- 
Michal Hocko
SUSE Labs

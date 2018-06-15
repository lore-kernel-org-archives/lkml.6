Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F2ECC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F3208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gtd3gK9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1F3208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756194AbeFOOCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:02:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59826 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbeFOOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:00:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FDxJAi074976;
        Fri, 15 Jun 2018 14:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=ifCgoz48Xb3CivFraPnAUyk0bQKybU0DNpjJPlhLmYs=;
 b=Gtd3gK9o0+pkw59E0MjSSr6TJzoAHBcnUC8uzVfsLGECFycJdut3USPQUZiCGc0rtheK
 p/PLcSM6Rh9YdYMr0/TE/P/qdggEozg3MoH3qVNtJhtMUTmDISxzMlHqYVyW8Fm+ftBZ
 2TFtt1Ur8NjlCDXUr81tahC73FWRRWV/2a5Fat19eKVWBehoy0Ao6B0SSvUSMOx32R4Q
 FOAkiyRWAFga/yajOoQeBmnAkkSPDZULUD4YfxxE5jK63IOwDvsk4DEv9Xl5Idod0zYA
 BbHSnvJ7oriPyhT6xw3LVgN0KaLOGS6A1XkS2Lk7olemVKdjRZsLkWMM6WjgMhEdcQzl 1A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jk0xrh65b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 14:00:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5FE07kH004543
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 14:00:07 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5FE03pK016866;
        Fri, 15 Jun 2018 14:00:03 GMT
Received: from xakep.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 07:00:02 -0700
Date:   Fri, 15 Jun 2018 10:00:00 -0400
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oscar Salvador <osalvador@techadventures.net>,
        Oscar Salvador <osalvador@suse.de>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v3] x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved
Message-ID: <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
References: <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
 <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp>
 <20180613090700.GG13364@dhcp22.suse.cz>
 <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp>
 <20180614053859.GA9863@techadventures.net>
 <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp>
 <20180614213033.GA19374@techadventures.net>
 <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp>
 <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp>
 <20180615084142.GE24039@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615084142.GE24039@dhcp22.suse.cz>
User-Agent: NeoMutt/20180512
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-15 10:41:42, Michal Hocko wrote:
> On Fri 15-06-18 07:29:48, Naoya Horiguchi wrote:
> [...]
> > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Date: Thu, 14 Jun 2018 16:04:36 +0900
> > Subject: [PATCH] x86/e820: put !E820_TYPE_RAM regions into memblock.reserved
> > 
> > There is a kernel panic that is triggered when reading /proc/kpageflags
> > on the kernel booted with kernel parameter 'memmap=nn[KMG]!ss[KMG]':
> > 
> >   BUG: unable to handle kernel paging request at fffffffffffffffe
> >   PGD 9b20e067 P4D 9b20e067 PUD 9b210067 PMD 0
> >   Oops: 0000 [#1] SMP PTI
> >   CPU: 2 PID: 1728 Comm: page-types Not tainted 4.17.0-rc6-mm1-v4.17-rc6-180605-0816-00236-g2dfb086ef02c+ #160
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.fc28 04/01/2014
> >   RIP: 0010:stable_page_flags+0x27/0x3c0
> >   Code: 00 00 00 0f 1f 44 00 00 48 85 ff 0f 84 a0 03 00 00 41 54 55 49 89 fc 53 48 8b 57 08 48 8b 2f 48 8d 42 ff 83 e2 01 48 0f 44 c7 <48> 8b 00 f6 c4 01 0f 84 10 03 00 00 31 db 49 8b 54 24 08 4c 89 e7
> >   RSP: 0018:ffffbbd44111fde0 EFLAGS: 00010202
> >   RAX: fffffffffffffffe RBX: 00007fffffffeff9 RCX: 0000000000000000
> >   RDX: 0000000000000001 RSI: 0000000000000202 RDI: ffffed1182fff5c0
> >   RBP: ffffffffffffffff R08: 0000000000000001 R09: 0000000000000001
> >   R10: ffffbbd44111fed8 R11: 0000000000000000 R12: ffffed1182fff5c0
> >   R13: 00000000000bffd7 R14: 0000000002fff5c0 R15: ffffbbd44111ff10
> >   FS:  00007efc4335a500(0000) GS:ffff93a5bfc00000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: fffffffffffffffe CR3: 00000000b2a58000 CR4: 00000000001406e0
> >   Call Trace:
> >    kpageflags_read+0xc7/0x120
> >    proc_reg_read+0x3c/0x60
> >    __vfs_read+0x36/0x170
> >    vfs_read+0x89/0x130
> >    ksys_pread64+0x71/0x90
> >    do_syscall_64+0x5b/0x160
> >    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >   RIP: 0033:0x7efc42e75e23
> >   Code: 09 00 ba 9f 01 00 00 e8 ab 81 f4 ff 66 2e 0f 1f 84 00 00 00 00 00 90 83 3d 29 0a 2d 00 00 75 13 49 89 ca b8 11 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 db d3 01 00 48 89 04 24
> > 
> > According to kernel bisection, this problem became visible due to commit
> > f7f99100d8d9 which changes how struct pages are initialized.
> > 
> > Memblock layout affects the pfn ranges covered by node/zone. Consider
> > that we have a VM with 2 NUMA nodes and each node has 4GB memory, and
> > the default (no memmap= given) memblock layout is like below:
> > 
> >   MEMBLOCK configuration:
> >    memory size = 0x00000001fff75c00 reserved size = 0x000000000300c000
> >    memory.cnt  = 0x4
> >    memory[0x0]     [0x0000000000001000-0x000000000009efff], 0x000000000009e000 bytes on node 0 flags: 0x0
> >    memory[0x1]     [0x0000000000100000-0x00000000bffd6fff], 0x00000000bfed7000 bytes on node 0 flags: 0x0
> >    memory[0x2]     [0x0000000100000000-0x000000013fffffff], 0x0000000040000000 bytes on node 0 flags: 0x0
> >    memory[0x3]     [0x0000000140000000-0x000000023fffffff], 0x0000000100000000 bytes on node 1 flags: 0x0
> >    ...
> > 
> > If you give memmap=1G!4G (so it just covers memory[0x2]),
> > the range [0x100000000-0x13fffffff] is gone:
> > 
> >   MEMBLOCK configuration:
> >    memory size = 0x00000001bff75c00 reserved size = 0x000000000300c000
> >    memory.cnt  = 0x3
> >    memory[0x0]     [0x0000000000001000-0x000000000009efff], 0x000000000009e000 bytes on node 0 flags: 0x0
> >    memory[0x1]     [0x0000000000100000-0x00000000bffd6fff], 0x00000000bfed7000 bytes on node 0 flags: 0x0
> >    memory[0x2]     [0x0000000140000000-0x000000023fffffff], 0x0000000100000000 bytes on node 1 flags: 0x0
> >    ...
> > 
> > This causes shrinking node 0's pfn range because it is calculated by
> > the address range of memblock.memory. So some of struct pages in the
> > gap range are left uninitialized.
> > 
> > We have a function zero_resv_unavail() which does zeroing the struct
> > pages within the reserved unavailable range (i.e. memblock.memory &&
> > !memblock.reserved). This patch utilizes it to cover all unavailable
> > ranges by putting them into memblock.reserved.
> > 
> > Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Tested-by: Oscar Salvador <osalvador@suse.de>
> 
> OK, this makes sense to me. It is definitely much better than the
> original attempt.
> 
> Unless I am missing something this should be correct
> Acked-by: Michal Hocko <mhocko@suse.com>

First of all thank you Naoya for finding and root causing this issue.

So, with this fix we reserve any hole and !E820_TYPE_RAM or
!E820_TYPE_RESERVED_KERN in e820.  I think, this will work because we
do pfn_valid() check in zero_resv_unavail(), so the ranges that do not have
backing struct pages will be skipped. But, I am worried on the performance
implications of when the holes of invalid memory are rather large. We would
have to loop through it in zero_resv_unavail() one pfn at a time.

Therefore, we might also need to optimize zero_resv_unavail() a little like
this:

6407			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
6408				continue;

Add before "continue":
	pfn = ALIGN_DOWN(pfn, pageblock_nr_pages) + pageblock_nr_pageas - 1.
At least, this way, we would skip a section of invalid memory at a time.

For the patch above:
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

But, I think the 2nd patch with the optimization above should go along this
this fix.

Thank you,
Pasha

> 
> > ---
> >  arch/x86/kernel/e820.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index d1f25c831447..c88c23c658c1 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1248,6 +1248,7 @@ void __init e820__memblock_setup(void)
> >  {
> >  	int i;
> >  	u64 end;
> > +	u64 addr = 0;
> >  
> >  	/*
> >  	 * The bootstrap memblock region count maximum is 128 entries
> > @@ -1264,13 +1265,21 @@ void __init e820__memblock_setup(void)
> >  		struct e820_entry *entry = &e820_table->entries[i];
> >  
> >  		end = entry->addr + entry->size;
> > +		if (addr < entry->addr)
> > +			memblock_reserve(addr, entry->addr - addr);
> > +		addr = end;
> >  		if (end != (resource_size_t)end)
> >  			continue;
> >  
> > +		/*
> > +		 * all !E820_TYPE_RAM ranges (including gap ranges) are put
> > +		 * into memblock.reserved to make sure that struct pages in
> > +		 * such regions are not left uninitialized after bootup.
> > +		 */
> >  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > -			continue;
> > -
> > -		memblock_add(entry->addr, entry->size);
> > +			memblock_reserve(entry->addr, entry->size);
> > +		else
> > +			memblock_add(entry->addr, entry->size);
> >  	}
> >  
> >  	/* Throw away partial pages: */
> > -- 
> > 2.7.4
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

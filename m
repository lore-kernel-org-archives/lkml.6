Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756512AbeEJC5k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:57:40 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:41059 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756359AbeEJC5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:57:36 -0400
X-Google-Smtp-Source: AB8JxZq5PXtDowvawlpZ59b1sJfr2+8Zr+9A9oR4UNZCsCf+nIlVMJitNIy3RB4np0k0vUZwVNjBTJAKYVfR3WwMRe8=
MIME-Version: 1.0
In-Reply-To: <20180509125611.GT32366@dhcp22.suse.cz>
References: <20180411104832.GF23400@dhcp22.suse.cz> <20180509122454.GR32366@dhcp22.suse.cz>
 <CAKTKpr5uPuZUHBnQtDwpGA_d=WTx_5O2SF_+WStO6OMVNe77QQ@mail.gmail.com> <20180509125611.GT32366@dhcp22.suse.cz>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Thu, 10 May 2018 08:27:35 +0530
Message-ID: <CAKTKpr59axOTxFL1eGCR7nvmERYuxKS=DmVX0jTmt53EobmeGw@mail.gmail.com>
Subject: Re: fd3e45436660 ("ACPI / NUMA: ia64: Parse all entries of SRAT
 memory affinity table")
To: Michal Hocko <mhocko@kernel.org>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, tiantao6@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 6:26 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 09-05-18 18:07:16, Ganapatrao Kulkarni wrote:
>> Hi Michal
>>
>>
>> On Wed, May 9, 2018 at 5:54 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Wed 11-04-18 12:48:32, Michal Hocko wrote:
>> >> Hi,
>> >> my attention was brought to the %subj commit and either I am missing
>> >> something or the patch is quite dubious. What is it actually trying to
>> >> fix? If a BIOS/FW provides more memblocks than the limit then we would
>> >> get misleading numa topology (numactl -H output) but is the situation
>> >> much better with it applied? Numa init code will refuse to init more
>> >> memblocks than the limit and falls back to dummy_numa_init (AFAICS)
>> >> which will break the topology again and numactl -H will have a
>> >> misleading output anyway.
>>
>> IIRC, the MEMBLOCK beyond max limit getting dropped from visible
>> memory(partial drop from a node).
>> this patch removed any upper limit on memblocks and allowed to parse
>> all entries of SRAT.
>
> Yeah I've understood that much. My question is, however, why do we care
> about parsing the NUMA topology when we fallback into a single NUMA node
> anyway? Or do I misunderstand the code? I do not have any platform with
> that many memblocks.

IMHO, this fix is very much logical by removing the SRAT parsing restriction.
below is the crash log which made us to debug and eventually fix with
this patch.

[    0.000000] NUMA: Adding memblock [0x80000000 - 0xfeffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0xfeffffff]
[    0.000000] NUMA: Adding memblock [0x880000000 - 0xffcffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x880000000-0xffcffffff]
[    0.000000] NUMA: Adding memblock [0xffd000000 - 0xfffffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0xffd000000-0xfffffffff]
[    0.000000] NUMA: Adding memblock [0x8800000000 - 0x8bfcffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x8800000000-0x8bfcffffff]
[    0.000000] NUMA: Adding memblock [0x8bfd000000 - 0x8ffcffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x8bfd000000-0x8ffcffffff]
[    0.000000] NUMA: Adding memblock [0x8ffd000000 - 0x93fcffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x8ffd000000-0x93fcffffff]
[    0.000000] NUMA: Adding memblock [0x93fd000000 - 0x9bfcffffff] on node 1
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x93fd000000-0x9bfcffffff]
[    0.000000] NUMA: Adding memblock [0x9bfd000000 - 0x9ffcffffff] on node 1
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x9bfd000000-0x9ffcffffff]
[    0.000000] NUMA: Warning: invalid memblk node 4 [mem
0x9ffd000000-0xa7fcffffff]
[    0.000000] NUMA: Faking a node at [mem
0x0000000000000000-0x000000a7fcffffff]
[    0.000000] NUMA: Adding memblock [0x802f0000 - 0x802fffff] on node 0
[    0.000000] NUMA: Adding memblock [0x80300000 - 0xbfffffff] on node 0
[    0.000000] NUMA: Adding memblock [0xc4000000 - 0xf5efffff] on node 0
[    0.000000] NUMA: Adding memblock [0xf5f00000 - 0xf5f6ffff] on node 0
[    0.000000] NUMA: Adding memblock [0xf5f70000 - 0xf603ffff] on node 0
[    0.000000] NUMA: Adding memblock [0xf6040000 - 0xf667ffff] on node 0
[    0.000000] NUMA: Adding memblock [0xf6680000 - 0xfe45ffff] on node 0
[    0.000000] NUMA: Adding memblock [0xfe460000 - 0xfe4effff] on node 0
[    0.000000] NUMA: Adding memblock [0xfe4f0000 - 0xfe4fffff] on node 0
[    0.000000] NUMA: Adding memblock [0xfe500000 - 0xfe61ffff] on node 0
[    0.000000] NUMA: Adding memblock [0xfe620000 - 0xfeffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x880000000 - 0xfffffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x8800000000 - 0x93fcffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x93fd000000 - 0x9ffcffffff] on node 0
[    0.000000] NUMA: Warning: invalid memblk node 4 [mem
0x9ffd000000-0xa7fcffffff]
[    0.000000] Unable to handle kernel NULL pointer dereference at
virtual address 00001b40
[    0.000000] pgd = fffffc0009570000
[    0.000000] [00001b40] *pgd=000000a7fcfe0003,
*pud=000000a7fcfe0003, *pmd=000000a7fcfe0003, *pte=0000000000000000
[    0.000000] Internal error: Oops: 96000006 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
4.11.12-11.cavium.ml.aarch64 #1
[    0.000000] Hardware name: (null) (DT)
[    0.000000] task: fffffc0008d35780 task.stack: fffffc0008cf0000
[    0.000000] PC is at sparse_early_usemaps_alloc_node+0x20/0xb4
[    0.000000] LR is at sparse_init+0xec/0x204
[    0.000000] pc : [<fffffc0008bd389c>] lr : [<fffffc0008bd3b88>]
pstate: 80000089
[    0.000000] sp : fffffc0008cf3e40

thanks
Ganapat
>
> --
> Michal Hocko
> SUSE Labs

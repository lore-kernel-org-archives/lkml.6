Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C40DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1548D20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1548D20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632884AbeKXC4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:56:02 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:57003 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632870AbeKXC4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:56:01 -0500
Subject: Re: NO_BOOTMEM breaks alpha pc164
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org
References: <8c8e3dba-7adf-96c6-195c-311050256743@linux.ee>
 <20181123071448.GE5704@rapoport-lnx>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <78de90df-d88b-d82f-baf1-f0218af7a341@linux.ee>
Date:   Fri, 23 Nov 2018 18:11:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181123071448.GE5704@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The bad commit is swith to NO_BOOTMEM.
> 
> [ ... ]
>   
>> How do I debug it?
> 
> Apparently, some of the early memory registration is not properly converted
> from bootmem to memblock + nobootmem for your system.
> 
> You can try applying the below patch to enable debug printouts from
> memblock, maybe it'll shed some more light.

Here is the serial console output from a boot with the debug patch applied:

(boot dka0.0.0.5.0 -flags 0)
block 0 of dka0.0.0.5.0 is a valid boot block
reading 161 blocks from dka0.0.0.5.0
bootstrap code read in
base = 180000, image_start = 0, image_bytes = 14200
initializing HWRPB at 2000
initializing page table at 172000
initializing machine state
setting affinity to the primary CPU
jumping to bootstrap code
aboot: Linux/Alpha SRM bootloader version 1.0_pre20040408
aboot: switching to OSF/1 PALcode version 1.23
aboot: booting from device 'SCSI 0 5 0 0 0 0 0'
aboot: valid disklabel found: 4 partitions.
aboot: loading uncompressed test...
aboot: loading compressed test...
aboot: PHDR 0 vaddr 0xfffffc0000310000 offset 0x2000 size 0x79925c
aboot: bss at 0xfffffc0000aa925c, size 0x16469c
aboot: zero-filling 1459868 bytes at 0xfffffc0000aa925c
aboot: starting kernel test with arguments root=/dev/sda2 console=ttyS0
[    0.000000] Linux version 4.20.0-rc2-00068-gda5322e65940-dirty (mroos@pc164) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #115 Fri Nov 23 17:38:17 EET 2018
[    0.000000] Booting on EB164 variation PC164 using machine vector PC164 from SRM
[    0.000000] Major Options: EV56 LEGACY_START VERBOSE_MCHECK DISCONTIGMEM MAGIC_SYSRQ
[    0.000000] Command line: root=/dev/sda2 console=ttyS0
[    0.000000] Raw memory layout:
[    0.000000]  memcluster  0, usage 1, start        0, end      192
[    0.000000]  memcluster  1, usage 0, start      192, end    32651
[    0.000000]  memcluster  2, usage 1, start    32651, end    32768
[    0.000000] Initializing bootmem allocator on Node ID 0
[    0.000000]  memcluster  1, usage 0, start      192, end    32651
[    0.000000]  Detected node memory:   start      192, end    32651
[    0.000000] memblock_add: [0x0000000000000000-0x000000000ff15fff] setup_memory+0x39c/0x478
[    0.000000] memblock_reserve: [0x0000000000300000-0x0000000000c11fff] setup_memory+0x444/0x478
[    0.000000] 1024K Bcache detected; load hit latency 30 cycles, load miss latency 212 cycles
[    0.000000] pci: cia revision 2
[    0.000000] memblock_alloc_try_nid: 104 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pci_controller+0x2c/0x50
[    0.000000] memblock_reserve: [0x000000000ff15f80-0x000000000ff15fe7] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 64 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_resource+0x2c/0x40
[    0.000000] memblock_reserve: [0x000000000ff15f40-0x000000000ff15f7f] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 40 bytes align=0x8000 nid=0 from=0x0000000000000000 max_addr=0x0000000000000000 iommu_arena_new_node+0x74/0x1b0
[    0.000000] memblock_reserve: [0x000000000ff10000-0x000000000ff10027] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 40 bytes align=0x8000 nid=0 from=0x0000000000000000 max_addr=0x0000000000000000 iommu_arena_new_node+0x104/0x1b0
[    0.000000] memblock_reserve: [0x000000000ff08000-0x000000000ff08027] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 1024 bytes align=0x8000 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 do_init_arch+0x37c/0x448
[    0.000000] memblock_reserve: [0x000000000ff00000-0x000000000ff003ff] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid_nopanic: 1835008 bytes align=0x20 nid=0 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_node_mem_map+0x7c/0xa8
[    0.000000] memblock_reserve: [0x000000000fd40000-0x000000000fefffff] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid_nopanic: 16 bytes align=0x20 nid=0 from=0x0000000000000000 max_addr=0x0000000000000000 setup_usemap.isra.111+0x5c/0x78
[    0.000000] memblock_reserve: [0x000000000ff15f20-0x000000000ff15f2f] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 29 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.14+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15f00-0x000000000ff15f1c] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 29 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.14+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15ee0-0x000000000ff15efc] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 29 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.14+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15ec0-0x000000000ff15edc] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid_nopanic: 8192 bytes align=0x2000 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_alloc_info+0x5c/0xc8
[    0.000000] memblock_reserve: [0x000000000ff12000-0x000000000ff13fff] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid_nopanic: 32768 bytes align=0x2000 nid=-1 from=0x000003ffffffffff max_addr=0x0000000000000000 setup_per_cpu_areas+0x70/0x118
[    0.000000] memblock_reserve: [0x000000000fd38000-0x000000000fd3ffff] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 8 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15ea0-0x000000000ff15ea7] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 8 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15e80-0x000000000ff15e87] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 4 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15e60-0x000000000ff15e63] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 8 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15e40-0x000000000ff15e47] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 240 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15d40-0x000000000ff15e2f] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 105 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15cc0-0x000000000ff15d28] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 1024 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff158c0-0x000000000ff15cbf] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 1032 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff154a0-0x000000000ff158a7] memblock_alloc_internal+0x170/0x278
[    0.000000] memblock_alloc_try_nid: 80 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc.constprop.29+0x28/0x40
[    0.000000] memblock_reserve: [0x000000000ff15440-0x000000000ff1548f] memblock_alloc_internal+0x170/0x278
[    0.000000] __memblock_free_early: [0x000000000ff12000-0x000000000ff13fff] pcpu_free_alloc_info+0x2c/0x40
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32427
[    0.000000] Kernel command line: root=/dev/sda2 console=ttyS0
[    0.000000] memblock_alloc_try_nid_nopanic: 262144 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_large_system_hash+0x258/0x3dc
[    0.000000] memblock_reserve: [0x000000000fcf8000-0x000000000fd37fff] memblock_alloc_internal+0x170/0x278
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
[    0.000000] memblock_alloc_try_nid_nopanic: 131072 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_large_system_hash+0x258/0x3dc
[    0.000000] memblock_reserve: [0x000000000fcd8000-0x000000000fcf7fff] memblock_alloc_internal+0x170/0x278
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 249680K/261208K available (5455K kernel code, 372K rwdata, 1740K rodata, 200K init, 1425K bss, 11528K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=128
[    0.000000] NR_IRQS: 35
[    0.000000] clocksource: rpcc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 3822520893 ns
[    0.001953] Console: colour VGA+ 80x25
[    0.074218] printk: console [ttyS0] enabled
[    0.076171] Calibrating delay loop... 985.92 BogoMIPS (lpj=480768)
[    0.084960] pid_max: default: 32768 minimum: 301
[    0.086914] Mount-cache hash table entries: 1024 (order: 0, 8192 bytes)
[    0.087890] Mountpoint-cache hash table entries: 1024 (order: 0, 8192 bytes)
[    0.098632] devtmpfs: initialized
[    0.101562] random: get_random_u32 called from bucket_table_alloc.isra.19+0xbc/0x280 with crng_init=0
[    0.102539] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1866466235866741 ns
[    0.103515] futex hash table entries: 256 (order: -1, 6144 bytes)
[    0.106445] NET: Registered protocol family 16
[    0.108398] pci: passed tb register update test
[    0.109374] pci: passed sg loopback i/o read test
[    0.110351] pci: passed tbia test
[    0.111328] pci: passed pte write cache snoop test

halted CPU 0

halt code = 7
machine check while in PAL mode
PC = 1814c
boot failure
>>>

-- 
Meelis Roos <mroos@linux.ee>

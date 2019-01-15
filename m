Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D0C20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfAOGvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:51:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52286 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfAOGvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:51:04 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43f1Fd5nT9z9vBKb;
        Tue, 15 Jan 2019 07:51:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id R1HoEa-GsUfH; Tue, 15 Jan 2019 07:51:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43f1Fd5Dxxz9vBKZ;
        Tue, 15 Jan 2019 07:51:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 25B628B7D0;
        Tue, 15 Jan 2019 07:51:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AVpSXPNcQhkP; Tue, 15 Jan 2019 07:51:03 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 381478B761;
        Tue, 15 Jan 2019 07:51:01 +0100 (CET)
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for
 STRICT_KERNEL_RWX
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
Date:   Tue, 15 Jan 2019 07:51:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115003353.GD22334@latitude>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/01/2019 à 01:33, Jonathan Neuschäfer a écrit :
> On Mon, Jan 14, 2019 at 07:23:07PM +0100, Christophe Leroy wrote:
>>
>>
>> Le 13/01/2019 à 22:02, Jonathan Neuschäfer a écrit :
>>> On Sun, Jan 13, 2019 at 08:43:07PM +0100, Christophe Leroy wrote:
>>>> Le 13/01/2019 à 19:16, Jonathan Neuschäfer a écrit :
>>>>> I just tested the whole series on my Wii (I didn't test any intermediate
>>>>> steps). Without CONFIG_STRICT_KERNEL_RWX, it seems to work fine, but
>>>>> with it, I get the following error while booting:
> [...]
>> I can't see anything special in your setup, and this failure looks rather
>> unexpected because I can't see anything done that early when
>> CONFIG_STRICT_KERNEL_RWX is selected.
>>
>> Does CONFIG_STRICT_KERNEL_RWX works properly without my serie ?
> 
> I hadn't tried this before, but yes, without this series (on v5.0-rc2),
> a kernel with CONFIG_STRICT_KERNEL_RWX boots.
> 
> I've checked it patch-by-patch now (with STRICT_KERNEL_RWX):
> 
> - patches 1 and 2 build and boot fine
> - patches 3 to 6 build, but fail to boot with this error:

The bug is in patch 2, mmu_mapin_ram() should return base instead of 
returning 0 when __map_without_bats is set.

> 
> 	top of MEM2 @ 13F00000
> 
> 	zImage starting: loaded at 0x00e00000 (sp: 0x01588fa0)
> 	Allocating 0x14e92c8 bytes for kernel...
> 	Decompressing (0x00000000 <- 0x00e11000:0x01586ba7)...
> 	Done! Decompressed 0xdc01f4 bytes
> 
> 	Linux/PowerPC load: root=/dev/mmcblk0p2 rootwait console=usbgecko1
> 	Finalizing device tree... flat tree at 0x15897a0
> 	[    0.000000] printk: bootconsole [udbg0] enabled
> 	[    0.000000] Total memory = 319MB; using 1024kB for hash table (at (ptrval))
> 	[    0.000000] RAM mapped without BATs
> 	[    0.000000] RAM mapped without BATs
> 	[    0.000000] ------------[ cut here ]------------
> 	[    0.000000] kernel BUG at arch/powerpc/mm/pgtable_32.c:223!
> 	[    0.000000] Oops: Exception in kernel mode, sig: 5 [#1]
> 	[    0.000000] BE PREEMPT
> 	[    0.000000] Modules linked in:
> 	[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-wii-00024-g596f9fe23c13 #1337
> 	[    0.000000] NIP:  c0017c4c LR: c0a836a0 CTR: c001edc4
> 	[    0.000000] REGS: c0d9deb0 TRAP: 0700   Not tainted  (5.0.0-rc1-wii-00024-g596f9fe23c13)
> 	[    0.000000] MSR:  00020030 <IR,DR>  CR: 42000888  XER: 20000000
> 	[    0.000000]
> 	[    0.000000] GPR00: c0a836a0 c0d9df60 c0d2a4a0 c0d29c00 00000000 c16ff000 c0d9de28 c0dc0000
> 	[    0.000000] GPR08: c0d9c000 00000001 00000001 00000000 28000824 00000000 00000000 00000000
> 	[    0.000000] GPR16: 00000000 00000000 00000020 00000000 c0860000 c0da0000 c0000000 c0a7d000
> 	[    0.000000] GPR24: c0acd55c c0d487c8 13f00000 c0d29000 00000c00 00000311 c0000000 c0d487c8
> 	[    0.000000] NIP [c0017c4c] map_kernel_page+0x78/0xf0
> 	[    0.000000] LR [c0a836a0] mapin_ram+0xe0/0x14c
> 	[    0.000000] Call Trace:
> 	[    0.000000] [c0d9df60] [c0a83f54] mmu_mapin_ram+0x54/0x1a4 (unreliable)
> 	[    0.000000] [c0d9df90] [c0a836a0] mapin_ram+0xe0/0x14c
> 	[    0.000000] [c0d9dfd0] [c0a83578] MMU_init+0x158/0x1a0
> 	[    0.000000] [c0d9dff0] [c0003418] start_here+0x40/0x78
> 	[    0.000000] Instruction dump:
> 	[    0.000000] 55290026 57c5b53a 7ca54a14 3d204000 7f854800 3ca5c000 419e0088 81250000
> 	[    0.000000] 552afffe 552907fe 7d4a4b79 4082004c <0f0a0000> 54840026 7c84eb78 9081000c
> 	[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x34/0x6c with crng_init=0
> 	[    0.000000] ---[ end trace 0000000000000000 ]---
> 	[    0.000000]
> 	[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> 	[    0.000000] Rebooting in 180 seconds..
> 
> - patches 7 to 11 fail to build with this error (really a warning, but
>    arch/powerpc doesn't allow warnings by default):
> 
> 	  CC      arch/powerpc/mm/ppc_mmu_32.o
> 	../arch/powerpc/mm/ppc_mmu_32.c:133:13: error: ‘clearibat’ defined but not used [-Werror=unused-function]
> 	 static void clearibat(int index)
> 		     ^~~~~~~~~
> 	../arch/powerpc/mm/ppc_mmu_32.c:115:13: error: ‘setibat’ defined but not used [-Werror=unused-function]
> 	 static void setibat(int index, unsigned long virt, phys_addr_t phys,
> 		     ^~~~~~~
> 	cc1: all warnings being treated as errors

Argh ! I have to squash the patch bringing the new functions with the 
one using them (patch 12). The result is a big messy patch which is more 
difficult to review but that's life.

> 
> - patches 12 to 15 build but fail to boot with this error:

Thats the one we need to really understand.

Do you have modules ? If so, can you try without ?

> 
> 	top of MEM2 @ 13F00000
> 
> 	zImage starting: loaded at 0x01000000 (sp: 0x0178afa0)
> 	Allocating 0x166b2c8 bytes for kernel...
> 	Decompressing (0x00000000 <- 0x01011000:0x017880ce)...
> 	Done! Decompressed 0xf421f4 bytes
> 
> 	Linux/PowerPC load: root=/dev/mmcblk0p2 rootwait console=usbgecko1
> 	Finalizing device tree... flat tree at 0x178b7a0
> 	[    0.000000] printk: bootconsole [udbg0] enabled
> 	[    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x00100000 bytes below 0x00000000.
> 	[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-wii-00033-gc263f8162122 #1337
> 	[    0.000000] Call Trace:
> 	[    0.000000] [c0f1ff30] [c00280f0] panic+0x144/0x324 (unreliable)
> 	[    0.000000] [c0f1ff90] [c0c18a34] memblock_alloc_base+0x34/0x44
> 	[    0.000000] [c0f1ffa0] [c0c071e0] MMU_init_hw+0xcc/0x300
> 	[    0.000000] [c0f1ffd0] [c0c06554] MMU_init+0x12c/0x198
> 	[    0.000000] [c0f1fff0] [c0003418] start_here+0x40/0x78
> 	[    0.000000] Rebooting in 180 seconds..
> 
> 
> I'll investigate some more tomorrow.

Thanks a lot for your help.

> 
> Jonathan
> 

Christophe

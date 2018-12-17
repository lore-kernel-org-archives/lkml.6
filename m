Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1FC206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeLQJ3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:29:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10022 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbeLQJ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:29:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43JG7c4VFJz9vGm8;
        Mon, 17 Dec 2018 10:29:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iXIKHKQKBMul; Mon, 17 Dec 2018 10:29:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43JG7c3yqrz9vGll;
        Mon, 17 Dec 2018 10:29:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 14AE08B7BC;
        Mon, 17 Dec 2018 10:29:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AB2C3IJwahOW; Mon, 17 Dec 2018 10:29:16 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D2B678B7C9;
        Mon, 17 Dec 2018 10:29:16 +0100 (CET)
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
Date:   Mon, 17 Dec 2018 10:29:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217012837.GT15324@latitude>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/12/2018 à 02:28, Jonathan Neuschäfer a écrit :
> Hi, thanks for your reply.
> 
> On Thu, Dec 13, 2018 at 03:51:32PM +0100, Christophe Leroy wrote:
>> Hi Again,
>>
>> Le 13/12/2018 à 13:16, Christophe Leroy a écrit :
> [...]
>>> Can you tell/provide the .config and dts used ?
> 
> I'm using wii.dts and almost the wii_defconfig from my tree (save-
> defconfig result is attached), which is 4.20-rc5 plus a few patches:
> 
>    https://github.com/neuschaefer/linux wii-4.20-rc5        (w/o your patches)
>    https://github.com/neuschaefer/linux wii-4.20-rc5-ppcbat (w/ your patches 1-3)
> 
>>> You seem to have 319MB RAM wherease arch/powerpc/boot/dts/wii.dts only
>>> has 88MB Memory:
>>>
>>>       memory {
>>>           device_type = "memory";
>>>           reg = <0x00000000 0x01800000    /* MEM1 24MB 1T-SRAM */
>>>                  0x10000000 0x04000000>;    /* MEM2 64MB GDDR3 */
>>>       };
> 
> This is, I think, because something marks all the address space from 0
> to the end of MEM2 as RAM, and then cuts out a hole in the middle. I'm
> not sure about the exact mechanism.
> 
> Unfortunately this hole has to be treated carefully because it contains
> MMIO devices.
> 
>> Putting the same description in my mpc832x board DTS and doing a few hacks
>> to get the WII functions called, I get the following:
>>
>> [    0.000000] Top of RAM: 0x14000000, Total RAM: 0x5800000
>> [    0.000000] Memory hole size: 232MB
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000000000-0x0000000013ffffff]
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000017fffff]
>> [    0.000000]   node   0: [mem 0x0000000010000000-0x0000000013ffffff]
>> [    0.000000] Initmem setup node 0 [mem
>> 0x0000000000000000-0x0000000013ffffff]
>> [    0.000000] On node 0 totalpages: 22528
>> [    0.000000]   DMA zone: 640 pages used for memmap
>> [    0.000000]   DMA zone: 0 pages reserved
>> [    0.000000]   DMA zone: 22528 pages, LIFO batch:3
>> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
>> [    0.000000] pcpu-alloc: [0] 0
>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 21888
>> [    0.000000] Kernel command line: loglevel=7
>> ip=192.168.2.5:192.168.2.2::255.0
>> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
>> bytes)
>> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>> [    0.000000] Memory: 77060K/90112K available (6548K kernel code, 1156K
>> rwdata,
>> [    0.000000] Kernel virtual memory layout:
>> [    0.000000]   * 0xfffdf000..0xfffff000  : fixmap
>> [    0.000000]   * 0xfdffd000..0xfe000000  : early ioremap
>> [    0.000000]   * 0xd5000000..0xfdffd000  : vmalloc & ioremap
>>
>>
>>
>>
>> root@vgoippro:~# cat /sys/kernel/debug/powerpc/block_address_translation
>> ---[ Instruction Block Address Translation ]---
>> 0: 0xc0000000-0xc0ffffff 0x00000000 Kernel EXEC coherent
>> 1:         -
>> 2: 0xc1000000-0xc17fffff 0x01000000 Kernel EXEC coherent
>> 3:         -
>> 4: 0xd0000000-0xd3ffffff 0x10000000 Kernel EXEC coherent
>> 5:         -
>> 6:         -
>> 7:         -
>>
>> ---[ Data Block Address Translation ]---
>> 0: 0xc0000000-0xc0ffffff 0x00000000 Kernel RW coherent
>> 1: 0xfffe0000-0xffffffff 0x0d000000 Kernel RW no cache guarded
>> 2: 0xc1000000-0xc17fffff 0x01000000 Kernel RW coherent
>> 3:         -
>> 4: 0xd0000000-0xd3ffffff 0x10000000 Kernel RW coherent
>> 5:         -
>> 6:         -
>> 7:         -
>>
>>
>> Could you please provide the dmesg and
>> /sys/kernel/debug/powerpc/block_address_translation from before this patch,
>> so that we can compare and identify the differences if any ?
> 
> After applying the patch that adds this debugfs file and enabling
> CONFIG_PPC_PTDUMP, I get this:
> 
> 	# cat /sys/kernel/debug/powerpc/block_address_translation
> 	---[ Instruction Block Address Translation ]---
> 	0:         -
> 	1:         -
> 	2: 0xc0000000-0xc0ffffff 0x00000000 Kernel EXEC
> 	3: 0xc1000000-0xc17fffff 0x01000000 Kernel EXEC
> 	4: 0xd0000000-0xd1ffffff 0x10000000 Kernel EXEC
> 	5:         -
> 	6:         -
> 	7:         -
> 
> 	---[ Data Block Address Translation ]---
> 	0:         -
> 	1: 0xfffe0000-0xffffffff 0x0d000000 Kernel RW no cache guarded
> 	2: 0xc0000000-0xc0ffffff 0x00000000 Kernel RW
> 	3: 0xc1000000-0xc17fffff 0x01000000 Kernel RW
> 	4: 0xd0000000-0xd1ffffff 0x10000000 Kernel RW
> 	5:         -
> 	6:         -
> 	7:         -
> 
> dmesg is attached.
> 
> 
> I added some tracing to the setbat function:
> 
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index f6f575bae3bc..4da3dc54fe46 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -120,6 +120,9 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
>   	struct ppc_bat *bat = BATS[index];
>   	unsigned long flags = pgprot_val(prot);
>   
> +	pr_info("setbat(%u, %px, %px, %px, %lx)\n",
> +			index, (void *)virt, (void *)phys, (void *)size, flags);
> +
>   	if ((flags & _PAGE_NO_CACHE) ||
>   	    (cpu_has_feature(CPU_FTR_NEED_COHERENT) == 0))
>   		flags &= ~_PAGE_COHERENT;
> 
> 
> And here's what I got:
> 
> Before your patches (circa v4.20-rc5):
> [    0.000000] setbat(2, c0000000, 00000000, 01000000, 591)
> [    0.000000] setbat(3, c1000000, 01000000, 00800000, 591)
> [    0.000000] setbat(4, d0000000, 10000000, 02000000, 591)

Ok, I have not tested against raw v4.20-rc5. I always powerpc/merge 
branch as the reference. Maybe I should try that.

> 
> With patches 1-3:
> [    0.000000] setbat(0, c0000000, 00000000, 01000000, 311)
> [    0.000000] setbat(2, c1000000, 01000000, 00800000, 311)
> [    0.000000] setbat(4, d0000000, 10000000, 02000000, 791)

What we see is that BAT0 is not used in the origin. I have always 
wondered the reason, maybe there is something odd behind and BAT0 shall 
no ne used.

Could you try and modify find_free_bat() so that it starts at b = 1 
instead of b = 0 ?

> 
> According to arch/powerpc/include/asm/book3s/32/hash.h,
>   - 0x591 = _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | _PAGE_PRESENT
>   - 0x311 = _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_COHERENT | _PAGE_PRESENT
>   - 0x791 = _PAGE_RW | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | _PAGE_PRESENT
> 

Yes, patch 1 added _PAGE_EXEC which explains this 0x200.
Do you confirm it still works well with only patch 1 ?

And patch 3 uses PAGE_KERNEL_TEXT instead of PAGE_KERNEL_X, hence the 
lack of _PAGE_RW, which should not be necessary.



> Changing the flags back to 0x591 in setbat doesn't result in a booting
> system.
> 
> 
>>>> I've tested at patch 1, 2, 3, 4, and 13, so I don't know if it works
>>>> somewhere in the middle, but probably not.
> 
> (I get the same results if I also merge powerpc/next, btw)

Ok, then no need for me to test with raw 4.20 rc 5.

Christophe

> 
> 
> I hope this helps somewhat,
>    Jonathan Neuschäfer
> 

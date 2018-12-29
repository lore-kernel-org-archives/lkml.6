Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C0AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C0421019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="km1r5C94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbeL2M1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:27:33 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57298 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeL2M1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:27:32 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 841055C0BC2;
        Sat, 29 Dec 2018 13:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546086448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0aluuXCGZ2q4LiUEKZ5W0RobqEiHEoilw5d3ke3Q6c=;
        b=km1r5C94v5HEgNIxkAx4O//6AW/JcDcG9uzYBYQnDtCCcEUQGAI9QNXBGQruH21GE0ENV8
        bK7aEjdQ903QOYZwVU6Mtebj1pVsbl35S08zcjoI5SbznOx/pijIYOnsJBwe16xN8J9CLT
        FTjvf4kCyd27VKHtBMicLfgNVHn0B80=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Dec 2018 13:27:28 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
In-Reply-To: <20181205194519.GA9197@flashbox>
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox>
 <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
 <20181205194519.GA9197@flashbox>
Message-ID: <9f43145527aa4220ecde4c3b263241e6@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.2018 20:45, Nathan Chancellor wrote:
> On Wed, Dec 05, 2018 at 07:39:55PM +0100, Ard Biesheuvel wrote:
>> On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
>> >
>> > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
>> > > (+ Arnd)
>> > >
>> > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
>> > > >
>> > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
>> > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
>> > > > > >
>> > > > > > This flag is not supported by lld:
>> > > > > >
>> > > > > >     ld.lld: error: unknown argument: --pic-veneer
>> > > > > >
>> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > > > >
>> > > > > Hi Nate,
>> > > > >
>> > > > > Does this mean ld.lld is guaranteed to produce position independent
>> > > > > veneers if you build kernels that are bigger than the typical range of
>> > > > > a relative branch?
>> > > > >
>> > > >
>> > > > Hi Ard,
>> > > >
>> > > > Honestly, I'm not quite sure. I saw your commit that introduced this
>> > > > flag and I wasn't quite sure what to make of it for lld. What
>> > > > configuration would I use to verify and what would I check for?
>> > > >
>> > >
>> > > Try building allyesconfig, and check the resulting binary for veneers
>> > > (which have 'veneer' in the symbol name, at least when ld.bfd emits
>> > > them). These veneers should not take the [virtual] address of the
>> > > branch target directly, but take a PC relative offset (as in the
>> > > example in the commit log of that patch you are referring to)
>> > >
>> >
>> > Alright, compiling with allyesconfig is a little rough at the moment
>> > (bug reports I will file in due time) but I was able to do it. Here's
>> > the disassembly specifically for the functions you had in your commit,
>> > my assembly knowledge is pretty much non-existent unfortunately so I am
>> > not sure what to make of it (it doesn't look like there is a virtual
>> > address for pc in that mix?). I am happy to provide any more information
>> > that is needed.
>> >
>> > c03030cc <__enable_mmu>:
>> > c03030cc:       e3c00002        bic     r0, r0, #2
>> > c03030d0:       e3c00b02        bic     r0, r0, #2048   ; 0x800
>> > c03030d4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
>> > c03030d8:       e3a05051        mov     r5, #81 ; 0x51
>> > c03030dc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
>> > c03030e0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
>> > c03030e4:       eafff3c5        b       c0300000 <__turn_mmu_on>
>> > c03030e8:       e320f000        nop     {0}
>> > c03030ec:       e320f000        nop     {0}
>> > c03030f0:       e320f000        nop     {0}
>> > c03030f4:       e320f000        nop     {0}
>> > c03030f8:       e320f000        nop     {0}
>> > c03030fc:       e320f000        nop     {0}
>> >
>> > c0300000 <__turn_mmu_on>:
>> > c0300000:       e1a00000        nop                     ; (mov r0, r0)
>> > c0300004:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
>> > c0300008:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
>> > c030000c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
>> > c0300010:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
>> > c0300014:       e1a03003        mov     r3, r3
>> > c0300018:       e1a0300d        mov     r3, sp
>> > c030001c:       e1a0f003        mov     pc, r3
>> >
>>
>> Thanks Nate.
>>
>> So these functions no longer appear to reside far away from each
>> other, so there no veneer has been emitted.
>>
>> What we're looking for are veneers, i.e., snippets inserted by the
>> linker that serve as a trampoline so a branch target that is far away
>> can be reached.
>>
>> If no symbols exist with 'veneer' in their name *, it might make sense
>> to rebuild the kernel as Thumb2, which has a branching range of only 8
>> MB (as opposed to 16 MB for ARM mode)
>>
>> * I have no idea whether lld names its veneers like this, or even at all
> 
> Thanks Ard, I understand now, I appreciate that.
> 
> I compiled with CONFIG_THUMB2_KERNEL (config attached) and I am still
> not seeing any veneers or thunks as Peter said they would be called for
> lld in the LLVM bug report linked earlier in the thread. Peter did note
> that the branch ranges were 32MB and 16MB for ARM and Thumb2
> respectively, which could be playing into this.
> 
> c03028d0 <__enable_mmu>:
> c03028d0:       f020 0002       bic.w   r0, r0, #2
> c03028d4:       f420 6000       bic.w   r0, r0, #2048   ; 0x800
> c03028d8:       f420 5080       bic.w   r0, r0, #4096   ; 0x1000
> c03028dc:       f04f 0551       mov.w   r5, #81 ; 0x51
> c03028e0:       ee03 5f10       mcr     15, 0, r5, cr3, cr0, {0}
> c03028e4:       ee02 4f10       mcr     15, 0, r4, cr2, cr0, {0}
> c03028e8:       f7fd bb8a       b.w     c0300000 <__turn_mmu_on>
> c03028ec:       f3af 8000       nop.w
> c03028f0:       f3af 8000       nop.w
> c03028f4:       f3af 8000       nop.w
> c03028f8:       f3af 8000       nop.w
> c03028fc:       f3af 8000       nop.w
> 
> c0300000 <__turn_mmu_on>:
> c0300000:       4600            mov     r0, r0
> c0300002:       f3bf 8f6f       isb     sy
> c0300006:       ee01 0f10       mcr     15, 0, r0, cr1, cr0, {0}
> c030000a:       ee10 3f10       mrc     15, 0, r3, cr0, cr0, {0}
> c030000e:       f3bf 8f6f       isb     sy
> c0300012:       461b            mov     r3, r3
> c0300014:       466b            mov     r3, sp
> c0300016:       469f            mov     pc, r3
> 
> Thanks for all the insight you've given!
> Nathan

I was able to reproduce the issue by using allyesconfig, removing
--pic-veneer and reverting eb765c1ceb27 ("ARM: 8317/1: move the
.idmap.text section closer to .head.text"). I guess due to that fix the
issue currently does not appear in practice (or at least not in that
particular case we are looking at).

Using ld.bfd:
$ arm-buildroot-linux-gnueabihf-objdump -d vmlinux | grep -C 4
turn_mmu_on
c020815c:       e12fff1e        bx      lr
c0208160:       cc3c2857        .word   0xcc3c2857
c0208164:       fd883000        .word   0xfd883000

c0208168 <__turn_mmu_on_loc>:
c0208168:       c0208168        .word   0xc0208168
c020816c:       c7b11230        .word   0xc7b11230
c0208170:       c7b11250        .word   0xc7b11250

--
c0303304:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
c0303308:       e3a05051        mov     r5, #81 ; 0x51
c030330c:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
c0303310:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
c0303314:       ea0fd9c7        b       c06f9a38
<____turn_mmu_on_veneer>
c0303318:       e320f000        nop     {0}
c030331c:       e320f000        nop     {0}

c0303320 <__do_fixup_smp_on_up>:
--
c06f9a30 <__bus_register_notifier_veneer>:
c06f9a30:       e51ff004        ldr     pc, [pc, #-4]   ; c06f9a34
<__bus_register_notifier_veneer+0x4>
c06f9a34:       c29752c0        .word   0xc29752c0

c06f9a38 <____turn_mmu_on_veneer>:
c06f9a38:       e51ff004        ldr     pc, [pc, #-4]   ; c06f9a3c
<____turn_mmu_on_veneer+0x4>
c06f9a3c:       c7b11230        .word   0xc7b11230

c06f9a40 <__rb_replace_node_veneer>:
c06f9a40:       e51ff004        ldr     pc, [pc, #-4]   ; c06f9a44
<__rb_replace_node_veneer+0x4>
 --

c7b1122c <__kprobes_text_end>:
c7b1122c:       00000000        .word   0x00000000

c7b11230 <__turn_mmu_on>:
c7b11230:       e1a00000        nop                     ; (mov r0, r0)
c7b11234:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
c7b11238:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
c7b1123c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}


And with ld.lld:

$ arm-buildroot-linux-gnueabihf-objdump -d vmlinux | grep -C 4
turn_mmu_on
c0208158:       e12fff1e        bx      lr
c020815c:       cb2cb747        .word   0xcb2cb747
c0208160:       fd883000        .word   0xfd883000

c0208164 <__turn_mmu_on_loc>:
c0208164:       c0208164        .word   0xc0208164
c0208168:       c6c3ca38        .word   0xc6c3ca38
c020816c:       c6c3ca58        .word   0xc6c3ca58

--
c0301fb4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
c0301fb8:       e3a05051        mov     r5, #81 ; 0x51
c0301fbc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
c0301fc0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
c0301fc4:       ea3f3e38        b       c12d18ac
<__ARMv7ABSLongThunk___turn_mmu_on>
c0301fc8:       e320f000        nop     {0}
c0301fcc:       e320f000        nop     {0}
c0301fd0:       e320f000        nop     {0}
c0301fd4:       e320f000        nop     {0}
--
c12d18a0:       e3a00001        mov     r0, #1
c12d18a4:       e28dd004        add     sp, sp, #4
c12d18a8:       e8bd8ff0        pop     {r4, r5, r6, r7, r8, r9, sl, fp,
pc}

c12d18ac <__ARMv7ABSLongThunk___turn_mmu_on>:
c12d18ac:       e30cca38        movw    ip, #51768      ; 0xca38
c12d18b0:       e34cc6c3        movt    ip, #50883      ; 0xc6c3
c12d18b4:       e12fff1c        bx      ip

--
c6c3ca2c:       e309c90c        movw    ip, #39180      ; 0x990c
c6c3ca30:       e34cc032        movt    ip, #49202      ; 0xc032
c6c3ca34:       e12fff1c        bx      ip

c6c3ca38 <__turn_mmu_on>:
c6c3ca38:       e1a00000        nop                     ; (mov r0, r0)
c6c3ca3c:       f57ff06f        isb     sy
c6c3ca40:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
c6c3ca44:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}

With --pic-veneer and ld.bfd:

 $ arm-buildroot-linux-gnueabihf-objdump -d vmlinux | grep -C 4
turn_mmu_on
c0208158:       e12fff1e        bx      lr
c020815c:       cb1cb747        .word   0xcb1cb747
c0208160:       fd883000        .word   0xfd883000

c0208164 <__turn_mmu_on_loc>:
c0208164:       c0208164        .word   0xc0208164
c0208168:       c6c514e0        .word   0xc6c514e0
c020816c:       c6c51500        .word   0xc6c51500

--
c0301fb4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
c0301fb8:       e3a05051        mov     r5, #81 ; 0x51
c0301fbc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
c0301fc0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
c0301fc4:       ea0fd5a4        b       c06f765c
<____turn_mmu_on_veneer>
c0301fc8:       e320f000        nop     {0}
c0301fcc:       e320f000        nop     {0}
c0301fd0:       e320f000        nop     {0}
c0301fd4:       e320f000        nop     {0}
--
c06f7650:       e59fc000        ldr     ip, [pc]        ; c06f7658
<____xa_set_mark_veneer+0x8>
c06f7654:       e08ff00c        add     pc, pc, ip
c06f7658:       0654cebc        .word   0x0654cebc

c06f765c <____turn_mmu_on_veneer>:
c06f765c:       e59fc000        ldr     ip, [pc]        ; c06f7664
<____turn_mmu_on_veneer+0x8>
c06f7660:       e08ff00c        add     pc, pc, ip
c06f7664:       06559e78        .word   0x06559e78

--
c6c514d4:       e1a00006        mov     r0, r6
c6c514d8:       e8bd4070        pop     {r4, r5, r6, lr}
c6c514dc:       e12fff13        bx      r3

c6c514e0 <__turn_mmu_on>:
c6c514e0:       e1a00000        nop                     ; (mov r0, r0)
c6c514e4:       f57ff06f        isb     sy
c6c514e8:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
c6c514ec:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}

--
Stefan

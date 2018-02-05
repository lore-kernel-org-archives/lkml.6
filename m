Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBEUa5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:30:57 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:44945 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeBEUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:30:49 -0500
X-Google-Smtp-Source: AH8x224bZBDGYQDb/rZkeuoyAE8awsi2jvYrkKbFzFTwFWFW9hmadYDjgmUr5QCh9C/gAQpZpaa4zGZcQ7fq9cQutQ4=
MIME-Version: 1.0
In-Reply-To: <20180205162211.GM30338@tassilo.jf.intel.com>
References: <20180205151300.539874-1-arnd@arndb.de> <20180205151300.539874-2-arnd@arndb.de>
 <20180205155001.GI30338@tassilo.jf.intel.com> <CAK8P3a3gNstYGm5KqAZ5T7kQL0raUC0OOrcLwYD3wc+thwmEkw@mail.gmail.com>
 <20180205162211.GM30338@tassilo.jf.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 21:30:48 +0100
X-Google-Sender-Auth: 8adVE3Jns9Qut1Vm1AtnCSA2dmY
Message-ID: <CAK8P3a27W7u+ZEewiRONkPY6n=qU9OaXLFxn0dFscmgOsdAEaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] modpost: don't add warnings for LTO-generated symbols
To: Andi Kleen <ak@linux.intel.com>
Cc: Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wanlong Gao <wanlong.gao@gmail.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 5:22 PM, Andi Kleen <ak@linux.intel.com> wrote:
> On Mon, Feb 05, 2018 at 04:59:32PM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 5, 2018 at 4:50 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> > On Mon, Feb 05, 2018 at 04:12:52PM +0100, Arnd Bergmann wrote:
>> >> WARNING: vmlinux.o(.data+0x12e0): Section mismatch in reference from the variable pfkey_net_ops.lto_priv.2992 to the function .init.text:pfkey_net_init.lto_priv.2977()
>> >> The variable pfkey_net_ops.lto_priv.2992 references
>> >> the function __init pfkey_net_init.lto_priv.2977()
>> >> If the reference is valid then annotate the
>> >> variable with __init* or __refdata (see linux/init.h) or name the variable:
>> >> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>> >
>> > A better fix would be to ensure modpost always runs on already LD_FINALed
>> > objects, so it never sees LTO.
>> >
>> > Otherwise you would need to teach modpost about the LTO symbol table
>> > and some other magic. I did that once, but it turned out to be very
>> > ugly.
>>
>> I'm not sure I understand what that means. Do you mean that with LD_FINAL,
>> those symbol references are completely eliminated so we don't need to worry
>> about them any more?
>
> Yes there should not be any .lto_priv references after LDFINAL, it will
> be just like any other ELF object. We also need to do the same
> thing before objtool.

>> I got about a dozen section mismatch errors with LTO in cases where the
>> calling function gets a specialized version of a structure, and my oneline
>> patch above addresses them all.
>
> Not sure I follow here. .lto_priv should be anything LTO, not just
> some specific optimizations.

I think it's a bit different from my first interpretation, this is what I see
in the output of 'objdump -Dr vmlinux' after the final LTO link:

b1da26f0 <amba_console.lto_priv.21118>:
b1da26f0:       74747941        cmnmi   r9, r4, ror r4
b1da26f4:       4d000000        andeq   r0, r0, sp, asr #32
        ...
b1da2700:       b0bdfa08        ldmeq   sl!, {r4, r5, r7, r8, sl, fp,
ip, sp, pc}^
b1da2704:       00000000        andeq   r0, r0, r0
b1da2708:       b0bcc790        strhls  fp, [r7], #192  ; 0xc0
b1da270c:       00000000        andeq   r0, r0, r0
b1da2710:       b1a2bb18        ldmne   fp!, {r0, r4, r5, r7, r9, sp, pc}
b1da2714:       00000000        andeq   r0, r0, r0
b1da2718:       0001ffff                        ; <UNDEFINED>
instruction: 0xffff0100
b1da271c:       00000000        andeq   r0, r0, r0
b1da2720:       b1da0938        stmdacc r9, {r0, r4, r5, r7, r9, fp, ip, lr, pc}
b1da2724:       00000000        andeq   r0, r0, r0


b1da2728 <amba_console.lto_priv.21119>:
b1da2728:       74747941        cmnmi   r9, r4, ror r4
b1da272c:       4d410000        andeq   r4, r0, sp, asr #2
        ...
b1da2738:       b0be163c        ldccc   14, cr11, [r6], {176}   ; 0xb0
b1da273c:       00000000        andeq   r0, r0, r0
b1da2740:       b0bcc790        strhls  fp, [r7], #192  ; 0xc0
b1da2744:       00000000        andeq   r0, r0, r0
b1da2748:       b1a2b8b8        ldmlt   r8!, {r0, r4, r5, r7, r9, sp, pc}
b1da274c:       b1a2e6d8        stmiale r6!, {r0, r4, r5, r7, r9, sp, pc}^
b1da2750:       0011ffff                        ; <UNDEFINED>
instruction: 0xffff1100
b1da2754:       00000000        andeq   r0, r0, r0
b1da2758:       b1d9fed8        ldmle   lr!, {r0, r4, r5, r7, r8, fp,
ip, lr, pc}^
b1da275c:       00000000        andeq   r0, r0, r0

I got a warning from scripts/mod/modpost about vmlinux.o before it,
which has relocations from each of these two into an init function.

My interpretation now is that LTO adds the .lto_priv.21118 suffix for
the two structures to disambiguate them, as one comes from
amba-pl010.c and the other one is from amba-pl011.c.
This means that the whitelist in modpost no longer works, as it
checks the name against the "*_console" glob string.

Almost all other symbols are not affected because the names of the
static symbols are unique, and LTO gets to drop the suffix.

         Arnd

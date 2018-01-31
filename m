Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeAaRGG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:06:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36174 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbeAaRGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:06:05 -0500
Date: Wed, 31 Jan 2018 18:05:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andy Lutomirski <luto@amacapital.net>
Cc: X86 ML <x86@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/vdso: Remove retpoline flags
Message-ID: <20180131170555.f6aboqitcvmgvhso@pd.tnic>
References: <20180131163312.7144-1-bp@alien8.de>
 <CALCETrVsZWL7ZDnGMyoN8V4mmL5NO+SARQBV1U2OzrVscMsoig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVsZWL7ZDnGMyoN8V4mmL5NO+SARQBV1U2OzrVscMsoig@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 08:35:30AM -0800, Andy Lutomirski wrote:
> Hmm.  I'm okay with this, but I'd also be okay doing nothing and
> figuring out WTF happened if an upstream kernel fails to build like
> this.

Oh sure, I'm sending it only as an FYI to show that something like this
*might* happen so that we're aware. I've taken it into our trees where
the 3.0 vdso code generates an indirect call to the thunk:

        .loc 1 41 0
        movq    -10489696, %rax # MEM[(const struct vsyscall_gtod_data *)-10489728B].clock.vread, MEM[(const struct vsyscall_gtod_data *)-10489728B].clock.vread
        call    __x86_indirect_thunk_rax

Without the retpoline flags, the code looks like this:

 170:   4c 8b 34 25 88 f0 5f    mov    0xffffffffff5ff088,%r14
 177:   ff 
 178:   44 8b 2c 25 90 f0 5f    mov    0xffffffffff5ff090,%r13d
 17f:   ff 
 180:   ff 14 25 a0 f0 5f ff    callq  *0xffffffffff5ff0a0		<---
 187:   4c 8b 0c 25 a8 f0 5f    mov    0xffffffffff5ff0a8,%r9
 18e:   ff 
 18f:   4c 8b 04 25 b0 f0 5f    mov    0xffffffffff5ff0b0,%r8


which is:

        movl    -10489712, %r12d        # MEM[(const struct vsyscall_gtod_data *)-10489728B].wall_time_nsec,
.LVL46:
.LBB125:
.LBB126:
        .loc 1 41 0
        call    *-10489696      # MEM[(const struct vsyscall_gtod_data *)-10489728B].clock.vread		<---
.LVL47:
        movq    -10489688, %r9  # MEM[(const struct vsyscall_gtod_data *)-10489728B].clock.cycle_last, D.23457
        movq    -10489680, %r8  # MEM[(const struct vsyscall_gtod_data *)-10489728B].clock.mask, D.23457


notrace static inline long vgetns(void)
{
        long v;
        cycles_t (*vread)(void);
        vread = gtod->clock.vread;
        v = (vread() - gtod->clock.cycle_last) & gtod->clock.mask;
	^^^^^^^^^^^^

so it has been converted to an absolute memory reference in that CALL -
nothing funky through a register.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

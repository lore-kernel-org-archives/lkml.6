Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=FUZZY_PRICES,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C55C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D6520645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D6520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJHO5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:57:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:41768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbeJHO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:57:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BFF8AEBC;
        Mon,  8 Oct 2018 07:46:51 +0000 (UTC)
Date:   Mon, 8 Oct 2018 09:46:49 +0200 (CEST)
From:   Richard Biener <rguenther@suse.de>
To:     Nadav Amit <namit@vmware.com>
cc:     Borislav Petkov <bp@alien8.de>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Michael Matz <matz@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
In-Reply-To: <56EB8A07-8D24-40F1-8CCE-614D7B712519@vmware.com>
Message-ID: <alpine.LSU.2.20.1810080941400.16707@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <4F2F1BCE-7875-4160-9E1E-9F8EF962D989@vmware.com> <FC56B15B-0D4A-4A4A-81DA-A5093B56A210@suse.de> <56EB8A07-8D24-40F1-8CCE-614D7B712519@vmware.com>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1609908220-1676946831-1538984810=:16707"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1609908220-1676946831-1538984810=:16707
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 7 Oct 2018, Nadav Amit wrote:

> at 9:46 AM, Richard Biener <rguenther@suse.de> wrote:
> 
> > On October 7, 2018 6:09:30 PM GMT+02:00, Nadav Amit <namit@vmware.com> wrote:
> >> at 2:18 AM, Borislav Petkov <bp@alien8.de> wrote:
> >> 
> >>> Hi people,
> >>> 
> >>> this is an attempt to see whether gcc's inline asm heuristic when
> >>> estimating inline asm statements' cost for better inlining can be
> >>> improved.
> >>> 
> >>> AFAIU, the problematic arises when one ends up using a lot of inline
> >>> asm statements in the kernel but due to the inline asm cost
> >> estimation
> >>> heuristic which counts lines, I think, for example like in this here
> >>> macro:
> >> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2Farch%2Fx86%2Finclude%2Fasm%2Fcpufeature.h%23n162&amp;data=02%7C01%7Cnamit%40vmware.com%7C860403cecb874db64b7e08d62c746f46%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636745275975505381&amp;sdata=Nd0636K9Z1IsUs1RWSRAhVuVboLxlBCB4peiAMfmQzQ%3D&amp;reserved=0
> >>> the resulting code ends up not inlining the functions themselves
> >> which
> >>> use this macro. I.e., you see a CALL <function> instead of its body
> >>> getting inlined directly.
> >>> 
> >>> Even though it should be because the actual instructions are only a
> >>> couple in most cases and all those other directives end up in another
> >>> section anyway.
> >>> 
> >>> The issue is explained below in the forwarded mail in a larger detail
> >>> too.
> >>> 
> >>> Now, Richard suggested doing something like:
> >>> 
> >>> 1) inline asm ("...")
> >>> 2) asm ("..." : : : : <size-expr>)
> >>> 3) asm ("...") __attribute__((asm_size(<size-expr>)));
> >>> 
> >>> with which user can tell gcc what the size of that inline asm
> >> statement
> >>> is and thus allow for more precise cost estimation and in the end
> >> better
> >>> inlining.
> >>> 
> >>> And FWIW 3) looks pretty straight-forward to me because attributes
> >> are
> >>> pretty common anyways.
> >>> 
> >>> But I'm sure there are other options and I'm sure people will have
> >>> better/different ideas so feel free to chime in.
> >> 
> >> Thanks for taking care of it. I would like to mention a second issue,
> >> since
> >> you may want to resolve both with a single solution: not inlining
> >> conditional __builtin_constant_p(), in which there are two code-paths -
> >> one
> >> for constants and one for variables.
> >> 
> >> Consider for example the Linux kernel ilog2 macro, which has a
> >> condition
> >> based on __builtin_constant_p() (
> >> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv4.19-rc7%2Fsource%2Finclude%2Flinux%2Flog2.h%23L160&amp;data=02%7C01%7Cnamit%40vmware.com%7C860403cecb874db64b7e08d62c746f46%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636745275975515386&amp;sdata=Hk39Za9%2FxcFyK0sGENB24d6QySjsDGzF%2FwqjnUEMiGk%3D&amp;reserved=0
> >> ). The compiler mistakenly considers the “heavy” code-path that is
> >> supposed
> >> to be evaluated only in compilation time to evaluate the code size.
> > 
> > But this is a misconception about __builtin_constant_p. It doesn't guard sth like 'constexpr' regions. If you try to use it with those semantics you'll fail (appearantly you do). 
> > 
> > Of course IPA CP code size estimates when seeing a constant fed to bcp might be not optimal, that's another issue of course. 
> 
> I understand that this is might not be the right way to implement macros
> such as ilog2() and test_bit(), but this code is around for some time.
> 
> I thought of using __builtin_choose_expr() instead of ternary operator, but
> this introduces a different problem, as the variable version is used instead
> of the constant one in many cases. From my brief experiments with llvm, it
> appears that llvm does not have both of these issues (wrong cost attributed
> to inline asm and conditions based on __builtin_constant_p()).
> 
> So what alternative do you propose to implement ilog2() like behavior? I was
> digging through the gcc code to find a workaround with no success.

1) Don't try to cheat the compilers constant propagation abilities
2) Use a language that allows this (C++)
3) Define (and implement) the corresponding GNU C extension

__builtin_constant_p() isn't the right fit (I wonder what it was
implemented for in the first place though...).

I suppose you want sth like

 if (__builtin_constant_p (x))
   return __constexpr ...;

or use a call and have constexpr functions.  Note it wouldn't be
C++-constexpr like since you want the constexpr evaluation to
happen very late in the compilation to benefit from optimizations
and you are fine with the non-constexpr path.

Properly defining a language extension is hard.

Richard.

> 
> Thanks,
> Nadav
> 
> 

-- 
Richard Biener <rguenther@suse.de>
SUSE LINUX GmbH, GF: Felix Imendoerffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nuernberg)
---1609908220-1676946831-1538984810=:16707--

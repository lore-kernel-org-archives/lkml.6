Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A43C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56A20896
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HOP2WuJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeLOAwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:52:04 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:42416 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLOAwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:52:04 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wBF0pn7O017693;
        Sat, 15 Dec 2018 09:51:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wBF0pn7O017693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544835110;
        bh=/VnjqWkGiGNdcpqRIOPtjPCm2TnYGLO322ka7X7xUIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HOP2WuJlDbmWkzrhLOtyOl9zwv/pakaYr0PvVvSeT5PxGOK/xMqXb3v3K4W8+59qK
         oyOZzE3W5h5af8YuinxudLE8fDWoP4VmJLz6zMZlWzIMaSWYzZrLirOFNvkwxSnf22
         t9Cig3sdItEWkNsQfOFyJDEwWWmWsyPxvVMsgGIQR8d+UMhlzJ+mdyfFIGDELuBYM3
         1lcuOmwV1vSouJR2d5Ws9wsop1dI0PP1dc9qlKY2U25cP9rwu5Uo39xzdE2gfN8Y9b
         iYU/MNyMcrzZVsCWFgR7LPKjO2xLQXU/cBmt6sTqjHYf3YcHwVZMCP9sShOJqtux59
         wx25311kglTig==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id p9so2646035uaa.5;
        Fri, 14 Dec 2018 16:51:49 -0800 (PST)
X-Gm-Message-State: AA+aEWaHUeR+AjeA+slkHVSqpFiiiiG7CvctUUBcjfzUJzzG8YyzOZVA
        n6tqifGK8Wb7C9Xq/g0J4bha2Re0upYixvdDe5k=
X-Google-Smtp-Source: AFSGD/WUvDg64Fj2pdEkGuj4GebPIo0QrnjObNuLdCvctIVbT6LVB7c3eXgn5O7zF5umLZ/c4zFgQE4KBH+zB8Ntl2Y=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr2467606uad.55.1544835108683;
 Fri, 14 Dec 2018 16:51:48 -0800 (PST)
MIME-Version: 1.0
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com> <20181213105146.GH5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181213105146.GH5289@hirez.programming.kicks-ass.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 15 Dec 2018 09:51:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
Message-ID: <CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Nadav Amit <namit@vmware.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-sparse@vger.kernel.org, Alok Kataria <akataria@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Dec 13, 2018 at 7:53 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 13, 2018 at 06:17:41PM +0900, Masahiro Yamada wrote:
> > Revert the following commits:
> >
> > - 5bdcd510c2ac9efaf55c4cbd8d46421d8e2320cd
> >   ("x86/jump-labels: Macrofy inline assembly code to work around GCC inlining bugs")
> >
> > - d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2
> >   ("x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs")
> >
> > - 0474d5d9d2f7f3b11262f7bf87d0e7314ead9200.
> >   ("x86/extable: Macrofy inline assembly code to work around GCC inlining bugs")
> >
> > - 494b5168f2de009eb80f198f668da374295098dd.
> >   ("x86/paravirt: Work around GCC inlining bugs when compiling paravirt ops")
> >
> > - f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6.
> >   ("x86/bug: Macrofy the BUG table section handling, to work around GCC inlining bugs")
> >
> > - 77f48ec28e4ccff94d2e5f4260a83ac27a7f3099.
> >   ("x86/alternatives: Macrofy lock prefixes to work around GCC inlining bugs")
> >
> > - 9e1725b410594911cc5981b6c7b4cea4ec054ca8.
> >   ("x86/refcount: Work around GCC inlining bug")
> >   (Conflicts: arch/x86/include/asm/refcount.h)
> >
> > - c06c4d8090513f2974dfdbed2ac98634357ac475.
> >   ("x86/objtool: Use asm macros to work around GCC inlining bugs")
> >
> > - 77b0bf55bc675233d22cd5df97605d516d64525e.
> >   ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")
> >
>
> I don't think we want to blindly revert all that. Some of them actually
> made sense and did clean up things irrespective of the asm-inline issue.
>
> In particular I like the jump-label one.

[1] The #error message is unnecessary.

[2] keep STATC_BRANCH_NOP/JMP instead of STATIC_JUMP_IF_TRUE/FALSE



In v2, I will make sure to not re-add [1].
I am not sure about [2].


Do you mean only [1],
or both of them?



> The cpufeature one OTOh, yeah,
> I'd love to get that reverted.
>
> And as a note; the normal commit quoting style is:
>
>   d5a581d84ae6 ("x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs")


OK. I will do so in v2.


--
Best Regards
Masahiro Yamada

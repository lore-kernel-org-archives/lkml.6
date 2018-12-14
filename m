Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A49C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4532070D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbeLNQPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:15:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeLNQPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:15:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15AC1650;
        Fri, 14 Dec 2018 08:15:15 -0800 (PST)
Received: from mail-it1-f169.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8AE33F7F4;
        Fri, 14 Dec 2018 08:15:15 -0800 (PST)
Received: by mail-it1-f169.google.com with SMTP id i145so9597378ita.4;
        Fri, 14 Dec 2018 08:15:15 -0800 (PST)
X-Gm-Message-State: AA+aEWZMssbrm9wm/aKGLlRHv2yPYCI9ru4s4JpgmuH9K6JGegywUraK
        TjJNylELwJFKweOWFXUQfgKXdiai2VAksNjyC9E=
X-Google-Smtp-Source: AFSGD/W1U8WKPpzXkNKjzyJ5vjP5WDuoq5P5vTP0WMl2qSI/rxc14jl4TicOIGmW0nVNpzbQOC/772TOccjClWd71wc=
X-Received: by 2002:a24:3555:: with SMTP id k82mr3746465ita.84.1544804114998;
 Fri, 14 Dec 2018 08:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20181130162015.83FE767357@newverein.lst.de> <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
 <20181214094714.GA30043@lst.de>
In-Reply-To: <20181214094714.GA30043@lst.de>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Fri, 14 Dec 2018 21:45:03 +0530
X-Gmail-Original-Message-ID: <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
Message-ID: <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
To:     duwe@lst.de
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        julien.thierry@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        mingo@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, takahiro.akashi@linaro.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Dec 14, 2018 at 3:18 PM Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, Dec 13, 2018 at 11:01:38PM +0530, Amit Daniel Kachhap wrote:
> > On Fri, Nov 30, 2018 at 9:53 PM Torsten Duwe <duwe@lst.de> wrote:
> >
> > Hi Torsten,
> >
> > I was testing your patch and it seems to work fine for function trace. However
> > function graph trace seems broken. Is it work in progress ? or I am
> > missing something.
>
> What did you base your tests on, you didn't specify?
> OTOH neither did I ;-) I precluded all addressees had the full picture.
>
> Precisely, I basically start with 4.19, but 4.20-rc shouldn't make a
> difference. BUT...
>
> > > [Changes from v4]
> > >
> > > * include Ard's feedback and pending changes:
> > >   - ADR/ADRP veneers
> > >   - ftrace_trampolines[2]
> > >   - add a .req for fp, just in case
> " [PATCH 1/2] arm64/insn: add support for emitting ADR/ADRP instructions "
> <20181122084646.3247-2-ard.biesheuvel@linaro.org> et.al, esp:
> Git-commit: bdb85cd1d20669dfae813555dddb745ad09323ba
>
> > >   - comment on the pt_regs.stackframe[2] mapping
> > > * include Mark's ftrace cleanup
> > >   - GLOBAL()
> > >   - prepare_ftrace_return(pc, &lr, fp)
> > >
> " [PATCH 1/6] linkage: add generic GLOBAL() macro "
> <20181115224203.24847-2-mark.rutland@arm.com> et.al., esp:
> Git-commit: 7dc48bf96aa0fc8aa5b38cc3e5c36ac03171e680
>
> change the API this patch set relies on. AFAIU they are on their way into
> mainline so I updated v5 accordingly. If you don't have these, just use v4;
> the other changes are only for compatibility and cosmetics.

Sorry I didn't mention my environment. I am using 4.20-rc3 and it has
all the above 8 extra patches
mentioned by you.
I read your change description in v3 patchset. You had mentioned there
that graph caller
is broken.

//Amit
>
> HTH,
>         Torsten
>

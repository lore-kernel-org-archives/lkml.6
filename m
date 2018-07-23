Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10C0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F1020880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F1020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbeGWNnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:43:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33124 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387965AbeGWNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:43:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40DBC80D;
        Mon, 23 Jul 2018 05:42:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFE073F778;
        Mon, 23 Jul 2018 05:42:16 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:42:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: Making KASAN compatible with VMAP_STACK
Message-ID: <20180723124026.3uqc6r3mgge62onh@lakrids.cambridge.arm.com>
References: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
 <CACT4Y+aP4QSGBiLWt0iNHVJ4nMc_phthK9P+gTMd4d=exaAKwA@mail.gmail.com>
 <20180723111813.vbnsmx2k45eqzdkc@lakrids.cambridge.arm.com>
 <CACT4Y+YMYogSo+Wq=29A7fKC9hufsc_DwLrneOKtsefZP-9h6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YMYogSo+Wq=29A7fKC9hufsc_DwLrneOKtsefZP-9h6g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:55:49PM +0200, Dmitry Vyukov wrote:
> On Mon, Jul 23, 2018 at 1:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jul 23, 2018 at 09:40:36AM +0200, Dmitry Vyukov wrote:
> >> On Sun, Jul 22, 2018 at 7:52 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >> > Hi all-
> >> >
> >> > It would be really nice to make KASAN compatible with VMAP_STACK.
> >> > Both are valuable memory debugging features, and the fact that you
> >> > can't use both is disappointing.
> >> >
> >> > As far as I know, there are only two problems:
> >> >
> >> > 1. The KASAN shadow population code is a mess, and adding *anything*
> >> > to the KASAN shadow requires magical, fragile incantations.  It should
> >> > be cleaned up so that ranges can be easily populated without needing
> >> > to very carefully align things, call helpers in the right order, etc.
> >> > The core KASAN code should figure it out by itself.
> >> >
> >> > 2. The vmalloc area is potentially extremely large.  It might be
> >> > necessary to have a way to *depopulate* shadow space when stacks get
> >> > freed or, more generally, when vmap areas are freed.  Ideally KASAN
> >> > would integrate with the core vmalloc/vmap code and it would Just Work
> >> > (tm).  And, as a bonus, we'd get proper KASAN protection of vmalloced
> >> > memory.
> >> >
> >> > Any volunteers to fix this?
> >>
> >> Hi Andy,
> >>
> >> I understand that having most configs as orthogonal settings that can
> >> be enabled independently is generally good in intself, but I would
> >> like to understand what does VMAP_STACK add on top of KASAN in terms
> >> of debugging capabilities?
> >
> > VMAP_STACK makes it possible to detect stack overflows reliably at the
> > point of overflow.
> >
> > KASAN can't handle this reliably, even if it detects that an access is
> > out of the stack bounds, since handling this requires stack space.
> > Depending on a number of factors, this may be reported, might result in
> > recursive exceptions, etc.
> 
> Interesting. Does VMAP_STACK detect task_struct smashing today? As far
> as I remember, the first version didn't.

I assume you mean thread_info? Both arm64 and x86 moved the thread_info
out of the stack region by moving it into task_struct, which has always
been allocated separately. So thread_info smashing by stack overflow is
not possible.

Regardless of VMAP_STACK, the stack region is purely stack on arm64 and
x86.

> As an orthogonal measure we could add KASAN redzone between stack and
> task_struct, and make KASAN instrumentation detect when the new frame
> hits this redzone. We bump stack order under KASAN significantly, so
> adding, say 128 byte redzone should not be a problem. Does it make any
> sense?

I don't think this is necessary since the two are allocated separately.

Thanks,
Mark.

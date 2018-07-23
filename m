Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE22120846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE22120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbeGWMTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:19:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60022 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387900AbeGWMTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:19:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53B2C18A;
        Mon, 23 Jul 2018 04:18:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F34503F73C;
        Mon, 23 Jul 2018 04:18:15 -0700 (PDT)
Date:   Mon, 23 Jul 2018 12:18:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: Making KASAN compatible with VMAP_STACK
Message-ID: <20180723111813.vbnsmx2k45eqzdkc@lakrids.cambridge.arm.com>
References: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
 <CACT4Y+aP4QSGBiLWt0iNHVJ4nMc_phthK9P+gTMd4d=exaAKwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aP4QSGBiLWt0iNHVJ4nMc_phthK9P+gTMd4d=exaAKwA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 09:40:36AM +0200, Dmitry Vyukov wrote:
> On Sun, Jul 22, 2018 at 7:52 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > Hi all-
> >
> > It would be really nice to make KASAN compatible with VMAP_STACK.
> > Both are valuable memory debugging features, and the fact that you
> > can't use both is disappointing.
> >
> > As far as I know, there are only two problems:
> >
> > 1. The KASAN shadow population code is a mess, and adding *anything*
> > to the KASAN shadow requires magical, fragile incantations.  It should
> > be cleaned up so that ranges can be easily populated without needing
> > to very carefully align things, call helpers in the right order, etc.
> > The core KASAN code should figure it out by itself.
> >
> > 2. The vmalloc area is potentially extremely large.  It might be
> > necessary to have a way to *depopulate* shadow space when stacks get
> > freed or, more generally, when vmap areas are freed.  Ideally KASAN
> > would integrate with the core vmalloc/vmap code and it would Just Work
> > (tm).  And, as a bonus, we'd get proper KASAN protection of vmalloced
> > memory.
> >
> > Any volunteers to fix this?
> 
> Hi Andy,
> 
> I understand that having most configs as orthogonal settings that can
> be enabled independently is generally good in intself, but I would
> like to understand what does VMAP_STACK add on top of KASAN in terms
> of debugging capabilities?

VMAP_STACK makes it possible to detect stack overflows reliably at the
point of overflow.

KASAN can't handle this reliably, even if it detects that an access is
out of the stack bounds, since handling this requires stack space.
Depending on a number of factors, this may be reported, might result in
recursive exceptions, etc.

I assume we must populate shadow  for vmalloc regions today, but I guess
that just shares the zero shadow?

Thanks,
Mark.

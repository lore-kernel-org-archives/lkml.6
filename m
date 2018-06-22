Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8943DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4E3244E4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhgOttX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4E3244E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934097AbeFVPfM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933920AbeFVPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:35:07 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C86244E4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529681706;
        bh=ewaVAnolCnql439IusvdtpvmWnE3haVtE2Xv1b9nxNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LhgOttX7ZWUD3Vq89c79nX9p1nNLZ8JRa/DABZDS4kzusX6o8eUUyiYFqJd+83qiW
         gGHkaf9QUi4+KaNmS6kWZ2T62kGJBsXx0FOxPDr7YcwE2KgA9b7vXrSVCeeeFs1VFW
         Pl6uTNpChu+psF9M/Bn8c+35k6jhLqbTNeJUn0gE=
Received: by mail-wm0-f53.google.com with SMTP id v16-v6so2649451wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:35:06 -0700 (PDT)
X-Gm-Message-State: APt69E1SoirfIJHrj5GAmkIQNUvJbgtLtXfm6LGZY9MdPP8bQ/9e8znh
        0sfoyqApDa8FDPsWm5mHegS8k9mKEfmYY48DxcCKEA==
X-Google-Smtp-Source: ADUXVKJEPdzztBBprxjjOAdDsmDllsqXZB+OQcRZ1svm7cG79LF6j4N+1eKHaz0Hft2dKtjQ9ebxitL+zZLNsDkhR44=
X-Received: by 2002:a1c:f30f:: with SMTP id q15-v6mr2018980wmq.36.1529681704958;
 Fri, 22 Jun 2018 08:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180620195652.27251-1-riel@surriel.com> <20180620195652.27251-5-riel@surriel.com>
 <CALCETrVUgO3PYvwbV9BHbepcEZ=Lwqm8TkETuC5ijUC9h0AQ6Q@mail.gmail.com> <1529680551.7898.191.camel@surriel.com>
In-Reply-To: <1529680551.7898.191.camel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 08:34:52 -0700
X-Gmail-Original-Message-ID: <CALCETrWjSsxK_v2ozs9R8AU_ZZ0zLq9Q+-+YLe4ugjaZBx3Aew@mail.gmail.com>
Message-ID: <CALCETrWjSsxK_v2ozs9R8AU_ZZ0zLq9Q+-+YLe4ugjaZBx3Aew@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 8:15 AM Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 2018-06-22 at 08:04 -0700, Andy Lutomirski wrote:
> > On Wed, Jun 20, 2018 at 12:57 PM Rik van Riel <riel@surriel.com>
> > wrote:
> > >
> > > Lazy TLB mode can result in an idle CPU being woken up by a TLB
> > > flush,
> > > when all it really needs to do is reload %CR3 at the next context
> > > switch,
> > > assuming no page table pages got freed.
> > >
> > > This patch deals with that issue by introducing a third TLB state,
> > > TLBSTATE_FLUSH, which causes %CR3 to be reloaded at the next
> > > context
> > > switch.
> > >
> > > Atomic compare and exchange is used to close races between the TLB
> > > shootdown code and the context switch code. Keying off just the
> > > tlb_gen is likely to not be enough, since that would not give
> > > lazy_clb_can_skip_flush() information on when it is facing a race
> > > and has to send the IPI to a CPU in the middle of a LAZY -> OK
> > > switch.
> > >
> > > Unlike the 2016 version of this patch, CPUs in TLBSTATE_LAZY are
> > > not
> > > removed from the mm_cpumask(mm), since that would prevent the TLB
> > > flush IPIs at page table free time from being sent to all the CPUs
> > > that need them.
> >
> > Eek, this is so complicated.  In the 2016 version of the patches, you
> > needed all this.  But I rewrote the whole subsystem to make it easier
> > now :)  I think that you can get rid of all of this and instead just
> > revert the relevant parts of:
> >
> > b956575bed91ecfb136a8300742ecbbf451471ab
> >
> > All the bookkeeping is already in place -- no need for new state.
>
> I looked at using your .tlb_gen stuff, but we need a
> way to do that race free.  I suppose setting the
> tlbstate to !lazy before checking .tlb_gen might do
> the trick, if we get the ordering right at the tlb
> invalidation site, too?

Oh, right.

>
> Something like this:
>
> context switch                tlb invalidation
>
>                         advance mm->context.tlb_gen
>                         send IPI to cpus with !is_lazy tlb
>
>
> tlbstate.is_lazy = FALSE
> *need_flush = .tlb_gen < next_tlb_gen
>
> Do you see any holes in that?

Logically, is_lazy is (with your patches) just like mm_cpumask in
terms of ordering.  So I think your idea above is fine.  But I think
you need to make sure there's a full barrier between is_lazy = false
and reading .tlb_gen.

--Andy

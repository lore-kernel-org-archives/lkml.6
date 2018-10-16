Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686C1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E642148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Gnd7cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E642148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJQHVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQHVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:21:54 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC87214C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 23:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539732550;
        bh=0SLkIOp/zYCd2QzIQvQ0DO1pKBnlQ1Qg0e0RXGq3zw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U2Gnd7cPeYiXx/r/GiIxyzJLGRFyrgrGeXCN2L1euQnsQjQlDHML+oZCKCDWzjx+A
         cLqSu7souukbWkDQs9phC27ssY1UM6OGxTZ2VxEpPjcIEm6l8j1LMt4P5GsGOCm5Vl
         8VssFBLAjulEs6MRHciiuhOBHzUPbTQQAWhG5nKo=
Received: by mail-wm1-f46.google.com with SMTP id e187-v6so193929wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:29:10 -0700 (PDT)
X-Gm-Message-State: ABuFfoh0GAANUN7kf8ZoognOYUsoJXlPaLyVnQxYFOwCmdbhXgM8Nf+h
        kNet6ednsUlX+Kd0uArTkESCsFY87GDQQOFBnFg3KQ==
X-Google-Smtp-Source: ACcGV60SoE9kY2FNHWNvxS5/t8BVsQqrbjgY5yIRmMyFqbBF0V8ogzczkBdY4+9/t4c7TAGCbm1TG4VwXzykDQ97T5s=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr234944wmd.128.1539732548922;
 Tue, 16 Oct 2018 16:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181016202525.29437-1-bigeasy@linutronix.de> <20181016202525.29437-2-bigeasy@linutronix.de>
 <CALCETrWB2kH9d5ui5haY3aRTD9SAU=tcdkTMoAzJ5rhLh3mO3w@mail.gmail.com> <20181016213859.ldx34cab7ggm5nm5@linutronix.de>
In-Reply-To: <20181016213859.ldx34cab7ggm5nm5@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Oct 2018 16:28:57 -0700
X-Gmail-Original-Message-ID: <CALCETrWf_RqcX7_R_0O0nZ9E8voTB4SE8WX=AP6mk2Uid1CxrQ@mail.gmail.com>
Message-ID: <CALCETrWf_RqcX7_R_0O0nZ9E8voTB4SE8WX=AP6mk2Uid1CxrQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around __flush_tlb_all()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 2:39 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-10-16 14:25:07 [-0700], Andy Lutomirski wrote:
> > > diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> > > index 51a5a69ecac9f..fe6b21f0a6631 100644
> > > --- a/arch/x86/mm/pageattr.c
> > > +++ b/arch/x86/mm/pageattr.c
> > > @@ -2088,7 +2088,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
> > >          * We should perform an IPI and flush all tlbs,
> > >          * but that can deadlock->flush only current cpu:
> > >          */
> > > +       preempt_disable();
> > >         __flush_tlb_all();
> > > +       preempt_enable();
> > >
> >
> > Depending on your CPU, __flush_tlb_all() is either
> > __native_flush_tlb_global() or __native_flush_tlb().  Only
> > __native_flush_tlb() could have any problem with preemption, but it
> > has a WARN_ON_ONCE(preemptible()); in it.  Can you try to figure out
> > why that's not firing for you?
>
> It is firing, it is the warning that was introduced in commit
> decab0888e6e (as mention in the commit message; I just noticed it way
> later because it popped early in the boot log).
>
> > I suspect that a better fix would be to put preempt_disable() into
> > __native_flulsh_tlb(), but I'd still like to understand why the
> > warning isn't working.
>
> __native_flulsh_tlb() just had its preempt_disable() removed in
> decab0888e6e and __kernel_map_pages() is only called from the debug
> code. The other caller of __native_flulsh_tlb() seem to hold a lock or
> run with disabled interrupts.
>
> Sebastian


Fair enough.  But can you copy the warning to __flush_tlb_all() so
it's checked on all systems (but make it VM_WARN_ON_ONCE)?

--Andy

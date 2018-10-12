Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E1C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E921470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1fRmNY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388E921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJMBni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeJMBni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:43:38 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5840621524
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539367794;
        bh=bqY6yoggV2wlerq78M5PLQiDOBJeTtjzULeSXpd5ABU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1fRmNY3b6BeIQdDriLMx5nBtA4RKUERQQqEVwavaY4WTqKLoe3Ra8smCbyC8YIwZ
         BrG9F8r2BFJ4jsEwfEA6MTzwWTP/RfIaiFo3Tu8UhcrcHo/+DLMWwM3mY/yU6+BGIe
         Okk7b5Je51YN+lCVO3F11XFFMXbIDE6DPHpCsUCU=
Received: by mail-wm1-f46.google.com with SMTP id 185-v6so13809185wmt.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:09:54 -0700 (PDT)
X-Gm-Message-State: ABuFfoi8ogC76NZ+6DRUlE3fmYTQy95ZIEjtPbQ4Kbw15SOfd9baTAel
        QNlqKOPGUrkkM23AOwROkh4S7xlWCxBu4nLs8PLdpQ==
X-Google-Smtp-Source: ACcGV61Hlh+ef+Kd3QDgXVAaoCrEh/Y7lRW4JZhhExD7L9wmqtt2NBL2/Arv88xOdfSKAqCsIQbKKis4kPnN6WsP1RA=
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr6439698wmn.102.1539367792688;
 Fri, 12 Oct 2018 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-5-bigeasy@linutronix.de>
 <76caafd5-c85d-61bb-62ec-8056cd6d95ac@linux.intel.com>
In-Reply-To: <76caafd5-c85d-61bb-62ec-8056cd6d95ac@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Oct 2018 11:09:41 -0700
X-Gmail-Original-Message-ID: <CALCETrVcrHUrYHd7EgfYSirc8JmtyU+b_ccFqm_Ux=9FB0we=A@mail.gmail.com>
Message-ID: <CALCETrVcrHUrYHd7EgfYSirc8JmtyU+b_ccFqm_Ux=9FB0we=A@mail.gmail.com>
Subject: Re: [PATCH 04/11] x86/fpu: eager switch PKRU state
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:51 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> On 10/04/2018 07:05 AM, Sebastian Andrzej Siewior wrote:
> > From: Rik van Riel <riel@surriel.com>
> >
> > While most of a task's FPU state is only needed in user space,
> > the protection keys need to be in place immediately after a
> > context switch.
> >
> > The reason is that any accesses to userspace memory while running
> > in kernel mode also need to abide by the memory permissions
> > specified in the protection keys.
> >
> > The "eager switch" is a preparation for loading the FPU state on return
> > to userland. Instead of decoupling PKRU state from xstate I update PKRU
> > within xstate on write operations by the kernel.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > [bigeasy: save pkru to xstate, no cache]
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  arch/x86/include/asm/fpu/internal.h | 20 +++++++++++++++----
> >  arch/x86/include/asm/fpu/xstate.h   |  2 ++
> >  arch/x86/include/asm/pgtable.h      |  6 +-----
> >  arch/x86/include/asm/pkeys.h        |  2 +-
> >  arch/x86/kernel/fpu/core.c          |  2 +-
> >  arch/x86/mm/pkeys.c                 | 31 ++++++++++++++++++++++-------
> >  include/linux/pkeys.h               |  2 +-
> >  7 files changed, 46 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> > index 16c4077ffc945..956d967ca824a 100644
> > --- a/arch/x86/include/asm/fpu/internal.h
> > +++ b/arch/x86/include/asm/fpu/internal.h
> > @@ -570,11 +570,23 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
> >   */
> >  static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
> >  {
> > -     bool preload = static_cpu_has(X86_FEATURE_FPU) &&
> > -                    new_fpu->initialized;
> > +     bool load_fpu;
> >
> > -     if (preload)
> > -             __fpregs_load_activate(new_fpu, cpu);
> > +     load_fpu = static_cpu_has(X86_FEATURE_FPU) && new_fpu->initialized;
> > +     if (!load_fpu)
> > +             return;
>
> Needs comments, please.  Especially around what an uninitialized new_fpu
> means.

See my other comment about getting rid of ->initialized *first*.

>
> > +     __fpregs_load_activate(new_fpu, cpu);
> > +
> > +#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> > +     if (static_cpu_has(X86_FEATURE_OSPKE)) {
>
> FWIW, you should be able to use cpu_feature_enabled() instead of an
> explicit #ifdef here.
>
> > +             struct pkru_state *pk;
> > +
> > +             pk = __raw_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> > +             if (pk->pkru != __read_pkru())
> > +                     __write_pkru(pk->pkru);
> > +     }
> > +#endif
> >  }
>
> Comments here as well, please.
>
> I think the goal is to keep the PKRU state in the 'init state' when
> possible and also to save the cost of WRPKRU.  But, it would be really
> nice to be explicit.

I suspect that this makes basically no difference.  PKRU is almost
never in the init state on Linux.  Also, it's a single word -- I doubt
that the init state optimization is worth much.

But maybe WRPKRU is more expensive than RDPKRU and a branch?

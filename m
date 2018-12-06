Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3102AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76F6214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544122022;
	bh=pU23eFS+GoT5fIWsjwZh7L8zyrjZHIKwz1TF0nFpOp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tQdCrxHs1kijUHXAqT3R+SRW6OrSyb6eMT8KWdDMcA28ziFYu3cyeOB9439/vmny/
	 lZhRR9SaLbeUzpL11GH4m/PvnU4rOjW78h0dZWInbdIo7lg6HM0+9gdYFgfmTf5ulh
	 Cv2T1THFrxqYRZG8FChC/9TguBhNDNEHLxksBpVQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76F6214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLFSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeLFSrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:47:00 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D088214F1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 18:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544122018;
        bh=pU23eFS+GoT5fIWsjwZh7L8zyrjZHIKwz1TF0nFpOp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TLF7qTdbsi+vzWFs9KcDQPt5pDpUMqjLFtElBfF3d3onSVlGcPnhbwmvvjImnG6na
         /C4K/JMqh5t97R+DTiCusESQM5qBaN0L+YV62LIv5vIhyKejFAh4hBbD7VeyzzLJOu
         GyKyL0e0JWArUj807T2HlKrBjb/4Ofji3lWbbzGk=
Received: by mail-wm1-f41.google.com with SMTP id y139so1990353wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:46:58 -0800 (PST)
X-Gm-Message-State: AA+aEWZsxsxA0ALmadIvQSJ8xhmvhLSknd8jY2aJz0hJ3rQL5+FwVgcl
        4hzrlzsHdcLPn1pkInrz+PCKP+aX7xfQOQZBAERwFg==
X-Google-Smtp-Source: AFSGD/UUNzNNUS0OGHQ5agcLXRGt2aoNqyBvKBJ21YlrTrV4rIwOeIh9f5lyjtQ2nTRbDzqW98D0aYBl8fEXgeEE53o=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr22046892wmc.74.1544122017020;
 Thu, 06 Dec 2018 10:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20181205232012.28920-1-sean.j.christopherson@intel.com>
 <20181205232012.28920-3-sean.j.christopherson@intel.com> <7a2f8782-9599-1554-aaaf-b3bd12e00778@intel.com>
In-Reply-To: <7a2f8782-9599-1554-aaaf-b3bd12e00778@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 10:46:44 -0800
X-Gmail-Original-Message-ID: <CALCETrUQWrzuFFr872rcY_kzz5hcTkxMviVgowVWfhQ=oJWoXQ@mail.gmail.com>
Message-ID: <CALCETrUQWrzuFFr872rcY_kzz5hcTkxMviVgowVWfhQ=oJWoXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/fault: Attempt to fixup unhandled #PF in vDSO
 before signaling
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:17 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> >  #define CREATE_TRACE_POINTS
> >  #include <asm/trace/exceptions.h>
> > @@ -928,6 +929,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> >               if (address >= TASK_SIZE_MAX)
> >                       error_code |= X86_PF_PROT;
> >
> > +             if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
> > +                     return;
> > +
> >               if (likely(show_unhandled_signals))
> >                       show_signal_msg(regs, error_code, address, tsk);
>
> I'd preferably like to get this plugged into the page fault code before
> we get to the "bad_area" handling.  This plugs it in near the erratum
> handling which seems really late to me.
>
> > @@ -1045,6 +1049,9 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
> >       if (is_prefetch(regs, error_code, address))
> >               return;
> >
> > +     if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
> > +             return;
> > +
> >       set_signal_archinfo(address, error_code);
> >
> >  #ifdef CONFIG_MEMORY_FAILURE
>
> This *seems* really late to me.  We've already called into the mm fault
> handling code to try and handle the fault and they told us it was
> VM_FAULT_SIGBUS.  Shouldn't we have just detected that it was in the
> vDSO first and not even called the handling code?

I think we only want to do the fixup in cases where we would have
signalled.  I'm about 99.5% confident that if the page fault points to
valid user memory that just happened to have been swapped out, then we
want to swap it in and go straight to ERESUME rather than bailing out
of the vDSO.  What we really want is to IRET with a magic flag saying
"resume the enclave, silly", but we don't have any way to ask for
that.

--Andy

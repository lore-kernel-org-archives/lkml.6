Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61437C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9C12081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9C12081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeLATy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:54:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42239 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeLATy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:54:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so8606805qtq.9;
        Sat, 01 Dec 2018 00:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3NUpUN6CKR3mRu78MCqdeIAzQJaBy9DuDe82A0o/0s=;
        b=oFhIO7lg2TLkglkQ4w0+QXddnY8mepE8S69FesLG7tGOLZ0Yc9vQ5TeZemsNvJtgP+
         Myd5KI35HFrTUTNHGHq3zNXfpj9fV83J0gwJH0YPIHVX2PwqpfJwOjguWkvoLbd17bg6
         2jgzKiZbhmZKCYcfThz3eaeMvAd7nCfXd5kM25kQiyFuIJ/gx5NI8LQ0CoqSXCuEOwaD
         TKcMC65cOwyG4JVmIAIiA1bQm1/mevWEfN0Y9JYax+tXtWB5ZxJ8Zb2rhWZsWKMTV1OU
         a6ct0YI177wqBDA9OTKPkSfR6NoWzmDF8jnRSyeomv638SAd9oIHO6fGyzhcRipOT3e/
         fUJQ==
X-Gm-Message-State: AA+aEWbkLYs6uTsTcznvJqbxBErJTXx0+RtIsY8aXir10GlO7wVTJHUP
        8r5VeOdHWs476+FX5744pZpHzJAsDjUXUfFRL5g=
X-Google-Smtp-Source: AFSGD/VOEUW+OdaQM2fZMH3WQvhNGa56LIKMGPv7ohvRmuBoQjfc5DxSkpR1NQQoEtjvlgfSRcvTZbjwilfpsYaCyjg=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr8444067qvk.40.1543653776130;
 Sat, 01 Dec 2018 00:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast> <CAK8P3a0YGyKf_0wg_sNhN2z-zVvv1N1_Yc=+2AL=8FZT+CRLxQ@mail.gmail.com>
 <CAGXu5jKXEEHbxdG2VzYhUWEPEEJYdCLEY1oF+zm8wOUfdS0v+A@mail.gmail.com>
In-Reply-To: <CAGXu5jKXEEHbxdG2VzYhUWEPEEJYdCLEY1oF+zm8wOUfdS0v+A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 1 Dec 2018 09:42:38 +0100
Message-ID: <CAK8P3a3xUMnWrSsW6gNwc5y0z-wR23v8Q6TGH+yNpDJq65FeMw@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
To:     Kees Cook <keescook@chromium.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 3:42 AM Kees Cook <keescook@chromium.org> wrote:
> On Fri, Nov 30, 2018 at 2:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Nov 30, 2018 at 11:48 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > |BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
> > > |in_atomic(): 1, irqs_disabled(): 1, pid: 2236, name: sig-xstate-bum
> > > |Preemption disabled at:
> > > |[<ffffffff99d60512>] pstore_dump+0x72/0x330
> > > |CPU: 26 PID: 2236 Comm: sig-xstate-bum Tainted: G      D           4.20.0-rc3 #45
> > > |Call Trace:
> > > | dump_stack+0x4f/0x6a
> > > | ___might_sleep.cold.91+0xd3/0xe4
> > > | __might_sleep+0x50/0x90
> > > | wait_for_completion+0x32/0x130
> > > | virt_efi_query_variable_info+0x14e/0x160
> > > | efi_query_variable_store+0x51/0x1a0
> > > | efivar_entry_set_safe+0xa3/0x1b0
> > > | efi_pstore_write+0x109/0x140
> > > | pstore_dump+0x11c/0x330
> > > | kmsg_dump+0xa4/0xd0
> > > | oops_exit+0x22/0x30
> > > ...
> > >
> > > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Fixes: 21b3ddd39fee ("efi: Don't use spinlocks for efi vars")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Hmm, I've actually been working on a patch set recently to deprecate
> > all semaphores from the kernel and replace them with something
> > else as much as possible.
> >
> > Why can't this be a mutex instead?
>
> My understanding is that I can't use a mutex in interrupt context
> (Documentation/kernel-hacking/locking.rst) and pstore_dump() needs to
> handle being called from anywhere. I'm surprised it's managed to get
> away with using a spinlock for this long. :P

You are right that you can't take (or release) a mutex from interrupt
context. However, I don't think converting a spinlock to a semaphore
is going to help here either.

spinlock (or raw_spinlock) is generally the only thing that can be the
innermost lock that you take in any atomic context, and using
down_trylock doesn't make the context less atomic than it already is.

virt_efi_query_variable_info() however waits for a completion
and a semaphore, so that must not be called in atomic context.
Holding a semaphore instead of a spinlock is not going to help you
here, since the interrupt context means you might already be holding
arbitrary locks.

        Arnd

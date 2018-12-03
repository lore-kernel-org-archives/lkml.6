Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916F620661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916F620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeLCQ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:26:32 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39757 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeLCQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:26:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so7686776qkh.6;
        Mon, 03 Dec 2018 08:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzEW3JSZEjlvbGA0qvO/aDBXGm3aFvbl0kSUpmbUVzc=;
        b=IxsbdsffVekg1X30f6MDTZnzGLsVVMALFq0mmIwedYaKozVQWNprATX2lNfsJnus+D
         IWc+aPNfKoUluzql7vWlewT0bg8++O6Iq/jx2t5b7a0zj9ccW5UuonRNYTMq0VvcdXIC
         b1sMJGY/fm1+JEOtKVfb7JjVW5YtJ+97mjrqYYiX6bdqM5/ON2j3K0/DKWZDMm6MKYa2
         /E83Z6llI8WExIjdSZQ2UtUtkN7mVua2CaGydtejLZndMJAdu1DIqn7B0+8mk1ysSceW
         EUIiOwMs60kaXlJRrbYfodBfhpfusDRSDEeFO+AaJ1PVemm+YiPLkL4qFoRwncuJLLxH
         QYaQ==
X-Gm-Message-State: AA+aEWbED680GN8+DR8Of4T7LA2b33XaYOjP+Ds2Oncc6k582FT4RswL
        6a6koCvoCv0HOmQVIfWCfG+Fz9XRUhxUHG7+iugkiEal
X-Google-Smtp-Source: AFSGD/W51osS7WvSSaRoP+Vg1zLLVbi/lZCC0WhUwud8ICoTs9DUNwWKZxmYX62bOLMUmtaEIgtPgQuU0RAK3DIHSb0=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr14544668qkm.343.1543854388798;
 Mon, 03 Dec 2018 08:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast> <CAK8P3a0YGyKf_0wg_sNhN2z-zVvv1N1_Yc=+2AL=8FZT+CRLxQ@mail.gmail.com>
 <CAGXu5jKXEEHbxdG2VzYhUWEPEEJYdCLEY1oF+zm8wOUfdS0v+A@mail.gmail.com>
 <CAK8P3a3xUMnWrSsW6gNwc5y0z-wR23v8Q6TGH+yNpDJq65FeMw@mail.gmail.com> <20181203111826.ri2csbxs33j34dvo@linutronix.de>
In-Reply-To: <20181203111826.ri2csbxs33j34dvo@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Dec 2018 17:26:11 +0100
Message-ID: <CAK8P3a1mAg-XDie7ekN36WQGwVLoPW_nYCkcGmCDMmscCSRFNA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Mon, Dec 3, 2018 at 12:18 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-12-01 09:42:38 [+0100], Arnd Bergmann wrote:
> > You are right that you can't take (or release) a mutex from interrupt
> > context. However, I don't think converting a spinlock to a semaphore
> > is going to help here either.
>
> you can acquire a semaphore with a try_lock from interrupts context but
> you can't do that with a mutex. You can also a acquire a semaphore in
> one context and release in another.

Right, that is the obvious part.

> I haven't looked a general picture yet, will try to do so later today or
> tomorrow.

To speed this up, the problem I'm referring to is in
virt_efi_query_variable_info() and efi_queue_work(),
as in the original BUG_ON() that Kees quoted:

> BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
> |in_atomic(): 1, irqs_disabled(): 1, pid: 2236, name: sig-xstate-bum
> |Preemption disabled at:
> |[<ffffffff99d60512>] pstore_dump+0x72/0x330
> |CPU: 26 PID: 2236 Comm: sig-xstate-bum Tainted: G      D           4.20.0-rc3 #45
> |Call Trace:
> | dump_stack+0x4f/0x6a
> | ___might_sleep.cold.91+0xd3/0xe4
> | __might_sleep+0x50/0x90
> | wait_for_completion+0x32/0x130
> | virt_efi_query_variable_info+0x14e/0x160
> | efi_query_variable_store+0x51/0x1a0
> | efivar_entry_set_safe+0xa3/0x1b0
> | efi_pstore_write+0x109/0x140
> | pstore_dump+0x11c/0x330
> | kmsg_dump+0xa4/0xd0
> | oops_exit+0x22/0x30

This will no longer happen when pstore is called from process
context with his patch, but we still get the same thing if we call
pstore from interrupt context, unless both the down_interruptible
and wait_for_completion in there are also changed to
nonblocking calls. However, once they are no longer blocking,
we don't need the outer lock to be changed from spinlock
to semaphore any more either.

        Arnd

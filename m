Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFF9C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E25lljyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D3F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLDA2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:28:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41843 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeLDA2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:28:30 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so6224168ywc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moRncWufPBgqABFZ/05wxku2nHCWZ/KVBe0JG4XLLu4=;
        b=E25lljyFzKLO4sn7UiH3Q3FjXgimpe0HyexphNyuU342LqfI5SfHLSlL4hqEotheoV
         PVMS0AVQtLdhYBZBNaxr99YQynTHEC5WFNdTFa8n+e9es+IEcBfuOv6oPktfsCNOZ1Wv
         XD9EV+yUy37w4LpOpQchk5TuBc1WN5eKrvddw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moRncWufPBgqABFZ/05wxku2nHCWZ/KVBe0JG4XLLu4=;
        b=dnN9QU1MUPZR1Y9l/K5Ic92kXnBxC7pHzAWTa+23y70FacPu/9UmF9kfCeHc58x0QJ
         BCHgIJY3rAORm5lW7Cjoa4wmVnuQpc7jy6iqzFvxDHkJpH+1InGL/blzLMaaG+MNNn+4
         0L/al7kc0Z3z6Ax/AXtR6QqRQxv3m5ioe2vcFRAK14OdxxQgK83nKE2/rL5dqbRor2u/
         HlncxFSIGNMKQw112PA14jVkjB96xhVxOWaUAgpLVR1+WjEfoGWXmlBem6JN5jRBuWUA
         mJjQaBjF9jAHTBtASZfOwW6d0PcEp3uXeuvophDwHEiIMhcvfvVGbhYNZV+uwg7ozs/o
         q1LA==
X-Gm-Message-State: AA+aEWa2LFVG/yYqg4jNpMKkmve/ahBcmuaiB10Dq/c0RKg045Zt90Ie
        zOLM5U2EwF1NE94bJSYM82aMBZjQ9Es=
X-Google-Smtp-Source: AFSGD/U+iC2cUSl9o05NmhYvYWzwhqu67d+QEA5qHIn8O1g9CG+v7WILfGmvkhFdTjiPPQHiMwHX5Q==
X-Received: by 2002:a81:3217:: with SMTP id y23mr18067415ywy.275.1543883308612;
        Mon, 03 Dec 2018 16:28:28 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id x4sm18542474ywj.80.2018.12.03.16.28.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:28:27 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id d190so6215243ywd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:28:26 -0800 (PST)
X-Received: by 2002:a81:c446:: with SMTP id s6mr18736891ywj.237.1543883306505;
 Mon, 03 Dec 2018 16:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast> <CAK8P3a0YGyKf_0wg_sNhN2z-zVvv1N1_Yc=+2AL=8FZT+CRLxQ@mail.gmail.com>
 <CAGXu5jKXEEHbxdG2VzYhUWEPEEJYdCLEY1oF+zm8wOUfdS0v+A@mail.gmail.com>
 <CAK8P3a3xUMnWrSsW6gNwc5y0z-wR23v8Q6TGH+yNpDJq65FeMw@mail.gmail.com>
 <20181203111826.ri2csbxs33j34dvo@linutronix.de> <CAK8P3a1mAg-XDie7ekN36WQGwVLoPW_nYCkcGmCDMmscCSRFNA@mail.gmail.com>
In-Reply-To: <CAK8P3a1mAg-XDie7ekN36WQGwVLoPW_nYCkcGmCDMmscCSRFNA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 3 Dec 2018 16:28:15 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLsHU0sRsnoynt==bZuagvohfAOGUu_i54Jy8BCFTvitQ@mail.gmail.com>
Message-ID: <CAGXu5jLsHU0sRsnoynt==bZuagvohfAOGUu_i54Jy8BCFTvitQ@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 8:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Dec 3, 2018 at 12:18 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2018-12-01 09:42:38 [+0100], Arnd Bergmann wrote:
> > > You are right that you can't take (or release) a mutex from interrupt
> > > context. However, I don't think converting a spinlock to a semaphore
> > > is going to help here either.
> >
> > you can acquire a semaphore with a try_lock from interrupts context but
> > you can't do that with a mutex. You can also a acquire a semaphore in
> > one context and release in another.
>
> Right, that is the obvious part.
>
> > I haven't looked a general picture yet, will try to do so later today or
> > tomorrow.
>
> To speed this up, the problem I'm referring to is in
> virt_efi_query_variable_info() and efi_queue_work(),
> as in the original BUG_ON() that Kees quoted:
>
> > BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
> > |in_atomic(): 1, irqs_disabled(): 1, pid: 2236, name: sig-xstate-bum
> > |Preemption disabled at:
> > |[<ffffffff99d60512>] pstore_dump+0x72/0x330
> > |CPU: 26 PID: 2236 Comm: sig-xstate-bum Tainted: G      D           4.20.0-rc3 #45
> > |Call Trace:
> > | dump_stack+0x4f/0x6a
> > | ___might_sleep.cold.91+0xd3/0xe4
> > | __might_sleep+0x50/0x90
> > | wait_for_completion+0x32/0x130
> > | virt_efi_query_variable_info+0x14e/0x160
> > | efi_query_variable_store+0x51/0x1a0
> > | efivar_entry_set_safe+0xa3/0x1b0
> > | efi_pstore_write+0x109/0x140
> > | pstore_dump+0x11c/0x330
> > | kmsg_dump+0xa4/0xd0
> > | oops_exit+0x22/0x30
>
> This will no longer happen when pstore is called from process
> context with his patch, but we still get the same thing if we call
> pstore from interrupt context, unless both the down_interruptible
> and wait_for_completion in there are also changed to
> nonblocking calls. However, once they are no longer blocking,
> we don't need the outer lock to be changed from spinlock
> to semaphore any more either.

My proposed patch was trying to do two things:

- have pstore not make things _worse_ (do not hold a spin lock)
- use preemptible() in efi pstore backend to get it right:

        ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
-                             !pstore_cannot_block_path(record->reason),
-                             record->size, record->psi->buf);
+                             preemptible(), record->size, record->psi->buf);

IIUC, that would make efi-vars take the nonblocking path so we don't
trip over the might_sleep().

-Kees

-- 
Kees Cook

Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB30C65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120782145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BIFiZ9zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120782145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLANyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:54:12 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43632 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeLANyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:54:11 -0500
Received: by mail-yb1-f195.google.com with SMTP id h187-v6so3060272ybg.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L569hJGCuXxzHAogdYPizeMk04YonlDmuT27vTOWtw0=;
        b=BIFiZ9zdp+HrJ71qVC6bEIZ/KNBoyVA5QsrAE+vGb9Xf3xDR2jmQzM2En8aKptxtaj
         aeSz+j5EvPbveF1pG5NZeCaZGaYopoosmVUUGaPZEkDNnwOUdpuQ/nD8hDVLgi0vxROg
         0eXhAIV8BL522cCH7mjGOtBtCEzvQLdOqvwb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L569hJGCuXxzHAogdYPizeMk04YonlDmuT27vTOWtw0=;
        b=lRzeGsSi5TcudRHybY3SrH5MacVZdSYB6FEEVlTDXHyA3iEKrv9pU8UzLOrqY/w0oc
         kxZkNE1MIXUe7dbcF0ewF3AjwcMDCQXtstvmGflvmo3d76ZOLTsi1pS9qKcsTkgwhrmo
         NqufZ/Bgxv0IN72/+5SNh3whLCnTKZfnmNJFx7w1xo3uH7LAIJcGDRsmrDFivzvWqsq6
         CPLbw8RDwCc/WyY9bpFOUT2J+Tem0qQ7MvSQ2kEUc77U2RHUYJ5hLocRqApfHytZCDpH
         ddjZk7Ag0QNnctiPOQW8iWI+z3UoS40TmOWh453oxE/DktyVmRuTVspkom3hHyigjdCz
         db0Q==
X-Gm-Message-State: AA+aEWaHMZoqjBAPsQhjVd+4VsBHIVfEetBIphi03v1+yjQ3/s3RUUCR
        WubgPF+jBPhziVPTUI4bT1D5Pqhj1Ek=
X-Google-Smtp-Source: AFSGD/VUojI/fP1cPCbsCB8eaBRwlgY3zGHts4+U3tGqnDjUrn/Ow8+fNkRrqmVoICSQww3vLm4Utg==
X-Received: by 2002:a25:e6d3:: with SMTP id d202-v6mr7902009ybh.466.1543632165747;
        Fri, 30 Nov 2018 18:42:45 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id k206sm2526861ywa.16.2018.11.30.18.42.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 18:42:44 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id g9-v6so3069615ybh.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:42:43 -0800 (PST)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr8266434ybi.141.1543632162755;
 Fri, 30 Nov 2018 18:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast> <CAK8P3a0YGyKf_0wg_sNhN2z-zVvv1N1_Yc=+2AL=8FZT+CRLxQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0YGyKf_0wg_sNhN2z-zVvv1N1_Yc=+2AL=8FZT+CRLxQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 30 Nov 2018 18:42:30 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKXEEHbxdG2VzYhUWEPEEJYdCLEY1oF+zm8wOUfdS0v+A@mail.gmail.com>
Message-ID: <CAGXu5jKXEEHbxdG2VzYhUWEPEEJYdCLEY1oF+zm8wOUfdS0v+A@mail.gmail.com>
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

On Fri, Nov 30, 2018 at 2:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 30, 2018 at 11:48 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Instead of running with interrupts disabled, use a semaphore. This should
> > make it easier for backends that may need to sleep (e.g. EFI) when
> > performing a write:
> >
> > |BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
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
> > ...
> >
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Fixes: 21b3ddd39fee ("efi: Don't use spinlocks for efi vars")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Hmm, I've actually been working on a patch set recently to deprecate
> all semaphores from the kernel and replace them with something
> else as much as possible.
>
> Why can't this be a mutex instead?

My understanding is that I can't use a mutex in interrupt context
(Documentation/kernel-hacking/locking.rst) and pstore_dump() needs to
handle being called from anywhere. I'm surprised it's managed to get
away with using a spinlock for this long. :P

-Kees

-- 
Kees Cook

Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB7FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AF120659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gTHXtr7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AF120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeLDQRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:17:22 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38309 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeLDQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:17:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id u103-v6so7070608ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5+cb9dzyx144bqobquhBoxzGw7to5MS70XtatUgiYg0=;
        b=gTHXtr7NRnC/THxYESh6FW0gt1AS7sZb8x1CuCsVTiWEOs1Vk7tok3OTCPxKsdpte/
         8HjX3QglL1nEtpMVZ9XswWMreuMYQRSsQcla4Co6fPclrD3E5U8OZcWotwLUbdfVfPlI
         sWAPKPWjb/N520sXTikjumUm8y/QkqojmdI6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5+cb9dzyx144bqobquhBoxzGw7to5MS70XtatUgiYg0=;
        b=eIJ5tloHL2P4RyOboyZ2VTSIjDF1GhJXPWSgX1LQqZN1cEUoaj+NnebbBdxGPU7t+x
         vCL48v/T7azFSeNbDmhTBaudyRWgtn4Y5HGGpuWXvq8GdP7MmfWVnL6jmYvKzIR1ncWO
         50bXHEZU9CsKP2M+PzbXGvqzFgLacP/34jVwwJmQ46PQM7pWYA7ujNeWDsGvWjhtFY3y
         dmL31W07eeOkKXq4rMWseiu777BC71Qu94sXJFO5B+GNQjPyIl90pIxC0YMlbJynn9Bj
         FQBGHv7LusNJdbJYZ/DacRsNif1QSom71lAxWDgptkoB09eX6qD5GLiSZZTYQuMaZ9Vd
         B/Vg==
X-Gm-Message-State: AA+aEWZFxUyhf1Fr5+/yiy6eYvPu8oCiIzlnzPiVwJd3Uj2o8q7pBK7r
        8dUt/tZZeAq/7/3W3IsO4QxoreYOeYc=
X-Google-Smtp-Source: AFSGD/Xu5cWoJbJDJg1vK/Li6BMcnECQarZAtX6tM9on80wR2okPaudRAAECgZ/P9FhJlWFk47o2PA==
X-Received: by 2002:a25:2288:: with SMTP id i130mr14998729ybi.319.1543940238707;
        Tue, 04 Dec 2018 08:17:18 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id d138sm5825687ywb.44.2018.12.04.08.17.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:17:15 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id g75so7201697ywb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:17:14 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr21346674ywo.168.1543940234243;
 Tue, 04 Dec 2018 08:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast> <20181204154056.iyf333bcxqwk3obe@linutronix.de>
In-Reply-To: <20181204154056.iyf333bcxqwk3obe@linutronix.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 4 Dec 2018 08:17:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ2zTsouLorcBFjamaxXpdX4CUAeXD6-ZiEM9jd+=WDDA@mail.gmail.com>
Message-ID: <CAGXu5jJ2zTsouLorcBFjamaxXpdX4CUAeXD6-ZiEM9jd+=WDDA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 7:41 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-11-30 14:47:36 [-0800], Kees Cook wrote:
> > diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/e=
fi-pstore.c
> > index cfe87b465819..0f7d97917197 100644
> > --- a/drivers/firmware/efi/efi-pstore.c
> > +++ b/drivers/firmware/efi/efi-pstore.c
> > @@ -259,8 +259,7 @@ static int efi_pstore_write(struct pstore_record *r=
ecord)
> >               efi_name[i] =3D name[i];
> >
> >       ret =3D efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIB=
UTES,
> > -                           !pstore_cannot_block_path(record->reason),
> > -                           record->size, record->psi->buf);
> > +                           preemptible(), record->size, record->psi->b=
uf);
>
> Well. Better I think.
> might_sleep() / preempt_count_equals() checks for preemptible() + rcu_pre=
empt_depth().
> kmsg_dump() starts with rcu_read_lock() which means with this patch appli=
ed I
> got:
>
> | BUG: sleeping function called from invalid context at kernel/sched/comp=
letion.c:99
> | in_atomic(): 0, irqs_disabled(): 0, pid: 2286, name: sig-xstate-bum PC:=
 0 RCU: 1
> | Preemption disabled at:
> | [<ffffffff9b959085>] __queue_work+0x95/0x440
> | CPU: 30 PID: 2286 Comm: sig-xstate-bum Tainted: G      D           4.20=
.0-rc3+ #90
> | Call Trace:
> |  dump_stack+0x4f/0x6a
> |  ___might_sleep.cold.91+0xef/0x100
> |  __might_sleep+0x50/0x90
> |  wait_for_completion+0x32/0x130
> |  virt_efi_query_variable_info+0x14e/0x160
> |  efi_query_variable_store+0x51/0x1a0
> |  efivar_entry_set_safe+0xa3/0x1b0
> |  efi_pstore_write+0x110/0x140
> |  pstore_dump+0x114/0x320
> |  kmsg_dump+0xa4/0xd0
> |  oops_exit+0x7f/0x90
> |  oops_end+0x67/0xd0
> |  die+0x41/0x4a
> |  do_general_protection+0xc1/0x150
> |  general_protection+0x1e/0x30
> | RIP: 0010:__fpu__restore_sig+0x1c1/0x540
>
> just in case you wonder why both counter are zero and it still creates
> this backtrace.

Oh, hmm. That didn't show up in my testing. Any thoughts on a solution?

>
> >       if (record->reason =3D=3D KMSG_DUMP_OOPS)
> >               efivar_run_worker();
> > diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> > index 2387cb74f729..afdfd3687f94 100644
> > --- a/fs/pstore/platform.c
> > +++ b/fs/pstore/platform.c
> > @@ -400,23 +401,20 @@ static void pstore_dump(struct kmsg_dumper *dumpe=
r,
> >       unsigned long   total =3D 0;
> >       const char      *why;
> >       unsigned int    part =3D 1;
> > -     unsigned long   flags =3D 0;
> > -     int             is_locked;
> >       int             ret;
> >
> >       why =3D get_reason_str(reason);
> >
> > -     if (pstore_cannot_block_path(reason)) {
> > -             is_locked =3D spin_trylock_irqsave(&psinfo->buf_lock, fla=
gs);
> > -             if (!is_locked) {
> > -                     pr_err("pstore dump routine blocked in %s path, m=
ay corrupt error record\n"
> > -                                    , in_nmi() ? "NMI" : why);
> > +     if (down_trylock(&psinfo->buf_lock)) {
> > +             /* Failed to acquire lock: give up if we cannot wait. */
> > +             if (pstore_cannot_wait(reason)) {
> > +                     pr_err("dump skipped in %s path: may corrupt erro=
r record\n",
> > +                             in_nmi() ? "NMI" : why);
> >                       return;
> >               }
> > -     } else {
> > -             spin_lock_irqsave(&psinfo->buf_lock, flags);
> > -             is_locked =3D 1;
> > +             down_interruptible(&psinfo->buf_lock);
>
>  In function =E2=80=98pstore_dump=E2=80=99:
> fs/pstore/platform.c:393:3: warning: ignoring return value of =E2=80=98do=
wn_interruptible=E2=80=99, declared with attribute warn_unused_result [-Wun=
used-result]
>    down_interruptible(&psinfo->buf_lock);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>

Thanks, yes. I've fixed this in the version in -next.

-Kees

--=20
Kees Cook

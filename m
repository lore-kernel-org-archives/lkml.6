Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87514C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCF120880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OHHbwtfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCF120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeGXSfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:35:41 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41475 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXSfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:35:41 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so4079168ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0WMVkDF1weuTmkBHW4gnXDBYHECJ/8A/Fxa0OuL8Yo=;
        b=OHHbwtfvaBxWhi8H0JEYRNFtPAy7oqqH4i9m0K5hyoliPhRNty3ik+TS8HAmj14sJY
         ZVX0T0AaSE+HYYraw5yw3EH7J0PwJ7na2NWlk1UKvbXy32HLb9FP2ZM7GNiHH+nsyhfn
         2r8jGDrOOC7DaabQjhDrWN5uXEG/EPDJHmqzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0WMVkDF1weuTmkBHW4gnXDBYHECJ/8A/Fxa0OuL8Yo=;
        b=ndtfJUCgwWDZW5HQ07SCjn14Yi/25KFt4WKu9uWVgdILihtg2di438zR86Bs2k6gO5
         QRZ2N7ADEaj+DC8MN9DtqoFEGowYRDfPsJTDHZrKupdbgVrU3loFlASLaGniAEiqy7sg
         UMpe6Kl5QTWWnlmM8Wm8PMZzjACi9/9rD1nTgiEx4pvt3kYfpcN6iw0Yk4Y07E8812yQ
         YMsRQJHcK3EEgp4xpC2oyYFudRZdW8kGAZwF5pG4Gm6Ye9gto4wJ/Osf4venBfzQgso/
         gTxWwASp/+oX9U6STzt4zxN8t1nZumNsBXpq1qXUiBSYbsNnInvr0T+ewmM6YCojBmtP
         PhXw==
X-Gm-Message-State: AOUpUlE+ilJzE+ITVOBiVfEpAAw8gt7qVunniGXxeIqWGHUbzNIwVaSx
        1iC2jF/muLsoxg+0Ekz6nC0Ej4tsCmskrpFUc8o=
X-Google-Smtp-Source: AAOMgpfPxKUj8SONVeCFb8iXL0cx2TOpaI8gbjBmIZP9PHXCN00s0iRvuJI/n/1b4bUWUsfiyjfaglfpNMnl/UOxtwc=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr14996281iov.203.1532453289922;
 Tue, 24 Jul 2018 10:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <87efft5ncd.fsf_-_@xmission.com> <20180724032419.20231-20-ebiederm@xmission.com>
In-Reply-To: <20180724032419.20231-20-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 10:27:58 -0700
Message-ID: <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
Subject: Re: [PATCH 20/20] signal: Don't restart fork when signals come in.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is completely broken.

On Mon, Jul 23, 2018 at 8:27 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6c358846a8b8..6ee5822f0085 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1602,6 +1603,24 @@ static __latent_entropy struct task_struct *copy_process(
>  {
>         int retval;
>         struct task_struct *p;
> +       struct multiprocess_signals delayed;
> +
> +       /*
> +        * Force any signals received before this point to be delivered
> +        * before the fork happens.  Collect up signals sent to multiple
> +        * processes that happen during the fork and delay them so that
> +        * they appear to happen after the fork.
> +        */
> +       sigemptyset(&delayed.signal);
> +       INIT_HLIST_NODE(&delayed.node);
> +
> +       spin_lock_irq(&current->sighand->siglock);
> +       if (!(clone_flags & CLONE_THREAD))
> +               hlist_add_head(&delayed.node, &current->signal->multiprocess);

Here you add the entry to the multiprocess list.

> +       recalc_sigpending();
> +       spin_unlock_irq(&current->sighand->siglock);
> +       if (signal_pending(current))
> +               return ERR_PTR(restart_syscall());

.. and here you return with the list entry still there, pointing to
the stack that you now no longer use.

The same is true of *all* the error cases, because the only point you
remove it is for the success case:

> @@ -1979,6 +1982,8 @@ static __latent_entropy struct task_struct *copy_process(
>                         attach_pid(p, PIDTYPE_TGID);
>                         attach_pid(p, PIDTYPE_PGID);
>                         attach_pid(p, PIDTYPE_SID);
> +                       p->signal->shared_pending.signal = delayed.signal;
> +                       hlist_del(&delayed.node);

So for all the error cases, you leave a dangling pointer to the
current stack in that signal handler, and then return an error.

Guaranteed stack and list corruption.

                 Linus

Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F4C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3BF21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbeLPTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:50:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43703 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeLPTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:50:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so11882278qtj.10;
        Sun, 16 Dec 2018 11:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y812xpIvHjfCfDvu+2DY3aSyffzIHWy0e/B7b1uXpek=;
        b=oDVQ4CANro7fOkfE9eVHfvpLsK8OLSOQrZ252SO/qElyTJLGjENC/wpOFXjiUtAOEQ
         vkbr/IDdhqv/odr5GRJpqR27cCCb65VB+zzfNNmuPJcqwRqPqvdouvdMkEXyjNZHIW0m
         pgFtFDWlugsxR0N6g22DiBnUV1DW0Stz686dl16fnzIvZZ4vygVbYDgB8wTNllRLgSWM
         omYOS4XshAZdXPRMDIqvcDDHlNNDnsiNUI7Ty4IojvwuuMN1sbYMg1swMbxw+bzAb++C
         xrOhxE+wpxmggt86YUPQveM3vFJlGUftdojL2dqJgjz71BsGxEHlDrJEkFiXF6sTwFjX
         Hf9Q==
X-Gm-Message-State: AA+aEWYdu6X0HErfjFprcd5oe6GzI1iSYIjt9QFio89uHEABNacmed17
        2ookAgPtFB30ZxvVXHT5azfgZzzKdk57ST2xXqg=
X-Google-Smtp-Source: AFSGD/VSwqnbXEXYwj6JKQc2RNMbIQUshgiICuc54wKQ5fST4CTDOZO56iH0WuUhPi6UVahfXgpdcjsvovUjaOgjPlI=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr10521536qvk.40.1544989826236;
 Sun, 16 Dec 2018 11:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20181210211957.210189-1-arnd@arndb.de> <20181214.132551.1587998892072248943.davem@davemloft.net>
In-Reply-To: <20181214.132551.1587998892072248943.davem@davemloft.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 16 Dec 2018 20:50:09 +0100
Message-ID: <CAK8P3a02ir7sdxMi6BYd9_VhNQ-2ph8qa4TCnLBe25u+i-znUQ@mail.gmail.com>
Subject: Re: [PATCH] test_rhashtable: remove semaphore usage
To:     David Miller <davem@davemloft.net>
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        NeilBrown <neilb@suse.com>, Tom Herbert <tom@quantonium.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Blakey <paulb@mellanox.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:25 PM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 10 Dec 2018 22:17:20 +0100
>
> > @@ -635,8 +636,9 @@ static int threadfunc(void *data)
> >       int i, step, err = 0, insert_retries = 0;
> >       struct thread_data *tdata = data;
> >
> > -     up(&prestart_sem);
> > -     if (down_interruptible(&startup_sem))
> > +     if (atomic_dec_and_test(&startup_count))
> > +             wake_up(&startup_wait);
> > +     if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == -1))
> >               pr_err("  thread[%d]: down_interruptible failed\n", tdata->id);
>
> Arnd, please adjust this pr_err() text to match the new code as pointed out by
> Phil Sutter.

Done, and resent as v2. I also noticed that the version I sent did not apply
cleanly on current kernels, so I fixed that, and also added a 'goto out' in
the kthread after printing the error message, so an interrupted thread would
exist straight away.

         Arnd

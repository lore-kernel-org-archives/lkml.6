Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6701AC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139D620843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IMsR6Owg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139D620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJ2AuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:50:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34391 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeJ2AuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:50:13 -0400
Received: by mail-yw1-f66.google.com with SMTP id v199-v6so2416002ywg.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nB+9spQO1O6xs+4+Gn5n9Xs1Rxdw6s378fqUjqRiAVY=;
        b=IMsR6OwgDZEhUM709GvAjR9TAE2aG+tftAlzSwcYQHRmd9xS6GC3hd1j0e0kuKOUqi
         iPJ0t00Mx36eRTLMv9E+iicWT31oHlOYxq+e/iwLpM3HekDNQPpCSjlLJ1r9uj+SLIOn
         4QnkIvqCKfgAvmhEvGhoT13AJFzpyBBKaOtgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nB+9spQO1O6xs+4+Gn5n9Xs1Rxdw6s378fqUjqRiAVY=;
        b=l0hq8qkaOhfrHG1m/jZcKgcdVSJuLeiXi3OvTE8qARAPGNxbI2zAYyI3l80CgGA/e4
         6slcu/7BfvXOOAglPz1gimHAnx9Mmlv0uyXwj38cB4Z8beqBtl0MgJ7NEOwjalvlSv4U
         euuJRKuLA1/xltN0kGtGpPVsrx+vbcXfke6ObTvQvgiERRHoCr/O33VOOXcigJbW5RWl
         oQHFBVsEA2D/NZL3mkDyNe4vBfgyEkoz+iFygcD3wwn7PukpKuGXjBDau3tb+9kJ/pYN
         6zv+fc3nbNIiIyDAxFm9NPHhieRfS2DctDgD1hc2ZFGEvFHi/CjxZVjOfSYTEe+RMOOX
         LZiw==
X-Gm-Message-State: AGRZ1gKxF126FthGsp9uHnyj8uVFoly0vFzVSUAbcOAcU2vq9f0xq8NI
        /GSC0JAeK0+FUJ/HXt3YajE8GnMOUlA=
X-Google-Smtp-Source: AJdET5fYf+JEOnxI3WdeEpNZlkT302zDkvC0muTncfiCJ7Qg2GbClDzCd71+07zqYRocJCsJI4Zs7w==
X-Received: by 2002:a0d:e442:: with SMTP id n63-v6mr10874145ywe.140.1540742711729;
        Sun, 28 Oct 2018 09:05:11 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g66-v6sm6712295ywg.22.2018.10.28.09.05.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 09:05:10 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e16-v6so2446972ybk.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 09:05:10 -0700 (PDT)
X-Received: by 2002:a25:8409:: with SMTP id u9-v6mr11008261ybk.421.1540742709790;
 Sun, 28 Oct 2018 09:05:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Sun, 28 Oct 2018 09:05:09
 -0700 (PDT)
In-Reply-To: <20181026212300.5827-1-linux@rasmusvillemoes.dk>
References: <20181026212300.5827-1-linux@rasmusvillemoes.dk>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 28 Oct 2018 16:05:09 +0000
X-Gmail-Original-Message-ID: <CAGXu5jKj6UWOHrJ-13WQf918sZFe7+gwjAErpu22pLZjdGAZKA@mail.gmail.com>
Message-ID: <CAGXu5jKj6UWOHrJ-13WQf918sZFe7+gwjAErpu22pLZjdGAZKA@mail.gmail.com>
Subject: Re: [PATCH] ptp: drop redundant kasprintf() to create worker name
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:22 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> Building with -Wformat-nonliteral, gcc complains
>
> drivers/ptp/ptp_clock.c: In function =E2=80=98ptp_clock_register=E2=80=99=
:
> drivers/ptp/ptp_clock.c:239:26: warning: format not a string literal and =
no format arguments [-Wformat-nonliteral]
>             worker_name : info->name);
>
> kthread_create_worker takes fmt+varargs to set the name of the
> worker, and that happens with a vsnprintf() to a stack buffer (that is
> then copied into task_comm). So there's no reason not to just pass
> "ptp%d", ptp->index to kthread_create_worker() and avoid the
> intermediate worker_name variable.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/ptp/ptp_clock.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 7eacc1c4b3b1..5419a89d300e 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -232,12 +232,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_cloc=
k_info *info,
>         init_waitqueue_head(&ptp->tsev_wq);
>
>         if (ptp->info->do_aux_work) {
> -               char *worker_name =3D kasprintf(GFP_KERNEL, "ptp%d", ptp-=
>index);
> -
>                 kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker=
);
> -               ptp->kworker =3D kthread_create_worker(0, worker_name ?
> -                                                    worker_name : info->=
name);
> -               kfree(worker_name);
> +               ptp->kworker =3D kthread_create_worker(0, "ptp%d", ptp->i=
ndex);
>                 if (IS_ERR(ptp->kworker)) {
>                         err =3D PTR_ERR(ptp->kworker);
>                         pr_err("failed to create ptp aux_worker %d\n", er=
r);
> --
> 2.19.1.6.gbde171bbf5
>



--=20
Kees Cook

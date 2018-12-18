Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBCEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8F21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeLRQQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:16:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeLRQQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:16:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so18763341qtf.7;
        Tue, 18 Dec 2018 08:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPsG8LHe7LbR8IWimNxu1tJf1e8xCfgBsKFmbckviLQ=;
        b=hTTcKQl6gR5RqHtZE7vlMWBPlSUEC8D0YhaSQcZzwJIFQ6G9jo2dmAli6KvJ/kUW5o
         ItYz0M6x24pZ1d55cGz8Hq17+Eo7U6uzTP0P4Wacp2zA+3WhN9c9j90PY9nG8PlXGBla
         gXrQLYLKtHv/D98haQgJEqR8GpQZu3tqGxlZTn9znsLIFCkbENYpf2oN/u4TUNvypSq6
         scJbfS8c9YKguxJ+iknuMOaSdr9yW8lyiVGtQKQHaWOMNtZKkhchIUKrrF+aGq+JLNoi
         njvY7Oge1Z1bxNdi2qf3HJaeCV3Vj2mE0fTRVlAlMqd/UcBBWGr7luCyZe02lRGL4MSW
         WsZA==
X-Gm-Message-State: AA+aEWbmZT7oY7WVWWo/xp8+Xgqql28hSbLj56nSU8Gy505hIFITbWoG
        LqAfJ9On050rWSL8dXN23jZAfzXUS3OPE4Uzlsk=
X-Google-Smtp-Source: AFSGD/VXyTq0hTJE6/FLsxMU+U2XtK9I2LN/x9c8ei/1ccKQuZ4wtgjeetVgMuICboHTyeyatgoUk/WyzG5bV5uGBpQ=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr17935701qte.212.1545149797871;
 Tue, 18 Dec 2018 08:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-8-deepa.kernel@gmail.com> <CAF=yD-+mrKfq35g+EVkP-pNbBL=6BvYDdduks=yAxiADSRWvzg@mail.gmail.com>
In-Reply-To: <CAF=yD-+mrKfq35g+EVkP-pNbBL=6BvYDdduks=yAxiADSRWvzg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 17:16:20 +0100
Message-ID: <CAK8P3a1xeZsrOv4+xhL5dbi02zfQcPEJvWDzmUNkFKmQubMkSA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] socket: Add SO_TIMESTAMPING_NEW
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Gleixner <tglx@linutronix.de>, ubraun@linux.ibm.com,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 4:25 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Tue, Dec 11, 2018 at 3:30 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:

> > @@ -851,39 +890,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
> >                 break;
> >
> >         case SO_TIMESTAMPING_OLD:
> > -               if (val & ~SOF_TIMESTAMPING_MASK) {
> > -                       ret = -EINVAL;
> > -                       break;
> > -               }
> > -
> > -               if (val & SOF_TIMESTAMPING_OPT_ID &&
> > -                   !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > -                       if (sk->sk_protocol == IPPROTO_TCP &&
> > -                           sk->sk_type == SOCK_STREAM) {
> > -                               if ((1 << sk->sk_state) &
> > -                                   (TCPF_CLOSE | TCPF_LISTEN)) {
> > -                                       ret = -EINVAL;
> > -                                       break;
> > -                               }
> > -                               sk->sk_tskey = tcp_sk(sk)->snd_una;
> > -                       } else {
> > -                               sk->sk_tskey = 0;
> > -                       }
> > -               }
> > -
> > -               if (val & SOF_TIMESTAMPING_OPT_STATS &&
> > -                   !(val & SOF_TIMESTAMPING_OPT_TSONLY)) {
> > -                       ret = -EINVAL;
> > -                       break;
> > -               }
> > -
> > -               sk->sk_tsflags = val;
> > -               if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
> > -                       sock_enable_timestamp(sk,
> > -                                             SOCK_TIMESTAMPING_RX_SOFTWARE);
> > -               else
> > -                       sock_disable_timestamp(sk,
> > -                                              (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
> > +               ret = setsockopt_timestamping(sk, optname, val);
>
> Once again a lot of needless code churn. The only functional change is adding

I think moving the code out into a separate function is a useful cleanup,
but if we want to do that, it may be better done in another patch, to
make it easier to review.

       Arnd

Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6707C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9157320660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbfAHUEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:04:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39699 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfAHUEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:04:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so5820435qtj.6;
        Tue, 08 Jan 2019 12:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkW7W76SxHhQT+R7Cgs1jTueM/y+bXON9Vp9PBD6KUk=;
        b=HyIIKg3rLtociAvCtiL4+W5F3RCEUAMnAlh/+qveGzgNHNSY7ucXD0BIkig2rCKHBg
         hLbL8rW/A8BVC0WDDZdvpzm/TQe5uwuN5DBgfbikoqjCvg5Kb+kbsGfpyqef+3GLcSFW
         R47kmUjQ1g7fGRCIe5wAhQgm8/67yWyYFeEmCrpJPZA5D/k/g2BQqY1ibkn6IsGUgEI4
         Xk/Mwn4ospq9Sxjuqi6+lvRQb3IvzMm9SzqvoMGeNc6Ow/2f/i+EST2SnDPCkjDy2X7L
         4ZYUh2Trj/N4F73RKaz+kytIzMonwMrkbQMyq3VPrdoZcKfeaz9oPaF5mB1zvhoYKf1M
         g8QQ==
X-Gm-Message-State: AJcUukeMWQRYL+0a+UaBmHhoi0+zzy2wV2QTvLdwzJMIP6lAYdmV0hjs
        l/fwPNEBmwhb10jrr0gKhG3jmsW4hZVs1lvpY0M=
X-Google-Smtp-Source: ALg8bN5tuqki2dVs4i6/g+wZOfwMue6nI3pGVupEcrtN/5VTklHmEP3RtEfeqtDa92ooEaFfMQvnuR6VEWedHRQyI4o=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr2955555qtl.343.1546977848238;
 Tue, 08 Jan 2019 12:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20190108052255.10699-1-deepa.kernel@gmail.com> <20190108052255.10699-3-deepa.kernel@gmail.com>
In-Reply-To: <20190108052255.10699-3-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Jan 2019 21:03:49 +0100
Message-ID: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
Subject: Re: [PATCH 2/3] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ccaulfie@redhat.com, Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>, cluster-devel@redhat.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 6:24 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
> as the time format. struct timeval is not y2038 safe.
> The subsequent patches in the series add support for new socket
> timeout options with _NEW suffix that are y2038 safe.
> Rename the existing options with _OLD suffix forms so that the
> right option is enabled for userspace applications according
> to the architecture and time_t definition of libc.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Looks good overall. A few minor concerns:

The description above makes it sound like there is a bug with y2038-safety
in this particular interface, which I think is just not what you meant,
as the change is only needed for compatiblity with new C libraries
that work around the y2038 problem in general by changing their
timeval definition.

> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 76976d6e50f9..c98ad9777ad9 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1089,12 +1089,12 @@ static void sctp_connect_to_sock(struct connection *con)
>          * since O_NONBLOCK argument in connect() function does not work here,
>          * then, we should restore the default value of this attribute.
>          */
> -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
>                           sizeof(tv));
>         result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
>                                    0);
>         memset(&tv, 0, sizeof(tv));
> -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
>                           sizeof(tv));
>
>         if (result == -EINPROGRESS)

It took me a bit to realize there that this is safe as well even if
we don't use SO_SNDTIMEO_NEW, for the same reason.

> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -378,7 +378,7 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
>                 return do_set_attach_filter(sock, level, optname,
>                                             optval, optlen);
>         if (!COMPAT_USE_64BIT_TIME &&
> -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
>                 return do_set_sock_timeout(sock, level, optname, optval, optlen);
>
>         return sock_setsockopt(sock, level, optname, optval, optlen);
> @@ -450,7 +450,7 @@ static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
>                                 char __user *optval, int __user *optlen)
>  {
>         if (!COMPAT_USE_64BIT_TIME &&
> -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
>                 return do_get_sock_timeout(sock, level, optname, optval, optlen);
>         return sock_getsockopt(sock, level, optname, optval, optlen);
>  }

I looked at the original code and noticed that it's horrible, which of course
is not your fault, but I wonder if we should just fix it now to avoid that
get_fs()/set_fs() hack, since that code mostly implements what you
also have in your patch 3 (which is done more nicely).

I'll follow up with a patch to demonstrate what I mean here. Your third
patch will then just have to add another code path so we can handle
all of old_timespec32 (for existing 32-bit user space), __kernel_old_timespec
(for sparc64) and __kernel_sock_timeval (for everything else).

       Arnd

Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53B420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53B420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIMRhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:37:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44269 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:37:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so5091139qtk.11;
        Thu, 13 Sep 2018 05:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLbj9lg5eI6XIgh+VfAYWNRoNRHbaP/ZH67mudtqUa0=;
        b=UcGrvRjqBtjVX0Qzr8o6wHLetCbwu/x0XazkrQoNd40IQQydbTvU8NKtAhxt/p2UA0
         /rPAf7rVCfRL8BizyiCTMaBcXiVLaV9E4dXtPp377dqKmKtaeSxRxfrE3NBZd+nlSXhw
         1f7jbP6DKn/5w6IzWLxmaAw3Uq5+NvnnMQj08BsWfcEQMqN2EnAHJEFc6KlVnHQE0XdR
         vk0dfX4D9JIu4pqfzvcfiv9egqjZwYorvNJIcaj0u9nu9mABsNVIAZw8u/YNpsQUouTM
         7qbSd3ZJFgbjZRp22Rz8Zrq1b+kd7rkJWjek61I1RM+utWzskNcN1Jy/2frM6Rla1u0s
         i3Pw==
X-Gm-Message-State: APzg51AwmNZ4Gck81CX2fJ/R2PPRyOn2MJH+9I9mfoQ348R5KJF8LqZX
        c3hsL8JFIWQ2XB4t5eSiQ/x57ULB/1jh6LZkE22JHA==
X-Google-Smtp-Source: ANB0VdYK7hWXcDAUXaH1AzBwZC2I3q8BdkL4MJDO5FpcUh1mVA2scSJYRi4LO0ZRHkSCzeW5iad2FE9ipmQ13reWyD4=
X-Received: by 2002:aed:3f22:: with SMTP id p31-v6mr4858714qtf.185.1536841704054;
 Thu, 13 Sep 2018 05:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180829130308.3504560-1-arnd@arndb.de>
In-Reply-To: <20180829130308.3504560-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Sep 2018 14:28:08 +0200
Message-ID: <CAK8P3a038aDQQotzua_QtKGhq8O9n+rdiz2=WDCp82ys8eUT+A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hams@vger.kernel.org,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 3:03 PM Arnd Bergmann <arnd@arndb.de> wrote:

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 3730eb855095..df17bbfaca27 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2897,37 +2897,31 @@ bool lock_sock_fast(struct sock *sk)
>  }
>  EXPORT_SYMBOL(lock_sock_fast);
>
> -int sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
> +int sock_gettstamp(struct socket *sock, void __user *userstamp,
> +                  bool timeval, bool time32)
>  {
> -       struct timeval tv;
> -
> -       sock_enable_timestamp(sk, SOCK_TIMESTAMP);
> -       tv = ktime_to_timeval(sk->sk_stamp);
> -       if (tv.tv_sec == -1)
> -               return -ENOENT;
> -       if (tv.tv_sec == 0) {
> -               sk->sk_stamp = ktime_get_real();
> -               tv = ktime_to_timeval(sk->sk_stamp);
> -       }
> -       return copy_to_user(userstamp, &tv, sizeof(tv)) ? -EFAULT : 0;
> -}
> -EXPORT_SYMBOL(sock_get_timestamp);

As  I just learned, sparc64 uses a 32-bit suseconds_t, so this
function always leaked 32 bits of kernel stack data by copying
the padding bytes of 'tv' into user space.

Linux-4.11 and higher could avoid that with
CONFIG_GCC_PLUGIN_STRUCTLEAK, but older kernels
have been affected since socket timestamps were first added.

The same thing is probably true of many other interfaces
that pass a timeval.

> -int sock_get_timestampns(struct sock *sk, struct timespec __user *userstamp)
> -{
> -       struct timespec ts;
> +       struct sock *sk = sock->sk;
> +       struct timespec64 ts;
>
>         sock_enable_timestamp(sk, SOCK_TIMESTAMP);
> -       ts = ktime_to_timespec(sk->sk_stamp);
> +       ts = ktime_to_timespec64(sk->sk_stamp);
>         if (ts.tv_sec == -1)
>                 return -ENOENT;
>         if (ts.tv_sec == 0) {
>                 sk->sk_stamp = ktime_get_real();
> -               ts = ktime_to_timespec(sk->sk_stamp);
> +               ts = ktime_to_timespec64(sk->sk_stamp);
>         }
> -       return copy_to_user(userstamp, &ts, sizeof(ts)) ? -EFAULT : 0;
> +
> +       if (timeval)
> +               ts.tv_nsec /= 1000;
> +#ifdef CONFIG_COMPAT_32BIT_TIME
> +       if (time32)
> +               return put_old_timespec32(&ts, userstamp);
> +#endif
> +
> +       return put_timespec64(&ts, userstamp);
>  }

My new implementation is worse here: it no longer leaks stack
data, but since we now write a big-endian 64-bit microseconds
value, the microseconds are in the wrong place and will
be interpreted as zero by user space...

I'll also have to revisit a few other similar patches I did for
y2038, to figure out what they should do on sparc64.

         Arnd

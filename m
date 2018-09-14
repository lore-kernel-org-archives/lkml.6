Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D11FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5809520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5809520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeINNfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:35:32 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39908 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeINNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:35:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so7967305qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xRJtm1do2m6phnT/3DWqlTLmM1TyHxfIvOEXNetLXA=;
        b=n6Iu0R4c1KVcTA6ZDBOHJTLJwMHGzkLyBa6IuGifRK4P+doPuH1YG0weWnjqYH6faD
         NnjfigEDCeHdQrZARVoZ6NmYrcCrKP/y58FrngjtCtW7rPKOKPaXtu8Djy/oZGvSLi4W
         ujxnzjlcVXSoVoUp8/rZr/743nyLFmXLlFJLmOcfaOJoV9XpySyMGW9Otx8wVq5uSRHX
         CpsiD2fGAeztKQDhmhaxGVzlXbASuox0jA5wMfrdBqNbvTXnar7h43fuqnZDFOJdt/Ha
         MdIfWOSpAa/aZQ7g9UKI7aCu81yxRkWKLFOJ9WoBACPC3n/Vp4kxZJKX6aYvNXg2Mtmd
         SZhA==
X-Gm-Message-State: APzg51ATPnPUCxWrEhVZvZDo/xrRKHOWaGsPBd+TAHtTnmsUdoUp/oXr
        Yx+bpDkfP7wGhsef0Lr98HRZitjPTY05Szx4BXTSrQ86
X-Google-Smtp-Source: ANB0VdbWAmmZAv7+gLkHPTlJhtWtEONw3JK7KklOvtNxKPmBm2EAR4ZIlHt0mhYzvp9aABxZ1NIASFsBWq3FpA4BAtg=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr7982940qtd.132.1536913330041;
 Fri, 14 Sep 2018 01:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
 <20180913203145.GU19965@ZenIV.linux.org.uk> <CAK8P3a3LD58jnwP38OpnEWHMzAAfrqtfjHamWVU5PwaKoWyKjg@mail.gmail.com>
 <20180914022737.GX19965@ZenIV.linux.org.uk>
In-Reply-To: <20180914022737.GX19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 10:21:53 +0200
Message-ID: <CAK8P3a0wN0uMZdj-mxXwbN9AnZjHzMU6_b01H5y+Vpdt+UoeAw@mail.gmail.com>
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Miller <davem@davemloft.net>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 4:27 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Sep 13, 2018 at 10:56:48PM +0200, Arnd Bergmann wrote:

> commit de36af5ca465156863b5fb7548e3660ea7d3bbcf
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Thu Sep 13 22:12:15 2018 -0400
>
>     change semantics of ldisc ->compat_ioctl()
>
>     First of all, make it return int.  Returning long when native method
>     had never allowed that is ridiculous and inconvenient.

Ack.

>     More importantly, change the caller; if ldisc ->compat_ioctl() is NULL
>     or returns -ENOIOCTLCMD, tty_compat_ioctl() will try to feed cmd and
>     compat_ptr(arg) to ldisc's native ->ioctl().
>
>     That simplifies ->compat_ioctl() instances quite a bit - they only
>     need to deal with ioctls that are neither generic tty ones (those
>     would get shunted off to tty_ioctl()) nor simple compat pointer ones.

This does sound very appealing, but there is a small downside:
The difference between ".compat_ioctl = NULL" and
".compat_ioctl=native_ioctl" is now very subtle, and I wouldn't
necessarily expect casual readers to understand that.

If we go with my file_operations patch for generic_compat_ioctl_ptrarg
and add generic_compat_ioctl_intarg, we can do the same thing here
with ldisc_compat_ioctl_ptrarg/ldisc_compat_ioctl_intarg to make it
a little more consistent with fops and self-documenting.

> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 963bb0309e25..ae0dd57a8e99 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -821,6 +821,7 @@ static int __init hci_uart_init(void)
>         hci_uart_ldisc.read             = hci_uart_tty_read;
>         hci_uart_ldisc.write            = hci_uart_tty_write;
>         hci_uart_ldisc.ioctl            = hci_uart_tty_ioctl;
> +       hci_uart_ldisc.compat_ioctl     = hci_uart_tty_ioctl;
>         hci_uart_ldisc.poll             = hci_uart_tty_poll;
>         hci_uart_ldisc.receive_buf      = hci_uart_tty_receive;
>         hci_uart_ldisc.write_wakeup     = hci_uart_tty_wakeup;

so this would become

       hci_uart_ldisc.compat_ioctl     = ldisc_compat_ioctl_intarg;

>  static struct tty_ldisc_ops sp_ldisc = {
>         .owner          = THIS_MODULE,
>         .magic          = TTY_LDISC_MAGIC,
> @@ -776,9 +758,6 @@ static struct tty_ldisc_ops sp_ldisc = {
>         .open           = sixpack_open,
>         .close          = sixpack_close,
>         .ioctl          = sixpack_ioctl,
> -#ifdef CONFIG_COMPAT
> -       .compat_ioctl   = sixpack_compat_ioctl,
> -#endif
>         .receive_buf    = sixpack_receive_buf,
>         .write_wakeup   = sixpack_write_wakeup,
>  };

And this would be

         .compat_ioctl = ldisc_compat_ioctl_ptrarg,

respectively

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 0f75ae6bfaa7..483ad432d906 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2824,6 +2824,9 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
>                 return hung_up_tty_compat_ioctl(file, cmd, arg);
>         if (ld->ops->compat_ioctl)
>                 retval = ld->ops->compat_ioctl(tty, file, cmd, arg);
> +       if (retval == -ENOIOCTLCMD && ld->ops->ioctl)
> +               retval = ld->ops->ioctl(tty, file,
> +                               (unsigned long)compat_ptr(cmd), arg);
>         tty_ldisc_deref(ld);

The added fallback would still be useful in case someone
forgets to add the .compat_ioctl assignment to a newly
added ldisc.

Another idea I had for a final fallback would be

          tty_ldisc_deref(ld);
+        if (retval == -ENOIOCTLCMD && _IOC_TYPE(cmd) == 'T') {
+                 retval = tty_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+                 WARN_ON_ONCE(retval != -ENOIOCTLCMD && retval != -ENOTTY);
+        }

Seeing that you list every single 'T' command in tty_compat_ioctl()
that we handle in the native case, that WARN_ON_ONCE should not
trigger for any input, but it would catch (and warn about) any of those
that might get added in the future to the native code path without the
compat entry.

That might be too much  -- if it gets easy enough to keep the code
correct in the first place, there is no need.

            Arnd

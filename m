Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8218DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F0920870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F0920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeJ2VwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:52:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34472 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJ2VwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:52:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so4827299qkg.1;
        Mon, 29 Oct 2018 06:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS8S9dnRxUWD38Fs9fu7hAdf1KDQ/28YbR5SSVzO0uo=;
        b=n/ZBaEOueS+k/s3/PEdBpjO1q7EEsvCh27934CtEU8fRRUYDqybjHdeo5GmeHZACt2
         brFkw0cAfN+k/BWhs0Lw+cvOWgFOrwGLFQiY2rIl7u+JWlJJXvPoqunzfdtF2Fp1pJ6Y
         d1o58dKNfs+BAiGpNikDY+9YcYZKJ77BbJJ3EL5rwFUnOGi6Eh/KITxXmGENqLr3eyoy
         txdCHvAU5JFFxQJ3mOXYbrfG3spizP0QtYBFxzAe3IhB0XX0mKkkWs2EPCV609UcGtjs
         FT7dgPXj0AGoDoqpdvOKv0TqbJFu3dCEQyomwJyh1NhizMGTvur2Z2WqH5xCiMwFdAAI
         iPZQ==
X-Gm-Message-State: AGRZ1gLI1KJEjCrrKiiTYs4Xt5ef/S+njN9T3FwcYVQ1WQL8BTBkZ9BS
        wEp/2ED4s1Ygih8ifRaPw9NhlnAzYLlQ2hRq+t4=
X-Google-Smtp-Source: AJdET5eELqkMzFqdWlAVL/GYN/JCuRbQicRvGdt820FZlEMgFzpxAgTWZiBmHijiVoOohdSWXamiklIiWzRYMv8Wkeo=
X-Received: by 2002:ae9:d801:: with SMTP id u1-v6mr12275026qkf.291.1540818211414;
 Mon, 29 Oct 2018 06:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20170630073448.GA9546@unicorn.suse.cz> <20180831111436.GA23780@dell5510>
In-Reply-To: <20180831111436.GA23780@dell5510>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 14:03:15 +0100
Message-ID: <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
Subject: Re: RFC: changed error code when binding unix socket twice
To:     pvorel@suse.cz
Cc:     mkubecek@suse.cz, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        rweikusat@mobileactivedefense.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
        junchi.chen@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 1:17 PM Petr Vorel <pvorel@suse.cz> wrote:
> > commit 0fb44559ffd6 ("af_unix: move unix_mknod() out of bindlock") moves
> > the special file creation in unix_bind() before u->bindlock is taken in
> > order to avoid an ABBA deadlock with do_splice(). As a side effect, it
> > also moves the check for existence of the special file (which would
> > result in -EADDRINUSE) before the check of u->addr (which would result
> > in -EINVAL if socket is already bound). This means that the error
> > returned for an attempt to bind a unix socket to the same path twice
> > changed from -EINVAL to -EADDRINUSE with this commit.
>
> > One way to restore the old error code is indicated below but before
> > submitting it, I would like to ask if we need/want it.
>
> > Pro:
> >   - in general, we do not want to change return code for given testcase
> >   - old error (-EINVAL) is consistent with AF_INET(6)
> > Con:
> >   - both POSIX and Linux man page only list error conditions without
> >     stating which should take precedence if more of them apply so
> >     neither of them seems wrong, strictly speaking
>
> I'd be for restoring the original behavior (be conservative + looks like as not intended).
>
> Any comment from netdev maintainers?

Naresh noticed that LTP now has a version check to  detect linux-4.10+ and
expect a different return code from previous versions, but the 0fb44559ffd6
commit that changed the behavior got backported to stable linux-4.4 and 4.9,
so now LTP complains about those:

https://bugs.linaro.org/show_bug.cgi?id=4042

I don't care much which error code gets returned here, but I think we
should either handle this consistently in all kernel versions and check for
the one that is deemed the correct one on all versions, or change LTP
again to accept either return code.

        Arnd

> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 1a0c961f4ffe..509292bdf7ed 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -992,7 +992,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> >       struct unix_sock *u = unix_sk(sk);
> >       struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
> >       char *sun_path = sunaddr->sun_path;
> > -     int err;
> > +     int err, mknod_err;
> >       unsigned int hash;
> >       struct unix_address *addr;
> >       struct hlist_head *list;
> > @@ -1016,12 +1016,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> >       if (sun_path[0]) {
> >               umode_t mode = S_IFSOCK |
> >                      (SOCK_INODE(sock)->i_mode & ~current_umask());
> > -             err = unix_mknod(sun_path, mode, &path);
> > -             if (err) {
> > -                     if (err == -EEXIST)
> > -                             err = -EADDRINUSE;
> > -                     goto out;
> > -             }
> > +             mknod_err = unix_mknod(sun_path, mode, &path);
> > +             /* do not exit on error until after u->addr check */
> > +             if (mknod_err == -EEXIST)
> > +                     mknod_err = -EADDRINUSE;
> >       }
>
> >       err = mutex_lock_interruptible(&u->bindlock);
> > @@ -1031,6 +1029,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
> >       err = -EINVAL;
> >       if (u->addr)
> >               goto out_up;
> > +     if (mknod_err) {
> > +             err = mknod_err;
> > +             goto out_up;
> > +     }
>
> >       err = -ENOMEM;
> >       addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);

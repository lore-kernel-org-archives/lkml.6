Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F12C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454312083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454312083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeHaOic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:38:32 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37746 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeHaOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:38:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so13938544qtl.4;
        Fri, 31 Aug 2018 03:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8eflnERVVnmyV4uIliMAqFR2z4AI9GlXrW8KWwX/mY=;
        b=m1g1UyaqhLb/11tzBdBw11XZPW2I5RcKYYVTduF1mb3emFWk6Vbm8/AW07kjLtNI9f
         7VX8dbO1ubTsRbWeR4sQs1EPylO2Wh55aa80zo2mJJmh7BrDk2m30fMXScPinm8lQckp
         cbWaBx8ogI0ZoPRyj+Z0I5nHo/edIsehx0KfA5s+wIhca/QMzbvDnPCZU6eMxuDl1cM5
         29x2txhu4dwsSR8WNc7jz+cXcq3L2F3bjzVDhqVshdHq+ELwZ51OjBdtKcWijg2HKraK
         b7jw5qPpl9QFiS88OgbOx8r6V4hwyQlBkMDAnC5xpqs3Hjg89Dz5Cs77WX5a1z/5S2rv
         oq2w==
X-Gm-Message-State: APzg51BLY+bgCdJpohiPmCyzMe3wVIZLye8HQysbso5LdGh2dV2VZhye
        NVy3WdQzsTV8J9R5l1yxcsK2cmbWzIK9W29edn8i/Fhs
X-Google-Smtp-Source: ANB0VdY2uJHQdI75yrPcd9T448Fl6txbEcPCukLr6rMQX4kWswshFc3BkkafvTZEUq59ntKzCeacFtdGx2OT8AIMry0=
X-Received: by 2002:aed:3f22:: with SMTP id p31-v6mr15106815qtf.185.1535711500103;
 Fri, 31 Aug 2018 03:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180829130308.3504560-1-arnd@arndb.de> <CAF=yD-J7-GumUmonrZt7s44e3bsjY2DCD6ZpmhtCx6FOBV5BNA@mail.gmail.com>
In-Reply-To: <CAF=yD-J7-GumUmonrZt7s44e3bsjY2DCD6ZpmhtCx6FOBV5BNA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Aug 2018 12:31:23 +0200
Message-ID: <CAK8P3a2XTUZJUqGu6v=SZqcoJTqM3fgtDAWBnBopX3=4NJYcRA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>,
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

On Thu, Aug 30, 2018 at 10:10 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, Aug 29, 2018 at 9:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> > socket protocol handlers, and all of those end up calling the same
> > sock_get_timestamp()/sock_get_timestampns() helper functions, which
> > results in a lot of duplicate code.
> >
> > With the introduction of 64-bit time_t on 32-bit architectures, this
> > gets worse, as we then need four different ioctl commands in each
> > socket protocol implementation.
> >
> > To simplify that, let's add a new .gettstamp() operation in
> > struct proto_ops, and move ioctl implementation into the common
> > sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> > through.
> >
> > We can reuse the sock_get_timestamp() implementation, but generalize
> > it so it can deal with both native and compat mode, as well as
> > timeval and timespec structures.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This also will simplify fixing a recently reported race condition with
> sock_get_timestamp [1]. That calls sock_enable_timestamp, which
> modifies sk->sk_flags, without taking the socket lock. Currently some
> callers of sock_get_timestamp hold the lock (ax25, netrom, qrtr), many
> don't. See also how this patch removes the lock_sock in the netrom
> case. Moving the call to sock_gettstamp outside the protocol handlers
> will allow taking the lock inside the function.

I suppose it would be best to always take that lock then, rather than
removing the lock as my patch does at the moment.

> If this is the only valid implementation of .gettstamp, the indirect
> call could be avoided in favor of a simple branch.

I thought about that as well, but I could not come up with a
good way to encode the difference between socket protocols
that allow timestamping and those that don't.

I think ideally we would just call sock_gettstamp() unconditonally
on every socket, and have that function decide whether timestamps
make sense or not. The part I did not understand is which ones
actually want the timestamps or not. Most protocols that
implement the ioctls also assign skb->tstamp, but there are some
protocols in which I could not see skb->tstamp ever being set,
and some that set it but don't seem to have the ioctls.

Looking at it again, it seems that sock_gettstamp() should
actually deal with this gracefully: it will return a -EINVAL
error condition if the timestamp remains at the
SK_DEFAULT_STAMP initial value, which is probably
just as appropriate (or better) as the current -ENOTTY
default, and if we are actually recording timestamps, we
might just as well report them.

> Acked-by: Willem de Bruijn <willemb@google.com>

Thanks,

      Arnd

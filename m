Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB24FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89312218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeLRQdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:33:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40551 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeLRQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:33:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so18832418qtf.7;
        Tue, 18 Dec 2018 08:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th7NHMeHQoKdSHNkZdcu6ZdlLE6n9OaMOuB+SLSeVIM=;
        b=YnWnlqUsK2idMXkZ2cl68ZucySbwB2mIdvHmce0TIygqFjvWPjr80M43PTMBPdgKLE
         1vsp0VBzdUDk7j5ke+5Dcnrz9QRbBKnOzkwaEMg/bMEKDdut6xLiTXfFG8FZoqsAUPhx
         b0ER/8QGtBBnOPaIo9V4FKL8r/G+POVH2zc7c5SiZakrvQ8EK+1zDxMrRtkh1kSyEKH2
         5jTrJfizww+S7FiJ+Y/1gpu0OHNfdNI4RE3bLQR2zmALy2CJWYvFfOS0O6d2eMKJ01vR
         uNspGwS0uFRP8aQDT6dXGr3JMDGYTYHIYV5rGvqyd8RtVjyG8G2yr6nlT+3VnwKx2mUm
         jnXw==
X-Gm-Message-State: AA+aEWaUu3/DLpGM05USgF0apBfq4J2CcpyMkmzm8Butx0GNGBMu27av
        yQ7d4bM2tqSE/8Wkz8GoXsWxgDwMqa6gDPw/ZyY=
X-Google-Smtp-Source: AFSGD/X1fIFL82Nf8GmTLH/6zhfFpdNDPUe8KNmqHsFbxXY4N9IlOUTYdEdlGguUMKpPcVx3gM9Rep2DFChQr0q7LZ4=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr17551159qvk.40.1545150808554;
 Tue, 18 Dec 2018 08:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
 <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com>
 <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
 <CABeXuvqrZgEDF5RYQEPJ8RyXDg0uvXx_qMq=2ER8Bc9RXFPDGQ@mail.gmail.com> <CAF=yD-KFYdXRgL-HpAJLLHuywMcaBGfz7sDL35DBNs0hoq+zxQ@mail.gmail.com>
In-Reply-To: <CAF=yD-KFYdXRgL-HpAJLLHuywMcaBGfz7sDL35DBNs0hoq+zxQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 17:33:11 +0100
Message-ID: <CAK8P3a0PFQCqo2Ofce7uJeWAgssMbh8u1CNWeAmUk9LzQRn35g@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 7:52 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > 3 reasons for not doing this:
> >
> > 1. We do not want to break userspace. If we move this to
> > linux/socket.h all the userspace programs now have to include
> > linux/socket.h or get this definition through a new libc.
> > 2. All the socket options are together in the file asm/socket.h. It
> > doesn't seem good for maintainability to move just a few bits
> > elsewhere.
> > 3. There are only 4 arches (after the series is applied) that have
> > their own asm/socket.h. And, this is because there seems to be
> > significant differences to asm-generic/socket.h that don't seem
> > logically obvious to group and eliminate some of the defines.
>
> Agreed. All good reasons to leave as is.
>
> > Also for the other comment. The reason the conditionals were not
> > consistent is because they were not consistent to begin with.
>
> The only difference I see is an inversion of the test. Nesting order
> is the same:
>
>         int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
>         ...
>         if (need_software_tstamp) {
>                 if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                 } else {
>                 }
>         }
>
> vs
>
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>                         if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                         } else {
>                         }
>                 }
>
> I suggest just adding something like
>
>         if (need_software_tstamp) {
> +              if (sock_uses_new_tstamp(sk) {
> +                   __sock_recv_timestamp_new(msg, sk,
> ktime_to_timespec64(skb->tstamp));
> +              } else if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> -               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                 } else {
>                 }
>
> and
>
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> +                      if (sock_uses_new_tstamp(sk) {
> +                           __sock_recv_timestamp_new(msg, sk, ts);
> +                      else if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> -                       if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                         } else {
>                         }

Generally speaking, I think we want the new time handling
to be written as the default case rather than have it hidden away
in a separate function. If we didn't have the sparc64 quirk with its
unusual timeval definition, we'd only need a special flag for the
old 32-bit format, but that doesn't work as long we have to support
two different 64-bit formats for 64-bit timeval on sparc64
(32 or 64 bit microseconds).

> Note also (2) tentative helper function sock_uses_new_tstamp(const
> struct sock *sk) instead of testing sock_flag(sk, SOCK_TSTAMP_NEW)
> directly. Since the .._NEW variants are equivalent to .._OLD on 64-bit,
> I wonder if we can just compile out the branch. Something like
>
>     static inline bool sock_uses_new_tstamp(const struct sock *sk) {
>             return (sizeof(time_t) != sizeof(__kernel_long_t)) &&
>                        sock_flag(sk, SOCK_TSTAMP_NEW);
>     }

I think that would break compat handling: when we have a 32-bit
user space process, the difference between old and new timestamps
is meaningful even on 64-bit kernels, but the distinction is only made all
the way down in put_cmsg_compat().

      Arnd

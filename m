Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31EEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52D620850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52D620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeKZHmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:42:23 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38454 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZHmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:42:23 -0500
Received: by mail-qt1-f194.google.com with SMTP id p17so15420768qtl.5;
        Sun, 25 Nov 2018 12:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUCxW18y8D6N0aWglscyqMJV0lD1gpvnnI/a2Goe44Q=;
        b=GJ63mvWoSDH+U/XTL+RXFHREofPPF9vPpBKdhfXJib4A2FLh2B1fwiVaI7ykSGKlpU
         Zzk0xgsxsl6lLfI9jJieIc0fLVKBQsquNlKHonDhfeFNHMOYo9CqoBO65MrKyZyfk803
         s9HahSXs0cLfIi8/R6Zeo8JJtvRk57tQjS6fYwWA+14Dbgdw18Wz2zkxApOmkweW+qgH
         dAYv4o2/O3u3L6/Yd5tpYNM3zUJqfSNs3AnmxIque93qTjFGOTY/rDCh86/ecJHZLWGD
         /yHsGMSC02NNn3GX6/xvJ2M/HCu9Fcs6b+2VXa1bINUODHBRNOl16CEbnsh8zMNGpZ0R
         4JNg==
X-Gm-Message-State: AGRZ1gIdHVJIsAXLIOAkM/lSdpoXiNZ0eZwU3mQNKrinwyOISEr9Ud9e
        zfhJ0kVuSIVFWfrhyzcqTsdt/yr0ByGeeTMT3Br3WQ==
X-Google-Smtp-Source: AJdET5dnIF9laNWhkNJmLD8ryDxEO2jv4N3E7A/HxrdrghTi9Vf5h8oes6+uA/jit8IPgJgXQL6PO3R9nKoNsv/p2J8=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr22879184qte.212.1543179027412;
 Sun, 25 Nov 2018 12:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-7-deepa.kernel@gmail.com> <CAF=yD-+1BJHuajcW=2bpeAp5XOAX2fObyvhOdH-YsiGY3-_J4Q@mail.gmail.com>
 <CABeXuvrV+xN3O8BSmJ7bGR+8uYmtrCk2YL37HQZrBSO8YSvzJQ@mail.gmail.com>
In-Reply-To: <CABeXuvrV+xN3O8BSmJ7bGR+8uYmtrCk2YL37HQZrBSO8YSvzJQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 25 Nov 2018 21:50:09 +0100
Message-ID: <CAK8P3a3UVOeaYqwOiAMrziVcY6GpbCkDRGGAgFJKBJnB1e=v=w@mail.gmail.com>
Subject: Re: [PATCH 6/8] socket: Add struct sock_timeval
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 5:52 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Sat, Nov 24, 2018 at 11:38 AM Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > On Sat, Nov 24, 2018 at 4:00 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > The new type is meant to be used as a y2038 safe structure
> > > to be used as part of cmsg data.
> > > Presently the SO_TIMESTAMP socket option uses struct timeval
> > > for timestamps. This is not y2038 safe.
> > > Subsequent patches in the series add new y2038 safe socket
> > > option to be used in the place of SO_TIMESTAMP_OLD.
> > > struct sock_timeval will be used as the timestamp format
> > > at that time.
> > >
> > > struct sock_timeval also maintains the same layout across
> > > 32 bit and 64 bit ABIs.
> > >
> > > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > > ---
> > >  include/uapi/linux/time.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
> > > index 04d5587f30d3..106f9398c285 100644
> > > --- a/include/uapi/linux/time.h
> > > +++ b/include/uapi/linux/time.h
> > > @@ -70,6 +70,11 @@ struct __kernel_old_timeval {
> > >  };
> > >  #endif
> > >
> > > +struct sock_timeval {
> > > +       long long tv_sec;
> > > +       long long tv_usec;
> >
> > should these use fixed-width type __u64?
>
> We have avoided using __u64/__s64 types for time types in uapi.
> I think we did this for portability reasons.
> Although this new type might not be required to be interpreted in
> libc, I would prefer for this to be long long.
> If there is a strong preference then I can change it.

I think we want signed types to keep it closer to what we
have today with 'timeval'. as long as linux/types.h is included
first (it is).

Between __s64 or long long, I don't think it makes a difference,
so let's just go with Willem's suggestion. We already rely on
'long long' being exactly 64 bit wide in 'struct __kernel_timespec'
as well.

We could however debate whether 'sock_timeval' should
be visible to user space in linux/tme.h like this, or if it
should be put in a namespace like '__kernel_sock_timeval'
to ensure it won't conflict with user space headers defining
a type of the same name.

       Arnd

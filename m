Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20DDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E61B21738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeLaMRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:17:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34097 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeLaMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:17:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so29214120qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TrCEGBSRshBH4A9wwGkDALkxyybXabTiBiAMJ5ITDw=;
        b=LaXE4Nc2++8byB+6yR1qprScQRv/hhWGf9KzIKBjeM/vZLnWeQwGej0KcFEE7nXoR/
         M8GPkg93q/EPOZbLdrKljy3ixOixeHA4EZongf1aCo9xe3rWvkgYLL2pEYQkSOPQEPDY
         mq0pavBrz8zvtk3+db3uSDY5fgzyYgfY7buzt4olFpjcyvzAMCdD1wam23dMAOtsqpOZ
         9sdpymJ4bhfED3CgGh0hDA/tbeIRtCl4ulXINfdT8vzZCLIYkSFStW4j+pAhphJagAtO
         dhKsLQtJvg1iJBJGbAOHCLK/zv8T0KrjVjbsLZKRCGxM+Jg8+wzOj/Vo5DwBQ5tkHx9Y
         ldcw==
X-Gm-Message-State: AJcUukfVjN8q9h7BzsVMDNyEoCqLyufxKvCr/l+FzUEQ1uSRq7X6Xl4L
        N7AuKEycjZY+WNXcHhkRRdI1lOYKq0QpCe6lEFY=
X-Google-Smtp-Source: ALg8bN45meDN7E3v+xhLS+DgQpPmWVBnyURZMJOYQl6VJ57mQFA4G73Em24t5QbMjTv8xBlIXqgQ2BOp1xxdSoyQScQ=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr34786484qvl.180.1546258669025;
 Mon, 31 Dec 2018 04:17:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
 <alpine.LNX.2.21.1812301744540.424@nippy.intranet> <alpine.LNX.2.21.1812311006040.444@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812311006040.444@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Dec 2018 13:17:33 +0100
Message-ID: <CAK8P3a0w5hGFJQv6hPgWFNruKjirjBCrviQS8W03KC4jd=Ldnw@mail.gmail.com>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 12:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 30 Dec 2018, Finn Thain wrote:
> > > > diff --git a/include/linux/nvram.h b/include/linux/nvram.h
> > > > index b7bfaec60a43..24a57675dba1 100644
> > > > --- a/include/linux/nvram.h
> > > > +++ b/include/linux/nvram.h
> > > > @@ -18,8 +18,12 @@ struct nvram_ops {
> > > >         unsigned char   (*read_byte)(int);
> > > >         void            (*write_byte)(unsigned char, int);
> > > >         ssize_t         (*get_size)(void);
> > > > +#ifdef CONFIG_PPC
> > > > +       long            (*sync)(void);
> > > > +#else
> > > >         long            (*set_checksum)(void);
> > > >         long            (*initialize)(void);
> > > > +#endif
> > > >  };
> > >
> > > Maybe just leave all entries visible here, and avoid the above #ifdef
> > > checks.
> > >
> >
> > The #ifdef isn't there just to save a few bytes, though it does do that.
> > It's really meant to cause a build failure when I mess up somewhere. But
> > I'm happy to change it if you can see a reason to do so (?)
> >
>
> I think the problem with these #ifdef conditionals is that they don't
> express the correct constraints. So, at the end of this series I'd prefer
> to see,
>
> struct nvram_ops {
>        ssize_t         (*read)(char *, size_t, loff_t *);
>        ssize_t         (*write)(char *, size_t, loff_t *);
>        unsigned char   (*read_byte)(int);
>        void            (*write_byte)(unsigned char, int);
>        ssize_t         (*get_size)(void);
> #if defined(CONFIG_PPC)
>        long            (*sync)(void);
>        int             (*get_partition)(int);
> #elif defined(CONFIG_X86) || defined(CONFIG_M68K)
>        long            (*set_checksum)(void);
>        long            (*initialize)(void);
> #endif
> };
>
> Is that okay with you?

My preference would be no #ifdef here, but the compile time
error you mention is a good enough reason, so I'm fine with
either version you pick.

       Arnd

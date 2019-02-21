Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A4820836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V81rMQ2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfBUSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:05:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36016 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:05:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so14123334pgr.3;
        Thu, 21 Feb 2019 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DQGIfQP8nQEV7q98KAz03H9vqLDFTfsvBZRn3KMVxYM=;
        b=V81rMQ2nFsmEeOPJloy1PnxO1Wh27a+n8X6SyzYvBDyOFdTUIf/S8/y9At3AT8S3B2
         wXC5hhRxNUnqJGr9I8UzSBXZ6Tqp1gj5g9W7jAqZmPy66roDApYMgoLvCpWvRMDEzdeA
         c10a4tsfF9Ly3XeuZ8OTkojFxihLP41Y/2T0/b03pyFfSUuJVQUOinEH1PYaBl7exmUd
         AF0WsEvuC0z+wzunyBGEwwn9emHuKjVyHvrCf/L9JAmeZ0wC3DodhfCZUb5hb/mOakCt
         JNAgUKJkScQJdd+06+QQ445L6dso/X1wKAc1MKc6akeAg2/v4awPalNc/xWXR66ItBHq
         /KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DQGIfQP8nQEV7q98KAz03H9vqLDFTfsvBZRn3KMVxYM=;
        b=Z18yuWMGUGHJgcNGpnn4qZKIqJGGUYZ9HpbwaUd8j0qVKG2A/3E2KXaenkQG0jjwaK
         /t3vXje4fyLctVTsiYohH7IbeXzfnZNFHtUyOl10iObQ1YgdJNkGWO2stlLschXA3eET
         847uLvR1NpoheiVkwsTMov2aQgwyoslHccixn5VH6ZePjPETi8+2b+llyuNjVR4nfaHy
         op9Rp0qx/Ynp5dFl+uTcg0uk3ng9KMqV/698H6Got66qkQ+nGOOBtv1iNtCMyaFhEIMC
         tP6bdrGNm5mbFoqqrS80vIrCckzIOXtA33idvfP6o4a34ZDtKfBQTWotZBaOiruC6KwV
         N8gQ==
X-Gm-Message-State: AHQUAub8rSHQWoo7Pg30C4uEEXpm1Eb07oYupIOHPoXuR5qbJ5EynDm5
        ui1gMHts1ga1vhaxrG62fuY=
X-Google-Smtp-Source: AHgI3IZUTlcJgaOYxPeFCzpK+SAttMW8t+Gh15xswVXLXFrecf/i8mrSkegWEvFwxuNTg51ziSGG8w==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr41543263pfl.149.1550772345609;
        Thu, 21 Feb 2019 10:05:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8sm19842738pfn.137.2019.02.21.10.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 10:05:44 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:05:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpfilter: remove extra header search paths for
 bpfilter_umh
Message-ID: <20190221180543.GB22715@roeck-us.net>
References: <20190221144257.GA12892@roeck-us.net>
 <CAK7LNASfiSrULgdG_tcm+m4wmyOjg4ZHYAB9EUgaGrjv=g-Zbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASfiSrULgdG_tcm+m4wmyOjg4ZHYAB9EUgaGrjv=g-Zbg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:54:47AM +0900, Masahiro Yamada wrote:
> On Thu, Feb 21, 2019 at 11:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Jan 31, 2019 at 12:15:35PM +0900, Masahiro Yamada wrote:
> > > Currently, the header search paths -Itools/include and
> > > -Itools/include/uapi are not used. Let's drop the unused code.
> > >
> > > We can remove -I. too by fixing up one C file.
> > >
> >
> > This patch reintroduces the problem last fixed with commit ae40832e53c3
> > ("bpfilter: fix a build err"). Seen (at least) with gcc 7.4.0, 8.2.0.
> > binutils version is 2.31.1. Reverting this patch fixes the problem.
> 
> 
> Hmm. I cannot reproduce the build error with my gcc,
> but you are right.
> 
Maybe it has less to do with the gcc version and more with how the
toolchain is built. I see the problem with toolchains generated
using buildroot.

> 
> I'd like to get back only
> 'KBUILD_HOSTCFLAGS += -Itools/include/ -Itools/include/uapi'
> instead of the full revert.
> 

That doesn't work for me. I need

KBUILD_HOSTCFLAGS += -I. -Itools/include/uapi

Just don't ask me why.

Guenter
 
> If David is fine with it, I can send a patch with filling commit log.
> 
> 
> 
> Thanks.
> 
> 
> 
> > Guenter
> >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > ---
> > >  net/bpfilter/Makefile | 1 -
> > >  net/bpfilter/main.c   | 2 +-
> > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> > > index 0947ee7f70d5..5d6c7760142d 100644
> > > --- a/net/bpfilter/Makefile
> > > +++ b/net/bpfilter/Makefile
> > > @@ -5,7 +5,6 @@
> > >
> > >  hostprogs-y := bpfilter_umh
> > >  bpfilter_umh-objs := main.o
> > > -KBUILD_HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
> > >  HOSTCC := $(CC)
> > >
> > >  ifeq ($(CONFIG_BPFILTER_UMH), y)
> > > diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
> > > index 1317f108df8a..61ce8454a88e 100644
> > > --- a/net/bpfilter/main.c
> > > +++ b/net/bpfilter/main.c
> > > @@ -6,7 +6,7 @@
> > >  #include <sys/socket.h>
> > >  #include <fcntl.h>
> > >  #include <unistd.h>
> > > -#include "include/uapi/linux/bpf.h"
> > > +#include "../../include/uapi/linux/bpf.h"
> > >  #include <asm/unistd.h>
> > >  #include "msgfmt.h"
> > >
> > > --
> > > 2.7.4
> 
> 
> 
> --
> Best Regards
> 
> Masahiro Yamada

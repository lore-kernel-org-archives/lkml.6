Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3054C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8038620868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1aUGJkfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8038620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeKZAsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:48:13 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:44695 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeKZAsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:48:12 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAPDux1W018779
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:57:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAPDux1W018779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543154220;
        bh=aIuesR7do2IocVBw8Ifx6CBIm/2NA2X6nJXyEEXcI20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1aUGJkfuFA2JPFrklE4SBF3GYLpme5k4XdBywvYRdOUeIEp//kRoPOZHMgFZHOpv/
         gi3hgG7PgdxBa6uxkHf9LguwUhkV9b+4RVy/LbVZ/AHpNxyRBVOlCcQELjjyZGgKAu
         2nSXCh4ZEgja/gHdq78HuD9EaBJRNQ+SxG52WxJE/iyea7GdsHRl9t3QQdyDgr04bx
         D8/yElge86Fs2bUuF4NMGYUYlCgWbqs5dtLweSLhuyRKKbZ2eeaSCTZcdxhNeM1LUN
         /FxdH1WapbMxxvYApOSyFHa5m+EXAK5lsj+sia8xUdSKocy6uD/R5ndw/ohq+qYglA
         INaQ0NMCK+nig==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id z11so5431839uaa.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 05:57:00 -0800 (PST)
X-Gm-Message-State: AA+aEWYw8Vt7TGHb23WGQUXALX4cSO0l06LI4b79zejS/WTnvyy7TTue
        bkqNvtYSpikLSNPKokM4QEk1hTbPJ3Poth5mVfg=
X-Google-Smtp-Source: AFSGD/WYRpP+O0FLaNc8OH3hCZbFsl9hD4XX00Rb4zzFTsAp+slHNo/4vcraSCwHaz3c0Z5uBv5rFdXMth/VC7Mn1MM=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr9751327uam.89.1543154219015;
 Sun, 25 Nov 2018 05:56:59 -0800 (PST)
MIME-Version: 1.0
References: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com>
 <20181122143201.d7vifhlny7gmrhzd@ltop.local> <CANiq72miapoMHiXsq-gSu5+dhpGDE6Dnf3c_6DpHRkwNiPPU6g@mail.gmail.com>
In-Reply-To: <CANiq72miapoMHiXsq-gSu5+dhpGDE6Dnf3c_6DpHRkwNiPPU6g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 25 Nov 2018 22:56:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVWmt9Eiy8s2wBbCGrWaus=j2b4NZ-OnEoTeph9x3dJw@mail.gmail.com>
Message-ID: <CAK7LNATVWmt9Eiy8s2wBbCGrWaus=j2b4NZ-OnEoTeph9x3dJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kernel.h: disable type-checks in container_of()
 for Sparse
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, cmo@melexis.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 6:06 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Nov 23, 2018 at 10:14 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Thu, Nov 22, 2018 at 12:14:20PM +0900, Masahiro Yamada wrote:
> > > When I tried to enable BUILD_BUG_ON for Sparse, the kbuild test robot
> > > reported lots of "unknown expression" warnings from container_of(),
> > > which seemed false positive.
> > >
> > > I addressed this in [1], but fixing Sparse is the right thing to do.
> > >
> > > The issue was fixed by Sparse commit 0eb8175d3e9c ("fix expansion of
> > > function designator"), but it will take time until the fixed version
> > > of Sparse is widely available.
> > >
> > > Disable the container_of() type checks for Sparse for now.
> >
> > I would prefer that developers upgrade their version of sparse but ...
> >
> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>
> Indeed. If someone is writing code for the latest kernels, I think it
> is reasonable to assume they are able to use the latest sparse too,
> since it is not required for compilation anyway.


I am OK with either way.

I leave this to Andrew.



-- 
Best Regards
Masahiro Yamada

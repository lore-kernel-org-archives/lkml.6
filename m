Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D9A2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JAAqGwbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D9A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeKROez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:34:55 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47513 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeKROez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:34:55 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAI4FqbY004746;
        Sun, 18 Nov 2018 13:15:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAI4FqbY004746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542514553;
        bh=k5kLdnkAExx7TCzc2TBOgiAEVZLmpQxrMUA5tGysWjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JAAqGwbWZzWL05yIu4PaGzfCJPbvbfo7lVIs+v3DegKApXIUpaKObgixce4+cIUgl
         FH5VibN0Ii4CIXlPQb8SyuYCfIUSA8xLmtlvlOWHB8ueMnK4dwLPtnYEIV7S4SYfv+
         DBfJbZXfb66QVB949+GWgy4JhH20R0kmA50/JR3sEPRt1cxUizlnhOhvT63fFebOkw
         9OMamgQifiZCHD+CenXdpkjN9eDZBEf0Tv5EFiuDxoJtrSzNMNRSIMi1mlkm9Hq3Zw
         jwsTK3egtu+e2thzVTkpVcz89e/1CkxVtNXyIgbGzNF10BRhUu73fMMIlMeogaH8Oo
         2/U5Y8SvPBefg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id g68so15940340vsd.11;
        Sat, 17 Nov 2018 20:15:53 -0800 (PST)
X-Gm-Message-State: AGRZ1gKDXCGm9sdkC75IsQWCKIwp0I6m8564iPf9OtVDqVg3L97o2RHY
        ewiMsQK1qXbq2I0VJ8s2u4xvGXz1lMjj0H6ezPE=
X-Google-Smtp-Source: AJdET5dKWIlUA1nbgBAtl1kidPjoB3mfXZbJnMx4Ixpq/MvIRcHUSCl2nQzWIaNLrIg/NhRgZapnnrFF2rojjdQH6eQ=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr6939888vsm.181.1542514552277;
 Sat, 17 Nov 2018 20:15:52 -0800 (PST)
MIME-Version: 1.0
References: <1541404309-30210-1-git-send-email-yamada.masahiro@socionext.com> <17334806.ITFQqvuZkQ@avalon>
In-Reply-To: <17334806.ITFQqvuZkQ@avalon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 18 Nov 2018 13:15:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=Mj+P46=Y2uMr0AiP9nohoRWbKA5kdvL+domZQncBYA@mail.gmail.com>
Message-ID: <CAK7LNAQ=Mj+P46=Y2uMr0AiP9nohoRWbKA5kdvL+domZQncBYA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: fix binrpm-pkg breakage when O= is used
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        zhenzhong.duan@oracle.com, Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sun, Nov 18, 2018 at 4:22 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Yamada-san,
>
> On Monday, 5 November 2018 09:51:49 EET Masahiro Yamada wrote:
> > Zhenzhong Duan reported that running 'make O=/build/kernel binrpm-pkg'
> > failed with the following errors:
> >
> >   Running 'make O=/build/kernel binrpm-pkg' failed with below two errors.
> >
> >   Makefile:600: include/config/auto.conf: No such file or directory
> >
> >   + cp make -C /mnt/root/kernel O=/build/kernel image_name make -f
> >   /mnt/root/kernel/Makefile ...
> >   cp: invalid option -- 'C'
> >   Try 'cp --help' for more information.
> >
> > Prior to commit 80463f1b7bf9 ("kbuild: add --include-dir flag only
> > for out-of-tree build"), both objtree and srctree were added to
> > --include-dir, and the wrong code 'make image_name' was working
> > relying on that. Now, the potential issue that had previously been
> > hidden just showed up.
> >
> > 'make image_name' recurses to the generated $(objtree)/Makefile and
> > ends up with running in srctree, which is incorrect. It should be
> > invoked with '-f $srctree/Makefile' (or KBUILD_SRC=) to be executed
> > in objtree.
>
> I (painfully) found out that a similar problem occurs with 'make bindeb-pkg'.
>
> After spending half a day unsuccessfully trying to debug and fix the problem I
> ran across this patch. The naive approach of mimicking the solution and adding
> 'MAKE="$MAKE -f $srctree/Makefile"' at the top of scripts/package/builddeb
> didn't work. Reverting commit 80463f1b7bf9 fixed the problem.
>
> Would you be able to give it a look ? I'm afraid my limited skills related to
> the kernel build system don't allow me to submit a fix :-S

I fixed bindeb-pkg as well for v4.20-rc2

commit 02826a6ba301b72461c3706e1cc66d5571cd327e
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon Nov 5 16:52:34 2018 +0900

    kbuild: deb-pkg: fix bindeb-pkg breakage when O= is used


If you still see a problem, please let me know.



-- 
Best Regards
Masahiro Yamada

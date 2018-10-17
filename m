Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97EEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22937214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eKw5gUDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22937214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJQRUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:20:54 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43360 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJQRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:20:54 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w9H9PxL5026401;
        Wed, 17 Oct 2018 18:26:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9H9PxL5026401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539768360;
        bh=gLp6Vi2l/Dj7KCRgRiJ1Kfz0BwlZuIT3FjpbSHgPT6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eKw5gUDcaLZDwjblICK9G+woPUbKNBypMVZqu4Toc6okHV1C7tNxhcX4GcVX9zzh2
         3iYsTvAn1aEJTzLas/Xwdbv9IgELqExcGlLgJy44hHzGwq0kuuc24mdXB4sizP2//Z
         xpPQ/P5aqer7eTDirthP5ufwwHicrYCEerEAcnjOV2okIu1X51J6MEPJ1Rljqx65ri
         Cv83OKlWLsnvNAEUXFsEG2j4H5lS4ryfZC+jo8Rg9kX/YWW/diOLoD5MF12RMxecKf
         a8BkdM4yJ4SBTpx4527qPbymOdMNhLt1K22LK6pSXPpFmzmgkpyzorU6P0YFv4H2N1
         komNiePNkSEFg==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id c21so4495316uap.7;
        Wed, 17 Oct 2018 02:26:00 -0700 (PDT)
X-Gm-Message-State: ABuFfoiygFpwxkzS1tsKL9+KDYjng1J5OC6R3GmDataG/uvRVQp8fly0
        bJFgNVCC7mEtG/6stGC31IovpteCJkCoD/YmKrI=
X-Google-Smtp-Source: ACcGV60qmMkKh5z2kqauUQfH3HWOfPqQQaq68mdSpK/bEzXKqd7OA0P9JR5QWih0hycvjLBIu/OBSmiT/m8F0bqMqPM=
X-Received: by 2002:ab0:4e8b:: with SMTP id l11mr11273242uah.93.1539768359327;
 Wed, 17 Oct 2018 02:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-4-git-send-email-yamada.masahiro@socionext.com>
 <20181016195420.GE27990@zn.tnic> <CAK7LNAS7wzJ+L-2kC2fyi9Ta9qq1jiM0-UOAisGL2CZuSEoE7w@mail.gmail.com>
 <20181017091059.GB22571@zn.tnic>
In-Reply-To: <20181017091059.GB22571@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Oct 2018 18:25:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARV5SPkuDkA0i85PoRzGmA3DoKX0WbSD9oEcpL6D8dQjg@mail.gmail.com>
Message-ID: <CAK7LNARV5SPkuDkA0i85PoRzGmA3DoKX0WbSD9oEcpL6D8dQjg@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: check the presence of lzo and lz4 tools when necessary
To:     Borislav Petkov <bp@suse.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 6:12 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Wed, Oct 17, 2018 at 05:59:02PM +0900, Masahiro Yamada wrote:
> > >   DESCEND  objtool
> > >   CALL    scripts/checksyscalls.sh
> > >   CHK     include/generated/compile.h
> > >   Building modules, stage 2.
> > >   CC      arch/x86/boot/compressed/misc.o
> > >   LZ4     arch/x86/boot/compressed/vmlinux.bin.lz4
> > > /bin/sh: 1: lz4c: not found
> > > make[2]: *** [arch/x86/boot/compressed/Makefile:143: arch/x86/boot/compressed/vmlinux.bin.lz4] Error 1
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> > > make: *** [arch/x86/Makefile:290: bzImage] Error 2
> > > make: *** Waiting for unfinished jobs....
> > >   MODPOST 956 modules
> > >
> > > What am I missing?
> >
> >
> > I have no idea.
> >
> > With liblz4-tool package installed on my machine,
> > I can build x86 kernel with CONFIG_KERNEL_LZ4.
>
> What happens if you remove the lz4c executable? Do you see the ugly
> error above or the "lz4 tool not found. Please install it." message with
> my config?
>

I tried that.
I can see the expected error message.



masahiro@pug:~/ref/linux$ git log  --oneline  | head -n 4
6cd6271 kbuild: check the presence of lzo and lz4 tools when necessary
b72cfb7 objtool: move libelf check out of top Makefile
e3061d8 kbuild: provide a new place to check necessary host tools
b955a91 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc
masahiro@pug:~/ref/linux$ git clean -dqfx
masahiro@pug:~/ref/linux$ cp ~/Downloads/config.lz4  .config
masahiro@pug:~/ref/linux$ sudo mv /usr/bin/lz4c /usr/bin/lz4c.backup
[sudo] password for masahiro:
masahiro@pug:~/ref/linux$ make
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig
*
* Restart config...
*
*
* GCC plugins
*
GCC plugins (GCC_PLUGINS) [N/y/?] (NEW)
*
* lz4 tool not found. Please install it.
*
make[1]: *** [scripts/Makefile.toolcheck;46: check_lz4] Error 1
Makefile:595: include/config/auto.conf: No such file or directory
make: *** [Makefile;636: include/config/auto.conf] Error 2
make: *** Deleting file 'include/config/auto.conf'





-- 
Best Regards
Masahiro Yamada

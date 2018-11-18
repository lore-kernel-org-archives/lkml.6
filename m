Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 05:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEF82080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 05:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="y3872g0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEF82080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeKRPUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 10:20:31 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:49952 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeKRPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 10:20:31 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAI51836017049;
        Sun, 18 Nov 2018 14:01:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAI51836017049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542517269;
        bh=dQpLK/4cyORAuLT6tU0euQEKA/LcBrscM9+Y7QXyxGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y3872g0gcPrJ08CHG2SCOBqaILUGEIcnJufphJKS6nwKkxlywG04tqnmZ6HmC7L0r
         60EKF16GagynkzMaKqtLf4iXt1mUB0YdVxfOsntEXnADqSEMPwTKG9CODSrnlcDg39
         LyjVyEfzYCnS5FcCzr5apLjRaYsVf+Ckb4WADkyK2Ar+a2QwfQIH1BypGIFLxh+PHg
         9A+I8Bbvbts/y2JxhiExX9IQ7fwyvPrmWdyloCDbDJpRqlIrJ3TrGZgKYt71Jo5YLF
         /UOCLB8zyNfYi6wSYLMeQNsmVVjztVWQE0Uy9fMJP18uRlS9TofuA8q6IjzuUq9v0M
         vd7XthQhVclDw==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id e16so8428395uam.12;
        Sat, 17 Nov 2018 21:01:08 -0800 (PST)
X-Gm-Message-State: AGRZ1gJmrv5OBgfrwAiIJxrev1cC2+gYgjrJiGTNpjpYlkgXNjJbemCG
        z2DHELAFEMmQZgw8n2w5a4eB/qXmR2KSrZ9gvsk=
X-Google-Smtp-Source: AJdET5dTWHXgttfLhmnqC1xjaELgaCwu4bmirddbriTb2uujr6i88cY9ec2rU8NnCWch+G/twNjCbYGpFKpfV6pvwWY=
X-Received: by 2002:ab0:849:: with SMTP id b9mr7846850uaf.93.1542517267868;
 Sat, 17 Nov 2018 21:01:07 -0800 (PST)
MIME-Version: 1.0
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-4-git-send-email-yamada.masahiro@socionext.com> <20181116200109.GC15240@ravnborg.org>
In-Reply-To: <20181116200109.GC15240@ravnborg.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 18 Nov 2018 14:00:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATefLJcb52N0=p2qAk-N_0hEQDOQinw5+kUiKo7oWFRnQ@mail.gmail.com>
Message-ID: <CAK7LNATefLJcb52N0=p2qAk-N_0hEQDOQinw5+kUiKo7oWFRnQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] kbuild: refactor modversions build rules
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,


On Sat, Nov 17, 2018 at 5:01 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Masahiro
>
> On Thu, Nov 15, 2018 at 05:27:10PM +0900, Masahiro Yamada wrote:
> > Let $(CC) compile objects into normal files *.o instead of .tmp_*.o
> > whether CONFIG_MODVERSIONS is enabled or not. This will help simplify
> > build rules a lot.
>
> Another approach would be to move more of the build stuff to
> one or a few build scripts.

Shifting code from Makefile to a shell script
will be another clean-up.


This patch is addressing a different problem.

See this code in Malefile.build

ifdef CONFIG_MODVERSIONS
objtool_o = $(@D)/.tmp_$(@F)
else
objtool_o = $(@)
endif



cmd_cc_o_c writes an object into a different file name
depending CONFIG_MODVERSIONS, which makes difficult
for other actions to manipulate the object in a
consistent manner.

I will clarify this in the commit log in v2.

Thanks.





> Using build scripts makes is much easier to add comments and
> still keep it readable.
> And when the build logic list a set of serialized actions
> they thay can be included in a build script nicely.
>
> But that said - I also like the simplifications you made.
> Everytime you trim the core kbuild files it is a win for
> readability.
>
>         Sam



-- 
Best Regards
Masahiro Yamada

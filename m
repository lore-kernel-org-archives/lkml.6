Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51492C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1549218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jvxPO2NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfAEBWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:22:04 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:58320 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEBWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 20:22:04 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x051LbMU026291
        for <linux-kernel@vger.kernel.org>; Sat, 5 Jan 2019 10:21:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x051LbMU026291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546651298;
        bh=ArocRil9sqwZLpuAkJJkAYFMYTHn5zG04p13k1d8IBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jvxPO2NIi1rrDQsJzNO9IqrxjGEgPL8l/rZon/ZGaCtoo1LGnlidZytDyeQVnUyDB
         fXD8R/KHeAakiQzQ3GcoTmYbfUmSbQcTA0/0pALzuMElpMNqKoLZLnl7vipYZAoO5N
         YqQELMkY2gAdy7NhRnhhiXGC09O5e4hOZnoOFs5QiBtiPypCW3xygzCfyV9ivBdRsc
         c2Mh3+T/VmNjGB+XvoTPsXqG8y4X4nHsP3C6EfKQZJ/gwzGDaJ0jjntBInfDbp298v
         yErtSpTDUkFSrVtBjhRAWHo+yBakETtzfdAX2Pp5Ke5HNQPGYihoFbyLJkULNIzo2m
         GpSxiJBhIvCGw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id x28so23698371vsh.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 17:21:37 -0800 (PST)
X-Gm-Message-State: AA+aEWYWXvRsQZefqcPKMPADpI9sien3OdDsk7F/lPZGah5dez9i/1WU
        XhIexqjw0byFqAhfCMkkzVJFfZIrL8zkOL2JL48=
X-Google-Smtp-Source: AFSGD/XrWHyQEIIya3zIvULwelBbXIaSa3SIj8KYj9Scx7L3SOa47pZ6gwe8oYr1dVbvDS6iOBe+v35zZJWkM28rvbE=
X-Received: by 2002:a67:a858:: with SMTP id r85mr21268706vse.215.1546651296526;
 Fri, 04 Jan 2019 17:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20190102143507.GI6310@bombadil.infradead.org>
In-Reply-To: <20190102143507.GI6310@bombadil.infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Jan 2019 10:21:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQA3Pvxyod2GD9tOkG9cSx32tmMN=dupgcjuHUw98LF7g@mail.gmail.com>
Message-ID: <CAK7LNAQA3Pvxyod2GD9tOkG9cSx32tmMN=dupgcjuHUw98LF7g@mail.gmail.com>
Subject: Re: [PATCH] Display CHECK files like CC files
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, Jan 3, 2019 at 12:41 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> When building with O= and C=1, this output looks weird:
>
>   CC      fs/file_table.o
>   CHECK   ../fs/file_table.c
>   CC      fs/open.o
>   CHECK   ../fs/open.c
>   CC      fs/super.o
>   CHECK   ../fs/super.c
>   CC      fs/read_write.o
>   CHECK   ../fs/read_write.c
>
> Use $@ like CC instead of $< to produce the same output for both CHECK and CC.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index fd03d60f6c5a..f36b03396d9a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -74,10 +74,10 @@ __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
>
>  # Linus' kernel sanity checking tool
>  ifeq ($(KBUILD_CHECKSRC),1)
> -  quiet_cmd_checksrc       = CHECK   $<
> +  quiet_cmd_checksrc       = CHECK   $@
>          cmd_checksrc       = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
>  else ifeq ($(KBUILD_CHECKSRC),2)
> -  quiet_cmd_force_checksrc = CHECK   $<
> +  quiet_cmd_force_checksrc = CHECK   $@
>          cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
>  endif


IMHO, $@ is also a bit weird
since Sparse does not produce objects at all.


What I can suggest is like follows:

quiet_cmd_checksrc       = CHECK   $(patsubst $(srctree)/%,%,$<)



-- 
Best Regards
Masahiro Yamada

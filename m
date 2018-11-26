Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5AAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C9420663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ytRPpQLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C9420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeK0Bq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:46:56 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33513 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0Bq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:46:56 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAQEqUHB020636;
        Mon, 26 Nov 2018 23:52:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAQEqUHB020636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543243951;
        bh=rYskIvsOGtOANynK50kzJ7dJByd3KsCHzMxP9W0XPhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ytRPpQLwZF5I5dgMuYZTnUbJcTIFtYYiWXcWI3hIBw9xUHTyf5a9gkf8+VrCgr+10
         Nd1/NYSlEdjYxolA0mS7yZiEpwcyI/HBl+j6pviLgrVUlyfw2bUUZXzB7iDJBdJwaH
         JcRmDjbE4wAzK8p/QDKB3BdliluC6BnY1yCU+heMYpzj4XmGZEtNPkCR/noDQ3+YJO
         +z548gzTr+lNjxB8ie66v7u51bdd0Bc48IxGh0pGzttl2QgXHEnZjAjYxszpu23aLu
         xf7/NEMo0elRBgodYZ0awKyuQKXmtnSs7RkR84hQ8VCVJdV/DESuB2jOxTnS9i+AZp
         s5WeATqJKW2wA==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id w72so4205692vkd.5;
        Mon, 26 Nov 2018 06:52:31 -0800 (PST)
X-Gm-Message-State: AA+aEWaeQOYnON/3Dj5GI4Yt1UWI6f+DBtMOyw7UOGvASs2IcpEyruGG
        vSOWeG157HEmpblBI7vxvJa5hR2a46PAZv6pi9w=
X-Google-Smtp-Source: AFSGD/XzNAckCbmXM3//czRnv/+XsdLKDmt9a4HuQ3yIx/398CRPehDDIZeeh1AiEJgOIKGpa9vIxqRyj7liwJehs/0=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr10801588vkb.34.1543243950079;
 Mon, 26 Nov 2018 06:52:30 -0800 (PST)
MIME-Version: 1.0
References: <1542841915-19686-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542841915-19686-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 26 Nov 2018 23:51:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1kzp+aPezpff3AC=tqEs9hTgrUk6578JzD=up4KXynQ@mail.gmail.com>
Message-ID: <CAK7LNAR1kzp+aPezpff3AC=tqEs9hTgrUk6578JzD=up4KXynQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: fix single target build for external module
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 6:33 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Building a single target in an external module fails due to missing
> .tmp_versions directory.
>
> For example,
>
>   $ make -C /lib/modules/$(uname -r)/build M=$PWD foo.o
>
> will fail in the following way:
>
>   CC [M]  /home/masahiro/foo/foo.o
> /bin/sh: 1: cannot create /home/masahiro/foo/.tmp_versions/foo.mod: Directory nonexistent
>
> This is because $(cmd_crmodverdir) is executed only for /, %/, %.ko
> single targets for external modules. Create .tmp_versions in the
> 'prepare' target.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.



>  Makefile | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d5da1df..36f3f0e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1554,9 +1554,6 @@ else # KBUILD_EXTMOD
>
>  # We are always building modules
>  KBUILD_MODULES := 1
> -PHONY += crmodverdir
> -crmodverdir:
> -       $(cmd_crmodverdir)
>
>  PHONY += $(objtree)/Module.symvers
>  $(objtree)/Module.symvers:
> @@ -1568,7 +1565,7 @@ $(objtree)/Module.symvers:
>
>  module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
>  PHONY += $(module-dirs) modules
> -$(module-dirs): crmodverdir $(objtree)/Module.symvers
> +$(module-dirs): prepare $(objtree)/Module.symvers
>         $(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
>
>  modules: $(module-dirs)
> @@ -1609,7 +1606,8 @@ help:
>
>  # Dummies...
>  PHONY += prepare scripts
> -prepare: ;
> +prepare:
> +       $(cmd_crmodverdir)
>  scripts: ;
>  endif # KBUILD_EXTMOD
>
> @@ -1733,17 +1731,14 @@ endif
>
>  # Modules
>  /: prepare scripts FORCE
> -       $(cmd_crmodverdir)
>         $(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
>         $(build)=$(build-dir)
>  # Make sure the latest headers are built for Documentation
>  Documentation/ samples/: headers_install
>  %/: prepare scripts FORCE
> -       $(cmd_crmodverdir)
>         $(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
>         $(build)=$(build-dir)
>  %.ko: prepare scripts FORCE
> -       $(cmd_crmodverdir)
>         $(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
>         $(build)=$(build-dir) $(@:.ko=.o)
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

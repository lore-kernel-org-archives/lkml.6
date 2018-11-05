Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927492081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="X3sPTIdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927492081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeKEROX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:14:23 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:65044 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeKEROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:14:23 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wA57tlBl025626;
        Mon, 5 Nov 2018 16:55:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wA57tlBl025626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541404547;
        bh=31yB+vN8PrOktbIWxnLsgYSRr8TFZE6bmNDOYgeLUeY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X3sPTIdLo4OhmbzzMEVynVrxnRBDMhcrCHb/wABPyyanb/paKN+nzY1uxIHKInBqH
         eDqM/1eK77AI65hlz1ZRo03/+PrmZdJT3925gwkWxrZ8dCrc3ryMhAGfuTupmN1xMe
         Zo1N33iV60k+VkPsinCvKHQSktpFFjMgxuS1gxW1rqUGboojXRN+A+OkMZO3GnyVKU
         EaJV4NmO6s2B5W0SzhsaDblrWdhVtzBESTQ7CTxhes7ZRYQn4VA2x4gUhu1HrZsAZl
         882pB+889uNpC5ube3l0MsPsYQhCDc3Ckv2qVwjmxBJ4AOkCzsGLPo8pCXqJxe4yuU
         2EUTsF4RPaxTA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id n7so2829102uao.7;
        Sun, 04 Nov 2018 23:55:47 -0800 (PST)
X-Gm-Message-State: AGRZ1gJgH0t7C5rIri/ArUgsJ6HQPZXdFQfH5wMLh+0SQsbNfuqcmrpK
        KXN3DHtkwZGJH1KEajmtknox1cbCqqWS0h5vhtQ=
X-Google-Smtp-Source: AJdET5eLodARO3cpNDDurwwZSmvMqIvb5fDSE0uzQ4dqCPIQ2kIzN/G9IsJbEr+CTLExFIp4uU9IiAqw57ZR+KDatwA=
X-Received: by 2002:ab0:5444:: with SMTP id o4mr9626720uaa.55.1541404546589;
 Sun, 04 Nov 2018 23:55:46 -0800 (PST)
MIME-Version: 1.0
References: <3e40ec15-3a8c-444d-8d32-35ef587f3980@default>
In-Reply-To: <3e40ec15-3a8c-444d-8d32-35ef587f3980@default>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 5 Nov 2018 16:55:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUie1D3=0o36idvxR7uLtGRaV-MCs5L_cPcuXj28inEw@mail.gmail.com>
Message-ID: <CAK7LNAQUie1D3=0o36idvxR7uLtGRaV-MCs5L_cPcuXj28inEw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: fix two build breaks when O= is used
To:     zhenzhong.duan@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        srinivas.eeda@oracle.com, Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenzhong,

On Fri, Nov 2, 2018 at 8:26 PM Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
>
> Running 'make O=/build/kernel binrpm-pkg' failed with below two errors.
>
> Makefile:600: include/config/auto.conf: No such file or directory
>
> + cp make -C /mnt/root/kernel O=/build/kernel image_name make -f
> /mnt/root/kernel/Makefile ...
> cp: invalid option -- 'C'
> Try 'cp --help' for more information.
>
> Export KBUILD_OUTPUT when O= is used so that it could be used in locating
> include/config/auto.conf
>
> Use $srctree to locate source dir when generating image name, no matter
> if O= is used.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>


Sorry for the breakage, and thanks for your report.

I'd like to fix the issue in a cleaner way.

See this:
https://patchwork.kernel.org/patch/10667539/


Thanks.


> ---
>  Makefile               | 5 +++++
>  scripts/package/mkspec | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9aa352b..df316e5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -135,6 +135,7 @@ KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
>  $(if $(KBUILD_OUTPUT),, \
>       $(error failed to create output directory "$(saved-output)"))
>
> +export KBUILD_OUTPUT
>  # Look for make include files relative to root of kernel src
>  #
>  # This does not become effective immediately because MAKEFLAGS is re-parsed
> @@ -597,7 +598,11 @@ virt-y             := virt/
>  endif # KBUILD_EXTMOD
>
>  ifeq ($(dot-config),1)
> +ifeq ($(KBUILD_OUTPUT),)
>  include include/config/auto.conf
> +else
> +include $(KBUILD_OUTPUT)/include/config/auto.conf
> +endif
>  endif
>
>  # The all: target is the default when no target is given on the
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index e05646d..3b4e5e4 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -84,10 +84,10 @@ $S
>         mkdir -p %{buildroot}/boot
>         %ifarch ia64
>         mkdir -p %{buildroot}/boot/efi
> -       cp \$(make image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
> +       cp \$(make -C \$srctree image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
>         ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
>         %else
> -       cp \$(make image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
> +       cp \$(make -C \$srctree image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
>         %endif
>  $M     make %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} KBUILD_SRC= modules_install
>         make %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr KBUILD_SRC= headers_install
> --
> 1.8.3.1



-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3F6EDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD62B208AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oqAyWu60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD62B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754381AbeFMCEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:04:11 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:52776 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbeFMCEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:04:09 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5D23nih004342;
        Wed, 13 Jun 2018 11:03:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5D23nih004342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528855430;
        bh=h75hTC0L064IJ0rxB6g18x+4cTB8uFbcIdADIo7QYHo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oqAyWu60yiOsbwDLQWu2b56AfNRNklnXmPMhWYQiKmJtfce2eFDf9czsNDNuYv176
         67zCDTSDMJUDRL2cwD749YCXlWsG001F5ubqbErfIYRZSbW85F0iJ3BuGjVOJBjFQu
         9frn4TNiHkvlqaoek2CFYRrMVDlLA5Nq5HlH4/nN0F3/TsosiTGm6XKhDi8xdIcKnn
         kMuYHeGiKkejZBhge9Tk9PSjDPiK0d4d/YRsl5Ida6bQekCzHFbUCg0wU0LpSirj6u
         mtHNy2QYp0dF7Y2aMzWodf9ECQRMm3t4Vatq8wN7zOaEG+y+XdA5l7auh838vZk1xO
         lQC1DOLYCzf6Q==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id o17-v6so596707vka.2;
        Tue, 12 Jun 2018 19:03:49 -0700 (PDT)
X-Gm-Message-State: APt69E2BMBJy2U6UA1GjETx5rOWfJG4Bg0GT73T7Wm7ZYnJB7pegT/gS
        ytbDzsJdlNebvW1ot+bFI7v5a99nY80GTkL3FtY=
X-Google-Smtp-Source: ADUXVKJRjwpBgpuQpIH2p21/+iNBfGqaXPffI3uChZ+tT6/UTt6esiVgvtBndg7d28lDfhGaC6vZm6Mlfho+DaK1zxY=
X-Received: by 2002:a1f:ba4a:: with SMTP id k71-v6mr1866446vkf.11.1528855428670;
 Tue, 12 Jun 2018 19:03:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 19:03:08
 -0700 (PDT)
In-Reply-To: <20180612003224.3658-2-labbott@redhat.com>
References: <20180612003224.3658-1-labbott@redhat.com> <20180612003224.3658-2-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Jun 2018 11:03:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJw4JjHD3RSmyBExvw+v+GE916RQiSZTQA+U-d4FXt1w@mail.gmail.com>
Message-ID: <CAK7LNASJw4JjHD3RSmyBExvw+v+GE916RQiSZTQA+U-d4FXt1w@mail.gmail.com>
Subject: Re: [PATCHv4 1/3] scripts: Preprocess module-common.lds
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-12 9:32 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> In preparation for some upcoming work, allow module-common.lds
> to be run through the preprocessor.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  scripts/.gitignore                                 | 1 +
>  scripts/Makefile                                   | 2 +-
>  scripts/{module-common.lds => module-common.lds.S} | 0
>  3 files changed, 2 insertions(+), 1 deletion(-)
>  rename scripts/{module-common.lds => module-common.lds.S} (100%)
>
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 0442c06eefcb..afd1de57d9c6 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -13,3 +13,4 @@ asn1_compiler
>  extract-cert
>  sign-file
>  insert-sys-cert
> +module-common.lds
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 25ab143cbe14..631d9d1a71e4 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -25,7 +25,7 @@ HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
>  HOSTLOADLIBES_sign-file = -lcrypto
>  HOSTLOADLIBES_extract-cert = -lcrypto
>
> -always         := $(hostprogs-y) $(hostprogs-m)
> +always         := $(hostprogs-y) $(hostprogs-m) module-common.lds


You do not need to generate module-common.lds all the time.
It is necessary only when the module feature is enabled.

You can do like this:

extra-$(CONFIG_MODULES)  +=  module-common.lds






-- 
Best Regards
Masahiro Yamada

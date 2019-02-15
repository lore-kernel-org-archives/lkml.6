Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92510C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CC521A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbfBOLAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:00:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45157 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfBOLAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:00:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so15765466ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJ1w0R223NOFMFs8jprELV7OmTbW2Ho0cuabQNPRrxs=;
        b=NOPJRbLNLTpZqE3iDWg/fKVoWOSS7zoj45lzMRWDvgcffcd90Qa7a0fFDpKztYBVWG
         Su4S9AXlTNdwY1h0+HzAnUZvnnBLhEy6lqg8bJP4k4RlGa7yXCXZ72r3QAmIxU3nMRqD
         S9icKbZRLfhHgzg1cyDUSb/zpnYS+bIJ4JlQqLsMcw//WtKpT7e/W5SEVodxnlxSOufp
         WtEYred5LGm5mLo1KboTIYHKR9Wo1NpLbLE4/990aFGyYTBr9ivp2opD7sInyS7gQFTA
         PFBk2ZWFX0FflvyPX027Hgh38ODCtiagsXe2DgEdTRW0OP48YFZA1LKxCFc7BAdDJ9Gc
         vUng==
X-Gm-Message-State: AHQUAuZHKeqpZd8478CjcPMic9lIysHNWhTWF5kifpIBNDcY/5Q+gN4X
        mZ+I8xIoXKghAwyOICYppppm2CwCc2xKNTZlt5p1gTeQ
X-Google-Smtp-Source: AHgI3IYbfrX7AIolW1V7LYuCoKrAWyKC2jau6gRe6jftYyoteJKqHvv9ysv43HkUNysa0i4dhW/Ns56Ri67xY1q9ZKk=
X-Received: by 2002:a9d:6acc:: with SMTP id m12mr5051127otq.300.1550228415864;
 Fri, 15 Feb 2019 03:00:15 -0800 (PST)
MIME-Version: 1.0
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 15 Feb 2019 12:00:04 +0100
Message-ID: <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I often test all Kconfig commands for all architectures. To ease my
> workflow, I want 'make defconfig' at least working without any cross
> compiler.
>
> Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
> default defconfig source.
>
> If CROSS_COMPILE is unset, it is likely to be the native build, so
> 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
> the user is cross-building (i.e. 'uname -m' is probably x86_64), so
> it falls back to ppc64_defconfig. Yup, make sense.
>
> However, I want to run 'make ARCH=* defconfig' without setting
> CROSS_COMPILE for each architecture.
>
> My suggestion is to check $(origin ARCH).
>
> When you cross-compile the kernel, you need to set ARCH from your
> environment or from the command line.
>
> For the native build, you do not need to set ARCH. The default in
> the top Makefile is used:
>
>   ARCH            ?= $(SUBARCH)
>
> Hence, $(origin ARCH) returns 'file'.
>
> Before this commit, 'make ARCH=powerpc defconfig' failed:

In case you have not seen it, please check:

http://patchwork.ozlabs.org/patch/1037835/

>   $ make ARCH=powerpc defconfig
>   *** Default configuration is based on target 'x86_64_defconfig'
>   ***
>   *** Can't find default configuration "arch/powerpc/configs/x86_64_defconfig"!
>   ***
>
> After this commit, it will succeed:
>
>   $ make ARCH=powerpc defconfig
>   *** Default configuration is based on 'ppc64_defconfig'
>   #
>   # configuration written to .config
>   #
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/powerpc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index ac03334..f989979 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -34,7 +34,7 @@ ifdef CONFIG_PPC_BOOK3S_32
>  KBUILD_CFLAGS          += -mcpu=powerpc
>  endif
>
> -ifeq ($(CROSS_COMPILE),)
> +ifeq ($(origin ARCH), file)
>  KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
>  else
>  KBUILD_DEFCONFIG := ppc64_defconfig
> --
> 2.7.4
>

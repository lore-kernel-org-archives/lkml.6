Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93800C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E23208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5dNfEeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E23208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeK1JBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:01:51 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36780 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeK1JBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:01:51 -0500
Received: by mail-yb1-f196.google.com with SMTP id g192-v6so9761608ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ptiWWLIY+FJNOsGLI2UDVNgPTlGp8zMEbL4VzcabXc=;
        b=I5dNfEeHTgyoSj2T3sMNOPGxseQUZAbdsc7okU6lq76tnu1i0fUbBepriA/YlbCJOP
         Kc1fdMk5BuLZSmjdfLlkfez9ZguYIcBZBB1At7nCZF4nMq0ilGul2RoMjgkC3rCOmlyk
         dCk4O949wfvu8IAOFPEbqK0RYfBm2QD7yPWv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ptiWWLIY+FJNOsGLI2UDVNgPTlGp8zMEbL4VzcabXc=;
        b=iLDrKen11iSO8DZGUqUDX09TKZGtck34KI9/TSUpQPTD+107zs9F0wVGm94KlUnd4i
         vwbhCACBXX/jVB2uN1enJcqbvpOy0xCDjj0AlvtrrUwPs53IfQOkcdQee32jbVWGasNM
         UEyHiYLFt1RgtciOrxhh0sx4qRASPrVcg/khVmxul5AwTxzKp5j8WSsYQcjleoRbofxd
         5qSDzTy1Q5Guy72CD01wugn+UQ652VaNsw69zBEVjK5DsrteyI7FitrkvbLs/KjVgQ+a
         9YimZApO190ZFDRbTbSFtXuDEpGrn0ypzEI01HCdgwjM0oO61yAXCJ8UOv6F/1/jPqFE
         nYRQ==
X-Gm-Message-State: AA+aEWZUWacTlVoEZacBoT9qgbpF9F08qHMPZ+P1irufBXUMoABrPik8
        baj2v7NcRTZtEF4+wswP4a07dwjbVj0=
X-Google-Smtp-Source: AFSGD/WCFdje3GcgbjWpw2PqnMMeZyaYsu7df6oht4sZgnDcvWC6blAbEW4lyH07N/C8PuZ2X2tPTA==
X-Received: by 2002:a25:843:: with SMTP id 64-v6mr35323007ybi.120.1543356151051;
        Tue, 27 Nov 2018 14:02:31 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 206-v6sm2801473ywp.0.2018.11.27.14.02.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:02:29 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id t13-v6so9756495ybb.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:02:29 -0800 (PST)
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr35752787ybc.421.1543356149049;
 Tue, 27 Nov 2018 14:02:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 14:02:28
 -0800 (PST)
In-Reply-To: <1542948687-7326-2-git-send-email-yamada.masahiro@socionext.com>
References: <1542948687-7326-1-git-send-email-yamada.masahiro@socionext.com> <1542948687-7326-2-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 14:02:28 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLkcd3p+Hra_1_zD4M66N1eFBPkU_ee=eXpp6NPOfoV9A@mail.gmail.com>
Message-ID: <CAGXu5jLkcd3p+Hra_1_zD4M66N1eFBPkU_ee=eXpp6NPOfoV9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: descend into scripts/gcc-plugins/ via scripts/Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 8:51 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Now that 'prepare0' depends on 'scripts', building GCC plugins can
> go into scripts/Makefile, which is a more standard way.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  Makefile                     | 2 +-
>  scripts/Makefile             | 3 ++-
>  scripts/Makefile.gcc-plugins | 8 --------
>  3 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index cee4cec..a8bbe68 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1114,7 +1114,7 @@ macroprepare: prepare1 archmacros
>
>  archprepare: archheaders archscripts macroprepare scripts_basic
>
> -prepare0: scripts archprepare gcc-plugins
> +prepare0: scripts archprepare
>         $(Q)$(MAKE) $(build)=scripts/mod
>         $(Q)$(MAKE) $(build)=.
>
> diff --git a/scripts/Makefile b/scripts/Makefile
> index b48259d..feb1f71 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -36,9 +36,10 @@ PHONY += build_unifdef
>  build_unifdef: $(obj)/unifdef
>         @:
>
> +subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
>  subdir-$(CONFIG_GDB_SCRIPTS) += gdb
>
>  # Let clean descend into subdirs
> -subdir-        += basic dtc kconfig mod package gcc-plugins
> +subdir-        += basic dtc kconfig mod package
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 46c5c68..c36f199 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -49,11 +49,3 @@ KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
>  # All enabled GCC plugins are collected here for building below.
>  GCC_PLUGIN := $(gcc-plugin-y)
>  export GCC_PLUGIN
> -
> -# Actually do the build, if requested.
> -PHONY += gcc-plugins
> -gcc-plugins: scripts_basic
> -ifdef CONFIG_GCC_PLUGINS
> -       $(Q)$(MAKE) $(build)=scripts/gcc-plugins
> -endif
> -       @:
> --
> 2.7.4
>



-- 
Kees Cook

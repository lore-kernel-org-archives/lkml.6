Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E6520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5YpFGpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388492AbfAKRUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:20:47 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41583 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733086AbfAKRUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:20:45 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so9648416vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDcUfiyYI4hRgIWvcxAXAkHX1UYAaFqoUgRFoXgcNdY=;
        b=J5YpFGpOz2A1Bhr7vIAzuzp8ZGLRE6sm4XxW6p4jPRBdilGVKwL39ugMZo7gJiJxy3
         6U/WQSA2AYTXgXFb0guvEV4iXhrg5Ybx93wGp8+/K5XMvTRta3cPHZLPzS7TsAW6+xZm
         0Qs3v995yB+0kYw0qY8yHMyZ+lOsN8Ji20GbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDcUfiyYI4hRgIWvcxAXAkHX1UYAaFqoUgRFoXgcNdY=;
        b=eGTmgZe/cC3+PzpR+kRKb/Fk37ELzDg3nFjx5Dl4Z8/KP0OISOauZyvLbd/4AmaUOa
         jTO4yb9d51wx5fuSX9vsgHINpxbfLXU7EQq7a3ikB3sOTcMlFFbulpsuhxlVvWPj/rwz
         Kl9a5S09G0ZyaYCK5ArP+njPkHYlHRN7QrhdtZFS5291CLIhjog2OCMD+LDBpCUh3sLY
         n6OP6OWTz2EMu1+M9iMHEWgFUbVfvZSrtIPyHWw3LgRFiyTXm9X8On2kv6bIvoGWCkFv
         sjewFlCoU9U3Smi69RqbBiUcHvb3tOXS9AnblQE04Os4nr5hvE/y2LbNL3JHNWRsdp/j
         o1pQ==
X-Gm-Message-State: AJcUukdhKp6o9+Pmte8LcJzXTooCWVkjmAea/qAI2eJZtMlafuopkKVj
        18ZvVWxjz5S5KltMS5vbM9Vk+nYLzfU=
X-Google-Smtp-Source: ALg8bN6he6BUH4T4Ts5JcvyfgdAv2fJBuGvC1sKjEjYWmDUiWUzMVeOKRuF/rgmuJYXUqs5MDLAIMA==
X-Received: by 2002:a67:2901:: with SMTP id p1mr6472415vsp.79.1547227243931;
        Fri, 11 Jan 2019 09:20:43 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id l197sm33844990vke.18.2019.01.11.09.20.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:20:43 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id v205so9662836vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:20:42 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr6422471vsl.188.1547227242437;
 Fri, 11 Jan 2019 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <1547198328-26359-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547198328-26359-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 11 Jan 2019 09:20:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJzkqvyhZbCiQFHDZ3v36j2bM3_y_RMCof97rA35Z6opw@mail.gmail.com>
Message-ID: <CAGXu5jJzkqvyhZbCiQFHDZ3v36j2bM3_y_RMCof97rA35Z6opw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: clean up hostprogs rules with hostld_flags
 and hostld_libs
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Emese Revfy <re.emese@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 1:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Add hostld_flags and hostld_libs shorthands. No function change.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  scripts/Makefile.host | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 0393f75..f2e15de 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -78,23 +78,26 @@ endif
>  hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
>  hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
>
> +hostld_flags   = $(KBUILD_HOSTLDFLAGS)
> +hostld_libs    = $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
> +
>  #####
>  # Compile programs on the host
>
>  # Create executable from a single .c file
>  # host-csingle -> Executable
>  quiet_cmd_host-csingle         = HOSTCC  $@
> -      cmd_host-csingle = $(HOSTCC) $(hostc_flags) $(KBUILD_HOSTLDFLAGS) -o $@ $< \
> -               $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
> +      cmd_host-csingle = $(HOSTCC) $(hostc_flags) $(hostld_flags) -o $@ $< \
> +               $(hostld_libs)
>  $(host-csingle): $(obj)/%: $(src)/%.c FORCE
>         $(call if_changed_dep,host-csingle)
>
>  # Link an executable based on list of .o files, all plain c
>  # host-cmulti -> executable
>  quiet_cmd_host-cmulti  = HOSTLD  $@
> -      cmd_host-cmulti  = $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ \
> +      cmd_host-cmulti  = $(HOSTCC) $(hostld_flags) -o $@ \
>                           $(addprefix $(obj)/,$($(@F)-objs)) \
> -                         $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
> +                         $(hostld_libs)
>  $(host-cmulti): FORCE
>         $(call if_changed,host-cmulti)
>  $(call multi_depend, $(host-cmulti), , -objs)
> @@ -109,10 +112,10 @@ $(host-cobjs): $(obj)/%.o: $(src)/%.c FORCE
>  # Link an executable based on list of .o files, a mixture of .c and .cc
>  # host-cxxmulti -> executable
>  quiet_cmd_host-cxxmulti        = HOSTLD  $@
> -      cmd_host-cxxmulti        = $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -o $@ \
> +      cmd_host-cxxmulti        = $(HOSTCXX) $(hostld_flags) -o $@ \
>                           $(foreach o,objs cxxobjs,\
>                           $(addprefix $(obj)/,$($(@F)-$(o)))) \
> -                         $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
> +                         $(hostld_libs)
>  $(host-cxxmulti): FORCE
>         $(call if_changed,host-cxxmulti)
>  $(call multi_depend, $(host-cxxmulti), , -objs -cxxobjs)
> @@ -143,9 +146,9 @@ $(host-cxxshobjs): $(obj)/%.o: $(src)/%.c FORCE
>  # Link a shared library, based on position independent .o files
>  # *.o -> .so shared library (host-cshlib)
>  quiet_cmd_host-cshlib  = HOSTLLD -shared $@
> -      cmd_host-cshlib  = $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
> +      cmd_host-cshlib  = $(HOSTCC) $(hostld_flags) -shared -o $@ \
>                           $(addprefix $(obj)/,$($(@F:.so=-objs))) \
> -                         $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
> +                         $(hostld_libs)
>  $(host-cshlib): FORCE
>         $(call if_changed,host-cshlib)
>  $(call multi_depend, $(host-cshlib), .so, -objs)
> @@ -153,9 +156,9 @@ $(call multi_depend, $(host-cshlib), .so, -objs)
>  # Link a shared library, based on position independent .o files
>  # *.o -> .so shared library (host-cxxshlib)
>  quiet_cmd_host-cxxshlib        = HOSTLLD -shared $@
> -      cmd_host-cxxshlib        = $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
> +      cmd_host-cxxshlib        = $(HOSTCXX) $(hostld_flags) -shared -o $@ \
>                           $(addprefix $(obj)/,$($(@F:.so=-objs))) \
> -                         $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
> +                         $(hostld_libs)
>  $(host-cxxshlib): FORCE
>         $(call if_changed,host-cxxshlib)
>  $(call multi_depend, $(host-cxxshlib), .so, -objs)
> --
> 2.7.4
>


-- 
Kees Cook

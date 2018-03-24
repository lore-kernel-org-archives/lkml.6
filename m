Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCXBYU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 21:24:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42180 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCXBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 21:24:18 -0400
X-Google-Smtp-Source: AG47ELtPQA6CpeHYZnpfbVktP2FDe5W3jDvdKRlHb7IZ7GxE/KFBrxB+v2GfZoTh8/nzyvkk7DNaRw==
Subject: Re: [PATCH 05/10] kbuild: add %.dtb.S and %.dtb to 'targets'
 automatically
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
 <1521810279-6282-5-git-send-email-yamada.masahiro@socionext.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <b3327969-cc48-17cd-5836-8cc164e240ba@gmail.com>
Date: Fri, 23 Mar 2018 18:24:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521810279-6282-5-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/18 06:04, Masahiro Yamada wrote:
> Another common pattern that consists of chained commands is to compile
> a DTB as binary data into the kernel image or a module.  It is used in
> several places in the source tree.  Let's support it in the build core.
> 
> $(call if_changed,dt_S_dtb) is more suitable than $(call cmd,dt_S_dtb)
> in case cmd_dt_S_dtb is changed in the future.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Frank Rowand <frowand.list@gmail.com>

-Frank

> ---
> 
>  drivers/of/unittest-data/Makefile | 2 --
>  scripts/Makefile.build            | 4 +++-
>  scripts/Makefile.lib              | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index df69797..333bc4c 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -7,8 +7,6 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
>  			    overlay_bad_symbol.dtb.o \
>  			    overlay_base.dtb.o
>  
> -targets += $(foreach suffix, dtb dtb.S, $(patsubst %.dtb.o,%.$(suffix),$(obj-y)))
> -
>  # enable creation of __symbols__ node
>  DTC_FLAGS_overlay := -@
>  DTC_FLAGS_overlay_bad_phandle := -@
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 36f7990..15b3bbb 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -544,9 +544,11 @@ targets := $(filter-out $(PHONY), $(targets))
>  intermediate_targets = $(foreach sfx, $(2), \
>  				$(patsubst %$(strip $(1)),%$(sfx), \
>  					$(filter %$(strip $(1)), $(targets))))
> +# %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
>  # %.lex.o <- %.lex.c <- %.l
>  # %.tab.o <- %.tab.[ch] <- %.y
> -targets += $(call intermediate_targets, .lex.o, .lex.c) \
> +targets += $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
> +	   $(call intermediate_targets, .lex.o, .lex.c) \
>  	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
>  
>  # Descending
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index b7d2c97..7a1fa92 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -278,8 +278,8 @@ cmd_dt_S_dtb=						\
>  	echo '.balign STRUCT_ALIGNMENT'; 		\
>  ) > $@
>  
> -$(obj)/%.dtb.S: $(obj)/%.dtb
> -	$(call cmd,dt_S_dtb)
> +$(obj)/%.dtb.S: $(obj)/%.dtb FORCE
> +	$(call if_changed,dt_S_dtb)
>  
>  quiet_cmd_dtc = DTC     $@
>  cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> 

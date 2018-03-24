Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeCXB00 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 21:26:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41522 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCXB0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 21:26:24 -0400
X-Google-Smtp-Source: AG47ELvCiqwrL3MuExsfoFyL7SLeOMVXbV0LCIxwIbjFN8mucKLJVyvEK1o59wWgYh+VWyQax1l4CQ==
Subject: Re: [PATCH 10/10] kbuild: mark $(targets) as .SECONDARY and remove
 .PRECIOUS specifier
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
 <1521810279-6282-10-git-send-email-yamada.masahiro@socionext.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <84d68deb-8905-cf96-7c71-49d4724f2fbc@gmail.com>
Date: Fri, 23 Mar 2018 18:26:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521810279-6282-10-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/18 06:04, Masahiro Yamada wrote:
> GNU Make automatically deletes intermediate files that are updated
> in a chain of pattern rules.
> 
> Example 1) %.dtb.o <- %.dtb.S <- %.dtb.S <- %.dts
> Example 2) %.o <- %.c <- %.c_shipped
> 
> A couple of makefiles mark such targets as .PRECIOUS to prevent Make
> from deleting them, but the correct way is to use .SECONDARY.
> 
>   .SECONDARY
>     Prerequisites of this special target are treated as intermediate
>     files but are never automatically deleted.
> 
>   .PRECIOUS
>     When make is interrupted during execution, it may delete the target
>     file it is updating if the file was modified since make started.
>     If you mark the file as precious, make will never delete the file
>     if interrupted.
> 
> Both can avoid deletion of intermediate files, but the difference is
> the behavior when Make is interrupted; .SECONDARY deletes the target,
> but .PRECIOUS does not.
> 
> The use of .PRECIOUS is relatively rare since we do not want to keep
> partially constructed (possibly corrupted) targets.
> 
> Another difference is that .PRECIOUS works with pattern rules whereas
> .SECONDARY does not.
> 
>   .PRECIOUS: $(obj)/%.lex.c
> 
> works, but
> 
>   .SECONDARY: $(obj)/%.lex.c
> 
> has no effect.  However, for the reason above, I do not want to use
> .PRECIOUS to avoid obscure build breakage.
> 
> The targets specified as .SECONDARY must be explicit.  $(targets)
> contains all targets that need to include .*.cmd files.  So, the
> intermediates you want to keep are likely to be contained in
> $(targets).  So, mark it as .SECONDARY.  The exception is when they
> are created by $(call cmd,...) instead of $(call if_changed,...)
> since the former does not need to include .*.cmd file.  In this
> case, makefiles need to mark them .SECONDARY by themselves, like
> arch/arm(64)/crypto/Makefile.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Frank Rowand <frowand.list@gmail.com>

-Frank

> ---
> 
>  arch/arc/boot/dts/Makefile        | 2 --
>  arch/arm/crypto/Makefile          | 2 +-
>  arch/arm64/crypto/Makefile        | 2 +-
>  arch/metag/boot/dts/Makefile      | 2 --
>  drivers/of/unittest-data/Makefile | 4 ----
>  scripts/Makefile.build            | 6 ++++--
>  scripts/Makefile.lib              | 3 ---
>  7 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
> index 22a4c5d..a83c4f5 100644
> --- a/arch/arc/boot/dts/Makefile
> +++ b/arch/arc/boot/dts/Makefile
> @@ -9,8 +9,6 @@ endif
>  obj-y   += $(builtindtb-y).dtb.o
>  dtb-y := $(builtindtb-y).dtb
>  
> -.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
> -
>  # for CONFIG_OF_ALL_DTBS test
>  dtstree	:= $(srctree)/$(src)
>  dtb-	:= $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
> diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
> index 30ef8e2..3d59567 100644
> --- a/arch/arm/crypto/Makefile
> +++ b/arch/arm/crypto/Makefile
> @@ -63,4 +63,4 @@ $(src)/sha256-core.S_shipped: $(src)/sha256-armv4.pl
>  $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
>  	$(call cmd,perl)
>  
> -.PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
> +.SECONDARY: $(obj)/sha256-core.S $(obj)/sha512-core.S
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index cee9b8d9..fceb638 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -76,4 +76,4 @@ $(src)/sha256-core.S_shipped: $(src)/sha512-armv8.pl
>  $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
>  	$(call cmd,perlasm)
>  
> -.PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
> +.SECONDARY: $(obj)/sha256-core.S $(obj)/sha512-core.S
> diff --git a/arch/metag/boot/dts/Makefile b/arch/metag/boot/dts/Makefile
> index f0a180f..16505aa 100644
> --- a/arch/metag/boot/dts/Makefile
> +++ b/arch/metag/boot/dts/Makefile
> @@ -12,5 +12,3 @@ endif
>  
>  dtb-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb
>  obj-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb.o
> -
> -.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index 333bc4c..0fb87cb 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -12,7 +12,3 @@ DTC_FLAGS_overlay := -@
>  DTC_FLAGS_overlay_bad_phandle := -@
>  DTC_FLAGS_overlay_bad_symbol := -@
>  DTC_FLAGS_overlay_base := -@
> -
> -.PRECIOUS: \
> -	$(obj)/%.dtb.S \
> -	$(obj)/%.dtb
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index cc081af..4397adb 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -430,8 +430,6 @@ quiet_cmd_asn1_compiler = ASN.1   $@
>        cmd_asn1_compiler = $(objtree)/scripts/asn1_compiler $< \
>  				$(subst .h,.c,$@) $(subst .c,.h,$@)
>  
> -.PRECIOUS: $(objtree)/$(obj)/%.asn1.c $(objtree)/$(obj)/%.asn1.h
> -
>  $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 \
>  					$(objtree)/scripts/asn1_compiler FORCE
>  	$(call if_changed,asn1_compiler)
> @@ -590,6 +588,10 @@ $(shell mkdir -p $(obj-dirs))
>  endif
>  endif
>  
> +# Some contained in $(targets) are intermediate artifacts.
> +# We never want them to be removed automatically.
> +.SECONDARY: $(targets)
> +
>  # Declare the contents of the .PHONY variable as phony.  We keep that
>  # information in a variable se we can use it in if_changed and friends.
>  
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 7a1fa92..c114ce5 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -183,7 +183,6 @@ endef
>  quiet_cmd_flex = LEX     $@
>        cmd_flex = $(LEX) -o$@ -L $<
>  
> -.PRECIOUS: $(obj)/%.lex.c
>  $(obj)/%.lex.c: $(src)/%.l FORCE
>  	$(call if_changed,flex)
>  
> @@ -192,14 +191,12 @@ $(obj)/%.lex.c: $(src)/%.l FORCE
>  quiet_cmd_bison = YACC    $@
>        cmd_bison = $(YACC) -o$@ -t -l $<
>  
> -.PRECIOUS: $(obj)/%.tab.c
>  $(obj)/%.tab.c: $(src)/%.y FORCE
>  	$(call if_changed,bison)
>  
>  quiet_cmd_bison_h = YACC    $@
>        cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
>  
> -.PRECIOUS: $(obj)/%.tab.h
>  $(obj)/%.tab.h: $(src)/%.y FORCE
>  	$(call if_changed,bison_h)
>  
> 

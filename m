Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518044174; cv=none;
        d=google.com; s=arc-20160816;
        b=g5bd1Jv3CCK0sOcwTYVbxZik13KGzdL24VTZDbbdYYFCTRvnYauoSuBGmeK6oZTbf5
         51Xd5HhmSYxCrMBtSb1FA5kF4rDnvlsgH0PeVx1HxABaBSR9UX5OSsap+HUNQyWyx7sn
         i92r39raTXx8l67rWHDJc1L1yrg/THZ0+i1qPOUJnTgHfHZ78XaGgcW2lsFOW3LGQeNH
         vnq0Bu2w8MJIEC/mVR9a7oi93xsDeBob3cN8+9x7l7O93R4zBo1bzBWxlZZG0Xklgday
         367R62HN+tmI/NYeee+67NLjuWu3gUAWBJ/QUxJPelRRKrNUK1j3Fcn39lxAdAnS8VqF
         TH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=FAmjHYXL3rntmC2dTA+uvmdFSuoptao+642a1CSkljo=;
        b=gSMRhminV0iGwAIXgcLhrtVIbaZ4SHM+wNx3CQeJKmRMZ7FOkhaHWhDu8ZvZnY5w8U
         qigQMWgh5Ae1UL9Q6aOO83DmI4itdlzJYK8fSOGNsPWQ+J8O98hZUdl4wTT/Ga+FmToG
         kfTRlfE/mAoswhYue0uOoLGF0Rq+tPNpwdVqEP04HN2nEbWfm6Czx1qd+QRiVmEF9u1p
         e3TyQerz5/P7QTM+mCY82A+KX2tz2/7XR5zDtAcBrI3znaJR6cSkCWR1tt9+fpeaWh0x
         fqwR6KDVZf8NLBcdkR36nEcDf8wwJAsELcRslFBgAOndK6A+t+PVmULvk5Blnh3V9aAj
         rzrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R/D9SHUp;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R/D9SHUp;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227BUWPYkKWROt5SSQi1ZJrkl7dyj58av60UaRTQiwy2LJFCI9msL5Ooqjq2bk4ntJWyA6mP/w==
Date: Wed, 7 Feb 2018 23:55:51 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 02/14] kconfig: do not write choice values when their
 dependency becomes n
Message-ID: <20180207225551.imdp6gqbdwzyvhwm@huvuddator>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
 <1517877294-4826-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517877294-4826-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778627076775?=
X-GMAIL-MSGID: =?utf-8?q?1591784688406477303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 09:34:42AM +0900, Masahiro Yamada wrote:
> "# CONFIG_... is not set" for choice values are wrongly written into
> the .config file if they are once visible, then become invisible later.
> 
>   Test case
>   ---------
> 
> ---------------------------(Kconfig)----------------------------
> config A
> 	bool "A"
> 
> choice
> 	prompt "Choice ?"
> 	depends on A
> 
> config CHOICE_B
> 	bool "Choice B"
> 
> config CHOICE_C
> 	bool "Choice C"
> 
> endchoice
> ----------------------------------------------------------------
> 
> ---------------------------(.config)----------------------------
> CONFIG_A=y
> ----------------------------------------------------------------
> 
> With the Kconfig and .config above,
> 
>   $ make config
>   scripts/kconfig/conf  --oldaskconfig Kconfig
>   *
>   * Linux Kernel Configuration
>   *
>   A (A) [Y/n] n
>   #
>   # configuration written to .config
>   #
>   $ cat .config
>   #
>   # Automatically generated file; DO NOT EDIT.
>   # Linux Kernel Configuration
>   #
>   # CONFIG_A is not set
>   # CONFIG_CHOICE_B is not set
>   # CONFIG_CHOICE_C is not set
> 
> Here,
> 
>   # CONFIG_CHOICE_B is not set
>   # CONFIG_CHOICE_C is not set
> 
> should not be written into the .config file because their dependency
> "depends on A" is unmet.
> 
> Currently, there is no code that clears SYMBOL_WRITE of choice values.
> 
> Clear SYMBOL_WRITE for all symbols in sym_calc_value(), then set it
> again after calculating visibility.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  scripts/kconfig/symbol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index c9123ed..5d6f6b1 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -371,8 +371,7 @@ void sym_calc_value(struct symbol *sym)
>  		sym->curr.tri = no;
>  		return;
>  	}
> -	if (!sym_is_choice_value(sym))
> -		sym->flags &= ~SYMBOL_WRITE;
> +	sym->flags &= ~SYMBOL_WRITE;
>  
>  	sym_calc_visibility(sym);
>  
> @@ -385,6 +384,7 @@ void sym_calc_value(struct symbol *sym)
>  		if (sym_is_choice_value(sym) && sym->visible == yes) {
>  			prop = sym_get_choice_prop(sym);
>  			newval.tri = (prop_get_symbol(prop)->curr.val == sym) ? yes : no;
> +			sym->flags |= SYMBOL_WRITE;
>  		} else {
>  			if (sym->visible != no) {
>  				/* if the symbol is visible use the user value
> -- 
> 2.7.4
> 

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

There's a possible simplification here:

All defined symbols, regardless of type, and regardless of whether
they're choice value symbols or not, always get written out if they have
non-n visibility. Therefore, the sym->visible != no check for
SYMBOL_WRITE can be moved to before the symbol type check, which gets
rid of two SYMBOL_WRITE assignments and makes it clear that the logic is
the same for all paths.

This is safe for symbols defined without a type (S_UNKNOWN) too, because
conf_write() skips those (plus they already generate a warning).

This matches how I do it in the tri_value() function in Kconfiglib:
https://github.com/ulfalizer/Kconfiglib/blob/master/kconfiglib.py#L2574.
SYMBOL_WRITE corresponds to _write_to_conf.

I've included a patch below. I tested it with the Kconfiglib test suite,
which verifies that the C implementation still generates the same
.config file for all defconfig files as well as for
all{no,yes,def}config, for all ARCHes.

(The Kconfiglib test suite runs scripts/kconfig/conf and compares its
output against it, which means it doubles as a regression test for the C
tools.)


diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index c9123ed2b791..13f7fdfe328d 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -371,11 +371,13 @@ void sym_calc_value(struct symbol *sym)
 		sym->curr.tri = no;
 		return;
 	}
-	if (!sym_is_choice_value(sym))
-		sym->flags &= ~SYMBOL_WRITE;
+	sym->flags &= ~SYMBOL_WRITE;
 
 	sym_calc_visibility(sym);
 
+	if (sym->visible != no)
+		sym->flags |= SYMBOL_WRITE;
+
 	/* set default if recursively called */
 	sym->curr = newval;
 
@@ -390,7 +392,6 @@ void sym_calc_value(struct symbol *sym)
 				/* if the symbol is visible use the user value
 				 * if available, otherwise try the default value
 				 */
-				sym->flags |= SYMBOL_WRITE;
 				if (sym_has_value(sym)) {
 					newval.tri = EXPR_AND(sym->def[S_DEF_USER].tri,
 							      sym->visible);
@@ -433,12 +434,9 @@ void sym_calc_value(struct symbol *sym)
 	case S_STRING:
 	case S_HEX:
 	case S_INT:
-		if (sym->visible != no) {
-			sym->flags |= SYMBOL_WRITE;
-			if (sym_has_value(sym)) {
-				newval.val = sym->def[S_DEF_USER].val;
-				break;
-			}
+		if (sym->visible != no && sym_has_value(sym)) {
+			newval.val = sym->def[S_DEF_USER].val;
+			break;
 		}
 		prop = sym_get_default_prop(sym);
 		if (prop) {
-- 
2.14.1

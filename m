Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbeCRWRy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:17:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35517 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbeCRWRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:17:52 -0400
X-Google-Smtp-Source: AG47ELsBfTotaPCay+5o9MoGBWyHO07YobnmNmXcfVbOWqIA+hNfmxRvxrtlQKsSldrLenMD7km6Hg==
From: Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date: Sun, 18 Mar 2018 23:17:37 +0100
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] kconfig: warn unmet direct dependency of tristate
 symbols selected by y
Message-ID: <20180318221737.GA25547@example.com>
References: <1520934968-30406-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520934968-30406-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Tue, Mar 13, 2018 at 06:56:07PM +0900, Masahiro Yamada wrote:
> Commit 246cf9c26bf1 ("kbuild: Warn on selecting symbols with unmet
> direct dependencies") forcibly promoted ->dir_dep.tri to yes from mod.
> So, the unmet direct dependencies of tristate symbols are not reported.
> 
> [Test Case]
> 
>   config MODULES
>           def_bool y
>           option modules
> 
>   config A
>           def_bool y
>           select B
> 
>   config B
>           tristate "B"
>           depends on m
> 
> This causes unmet dependency because 'B' is forced 'y' ignoring
> 'depends on m'.  This should be warned.
> 
> On the other hand, the following case ('B' is bool) should not be
> warned, so 'depends on m' for bool symbols should be naturally treated
> as 'depends on y'.
> 
> [Test Case2 (not unmet dependency)]
> 
>   config MODULES
>           def_bool y
>           option modules
> 
>   config A
>           def_bool y
>           select B
> 
>   config B
>           bool "B"
>           depends on m
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v4:
>   - newly added
> 
> 
>  scripts/kconfig/symbol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index 0f7eba7..def860b 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -243,7 +243,7 @@ static void sym_calc_visibility(struct symbol *sym)
>  	tri = yes;
>  	if (sym->dir_dep.expr)
>  		tri = expr_calc_value(sym->dir_dep.expr);
> -	if (tri == mod)
> +	if (sym->type == S_BOOLEAN && tri == mod)

This seems to be very close to one of the issues fixed in the old
v2.6.5 commit 5a87d187fce1 ("[PATCH] config: choice fix") accessible at
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?h=5a87d187fce1

IMHO you could probably use (not tested!):
+	if (tri == mod && sym_get_type(sym) == S_BOOLEAN)

instead of
+	if (sym->type == S_BOOLEAN && tri == mod)

to be consistent with the rest of sym_calc_visibility().

Also, since after this commit there will be a great amount of symmetry
between how dirdep/revdep/weak-revdep are calculated inside
sym_calc_visibility(), somebody could probably unify the implementations
in future (not subject of this patch).

>  		tri = yes;
>  	if (sym->dir_dep.tri != tri) {
>  		sym->dir_dep.tri = tri;
> @@ -414,7 +414,7 @@ void sym_calc_value(struct symbol *sym)
>  				}
>  			}
>  		calc_newval:
> -			if (sym->dir_dep.tri == no && sym->rev_dep.tri != no) {
> +			if (sym->dir_dep.tri < sym->rev_dep.tri) {

Looks good.

>  				struct expr *e;
>  				e = expr_simplify_unmet_dep(sym->rev_dep.expr,
>  				    sym->dir_dep.expr);
> -- 
> 2.7.4
> 

Best regards,
Eugeniu.

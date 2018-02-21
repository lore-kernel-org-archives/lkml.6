Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeBULKp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:10:45 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33760 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeBULKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:10:43 -0500
X-Google-Smtp-Source: AH8x226nBAoKiP1qdH8XGdEGttnYG+GTlIMAckV5q9FYsvrQIkrtnU3bOz5HS9J0uVXqt7yITuqLYA==
Date: Wed, 21 Feb 2018 12:10:40 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] kconfig: Print reverse dependencies in groups
Message-ID: <20180221111038.clllad7wfhwd3dou@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <1519191855-27943-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519191855-27943-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
Just please fix typo leading to segfault and add ':'

<snip>
>  	get_symbol_props_str(r, sym, P_SELECT, _("  Selects: "));
>  	if (sym->rev_dep.expr) {
> -		str_append(r, _("  Selected by: \n"));
> -		expr_gstr_print_revdep(sym->rev_dep.expr, r);
> +		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Selected by [y]\n");
> +		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Selected by [m]\n");
> +		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Selected by [n]\n");
Maybe add ':' to be consistent with the rest of titles?
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Selected by [y]:\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Selected by [m]:\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Selected by [n]:\n");

>  	}

>  	get_symbol_props_str(r, sym, P_IMPLY, _("  Implies: "));
>  	if (sym->implied.expr) {
> -		str_append(r, _("  Implied by: \n"));
> -		expr_gstr_print_revdep(sym->implied.expr, r);
> +		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Implied by [y]\n");
> +		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Implied by [m]\n");
> +		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Implied by [n]\n");
And the same here.
+ the most important thing - copy paste error, which obviously leads to segfault on
"Implied by":
Try search for PTP_1588_CLOCK (in x86_64 defconfig). gdb in coredump shows
#0  0x000000000041043e in expr_print_revdep (e=0x0, fn=0x410297 <expr_print_gstr_helper>, data=0x7fff0f2a8640, pr_type=yes, title=0x7fff0f2a85a0) at scripts/kconfig/expr.c:1328
1328        if (e->type == E_OR) {

So the correct is:
		expr_gstr_print_revdep(sym->implied.expr, r, yes, "  Implied by [y]:\n");
		expr_gstr_print_revdep(sym->implied.expr, r, mod, "  Implied by [m]:\n");
		expr_gstr_print_revdep(sym->implied.expr, r, no, "  Implied by [n]:\n");


Kind regards,
Petr

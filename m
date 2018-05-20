Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeETOjj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 10:39:39 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:54019 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeETOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 10:39:38 -0400
Date: Sun, 20 May 2018 16:39:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v4 05/31] kconfig: remove string expansion for mainmenu
 after yyparse()
Message-ID: <20180520143933.GA9826@ravnborg.org>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-6-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526537830-22606-6-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=c-n4J4-pAAAA:8 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8
        a=CgTsw72b9cj2pn2SOOgA:9 a=CjuIK1q_8ugA:10 a=L0NDqeB7ZLmQzAogN4cw:22
        a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:16:44PM +0900, Masahiro Yamada wrote:
> Now that environments are expanded in the lexer, conf_parse() does
> not need to expand them explicitly.
> 
> The hack introduced by commit 0724a7c32a54 ("kconfig: Don't leak
> main menus during parsing") can go away.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
>   - Simplify the patch.  Just remove the text expansion.
> 
>  scripts/kconfig/zconf.y | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> index 3a4a0fa..22e318c 100644
> --- a/scripts/kconfig/zconf.y
> +++ b/scripts/kconfig/zconf.y
> @@ -109,7 +109,7 @@ static struct menu *current_menu, *current_entry;
>  %%
>  input: nl start | start;
>  
> -start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
> +start: mainmenu_stmt stmt_list | stmt_list;
>  
>  /* mainmenu entry */
>  
> @@ -118,19 +118,6 @@ mainmenu_stmt: T_MAINMENU prompt nl
>  	menu_add_prompt(P_MENU, $2, NULL);
>  };
>  
> -/* Default main menu, if there's no mainmenu entry */
> -
> -no_mainmenu_stmt: /* empty */
> -{
> -	/*
> -	 * Hack: Keep the main menu title on the heap so we can safely free it
> -	 * later regardless of whether it comes from the 'prompt' in
> -	 * mainmenu_stmt or here
> -	 */
> -	menu_add_prompt(P_MENU, xstrdup("Linux Kernel Configuration"), NULL);
> -};
> -
> -
>  stmt_list:
>  	  /* empty */
>  	| stmt_list common_stmt
> @@ -528,7 +515,6 @@ word_opt: /* empty */			{ $$ = NULL; }
>  
>  void conf_parse(const char *name)
>  {
> -	const char *tmp;
>  	struct symbol *sym;
>  	int i;
>  
> @@ -544,10 +530,10 @@ void conf_parse(const char *name)
>  	if (!modules_sym)
>  		modules_sym = sym_find( "n" );
>  
> -	tmp = rootmenu.prompt->text;
> -	rootmenu.prompt->text = _(rootmenu.prompt->text);
> -	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
> -	free((char*)tmp);
> +	if (!menu_has_prompt(&rootmenu)) {
> +		current_entry = &rootmenu;
> +		menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);

Could this be something less specific?
To help the other users of kconfig out is the wild.

For example:

	menu_add_prompt(P_MENU, _("Main menu"), NULL);

Note, the added _() to make the text translateable.

	Sam

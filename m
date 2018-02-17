Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518884215; cv=none;
        d=google.com; s=arc-20160816;
        b=hGwRg2WEudnbNH5x2AeJtgdOwIo8EAwIcvHGY4n8R+h5POkZOHsjCAA+3f8gUl1Tp5
         HbNthNC6KH6clkhK91USXs9zoAd9C1KzFl8LrZsVel5U/0lOjbPWDsQ+R6cNpSIae3Us
         ZPQjp4Fi2Awg50uoPzyPqDAOXelhSlmhSDLO78qaoh4bEb0PMzAagzOLsGrN7iMmuvbC
         W8bVMz32VrIyPq9LJ2/6ICAsIUWYn2hZNoAvDvBIsGdLHrEdJXnN0Jg5GcaAdUaHgzYj
         9iEbftc325wh4Wj9+Yi8PMxBU56lOf05UqFqkpCIsyvlNHeJID1//8mGVxhRnfTPJ56w
         iang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ljB6uV29yXESl2uRR0HdFXq9aSntUXNqM3UM2aFAco0=;
        b=ZclVrwEmjeh2GNu2j+AIycGPBTAtbGL1Udi2jLK9Va3lOdxiF+bouW2g9F1wHc+Wgf
         hWu/V9Vp/kbhYJH7OgcSiz86l8tx1FSI3eY9bjF8XPfVPqI33+zc+Pv4BKIlOHM+0Kgj
         ZYg5WPfeX7/94o8NX66WYahYTQERPAldVyjsXsjz2UvBJSosmT57tzFeT738H/x+sKgc
         pUVH+mAgxFCTNXjJke518QoHlg5GaGhJO35gMxYQmBcJF7MCIBFsDwBNrICA5y2q0ZbM
         vekV80tXzujFpCs2KL+6KzV0PX8740KzY/xyfMXPyhQvcFm96k3KT2RUpSBOzO7rz9aZ
         kyZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DIWQGuqD;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DIWQGuqD;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224qWP9khfYufwH4ldAa715+Pubni8TjrQ+J86ujFmC5lDNRSE02wN01CdSNj2ZRhjeddn/gbw==
Date: Sat, 17 Feb 2018 17:16:36 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/23] kconfig: add function support and implement
 'shell' function
Message-ID: <20180217161636.h6miw4xhu2mfjzvd@huvuddator>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-8-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518806331-7101-8-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925672243095?=
X-GMAIL-MSGID: =?utf-8?q?1592665535289384088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 03:38:35AM +0900, Masahiro Yamada wrote:
> This commit adds a new concept 'function' to Kconfig.  A function call
> resembles a variable reference with arguments, and looks like this:
> 
>   $(function arg1, arg2, arg3, ...)
> 
> (Actually, this syntax was inspired by Makefile.)
> 
> Real examples will look like this:
> 
>   $(shell true)
>   $(cc-option -fstackprotector)
> 
> This commit adds the basic infrastructure to add, delete, evaluate
> functions.
> 
> Also, add the first built-in function $(shell ...).  This evaluates
> to 'y' if the given command exits with 0, 'n' otherwise.
> 
> I am also planning to support user-defined functions (a.k.a 'macro')
> for cases where hard-coding is not preferred.
> 
> If you want to try this feature, the hello-world code is someting below.
> 
> Example code:
> 
>   config CC_IS_GCC
>           bool
>           default $(shell $CC --version | grep -q gcc)
> 
>   config CC_IS_CLANG
>           bool
>           default $(shell $CC --version | grep -q clang)
> 
>   config CC_HAS_OZ
>           bool
>           default $(shell $CC -Werror -Oz -c -x c /dev/null -o /dev/null)
> 
> Result:
> 
>   $ make -s alldefconfig && tail -n 3 .config
>   CONFIG_CC_IS_GCC=y
>   # CONFIG_CC_IS_CLANG is not set
>   # CONFIG_CC_HAS_OZ is not set
> 
>   $ make CC=clang -s alldefconfig && tail -n 3 .config
>   # CONFIG_CC_IS_GCC is not set
>   CONFIG_CC_IS_CLANG=y
>   CONFIG_CC_HAS_OZ=y
> 
> A function call can appear anywhere a symbol reference can appear.
> So, the following code is possible.
> 
> Example code:
> 
>   config CC_NAME
>           string
>           default "gcc" if $(shell $CC --version | grep -q gcc)
>           default "clang" if $(shell $CC --version | grep -q clang)
>           default "unknown compiler"
> 
> Result:
> 
>   $ make -s alldefconfig && tail -n 1 .config
>   CONFIG_CC_NAME="gcc"
> 
>   $ make CC=clang -s alldefconfig && tail -n 1 .config
>   CONFIG_CC_NAME="clang"
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Reminder for myself:
> Update Documentation/kbuild/kconfig-language.txt
> 
> 
>  scripts/kconfig/function.c  | 149 ++++++++++++++++++++++++++++++++++++++++++++
>  scripts/kconfig/lkc_proto.h |   5 ++
>  scripts/kconfig/util.c      |  46 +++++++++++---
>  scripts/kconfig/zconf.l     |  38 ++++++++++-
>  scripts/kconfig/zconf.y     |   9 +++
>  5 files changed, 238 insertions(+), 9 deletions(-)
>  create mode 100644 scripts/kconfig/function.c
> 
> diff --git a/scripts/kconfig/function.c b/scripts/kconfig/function.c
> new file mode 100644
> index 0000000..60e59be
> --- /dev/null
> +++ b/scripts/kconfig/function.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "list.h"
> +
> +#define FUNCTION_MAX_ARGS		10
> +
> +static LIST_HEAD(function_list);
> +
> +struct function {
> +	const char *name;
> +	char *(*func)(int argc, char *argv[]);
> +	struct list_head node;
> +};
> +
> +static struct function *func_lookup(const char *name)
> +{
> +	struct function *f;
> +
> +	list_for_each_entry(f, &function_list, node) {
> +		if (!strcmp(name, f->name))
> +			return f;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void func_add(const char *name, char *(*func)(int argc, char *argv[]))
> +{
> +	struct function *f;
> +
> +	f = func_lookup(name);
> +	if (f) {
> +		fprintf(stderr, "%s: function already exists. ignored.\n", name);
> +		return;
> +	}
> +
> +	f = xmalloc(sizeof(*f));
> +	f->name = name;
> +	f->func = func;
> +
> +	list_add_tail(&f->node, &function_list);
> +}
> +
> +static void func_del(struct function *f)
> +{
> +	list_del(&f->node);
> +	free(f);
> +}
> +
> +static char *func_call(int argc, char *argv[])
> +{
> +	struct function *f;
> +
> +	f = func_lookup(argv[0]);
> +	if (!f) {
> +		fprintf(stderr, "%s: function not found\n", argv[0]);
> +		return NULL;
> +	}
> +
> +	return f->func(argc, argv);
> +}
> +
> +static char *func_eval(const char *func)
> +{
> +	char *expanded, *saveptr, *str, *token, *res;
> +	const char *delim;
> +	int argc = 0;
> +	char *argv[FUNCTION_MAX_ARGS];
> +
> +	expanded = expand_string_value(func);
> +
> +	str = expanded;
> +	delim = " ";
> +
> +	while ((token = strtok_r(str, delim, &saveptr))) {
> +		argv[argc++] = token;
> +		str = NULL;
> +		delim = ",";
> +	}
> +
> +	res = func_call(argc, argv);
> +
> +	free(expanded);
> +
> +	return res ?: xstrdup("");
> +}
> +
> +char *func_eval_n(const char *func, size_t n)
> +{
> +	char *tmp, *res;
> +
> +	tmp = xmalloc(n + 1);
> +	memcpy(tmp, func, n);
> +	*(tmp + n) = '\0';
> +
> +	res = func_eval(tmp);
> +
> +	free(tmp);
> +
> +	return res;
> +}
> +
> +/* built-in functions */
> +static char *do_shell(int argc, char *argv[])
> +{
> +	static const char *pre = "(";
> +	static const char *post = ") >/dev/null 2>&1";
> +	char *cmd;
> +	int ret;
> +
> +	if (argc != 2)
> +		return NULL;
> +
> +	/*
> +	 * Surround the command with ( ) in case it is piped commands.
> +	 * Also, redirect stdout and stderr to /dev/null.
> +	 */
> +	cmd = xmalloc(strlen(pre) + strlen(argv[1]) + strlen(post) + 1);
> +	strcpy(cmd, pre);
> +	strcat(cmd, argv[1]);
> +	strcat(cmd, post);
> +
> +	ret = system(cmd);
> +
> +	free(cmd);
> +
> +	return xstrdup(ret == 0 ? "y" : "n");
> +}
> +
> +void func_init(void)
> +{
> +	/* register built-in functions */
> +	func_add("shell", do_shell);
> +}
> +
> +void func_exit(void)
> +{
> +	struct function *f, *tmp;
> +
> +	/* unregister all functions */
> +	list_for_each_entry_safe(f, tmp, &function_list, node)
> +		func_del(f);
> +}
> diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
> index 9884adc..09a4f53 100644
> --- a/scripts/kconfig/lkc_proto.h
> +++ b/scripts/kconfig/lkc_proto.h
> @@ -48,5 +48,10 @@ const char * sym_get_string_value(struct symbol *sym);
>  
>  const char * prop_get_type_name(enum prop_type type);
>  
> +/* function.c */
> +char *func_eval_n(const char *func, size_t n);
> +void func_init(void);
> +void func_exit(void);
> +
>  /* expr.c */
>  void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
> diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
> index dddf85b..ed89fb9 100644
> --- a/scripts/kconfig/util.c
> +++ b/scripts/kconfig/util.c
> @@ -93,9 +93,10 @@ static char *env_expand_n(const char *name, size_t n)
>  }
>  
>  /*
> - * Expand environments embedded in the string given in argument. Environments
> - * to be expanded shall be prefixed by a '$'. Unknown environment expands to
> - * the empty string.
> + * Expand environments and functions embedded in the string given in argument.
> + * Environments to be expanded shall be prefixed by a '$'. Functions to be
> + * evaluated shall be surrounded by $(). Unknown environment/function expands
> + * to the empty string.
>   */
>  char *expand_string_value(const char *in)
>  {
> @@ -113,11 +114,40 @@ char *expand_string_value(const char *in)
>  	while ((p = strchr(in, '$'))) {
>  		char *new;
>  
> -		q = p + 1;
> -		while (isalnum(*q) || *q == '_')
> -			q++;
> -
> -		new = env_expand_n(p + 1, q - p - 1);
> +		/*
> +		 * If the next character is '(', it is a function.
> +		 * Otherwise, environment.
> +		 */
> +		if (*(p + 1) == '(') {
> +			int nest = 0;
> +
> +			q = p + 2;
> +			while (1) {
> +				if (*q == '\0') {
> +					fprintf(stderr,
> +						"unterminated function: %s\n",
> +						p);
> +					new = xstrdup("");
> +					break;
> +				} else if (*q == '(') {
> +					nest++;
> +				} else if (*q == ')') {
> +					if (nest-- == 0) {
> +						new = func_eval_n(p + 2,
> +								  q - p - 2);
> +						q++;
> +						break;
> +					}
> +				}
> +				q++;
> +			}
> +		} else {
> +			q = p + 1;
> +			while (isalnum(*q) || *q == '_')
> +				q++;
> +
> +			new = env_expand_n(p + 1, q - p - 1);
> +		}
>  
>  		reslen = strlen(res) + (p - in) + strlen(new) + 1;
>  		res = xrealloc(res, reslen);
> diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
> index 0d89ea6..f433ab0 100644
> --- a/scripts/kconfig/zconf.l
> +++ b/scripts/kconfig/zconf.l
> @@ -1,7 +1,7 @@
>  %option nostdinit noyywrap never-interactive full ecs
>  %option 8bit nodefault perf-report perf-report
>  %option noinput
> -%x COMMAND HELP STRING PARAM
> +%x COMMAND HELP STRING PARAM FUNCTION
>  %{
>  /*
>   * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
> @@ -25,6 +25,7 @@ static struct {
>  
>  static char *text;
>  static int text_size, text_asize;
> +static int function_nest;
>  
>  struct buffer {
>  	struct buffer *parent;
> @@ -138,6 +139,12 @@ n	[$A-Za-z0-9_-]
>  		new_string();
>  		BEGIN(STRING);
>  	}
> +	"$("	{
> +		new_string();
> +		append_string(yytext, yyleng);
> +		function_nest = 0;
> +		BEGIN(FUNCTION);
> +	}
>  	\n	BEGIN(INITIAL); current_file->lineno++; return T_EOL;
>  	({n}|[/.])+	{
>  		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
> @@ -196,6 +203,35 @@ n	[$A-Za-z0-9_-]
>  	}
>  }
>  
> +<FUNCTION>{
> +	[^()\n]* {
> +		append_string(yytext, yyleng);
> +	}
> +	"(" {
> +		append_string(yytext, yyleng);
> +		function_nest++;
> +	}
> +	")" {
> +		append_string(yytext, yyleng);
> +		if (function_nest-- == 0) {
> +			BEGIN(PARAM);
> +			yylval.string = text;
> +			return T_WORD;

T_WORD_QUOTE (which would turn into a constant symbol in most contexts)
would be better here, IMO. That would turn $(foo) into just an alias for
"$(foo)".

See below.

> +		}
> +	}
> +	\n {
> +		fprintf(stderr,
> +			"%s:%d:warning: multi-line function not supported\n",
> +			zconf_curname(), zconf_lineno());
> +		current_file->lineno++;
> +		BEGIN(INITIAL);
> +		return T_EOL;
> +	}
> +	<<EOF>>	{
> +		BEGIN(INITIAL);
> +	}
> +}
> +
>  <HELP>{
>  	[ \t]+	{
>  		ts = 0;
> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> index 784083d..d9977de 100644
> --- a/scripts/kconfig/zconf.y
> +++ b/scripts/kconfig/zconf.y
> @@ -534,11 +534,19 @@ void conf_parse(const char *name)
>  
>  	zconf_initscan(name);
>  
> +	func_init();
>  	_menu_init();
>  
>  	if (getenv("ZCONF_DEBUG"))
>  		yydebug = 1;
>  	yyparse();
> +
> +	/*
> +	 * Currently, functions are evaluated only when Kconfig files are
> +	 * parsed. We can free functions here.
> +	 */
> +	func_exit();
> +
>  	if (yynerrs)
>  		exit(1);
>  	if (!modules_sym)
> @@ -778,4 +786,5 @@ void zconfdump(FILE *out)
>  #include "confdata.c"
>  #include "expr.c"
>  #include "symbol.c"
> +#include "function.c"
>  #include "menu.c"
> -- 
> 2.7.4
> 

Here's a simplification idea I'm throwing out there:

What about only allowing $ENV and $() within quotes, and just having
them always do simple text substitution (so that they'd indirectly
always generate T_WORD_QUOTE tokens)?

Pros:

 - Zero new syntax outside of strings (until the macro stuff).

 - Makes the behavior and limitations of the syntax obvious: You can't
   have $(foo) expand to a full expression, only to (possibly part of) a
   value. This is a good limitation, IMO, and it's already there.

 - Super simple and straightforward Kconfig implementation. All the new
   magic would happen in expand_string_value().

Neutral:

 - Just as general where it matters. Take something like

     default "$(foo)"

   If $(foo) happens to expand to "y", then that will do its usual thing
   for a bool/tristate symbol. Same for string symbols, etc. It'd just
   be a thin preprocessing step on constant symbol values.

 - The only loss in generality would be that you can no longer have
   a function expand to the name of non-constant symbol. For example,
   take the following:

	default $(foo)

   If $(foo) expands to MY_SYMBOL, then that would work as

	default MY_SYMBOL

  (I.e., it would default to the value of the symbol MY_SYMBOL.)

  With the quotes, it would instead work as

     default "MY_SYMBOL"

  IMO, the second version is less confusing, and deliberately using the
  first version seems like a bad idea (there's likely to be cleaner ways
  to do the indirection in plain Kconfig).

  This is also why I think T_WORD_QUOTE is better in the code above. It
  would make $(foo) work more like a shorthand for "$(foo)".


Cons:

 - Bit more typing to add the quotes

 - Maybe it isn't widely known that "n", "m", "y" work just like n, m, y
   for bool and tristate symbols (the latter automatically get converted
   to the former), though you see them quite a lot in Kconfig files.
   
   ("n", "foo bar", etc., are all just constant symbols. Kconfig keeps
   track of them separately from non-constant symbols. The constant
   symbols "n", "m", and "y" are predefined.)

   If we go with obligatory quotes, I volunteer to explain things in
   kconfig-language.txt at least, to make it clear why you'd see quotes
   in bool/tristate symbols using $(shell). I suspect it wouldn't be
   that tricky to figure out anyway.


What do you think?

Cheers,
Ulf

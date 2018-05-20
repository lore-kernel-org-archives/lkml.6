Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeETOuj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 10:50:39 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:54211 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeETOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 10:50:35 -0400
Date: Sun, 20 May 2018 16:50:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v4 07/31] kconfig: add built-in function support
Message-ID: <20180520145031.GB9826@ravnborg.org>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-8-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526537830-22606-8-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=c-n4J4-pAAAA:8 a=mTnDXwI-aR6BdpQ_sW0A:9
        a=UxxIoLBfMT1qoQmz:21 a=0_5jFHM1TgMQ-lGW:21 a=CjuIK1q_8ugA:10
        a=L0NDqeB7ZLmQzAogN4cw:22
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:16:46PM +0900, Masahiro Yamada wrote:
> This commit adds a new concept 'function' to do more text processing
> in Kconfig.
> 
> A function call looks like this:
> 
>   $(function,arg1,arg2,arg3,...)
> 
> This commit adds the basic infrastructure to expand functions.
> Change the text expansion helpers to take arguments.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v4:
>   - Error out if arguments more than FUNCTION_MAX_ARGS are passed
>   - Use a comma as a delimiter between the function name and the
>     first argument
>   - Check the number of arguments accepted by each function
>   - Support delayed expansion of arguments.
>     This will be needed to implement 'if' function
> 
> Changes in v3:
>   - Split base infrastructure and 'shell' function
>     into separate patches.
> 
> Changes in v2:
>   - Use 'shell' for getting stdout from the comment.
>     It was 'shell-stdout' in the previous version.
>   - Simplify the implementation since the expansion has been moved to
>     lexer.
> 
>  scripts/kconfig/preprocess.c | 168 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 159 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
> index 1bf506c..5be28ec 100644
> --- a/scripts/kconfig/preprocess.c
> +++ b/scripts/kconfig/preprocess.c
> @@ -3,12 +3,17 @@
>  // Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
>  
>  #include <stdarg.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  
>  #include "list.h"
>  
> +#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
> +
> +static char *expand_string_with_args(const char *in, int argc, char *argv[]);
> +
>  static void __attribute__((noreturn)) pperror(const char *format, ...)
>  {
>  	va_list ap;
> @@ -88,9 +93,85 @@ void env_write_dep(FILE *f, const char *autoconfig_name)
>  	}
>  }
>  
> -static char *eval_clause(const char *in)
> +/*
> + * Built-in functions
> + */
> +struct function {
> +	const char *name;
> +	unsigned int min_args;
> +	unsigned int max_args;
> +	bool expand_args;
> +	char *(*func)(int argc, char *argv[], int old_argc, char *old_argv[]);
> +};
If a typedef was provided for the function then ...

> +
> +static const struct function function_table[] = {
> +	/* Name		MIN	MAX	EXP?	Function */
> +};
> +
> +#define FUNCTION_MAX_ARGS		16
> +
> +static char *function_expand_arg_and_call(char *(*func)(int argc, char *argv[],
> +							int old_argc,
> +							char *old_argv[]),
> +					  int argc, char *argv[],
> +					  int old_argc, char *old_argv[])
this could be much easier to read.

> +{
> +	char *expanded_argv[FUNCTION_MAX_ARGS], *res;
> +	int i;
> +
> +	for (i = 0; i < argc; i++)
> +		expanded_argv[i] = expand_string_with_args(argv[i],
> +							   old_argc, old_argv);

No check for too many arguments here - maybe it is done in some other place.

> +
> +	res = func(argc, expanded_argv, 0, NULL);
> +
> +	for (i = 0; i < argc; i++)
> +		free(expanded_argv[i]);
> +
> +	return res;
> +}
> +
> +static char *function_call(const char *name, int argc, char *argv[],
> +			   int old_argc, char *old_argv[])
> +{
> +	const struct function *f;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(function_table); i++) {
> +		f = &function_table[i];
> +		if (strcmp(f->name, name))
> +			continue;
> +
> +		if (argc < f->min_args)
> +			pperror("too few function arguments passed to '%s'",
> +				name);
> +
> +		if (argc > f->max_args)
> +			pperror("too many function arguments passed to '%s'",
> +				name);
Number of arguments checked here, but max_args is not assiged in this patch.


> +
> +		if (f->expand_args)
> +			return function_expand_arg_and_call(f->func, argc, argv,
> +							    old_argc, old_argv);
> +		return f->func(argc, argv, old_argc, old_argv);
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Evaluate a clause with arguments.  argc/argv are arguments from the upper
> + * function call.
> + *
> + * Returned string must be freed when done
> + */
> +static char *eval_clause(const char *in, int argc, char *argv[])
>  {
> -	char *res, *name;
> +	char *tmp, *prev, *p, *res, *name;
> +	int new_argc = 0;
> +	char *new_argv[FUNCTION_MAX_ARGS];
> +	int nest = 0;
> +	int i;
>  
>  	/*
>  	 * Returns an empty string because '$()' should be evaluated
> @@ -99,10 +180,69 @@ static char *eval_clause(const char *in)
>  	if (!*in)
>  		return xstrdup("");
>  
> -	name = expand_string(in);
> +	tmp = xstrdup(in);
> +
> +	prev = p = tmp;
> +
> +	/*
> +	 * Split into tokens
> +	 * The function name and arguments are separated by a comma.
> +	 * For example, if the function call is like this:
> +	 *   $(foo,abc,$(x),$(y))
> +	 *
> +	 * The input string for this helper should be:
> +	 *   foo,abc,$(x),$(y)
> +	 *
> +	 * and split into:
> +	 *   new_argv[0] = 'foo'
> +	 *   new_argv[1] = 'abc'
> +	 *   new_argv[2] = '$(x)'
> +	 *   new_argv[3] = '$(y)'
> +	 */
> +	while (*p) {
> +		if (nest == 0 && *p == ',') {
> +			*p = 0;
> +			if (new_argc >= FUNCTION_MAX_ARGS)
> +				pperror("too many function arguments");
> +			new_argv[new_argc++] = prev;
> +			prev = p + 1;
> +		} else if (*p == '(') {
> +			nest++;
> +		} else if (*p == ')') {
> +			nest--;
> +		}
> +
> +		p++;
> +	}
> +	new_argv[new_argc++] = prev;

Will the following be equal:

	$(foo,abc,$(x),$(y))
	$(foo, abc, $(x), $(y))

make is rather annoying as space is significant, but there seems no good reason
for kconfig to inheritate this.
So unless there are good arguments consider alloing the spaces.
If the current implmentation already supports optional spaces then I just missed
it whie reviewing.

	Sam

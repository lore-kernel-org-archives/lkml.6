Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeDOH5q (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 03:57:46 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39479 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeDOH5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 03:57:45 -0400
X-Google-Smtp-Source: AIpwx4+NZc3Alyo0xNbFE5+6pDevEqWWqZYXryMk1IcZYg9KDLYK6nkOb02ZaIbgxBbPqSREdItqvm6zWFEQXUjFxiY=
MIME-Version: 1.0
In-Reply-To: <1523595999-27433-9-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com> <1523595999-27433-9-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 15 Apr 2018 09:57:43 +0200
Message-ID: <CAFkk2KTz6icMhNma5=Evd8Mr0HL7gY5GQe1qzYS78x-ZC67fng@mail.gmail.com>
Subject: Re: [PATCH 08/30] kconfig: add built-in function support
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
        Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 7:06 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This commit adds a new concept 'function' to do more text processing
> in Kconfig.
>
> A function call looks like this:
>
>   $(function arg1, arg2, arg3, ...)
>
> This commit adds the basic infrastructure to expand functions.
> Change the text expansion helpers to take arguments.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v3:
>   - Split base infrastructure and 'shell' function
>     into separate patches.
>
> Changes in v2:
>   - Use 'shell' for getting stdout from the comment.
>     It was 'shell-stdout' in the previous version.
>   - Symplify the implementation since the expansion has been moved to
>     lexer.
>
>  scripts/kconfig/preprocess.c | 142 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 130 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
> index fa4abc8..e77cf7c 100644
> --- a/scripts/kconfig/preprocess.c
> +++ b/scripts/kconfig/preprocess.c
> @@ -8,6 +8,10 @@
>
>  #include "list.h"
>
> +#define ARRAY_SIZE(arr)                (sizeof(arr) / sizeof((arr)[0]))
> +
> +static char *expand_string_with_args(const char *in, int argc, char *argv[]);
> +
>  /*
>   * Environment variables
>   */
> @@ -74,9 +78,47 @@ void env_write_dep(FILE *f, const char *autoconfig_name)
>         }
>  }
>
> -static char *eval_clause(const char *in)
> +/*
> + * Built-in Functions
> + */
> +struct function {
> +       char *name;
> +       char *(*func)(int argc, char *argv[]);
> +};
> +
> +static const struct function function_table[] = {
> +};
> +
> +static char *function_call(const char *name, int argc, char *argv[])
>  {
> -       char *res, *name;
> +       const struct function *f;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(function_table); i++) {
> +               f = &function_table[i];
> +               if (!strcmp(f->name, name))
> +                       return f->func(argc, argv);
> +       }
> +
> +       return NULL;
> +}
> +
> +#define FUNCTION_MAX_ARGS              16
> +
> +/*
> + * Evaluate a clause with arguments.  argc/argv are arguments from the upper
> + * function call.
> + *
> + * Returned string must be freed when done
> + */
> +static char *eval_clause(const char *in, int argc, char *argv[])
> +{
> +       char *tmp, *prev, *p, *res, *name;
> +       char delim = ' ';
> +       int new_argc = 0;
> +       char *new_argv[FUNCTION_MAX_ARGS];
> +       int nest = 0;
> +       int i;
>
>         /*
>          * Returns an empty string because '$()' should be evaluated
> @@ -85,10 +127,73 @@ static char *eval_clause(const char *in)
>         if (!*in)
>                 return xstrdup("");
>
> -       name = expand_string(in);
> +       tmp = xstrdup(in);
> +
> +       prev = p = tmp;
>
> -       res = env_expand(name);
> +       /*
> +        * Split into tokens
> +        * The function name and the first argument are separated by a space.
> +        * Arguments are separated by a comma.
> +        * For example, if the function call is like this:
> +        *   $(foo abc,$(x),$(y))
> +        *
> +        * The input string for this helper should be:
> +        *   foo abc,$(x),$(y)
> +        *
> +        * and split into:
> +        *   new_argv[0]: foo
> +        *   new_argv[1]: abc
> +        *   new_argv[2]: $(x)
> +        *   new_argv[3]: $(y)
> +        */
> +       while (*p) {
> +               if (nest == 0 && *p == delim) {
> +                       *p = 0;
> +                       new_argv[new_argc++] = prev;

Erroring out would be nicer than overflowing the array.

Cheers,
Ulf

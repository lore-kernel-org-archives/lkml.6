Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeEQGi7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:38:59 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33640 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQGi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:38:57 -0400
X-Google-Smtp-Source: AB8JxZpIZ328Q+GnijsFRRgAiXXWLZrXRI9JrtXhShebvclmq+W3QRnknNOFMIr1skzaKqtcznuxhqipBakpuBhs1ao=
MIME-Version: 1.0
In-Reply-To: <1526537830-22606-16-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <1526537830-22606-16-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 23:38:55 -0700
X-Google-Sender-Auth: NwZDLa6DQgPJyFoc8PHjDAS1dUE
Message-ID: <CAGXu5jLPzCYaT199CZTFdy0Fnqrr70q2YrZs5J3NdTBKPHO8AA@mail.gmail.com>
Subject: Re: [PATCH v4 15/31] kconfig: add 'info', 'warning', and 'error'
 built-in functions
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:16 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Add 'info', 'warning', and 'error' functions as in Make.
>
> They print messages during parsing Kconfig files. 'error' will be
> useful to terminate the parsing immediately in fatal cases.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
> Changes in v4:
>   - Add 'error' function
>
> Changes in v3: None
> Changes in v2: None
>
>  scripts/kconfig/preprocess.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
> index 47b32dc..591bcf7 100644
> --- a/scripts/kconfig/preprocess.c
> +++ b/scripts/kconfig/preprocess.c
> @@ -104,6 +104,20 @@ struct function {
>         char *(*func)(int argc, char *argv[], int old_argc, char *old_argv[]);
>  };
>
> +static char *do_error(int argc, char *argv[], int old_argc, char *old_argv[])
> +{
> +       pperror("%s", argv[0]);
> +
> +       return NULL;
> +}
> +
> +static char *do_info(int argc, char *argv[], int old_argc, char *old_argv[])
> +{
> +       printf("%s\n", argv[0]);
> +
> +       return xstrdup("");
> +}
> +
>  static char *do_shell(int argc, char *argv[], int old_argc, char *old_argv[])
>  {
>         FILE *p;
> @@ -144,9 +158,19 @@ static char *do_shell(int argc, char *argv[], int old_argc, char *old_argv[])
>         return xstrdup(buf);
>  }
>
> +static char *do_warning(int argc, char *argv[], int old_argc, char *old_argv[])
> +{
> +       fprintf(stderr, "%s:%d: %s\n", current_file->name, yylineno, argv[0]);
> +
> +       return xstrdup("");
> +}
> +
>  static const struct function function_table[] = {
>         /* Name         MIN     MAX     EXP?    Function */
> +       { "error",      1,      1,      true,   do_error },
> +       { "info",       1,      1,      true,   do_info },
>         { "shell",      1,      1,      true,   do_shell },
> +       { "warning",    1,      1,      true,   do_warning },
>  };
>
>  #define FUNCTION_MAX_ARGS              16
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security

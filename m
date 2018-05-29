Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755135AbeE2H5t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:57:49 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40035 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbeE2H5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:57:44 -0400
X-Google-Smtp-Source: ADUXVKKVrL0+AkA8Tg93sh0Y6GMQ7JDnr7JlTLAAxLkYG4+uVy7Adkzh46bR7TB86zErbK/qorsP9L/LIR2dLjP1fyg=
MIME-Version: 1.0
In-Reply-To: <1527573427-16569-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527573427-16569-1-git-send-email-nick.desaulniers@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 May 2018 09:57:43 +0200
X-Google-Sender-Auth: aLb772PoYN2vCver3A2QEdc7JAw
Message-ID: <CAK8P3a2=THd7YL6sB4=xXZShD=wOjk_taM1L-E5VPH77TiQK0w@mail.gmail.com>
Subject: Re: [PATCH] kdb: prefer strlcpy to strncpy
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 7:57 AM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes stringop-truncation and stringop-overflow warnings from gcc-8.

That patch description should really explain whether gcc is right or not. What's
the worst thing that could happen here?

I would also recommend citing the exact warning you got.

> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index ed5d349..b5dfff1 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -443,7 +443,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>  char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
>  {
>         if (prompt && kdb_prompt_str != prompt)
> -               strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> +               strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>         kdb_printf(kdb_prompt_str);
>         kdb_nextline = 1;       /* Prompt and input resets line number */
>         return kdb_read(buffer, bufsize);
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index e405677..c30a0d8 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1103,12 +1103,12 @@ static int handle_ctrl_cmd(char *cmd)
>         case CTRL_P:
>                 if (cmdptr != cmd_tail)
>                         cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;
> -               strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> +               strlcpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
>                 return 1;
>         case CTRL_N:
>                 if (cmdptr != cmd_head)
>                         cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
> -               strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> +               strlcpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
>                 return 1;
>         }
>         return 0;

Those three all look good.

> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index 990b3cc..dcfbf8f 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -236,7 +236,7 @@ int kallsyms_symbol_next(char *prefix_name, int flag)
>
>         while ((name = kdb_walk_kallsyms(&pos))) {
>                 if (strncmp(name, prefix_name, prefix_len) == 0) {
> -                       strncpy(prefix_name, name, strlen(name)+1);
> +                       strlcpy(prefix_name, name, prefix_len);
>                         return 1;
>                 }

I don't know what this does, but you are changing the behavior: the previous
'strlen(name)+1' argument was the size of the source string (which makes
the strncpy() behave the same as a plain strcpy()), the new one means
we only copy at most as many bytes as the previous length of the destination
string.

Is that intended? If yes, better explain it in the patch description.

        Arnd

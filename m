Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518035320; cv=none;
        d=google.com; s=arc-20160816;
        b=MTlUdTLI3EcD7l10qGZrvH6dDmDuz3G8RwCdgA2dKGoV0jxcyqtnC8oSM8E5gp/OXR
         HBrzM+uLLV2tMzovkk0+GI8FudpnyXk/WlXuzY+F3zmqEvrJKuBz26rkY/K2vzRjSaUO
         xNwb1eUoT1BKeQVmuv2VPoHXLdOncVOWQZpl4N+McTHgjTxQC9PywKHzIf1mHST4WtMo
         s7bBFCTkc7tXI3336wqHXMKNN3waZa3SW/3Cy1TKMLqTrJTG/kiwpz5zOW6V+1DG7flF
         /HmvrFdzRxDzJKBQ70ZRt6Pmq/Q/XRQSzEJXzYMXkKGOFNimAffI+Qc2BlwORvIZZf4M
         bdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Ie3xjJ0QFL1iA7DodXBObAxNp+gbTkJ//1UR/llBguE=;
        b=tEGWJDLuhgDgJ3ausj9Q035x0IHXkwVgzd6fpGWjlQAh03K1A4FujTW85JsT6Cnd/U
         nj+YPDxcweCIRfwmuZwaG4nyYICMANutgJC7qHn0o+0Dx5l7vyjTE6ZbnGKyP+c5vu9E
         FmgEw8DojjivjxVLuKbJUS3YojoK3AZaNoFdJwywIhgeVqNDJamslNOoP3zd+qq+F2Pj
         YxXRwHjcMIP8/1K/YMA2ddo8F/fpWf4zPSoB+G80tt0Kzv08bjyJdptZZNfhq1nttiwH
         CXfKcEAMNjwHUa/yvEu2g08fBSWbtPUn/JUSrhYVBLBs9b+tpbsLZhrzn7cGr2ocPakj
         9HIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AE7TiEts;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AE7TiEts;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227iZiQirGksfzD/jBAZnkXAJPshAy0w4SmYeX1R9rBS4Rz1hWc/HjtJAEYxG/fvNlHsoGJkKaV9awEdJwHu8+o=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-4-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-4-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Wed, 7 Feb 2018 21:28:40 +0100
Message-ID: <CAFkk2KQCP-xwaAaA5D0Mse2YiOYwkSpEYSVMrMR8zSBjgmn60Q@mail.gmail.com>
Subject: Re: [PATCH 03/14] kconfig: show '?' prompt even if no help text is available
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778610656090?=
X-GMAIL-MSGID: =?utf-8?q?1591775405084099344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 'make config', 'make oldconfig', etc. always receive '?' as a valid
> input and show useful information even if no help text is available.
>
> ------------------------>8------------------------
> foo (FOO) [N/y] (NEW) ?
>
> There is no help available for this option.
> Symbol: FOO [=n]
> Type  : bool
> Prompt: foo
>   Defined at Kconfig:1
> ------------------------>8------------------------
>
> However, '?' is not shown in the prompt if its help text is missing.
> Let's show '?' all the time so that the prompt and the behavior match.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/conf.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 90a76aa2..d346642 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -201,9 +201,7 @@ static int conf_sym(struct menu *menu)
>                         printf("/m");
>                 if (oldval != yes && sym_tristate_within_range(sym, yes))
>                         printf("/y");
> -               if (menu_has_help(menu))
> -                       printf("/?");
> -               printf("] ");
> +               printf("/?] ");
>                 if (!conf_askvalue(sym, sym_get_string_value(sym)))
>                         return 0;
>                 strip(line);
> @@ -305,10 +303,7 @@ static int conf_choice(struct menu *menu)
>                         printf("[1]: 1\n");
>                         goto conf_childs;
>                 }
> -               printf("[1-%d", cnt);
> -               if (menu_has_help(menu))
> -                       printf("?");
> -               printf("]: ");
> +               printf("[1-%d?]: ", cnt);
>                 switch (input_mode) {
>                 case oldconfig:
>                 case silentoldconfig:
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

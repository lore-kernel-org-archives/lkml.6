Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518046479; cv=none;
        d=google.com; s=arc-20160816;
        b=wbhLcGw8krE874WMjXSWrgyHV7q+XiPS961Vq1gjPE0fNg09gm74cH9Wq+wsgoe+uv
         mtPQanMfyhb0RdfX9ory0jzqH2Hak1bP3liWEEPOPFKcfpGhjiF0C06GP2JfR6XxsbYW
         dJZQAlX498nsHkciQVPzKTE0X+tm3yogJeYlUK+M/6ulWbsNIykfw3gR1D/ZRvQ0gCCR
         woyo7b6k8NYBVr0TxCL7v+tCP4o+VZ3F02OfgVWyJFGJifNR8j3N9AeXYnSUD/b5jic4
         tq1udr70EbLrpLsWR72NymqRUyTgUOKY/XdOCHtWyFkvUd1zI5plJwd2F5APCJkciFj2
         3sNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mbJqIYFPQk2XIGpnFogq+9Qft1Gq5ze56onms37/DOU=;
        b=SSBPYEXNMnc428EJsKMcGZxroOiYO1SE4Y0QVe9zei1JpGhYBxPqo2dH47WgLjKeWU
         RroC99kOwOCVjgZN4Saszq9NuTQ/KzQP6qn7l4I9QbpgLXeUfndDbzphafMQgaPtRFeB
         jIP18v33E7OBkXOiZ/2teuXMZtMfGoUMYyzZia8P2vu3gZ3nocsvq0EtjSJrQ1uup1dD
         meB5c0JrDjM3L06p+wjrVvvSVTBZjOEVeJOe/cVas+TQpu1uWpp+nLO8N94u3oKbpDHa
         EJut7vzs21uqJiBNoxJ/DIEj3cj8Jw/N42NPkPP5Wa3iP6x6ybK2SadyRkfx5Qx4ZMAh
         Syjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rJY6YKfh;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rJY6YKfh;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227jOvdyRudeL7k13+UPbWIjH7+hEem7NDcHR20z6YQy9HoXCDhMmAvaXJRC4WXNcpRRJau5HKVXXrQfNbohGGM=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-5-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-5-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 00:34:38 +0100
Message-ID: <CAFkk2KSA6L_Ti_rFN9waJWZvntNT6qnvW1bzcbAbfnHpZM_wyw@mail.gmail.com>
Subject: Re: [PATCH 04/14] kconfig: print additional new line for choice for redirection
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778754475982?=
X-GMAIL-MSGID: =?utf-8?q?1591787105624052549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> If stdout is redirected to a file, prompts look differently due to
> missing new lines.
>
> Currently, conf_askvalue() takes care of this by putting additional
> new line, but conf_choice() does not.  Do likewise so that prompts
> after 'choice' look properly.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/conf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index d346642..6ce06c8 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -317,6 +317,8 @@ static int conf_choice(struct menu *menu)
>                 case oldaskconfig:
>                         fflush(stdout);
>                         xfgets(line, sizeof(line), stdin);
> +                       if (!tty_stdio)
> +                               printf("\n");
>                         strip(line);
>                         if (line[0] == '?') {
>                                 print_help(menu);
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Maybe this could be moved into the xfgets() function as well.

Cheers,
Ulf

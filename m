Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518035056; cv=none;
        d=google.com; s=arc-20160816;
        b=oxhqs1U+vzFP5zZ02z3XVmfCn1QF1SLggQlCC114V2LnOzqt8eGJYTJTEFTd1cuKIR
         ZbH/xij/DqRVlS1nAU72u7l/W/hqeZR/FgRRgDY2OKxppSIauJyWP3hF9RiXSeiMzKBe
         maatEAq+LCmI9ZW2RCgthA/p9aY3Pz7ajG+p6Jta14Y2t/2xi9Rwb0TNbiltpot7HO0t
         wkZxKGrIyJvmV862iGcveMf2lIgyTDLoGWjUnR1IT4USo8gsFgTsOBTt/R/0Vbik5trP
         08/jQ/DWF9WyiDs4zFDXQsgXcBb466WCEOzjeQE7zV3WJ9/dn3ztTvIA2nfZQzeGh0Qp
         tmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ZYZEnuldO8sRgeSTYf3ey7n5Kyqc139oEtQzcThpXto=;
        b=JIWGGxPZFoNzSbo2btf08T6F0FjbzJEGwsuwZeqwuBvBk/muOcbY6Fo64Jvpm/eIYo
         tnCl7op99SlEhGdypEMFb7P99MbUMq7lM2t0fqZ0qZTCjCOR11a3DvrDXiTNsbL/4+Wy
         0NpC79Ka6LuXJojemYyZGnf4v2qNngSo0HqIJEm4vcG5FGKo92Ek4eo80/moPAyMdqGE
         PyyW4+VVoIa90HvtL3ucxhN5LK2tkWoVSJtyemF5EOEcf2UFGsiKSaF2GwLFDm2vDGZp
         fiE5ZmxXyQ25Ks1wPySqweumKqCNgNgd8J1OwVF0U10YnqH7SQLq8M2/01/SAXaBcvEc
         a4AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e3Qfcuzr;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e3Qfcuzr;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2267DJwlgGVpx4Bm+nbpHQQgy86AbOyGMpEBCsx7Ta84NUhQfagIZ5gG78hshZym/edodkqfxF1ADsU+QkPwWkA=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-2-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-2-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Wed, 7 Feb 2018 21:24:14 +0100
Message-ID: <CAFkk2KQNQV2GAXW+hyMvE+J5mMp+5g3SuYdcGA-JjGk5fE=VUA@mail.gmail.com>
Subject: Re: [PATCH 01/14] kconfig: send error messages to stderr
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778719993235?=
X-GMAIL-MSGID: =?utf-8?q?1591775127116774350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> These messages should be directed to stderr.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/conf.c  | 18 +++++++++++-------
>  scripts/kconfig/zconf.l | 27 +++++++++++++++------------
>  2 files changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 307bc3f..90a76aa2 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -75,9 +75,11 @@ static void strip(char *str)
>  static void check_stdin(void)
>  {
>         if (!valid_stdin) {
> -               printf(_("aborted!\n\n"));
> -               printf(_("Console input/output is redirected. "));
> -               printf(_("Run 'make oldconfig' to update configuration.\n\n"));
> +               fprintf(stderr,
> +                       _("Aborted!\n"
> +                         "Console input/output is redirected.\n"
> +                         "Run 'make oldconfig' to update configuration.\n\n")
> +                       );

This could use fputs() too, moving the stderr to the last argument.

I think the _() thingies around the strings are for gettext
(https://www.gnu.org/software/gettext/manual/html_node/Mark-Keywords.html).
This would break it if there are existing translations, since the
msgids change.

More practically, I doubt anyone is translating these tools. IMO we
should remove the gettext stuff unless we find traces of translations.

>                 exit(1);
>         }
>  }
> @@ -565,7 +567,7 @@ int main(int ac, char **av)
>                 }
>         }
>         if (ac == optind) {
> -               printf(_("%s: Kconfig file missing\n"), av[0]);
> +               fprintf(stderr, _("%s: Kconfig file missing\n"), av[0]);
>                 conf_usage(progname);
>                 exit(1);
>         }
> @@ -590,9 +592,11 @@ int main(int ac, char **av)
>                 if (!defconfig_file)
>                         defconfig_file = conf_get_default_confname();
>                 if (conf_read(defconfig_file)) {
> -                       printf(_("***\n"
> -                               "*** Can't find default configuration \"%s\"!\n"
> -                               "***\n"), defconfig_file);
> +                       fprintf(stderr,
> +                               _("***\n"
> +                                 "*** Can't find default configuration \"%s\"!\n"
> +                                 "***\n"),
> +                               defconfig_file);
>                         exit(1);
>                 }
>                 break;
> diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
> index 07e074d..0ba4900 100644
> --- a/scripts/kconfig/zconf.l
> +++ b/scripts/kconfig/zconf.l
> @@ -184,7 +184,9 @@ n   [A-Za-z0-9_-]
>                         append_string(yytext, 1);
>         }
>         \n      {
> -               printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
> +               fprintf(stderr,
> +                       "%s:%d:warning: multi-line strings not supported\n",
> +                       zconf_curname(), zconf_lineno());

Whether stuff is translated seems inconsistent too.

>                 current_file->lineno++;
>                 BEGIN(INITIAL);
>                 return T_EOL;
> @@ -294,7 +296,7 @@ void zconf_initscan(const char *name)
>  {
>         yyin = zconf_fopen(name);
>         if (!yyin) {
> -               printf("can't find file %s\n", name);
> +               fprintf(stderr, "can't find file %s\n", name);
>                 exit(1);
>         }
>
> @@ -315,8 +317,8 @@ void zconf_nextfile(const char *name)
>         current_buf->state = YY_CURRENT_BUFFER;
>         yyin = zconf_fopen(file->name);
>         if (!yyin) {
> -               printf("%s:%d: can't open file \"%s\"\n",
> -                   zconf_curname(), zconf_lineno(), file->name);
> +               fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
> +                       zconf_curname(), zconf_lineno(), file->name);
>                 exit(1);
>         }
>         yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
> @@ -325,20 +327,21 @@ void zconf_nextfile(const char *name)
>
>         for (iter = current_file->parent; iter; iter = iter->parent ) {
>                 if (!strcmp(current_file->name,iter->name) ) {
> -                       printf("%s:%d: recursive inclusion detected. "
> -                              "Inclusion path:\n  current file : '%s'\n",
> -                              zconf_curname(), zconf_lineno(),
> -                              zconf_curname());
> +                       fprintf(stderr,
> +                               "%s:%d: recursive inclusion detected. "
> +                               "Inclusion path:\n  current file : '%s'\n",
> +                               zconf_curname(), zconf_lineno(),
> +                               zconf_curname());
>                         iter = current_file->parent;
>                         while (iter && \
>                                strcmp(iter->name,current_file->name)) {
> -                               printf("  included from: '%s:%d'\n",
> -                                      iter->name, iter->lineno-1);
> +                               fprintf(stderr, "  included from: '%s:%d'\n",
> +                                       iter->name, iter->lineno-1);
>                                 iter = iter->parent;
>                         }
>                         if (iter)
> -                               printf("  included from: '%s:%d'\n",
> -                                      iter->name, iter->lineno+1);
> +                               fprintf(stderr, "  included from: '%s:%d'\n",
> +                                       iter->name, iter->lineno+1);
>                         exit(1);
>                 }
>         }
> --
> 2.7.4
>

The unrelated gettext stuff aside:

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Cheers,
Ulf

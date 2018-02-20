Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224Hbi0SPoPgNFDyK9cluW+gCcPDlLNctBKE2LQ3e86iu+OHlFCg6xGFgUme6Sg31JmR3Srx
ARC-Seal: i=1; a=rsa-sha256; t=1519118876; cv=none;
        d=google.com; s=arc-20160816;
        b=P8y/0n5jZiiWohSnm/FngL/MPHPiQIcyZSo56qJjm9MXWBPIaBBTnZwEs/CBcGNiDm
         LJratSz3mQfL3KYCESWZddU5xrr109qBWt35OSWyGsWKdN0JlL5S6urq18tEEwiElAaA
         o2phzjnFaN80Ti6LUZheZNmRsCIjslzrFYb8ugFKLd0nALpgDE/5tPJmVUiPt+0UBcgp
         EB+CBT8+U2slWdrblpoHeov+Gyehw9hNNb6GXxLY+DDlmeBWVaN6tP7AxLZrBXlcRzTN
         d4xaOcPjad6CV9V2rQIYaWdQWUp0RkAy6/ooPwHz/HSqt3dFTXi6dp4AnO1wRK2/MFqb
         6Ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=ohJXzFXTa5vcOBXSIc1lSM6ov1VhF2+9RtcKrnF2Q2Y=;
        b=Efc8OUZIKsHIGoEGoLIBV/XJ6COG2I+MfQi/pOGG/eCMP6hbIgzMWb3J6vuWAeuWC5
         fbenDyOMzbQUm9VTMbgJvl2R4wD9gSrsOBS8oO98BWyZK70KX604ZUmDkut9k4B69pRr
         UL5u+hDF8JMDtpQwt9zfLSIJ+KEIghHqnTzydSPK8QBnI9Z6hLLDkgI3n2TKz158sFuC
         PKCKr90mYGyDOa5UFq121J9m6MKIoZnYaNKOmhALELVZnDpHnt6nKaCOXs6Od7Rm/6nq
         gy8rPlj3EHrphDfA+5dC7LljYB/I5CSa6wgHF1bc6pk5maQL34YKgEtgcxod5y51NwVE
         r98g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=zBy92drm;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=zBy92drm;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w1K9RaQ7006852
X-Nifty-SrcIP: [209.85.213.49]
MIME-Version: 1.0
In-Reply-To: <20180216214117.1947175-3-arnd@arndb.de>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-3-arnd@arndb.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 20 Feb 2018 18:26:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com>
Message-ID: <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com>
Subject: Re: [PATCH 2/3] Kconfig: improve handling for all{rand,yes,no,}.config
 fragments
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E. MORIN" <yann.morin.1998@free.fr>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595410017482900?=
X-GMAIL-MSGID: =?utf-8?q?1592911594576037859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> The kernel currently supports two methods of dealing with config
> fragments in the tree:
>
> a) Running "make foo.config" looks for arch/$(ARCH)/configs/foo.config
>    and kernel/configs/foo.config, and applies the defaults from those
>    files on top of the current configuration.
>
> b) Running "KCONFIG_ALLCONFIG=1 make randconfig" (or the equivalent
>    allmodconfig/allnoconfig/allyesconfig/alldefconfig) will look
>    for a "allrandconfig.config" file in the current directory or the
>    top of the $(srctree). These are used as defaults before we generate
>    the remaining options.
>
> This is rather inconsistent, and prevents us from easily shipping
> good defaults for "randconfig". I'm extending the logic here so that
> the second case also looks for the hardcoded file names in the standard
> directories (first arch/$(ARCH)/configs/, then kernel/configs) in the
> source tree.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/kconfig/conf.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 866369f10ff8..848bf4d15e9a 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -493,8 +493,9 @@ int main(int ac, char **av)
>  {
>         const char *progname = av[0];
>         int opt;
> -       const char *name, *defconfig_file = NULL /* gcc uninit */;
> +       const char *arch, *name, *defconfig_file = NULL /* gcc uninit */;
>         struct stat tmpstat;
> +       char fullname[PATH_MAX+1];
>
>         setlocale(LC_ALL, "");
>         bindtextdomain(PACKAGE, LOCALEDIR);
> @@ -621,14 +622,24 @@ int main(int ac, char **av)
>                 case randconfig:        name = "allrandom.config"; break;
>                 default: break;
>                 }
> -               if (conf_read_simple(name, S_DEF_USER) &&
> -                   conf_read_simple("all.config", S_DEF_USER)) {
> -                       fprintf(stderr,
> -                               _("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
> -                               name);
> -                       exit(1);
> +               /* try ./name, arch/$(ARCH)/configs/name and kernel/config/name */
> +               if (!conf_read_simple(name, S_DEF_USER))
> +                       break;
> +               arch = getenv("ARCH");
> +               if (arch) {
> +                       snprintf(fullname, sizeof(fullname), "arch/%s/configs/%s",
> +                                arch, name);
> +                       if (!conf_read_simple(fullname, S_DEF_USER))
> +                               break;
>                 }


I am not a big fan of hard-coding the kernel directory structure.

We already do this [1], but I am thinking of kicking this out.
[1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/confdata.c#L33



BTW, I am trying to compiler capability check to Kconfig.
If this work is done, I hope some "depends on !COMPILE_TEST" will go
away (but not all?)
https://patchwork.kernel.org/patch/10225375/



> -               break;
> +               snprintf(fullname, sizeof(fullname), "kernel/configs/%s", name);
> +               if (!conf_read_simple(fullname, S_DEF_USER))
> +                       break;
> +
> +               fprintf(stderr,
> +                       _("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
> +                               name);
> +               exit(1);
>         default:
>                 break;
>         }
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

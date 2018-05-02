Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEBO5B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:57:01 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:61453 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeEBO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:56:49 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w42EuZqW027220
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AB8JxZqB7yHnr7jiOeIdbFDFUeo0TmxapOLr0ccONkMfghif02+fUp+OR/m97ZSiAdRpz9GENMhzAr0FsH21oMzgDvI=
MIME-Version: 1.0
In-Reply-To: <20180322210525.25361-2-linux@rasmusvillemoes.dk>
References: <20180322150005.15061-2-linux@rasmusvillemoes.dk>
 <20180322210525.25361-1-linux@rasmusvillemoes.dk> <20180322210525.25361-2-linux@rasmusvillemoes.dk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 2 May 2018 23:55:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqWht6gMitprEY-LPKpbPj5gQN=3yiLSH19BeOdiexTA@mail.gmail.com>
Message-ID: <CAK7LNAQqWht6gMitprEY-LPKpbPj5gQN=3yiLSH19BeOdiexTA@mail.gmail.com>
Subject: Re: [RFC resend 2/2] modpost: sumversions: try to fix "same dir" logic
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-03-23 6:05 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
> The current logic for deciding whether to parse a file listed in the
> .o.cmd file matches neither "is in same dir" (implied by the comment
> here), nor the "/* Sum all files in the same dir or subdirs. */" a
> little higher up. For example, for an object file in the top-level
> crypto/ directory, we end up also parsing anything it includes from
> include/crypto/ (though not subdirectories of that) and
> arch/x86/include/asm/crypto/. On the other hand, we never parse anything
> included from subdirectories of the object file's directory, contrary to
> at least one of the comments.
>
> This tries to fix things so that we actually implement "parse stuff
> found in $(dirname $objfile) and below" by simply checking whether line
> begins with dir. It doesn't quite work, though, because there are some
>
> #include "../blabla"
>
> directives, e.g. in drivers/scsi/libsas/ we have #include
> "../scsi_sas_internal.h", and gcc doesn't normalize the path before
> printing it, so we have
>
> drivers/scsi/libsas/../scsi_sas_internal.h
>
> in the .o.cmd file. But perhaps that's actually a good thing - then the
> logic would be something like "if gcc found the included file using . as
> starting point, we include it - otherwise it was found via some -I path,
> so do not include it".
>
> In any case, this is mostly just something I stumbled on because I'm
> about to change the .o.cmd layout slightly, so I'd like to know what the
> rules are really supposed to be.


I have no idea about this.

Rusty Russell was CCed.  He may say something about this.

(I attached the log of the initial commit of sumversion.c below)




> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Resending because I didn't reach any current kbuild maintainers nor
> the kbuild mailing list.


It is true this patch fixes the crypto/ case,
but it breaks out-of-tree building.


>  scripts/mod/sumversion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
> index 0f6dcb4011a8..e4f83fb9da2f 100644
> --- a/scripts/mod/sumversion.c
> +++ b/scripts/mod/sumversion.c
> @@ -368,7 +368,7 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
>                 }
>
>                 /* Check if this file is in same dir as objfile */
> -               if ((strstr(line, dir)+strlen(dir)-1) == strrchr(line, '/')) {
> +               if (strncmp(line, dir, dirlen) == 0) {
>                         if (!parse_file(line, md)) {
>                                 warn("could not open %s: %s\n",
>                                      line, strerror(errno));
> --

If the kernel is built out-of-tree with O= option,
"strncmp(line, dir, dirlen) == 0" is always false.




sumversion.c was added in pre-git era.

The commit log is below:




    [PATCH] Add a MODULE_VERSION macro

    From: Rusty Russell <rusty@au1.ibm.com>

    The way it works is that the .mod file contains the name of the module (as
    before), but succeeding lines are the constituent parts (assumed to be .c
    files, which usually works: if they use MODULE_VERSION in a file for which
    this isn't true we'll get a warning).

    As we postprocess modules, we look in the .modinfo section for a
    "version=", which is placed by the MODULE_VERSION() macro.  This will be of
    form "version=<macroarg>" "\0" [24 chars] "\0".  The 24 chars are replaced
    by the md4 sum of the .c files and any files they #include using '#include
    "file"' which are found in the current directory.  Whitespace is collapsed
    outside strings, and comments are ignored for purposes of the sum.

    The result is a .modinfo entry such as

        version=1.16ac-rustytest B13E9451C4CA3B89577DEFF



    At the kernel summit, various people asked for a MODULE_VERSION macro to
    store module strings (for later access through sysfs).  A simple md4 is
    needed to identify changes in modules which, inevitably, do not update the
    version.  It skips whitespace and comments, and includes #includes which
    are in the same dir.

    The module versions should be set according to this definition, based on
    the RPM one, or CVS Revision tags.  Violators will be shot.

     [<epoch>`:']<version>[`-'<extraversion>]
     <epoch>: A (small) unsigned integer which allows you to start versions
              anew. If not mentioned, it's zero.  eg. "2:1.0" is after
         "1:2.0".
     <version>: The <version> may contain only alphanumerics.
     <extraversion>: Like <version>, but inserted for local
              customizations, eg "rh3" or "rusty1".

    Comparison of two versions (assuming same epoch):

    Split each into all-digit and all-alphabetical parts.  Compare each one one
    at a time: digit parts numerically, alphabetical in ASCII order.  So 0.10
    comes after 0.9.






-- 
Best Regards
Masahiro Yamada

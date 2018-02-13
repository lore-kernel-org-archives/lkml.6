Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933415AbeBMDAx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 22:00:53 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:55638 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933393AbeBMDAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 22:00:51 -0500
X-Google-Smtp-Source: AH8x224NF9LoXYyy/nj3j2gYniIaFMcCvXpTFnz7Cf8PRo7CSd9V+Xmk3GFX1ifQMx1SzovSy36n9A==
Subject: Re: Linux 4.16-rc1: regression bisected, Debian kernel package tool
 make-kpkg stalls indefinitely during kernel build due to commit "kconfig:
 remove check_stdin()"
To: Sander Eikelenboom <linux@eikelenboom.it>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>
Cc: srivasta@debian.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <b7f71558-0e57-cacb-280c-a9d3baa030b2@eikelenboom.it>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <9d122a3c-b1fe-a9f8-17db-c38f42fdc4b1@gmail.com>
Date: Mon, 12 Feb 2018 22:00:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.1
MIME-Version: 1.0
In-Reply-To: <b7f71558-0e57-cacb-280c-a9d3baa030b2@eikelenboom.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sander Eikelenboom wrote:
> L.S.,
>
> The Debian kernel-package tool make-kpkg for easy building of upstream kernels on Debian fails with linux 4.16-rc1.
>
> The tool (perl script) while invoked with:
>      make-kpkg --initrd --append_to_version -20180212 kernel_image
>
> On a git tree with a .config from the previous kernel release, so new KConfig questions have to be asked on new or changed options.
>
> The script stalls indefinitely while it seems to be excuting:
>      exec make kpkg_version=13.018+nmu1 -f /usr/share/kernel-package/ruleset/minimal.mk debian APPEND_TO_VERSION=-t440s-20180212  INITRD=YES
>
> After using ctrl-c to break out it, i get:
>     ^CFailed to create a ./debian directory: No such file or directory at /usr/bin/make-kpkg line 970.
>   
>
> Bisection turned up as culprit:
>      commit d2a04648a5dbc3d1d043b35257364f0197d4d868
>      kconfig: remove check_stdin()
>      
>      Except silentoldconfig, valid_stdin is 1, so check_stdin() is no-op.
>      
>      oldconfig and silentoldconfig work almost in the same way except that
>      the latter generates additional files under include/.  Both ask users
>      for input for new symbols.
>      
>      I do not know why only silentoldconfig requires stdio be tty.
>      
>        $ rm -f .config; touch .config
>        $ yes "" | make oldconfig > stdout
>        $ rm -f .config; touch .config
>        $ yes "" | make silentoldconfig > stdout
>        make[1]: *** [silentoldconfig] Error 1
>        make: *** [silentoldconfig] Error 2
>        $ tail -n 4 stdout
>        Console input/output is redirected. Run 'make oldconfig' to update configuration.
>      
>        scripts/kconfig/Makefile:40: recipe for target 'silentoldconfig' failed
>        Makefile:507: recipe for target 'silentoldconfig' failed
>      
>      Redirection is useful, for example, for testing where we want to give
>      particular key inputs from a test file, then check the result.
>      
>      Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>      Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> Reverting this specific commit makes make-kpkg work again as usual.
>
> Version of the kernel-package used:
> ii  kernel-package                                              13.018+nmu1
>
>
> I also cc'ed the Debian developer who maintains the kernel-package package: Manoj Srivastava
>
> --
> Sander
>
I have noticed today the same - the kernel-build blockage was in (as I 
recall)
srcipts/kconfig/conf -s --silentoldconfig Kbuild

I have bypassed it by regenerating the .config "by hand"...

Woody

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeBSOWA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:22:00 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:51372 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750978AbeBSOV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:21:59 -0500
Subject: Re: Linux 4.16-rc1: regression bisected, Debian kernel package tool
 make-kpkg stalls indefinitely during kernel build due to commit "kconfig:
 remove check_stdin()"
To: Sander Eikelenboom <linux@eikelenboom.it>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>
Cc: srivasta@debian.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <b7f71558-0e57-cacb-280c-a9d3baa030b2@eikelenboom.it>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <55ef3f98-61e3-69e9-4b65-a80efd1998ac@leemhuis.info>
Date: Mon, 19 Feb 2018 14:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b7f71558-0e57-cacb-280c-a9d3baa030b2@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1519050119;48089a85;
X-HE-SMSGID: 1enlkk-0007wk-3D
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFYI: This issues is tracked in the regression reports for Linux 4.16
(http://bit.ly/lnxregrep416 ) with this id:

Linux-Regression-ID: lr#2fd778

Please include this line in the comment section of patches that are
supposed to fix the issue. Please also mention the string once in other
mailinglist threads or different bug tracking entries if you or someone
else start to discuss the issue there. By including that string you make
it a whole lot easier to track where an issue gets discussed and how far
patches to fix it have made it. For more details on this please see
here: http://bit.ly/lnxregtrackid

Thx for your help. Ciao, Thorsten

On 12.02.2018 20:01, Sander Eikelenboom wrote:
> L.S.,
> 
> The Debian kernel-package tool make-kpkg for easy building of upstream kernels on Debian fails with linux 4.16-rc1.
> 
> The tool (perl script) while invoked with:
>     make-kpkg --initrd --append_to_version -20180212 kernel_image
> 
> On a git tree with a .config from the previous kernel release, so new KConfig questions have to be asked on new or changed options.
> 
> The script stalls indefinitely while it seems to be excuting:
>     exec make kpkg_version=13.018+nmu1 -f /usr/share/kernel-package/ruleset/minimal.mk debian APPEND_TO_VERSION=-t440s-20180212  INITRD=YES
> 
> After using ctrl-c to break out it, i get:
>    ^CFailed to create a ./debian directory: No such file or directory at /usr/bin/make-kpkg line 970.
>  
> 
> Bisection turned up as culprit:
>     commit d2a04648a5dbc3d1d043b35257364f0197d4d868
>     kconfig: remove check_stdin()
>     
>     Except silentoldconfig, valid_stdin is 1, so check_stdin() is no-op.
>     
>     oldconfig and silentoldconfig work almost in the same way except that
>     the latter generates additional files under include/.  Both ask users
>     for input for new symbols.
>     
>     I do not know why only silentoldconfig requires stdio be tty.
>     
>       $ rm -f .config; touch .config
>       $ yes "" | make oldconfig > stdout
>       $ rm -f .config; touch .config
>       $ yes "" | make silentoldconfig > stdout
>       make[1]: *** [silentoldconfig] Error 1
>       make: *** [silentoldconfig] Error 2
>       $ tail -n 4 stdout
>       Console input/output is redirected. Run 'make oldconfig' to update configuration.
>     
>       scripts/kconfig/Makefile:40: recipe for target 'silentoldconfig' failed
>       Makefile:507: recipe for target 'silentoldconfig' failed
>     
>     Redirection is useful, for example, for testing where we want to give
>     particular key inputs from a test file, then check the result.
>     
>     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>     Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
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
> 
> http://news.gmane.org/find-root.php?message_id=b7f71558-0e57-cacb-280c-a9d3baa030b2%40eikelenboom.it 
> http://mid.gmane.org/b7f71558-0e57-cacb-280c-a9d3baa030b2%40eikelenboom.it
> 

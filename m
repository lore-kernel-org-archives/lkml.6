Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935189AbeBMMfQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:35:16 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:45021 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935020AbeBMMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:35:14 -0500
X-Google-Smtp-Source: AH8x2259IPHwtNZBQe2Iqp7DiHDDLtCeVW110bBTiqlnskfCQsTzPSGNwuAFyZlMco3qyNpYy76cBQ==
Date: Tue, 13 Feb 2018 13:35:10 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Woody Suwalski <terraluna977@gmail.com>, srivasta@debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.16-rc1: regression bisected, Debian kernel package tool
 make-kpkg stalls indefinitely during kernel build due to commit "kconfig:
 remove check_stdin()"
Message-ID: <20180213123510.hkbblka6xkosxi36@huvuddator>
References: <b7f71558-0e57-cacb-280c-a9d3baa030b2@eikelenboom.it>
 <9d122a3c-b1fe-a9f8-17db-c38f42fdc4b1@gmail.com>
 <CAK7LNAQRZ6F92s5QotKHoapAG+9BqxaUqmGSeKJRYOuu5izauQ@mail.gmail.com>
 <27f3817b-0c92-5f92-e079-078a8b92eab4@eikelenboom.it>
 <20180213113324.gm6sv37g72gs3qrc@huvuddator>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213113324.gm6sv37g72gs3qrc@huvuddator>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 12:33:24PM +0100, Ulf Magnusson wrote:
> On Tue, Feb 13, 2018 at 11:00:49AM +0100, Sander Eikelenboom wrote:
> > On 13/02/18 05:09, Masahiro Yamada wrote:
> > > 2018-02-13 12:00 GMT+09:00 Woody Suwalski <terraluna977@gmail.com>:
> > >> Sander Eikelenboom wrote:
> > >>>
> > >>> L.S.,
> > >>>
> > >>> The Debian kernel-package tool make-kpkg for easy building of upstream
> > >>> kernels on Debian fails with linux 4.16-rc1.
> > >>>
> > >>> The tool (perl script) while invoked with:
> > >>>      make-kpkg --initrd --append_to_version -20180212 kernel_image
> > >>>
> > >>> On a git tree with a .config from the previous kernel release, so new
> > >>> KConfig questions have to be asked on new or changed options.
> > >>>
> > >>> The script stalls indefinitely while it seems to be excuting:
> > >>>      exec make kpkg_version=13.018+nmu1 -f
> > >>> /usr/share/kernel-package/ruleset/minimal.mk debian
> > >>> APPEND_TO_VERSION=-t440s-20180212  INITRD=YES
> > >>>
> > >>> After using ctrl-c to break out it, i get:
> > >>>     ^CFailed to create a ./debian directory: No such file or directory at
> > >>> /usr/bin/make-kpkg line 970.
> > >>>
> > >>> Bisection turned up as culprit:
> > >>>      commit d2a04648a5dbc3d1d043b35257364f0197d4d868
> > >>>      kconfig: remove check_stdin()
> > >>>           Except silentoldconfig, valid_stdin is 1, so check_stdin() is
> > >>> no-op.
> > >>>           oldconfig and silentoldconfig work almost in the same way except
> > >>> that
> > >>>      the latter generates additional files under include/.  Both ask users
> > >>>      for input for new symbols.
> > >>>           I do not know why only silentoldconfig requires stdio be tty.
> > >>>             $ rm -f .config; touch .config
> > >>>        $ yes "" | make oldconfig > stdout
> > >>>        $ rm -f .config; touch .config
> > >>>        $ yes "" | make silentoldconfig > stdout
> > >>>        make[1]: *** [silentoldconfig] Error 1
> > >>>        make: *** [silentoldconfig] Error 2
> > >>>        $ tail -n 4 stdout
> > >>>        Console input/output is redirected. Run 'make oldconfig' to update
> > >>> configuration.
> > >>>             scripts/kconfig/Makefile:40: recipe for target
> > >>> 'silentoldconfig' failed
> > >>>        Makefile:507: recipe for target 'silentoldconfig' failed
> > >>>           Redirection is useful, for example, for testing where we want to
> > >>> give
> > >>>      particular key inputs from a test file, then check the result.
> > >>>           Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > >>>      Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
> > >>>
> > >>> Reverting this specific commit makes make-kpkg work again as usual.
> > >>>
> > >>> Version of the kernel-package used:
> > >>> ii  kernel-package
> > >>> 13.018+nmu1
> > >>>
> > >>>
> > >>> I also cc'ed the Debian developer who maintains the kernel-package
> > >>> package: Manoj Srivastava
> > >>>
> > >>> --
> > >>> Sander
> > >>>
> > >> I have noticed today the same - the kernel-build blockage was in (as I
> > >> recall)
> > >> srcipts/kconfig/conf -s --silentoldconfig Kbuild
> > >>
> > >> I have bypassed it by regenerating the .config "by hand"...
> > > 
> > > 
> > > silentoldconfig asks you values for new symbols.
> > > So, you must answer questions to proceed.
> > 
> > I know, but it stalls before asking the questions.
> >  
> > > 
> > > How does 'make-kpkg' handle silentoldconfig?
> > > 
> > > Re-direct stdio, then make it forcibly fail?
> > 
> > I don't know, it is a bunch of perl and shell scripts that gets invoked, not the most easy to comprehend if you are not familiar with them. I'm just a user of the tool.
> > 
> > So i would have to defer that question to the Debian package maintainer, hopefully he will chime in.
> > 
> > --
> > Sander
> > 
> > > 
> > > 
> > > 
> > 
> 
> Hello,
> 
> What the commit does is to make silentoldconfig not immediately exit(1)
> when both of the following apply:
> 
>     1. stdin is from something that's not a terminal
> 
>     2. New symbols are prompted for
> 
> All the outputs (.config and the include/generated/ and include/config/
> trees) are generated after the point where silentoldconfig would
> previously exit(1), afaics, so the effects of the commit can be
> summarized as follows:
> 
>     * If no new symbols appear (that would be prompted for), the
>       behavior is exactly the same as before.
>       
>       (check_stdin() never seems to get called unless a value would
>       actually be prompted for, which makes sense.)
> 
>     * If new symbols appear and stdin is a tty, the behavior is also
>       exactly the same as before.
> 
> And finally, the only case where the behavior differs:
> 
>     * If new symbols appear and stdin is not a tty, the
>       new behavior is to prompt (to expect e.g. "n"/"m"/"y" from
>       wherever stdin is coming from).
> 
>       The old behavior was to exit(1) without generating any output
>       files.
> 
> Hopefully that clarifies it.
> 
> The intent of the commit was just to clean up the code a bit, since
> there doesn't seem to be a good reason to bail just because stdin
> happens to not be a tty (plus it's inconsistent with the way oldconfig
> works, which never bailed).
> 
> silentoldconfig is something of an internal implementation detail at
> this point by the way. It's basically oldconfig + generate the
> configuration stuff in include/generated/ and include/config/ that
> actually gets used during the build. Normally it's called automatically
> as needed when building the kernel.
> 
> See https://www.spinics.net/lists/kernel/msg2720574.html for some more
> details re. silentoldconfig.
> 
> Cheers,
> Ulf

By the way: If you can figure out a reason for why that stdin check was
there before while looking into the Debian tool, then please tell us. 

The problem with uncommented mystery code like that is that it easily
looks pointless and is at risk of getting changed or removed, even if
there was a good reason for it (which I still suspect there wasn't
though).

</soapbox>

Cheers,
Ulf

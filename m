Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbeBMEKI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 23:10:08 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:61233 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeBMEKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 23:10:06 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w1D4A2jx028406
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AH8x224kkM0YcRDyOXvnLi04e5BJSMjZNs2ODsp1JK9oEQm23Us5P/DRXseKGWJTRWs0uoAVNUjyVEIC1jTOltAk6kg=
MIME-Version: 1.0
In-Reply-To: <9d122a3c-b1fe-a9f8-17db-c38f42fdc4b1@gmail.com>
References: <b7f71558-0e57-cacb-280c-a9d3baa030b2@eikelenboom.it> <9d122a3c-b1fe-a9f8-17db-c38f42fdc4b1@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Feb 2018 13:09:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRZ6F92s5QotKHoapAG+9BqxaUqmGSeKJRYOuu5izauQ@mail.gmail.com>
Message-ID: <CAK7LNAQRZ6F92s5QotKHoapAG+9BqxaUqmGSeKJRYOuu5izauQ@mail.gmail.com>
Subject: Re: Linux 4.16-rc1: regression bisected, Debian kernel package tool
 make-kpkg stalls indefinitely during kernel build due to commit "kconfig:
 remove check_stdin()"
To: Woody Suwalski <terraluna977@gmail.com>
Cc: Sander Eikelenboom <linux@eikelenboom.it>,
        Ulf Magnusson <ulfalizer@gmail.com>, srivasta@debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-13 12:00 GMT+09:00 Woody Suwalski <terraluna977@gmail.com>:
> Sander Eikelenboom wrote:
>>
>> L.S.,
>>
>> The Debian kernel-package tool make-kpkg for easy building of upstream
>> kernels on Debian fails with linux 4.16-rc1.
>>
>> The tool (perl script) while invoked with:
>>      make-kpkg --initrd --append_to_version -20180212 kernel_image
>>
>> On a git tree with a .config from the previous kernel release, so new
>> KConfig questions have to be asked on new or changed options.
>>
>> The script stalls indefinitely while it seems to be excuting:
>>      exec make kpkg_version=13.018+nmu1 -f
>> /usr/share/kernel-package/ruleset/minimal.mk debian
>> APPEND_TO_VERSION=-t440s-20180212  INITRD=YES
>>
>> After using ctrl-c to break out it, i get:
>>     ^CFailed to create a ./debian directory: No such file or directory at
>> /usr/bin/make-kpkg line 970.
>>
>> Bisection turned up as culprit:
>>      commit d2a04648a5dbc3d1d043b35257364f0197d4d868
>>      kconfig: remove check_stdin()
>>           Except silentoldconfig, valid_stdin is 1, so check_stdin() is
>> no-op.
>>           oldconfig and silentoldconfig work almost in the same way except
>> that
>>      the latter generates additional files under include/.  Both ask users
>>      for input for new symbols.
>>           I do not know why only silentoldconfig requires stdio be tty.
>>             $ rm -f .config; touch .config
>>        $ yes "" | make oldconfig > stdout
>>        $ rm -f .config; touch .config
>>        $ yes "" | make silentoldconfig > stdout
>>        make[1]: *** [silentoldconfig] Error 1
>>        make: *** [silentoldconfig] Error 2
>>        $ tail -n 4 stdout
>>        Console input/output is redirected. Run 'make oldconfig' to update
>> configuration.
>>             scripts/kconfig/Makefile:40: recipe for target
>> 'silentoldconfig' failed
>>        Makefile:507: recipe for target 'silentoldconfig' failed
>>           Redirection is useful, for example, for testing where we want to
>> give
>>      particular key inputs from a test file, then check the result.
>>           Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>      Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>>
>> Reverting this specific commit makes make-kpkg work again as usual.
>>
>> Version of the kernel-package used:
>> ii  kernel-package
>> 13.018+nmu1
>>
>>
>> I also cc'ed the Debian developer who maintains the kernel-package
>> package: Manoj Srivastava
>>
>> --
>> Sander
>>
> I have noticed today the same - the kernel-build blockage was in (as I
> recall)
> srcipts/kconfig/conf -s --silentoldconfig Kbuild
>
> I have bypassed it by regenerating the .config "by hand"...


silentoldconfig asks you values for new symbols.
So, you must answer questions to proceed.


How does 'make-kpkg' handle silentoldconfig?

Re-direct stdio, then make it forcibly fail?



-- 
Best Regards
Masahiro Yamada

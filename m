Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeDMN4y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:56:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:19890 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753884AbeDMN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:56:53 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w3DDuelj011408
X-Nifty-SrcIP: [209.85.213.42]
X-Google-Smtp-Source: AIpwx49Q29X+u0agopv0Apf9tmgehELxeKHM8WqA/b9Rspw6ShSniaH8zW7zQr237EH2MnlkdHps0eZYU5/GX6eL5ws=
MIME-Version: 1.0
In-Reply-To: <CAK7LNASrWiJZ0qOvjut5BxRXahgQZ7gjpF1WRvCGxvF2Qq74PA@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5jJJ+kUZ7ETEDB4hmUUMjFa2A6+vbPkm+0f-S1zZ=ZYT3g@mail.gmail.com> <CAK7LNASrWiJZ0qOvjut5BxRXahgQZ7gjpF1WRvCGxvF2Qq74PA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 13 Apr 2018 22:55:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxCvBnntT-X5o_NNiv2wYga=pBQnYeni7D+5V4CGaHNw@mail.gmail.com>
Message-ID: <CAK7LNAQxCvBnntT-X5o_NNiv2wYga=pBQnYeni7D+5V4CGaHNw@mail.gmail.com>
Subject: Re: [PATCH 00/30] kconfig: move compiler capability tests to Kconfig
To: linux-kbuild <linux-kbuild@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-13 21:21 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-04-13 14:52 GMT+09:00 Kees Cook <keescook@chromium.org>:
>> On Thu, Apr 12, 2018 at 10:06 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> [Major Changes in V3]
>>
>> Awesome work! I don't see this pushed to your git tree? I'd like to
>> test it, but I'd rather "git fetch" instead of "git am" :)
>>
>> -Kees
>>
>
> I pushed this series to the following branch.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kconfig-shell-v3
>


If this approach is successful, we will move more and more
compiler option tests to the Kconfig stage in the future.

People (including me) might be worried about
how slow Kconfig will become.



First, I compared the before/after on my PC.


Without this series,

masahiro@grover:~/workspace/linux-kbuild$ time make -s defconfig

real 0m0.175s
user 0m0.128s
sys 0m0.008s



With this series,
masahiro@grover:~/workspace/linux-kbuild$ time make -s defconfig

real 0m0.729s
user 0m0.400s
sys 0m0.056s


This is noticeable difference.


Then, I looked into per-commit analysis.

Here is the result of the real time of 'time make -s defconfig'

[30/30] kbuild: test dead code/data elimination...     0m0.719s
[29/30] arm64: move GCC version check for...           0m0.711s
[28/30] gcc-plugins: allow to enable GCC_PLUGINS...    0m0.722s
[27/30] gcc-plugins: test plugin support in...         0m0.719s   [+0.31]
[26/30] gcc-plugins: move GCC version check...         0m0.410s
[25/30] kcov: test compiler capability in...           0m0.392s
[24/30] gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT     0m0.400s
[23/30] kconfig: add CC_IS_CLANG and CLANG_VERSION     0m0.396s
[22/30] kconfig: add CC_IS_GCC and GCC_VERSION         0m0.392s
[21/30] stack-protector: test compiler capability...   0m0.381s   [+0.04]
[20/30] kconfig: add basic helper macros to...         0m0.343s
[19/30] kconfig: show compiler version text...         0m0.345s
[18/30] kconfig: test: test text expansion...          0m0.342s
[17/30] Documentation: kconfig: document...            0m0.344s
[16/30] kconfig: add 'info' and 'warning'...           0m0.347s
[15/30] kconfig: expand lefthand side of...            0m0.340s
[14/30] kconfig: support append assignment...          0m0.342s
[13/30] kconfig: support simply expanded...            0m0.341s
[12/30] kconfig: support variable and...               0m0.344s
[11/30] kconfig: begin PARAM state only...             0m0.342s
[10/30] kconfig: replace $(UNAME_RELEASE)...           0m0.347s
[09/30] kconfig: add 'shell' built-in function         0m0.344s
[08/30] kconfig: add built-in function support         0m0.350s
[07/30] kconfig: remove sym_expand_string_value()      0m0.344s
[06/30] kconfig: remove string expansion...            0m0.349s
[05/30] kconfig: remove string expansion...            0m0.342s
[04/30] kconfig: reference environment...              0m0.342s
[03/30] kbuild: remove CONFIG_CROSS_COMPILE...         0m0.347s
[02/30] kbuild: remove kbuild cache                    0m0.347s  [+0.17]
[01/30] gcc-plugins: fix build condition...            0m0.171s
[00/30] Merge tag 'drm-fixes-for-v4.17-rc1'...         0m0.176s


There are three big jump points.

The first one is [02/30]  (+0.17)
We are removing the build cache, so this is what we expect.


The second one is  [21/30]  (+0.04)
For x86, Kconfig runs scripts/gcc-x86_{32,64}-has-stack-protector.sh


The biggest one is [27/30]  (+0.31)
scripts/gcc-plugins.sh is probably very costly script.
If we bump the minimum gcc version to GCC 4.8
the script will be much cleaner in the future.


I was also interested in the cost of
a single $(cc-option ...) invocation.

It is pretty easy to measure this.


For example, copy $(cc-option -fstack-protector)
1000 lines like follows.

config FOO
       bool
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
       default $(cc-option -fstack-protector)
         ...  [ repeat 1000 line ]



On my core i7 PC, it took 7.2 msec
to run $(cc-option -fstack-protector) 1000 times.


We can make it much faster.

Currently we use
   $(CC) -Werror $(1) -c -x c /dev/null
to test the compiler flag.


Ulf Magnusson suggested to use -S instead of -c
(https://patchwork.kernel.org/patch/10309297/)
With -S, the compiler stops after the compilation stage.
It took only 4.0 msec
to run $(cc-option -fstack-protector) 1000 times


If I use -E  (only pre-process stage), it becomes even faster.
It took only 2.6 msec.


As for $(cc-option ...), probably this will not be a problem.

For some feature, we need special shell-scripts,
some of which can be more costly.




-- 
Best Regards
Masahiro Yamada

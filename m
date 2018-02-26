Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeBZCNx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:13:53 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31992 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeBZCNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:13:49 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1Q2DfnA025761
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AG47ELtRLpm/ixmQyCsQyZB1RxqKQGxURQ+dlec/+B1E+9i5phOL0xrn1jMC5rnPsEnKIvnwq6xTr5bNmTHL4cKQeUM=
MIME-Version: 1.0
In-Reply-To: <201802241211.z062884N%fengguang.wu@intel.com>
References: <1519301715-31798-6-git-send-email-yamada.masahiro@socionext.com> <201802241211.z062884N%fengguang.wu@intel.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 26 Feb 2018 11:13:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMEM5uVzHd78wPN1EdKp+k6UbA8-J=xo+_VZ1uhwy-LQ@mail.gmail.com>
Message-ID: <CAK7LNAQMEM5uVzHd78wPN1EdKp+k6UbA8-J=xo+_VZ1uhwy-LQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] linux/const.h: move BIT(_ULL) to linux/const.h for
 use in assembly
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi test robot,


2018-02-24 14:00 GMT+09:00 kbuild test robot <lkp@intel.com>:
> Hi Masahiro,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.16-rc2 next-20180223]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/linux-const-h-cleanups-of-macros-such-as-UL-_BITUL-BIT-etc/20180224-110702
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386


I think this is a false positive report
because I see the same warning in the mainline.


The cause of the problem is
  #define BNXT_RE_MAX_MR_SIZE_HIGH    BIT(39)
in drivers/infiniband/hw/bnxt_re/bnxt_re.h


This causes -Wshift-count-overflow warning
if you compile test it on 32 bit arches.


I did not change the BIT() definition,
so this is not my fault.



> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/const.h:4:0,
>                     from include/linux/bitops.h:4,
>                     from include/linux/kernel.h:11,
>                     from include/linux/interrupt.h:6,
>                     from drivers/infiniband/hw/bnxt_re/ib_verbs.c:39:
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_query_device':
>>> include/uapi/linux/const.h:28:27: warning: left shift count >= width of type [-Wshift-count-overflow]
>     #define _BITUL(x) (_UL(1) << (x))
>                               ^
>>> include/linux/const.h:9:18: note: in expansion of macro '_BITUL'
>     #define BIT(x)  (_BITUL(x))
>                      ^~~~~~
>    drivers/infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
>     #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
>                                      ^~~
>    drivers/infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
>     #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c:149:25: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
>      ib_attr->max_mr_size = BNXT_RE_MAX_MR_SIZE;
>                             ^~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_reg_user_mr':
>>> include/uapi/linux/const.h:28:27: warning: left shift count >= width of type [-Wshift-count-overflow]
>     #define _BITUL(x) (_UL(1) << (x))
>                               ^
>>> include/linux/const.h:9:18: note: in expansion of macro '_BITUL'
>     #define BIT(x)  (_BITUL(x))
>                      ^~~~~~
>    drivers/infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
>     #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
>                                      ^~~
>    drivers/infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
>     #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c:3588:15: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
>      if (length > BNXT_RE_MAX_MR_SIZE) {
>                   ^~~~~~~~~~~~~~~~~~~
>>> include/uapi/linux/const.h:28:27: warning: left shift count >= width of type [-Wshift-count-overflow]
>     #define _BITUL(x) (_UL(1) << (x))
>                               ^
>>> include/linux/const.h:9:18: note: in expansion of macro '_BITUL'
>     #define BIT(x)  (_BITUL(x))
>                      ^~~~~~
>    drivers/infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
>     #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
>                                      ^~~
>    drivers/infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
>     #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c:3590:12: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
>        length, BNXT_RE_MAX_MR_SIZE);
>                ^~~~~~~~~~~~~~~~~~~
>
> vim +28 include/uapi/linux/const.h
>
> 5289f87f3 Masahiro Yamada 2018-02-22  27
> 4fac4e1b2 Masahiro Yamada 2018-02-22 @28  #define _BITUL(x)     (_UL(1) << (x))
> 4fac4e1b2 Masahiro Yamada 2018-02-22  29  #define _BITULL(x)    (_ULL(1) << (x))
> 2fc016c5b H. Peter Anvin  2013-04-27  30
>
> :::::: The code at line 28 was first introduced by commit
> :::::: 4fac4e1b26bc6cfec630fb48920c391d99a44940 linux/const.h: refactor _BITUL and _BITULL a bit
>
> :::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
> :::::: CC: 0day robot <fengguang.wu@intel.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Best Regards
Masahiro Yamada

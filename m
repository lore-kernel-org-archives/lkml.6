Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCNVbh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:31:37 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36627 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeCNVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:31:35 -0400
X-Google-Smtp-Source: AG47ELuwv7hFn5fsONgro2GUcACvE+X8GOtuu7xWduCOrddC8o0xD6VvgoYduKV6fmy44wihbT7kOoZsyS4eCK7Q648=
MIME-Version: 1.0
In-Reply-To: <201803141059.9HN3FiaN%fengguang.wu@intel.com>
References: <201803141059.9HN3FiaN%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 22:31:34 +0100
X-Google-Sender-Auth: P1rjjpFS03sdH9sNtepVPRyQhAk
Message-ID: <CAK8P3a1CyFM8i14OVJO7wDL7951wC22BrO-xJCLg9j=+D4BFKw@mail.gmail.com>
Subject: Re: lib///lzo/lzodefs.h:27:2: error: #error "conflicting endian definitions"
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 3:16 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> Hi Arnd,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fc6eabbbf8ef99efed778dd5afabc83c21dba585
> commit: 101110f6271ce956a049250c907bc960030577f8 Kbuild: always define endianess in kconfig.h
> date:   3 weeks ago
> config: m32r-allmodconfig (attached as .config)
> compiler: m32r-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 101110f6271ce956a049250c907bc960030577f8
>         # save the attached .config to linux build tree
>         make.cross ARCH=m32r
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/m32r/include/uapi/asm/byteorder.h:8:0,
>                     from arch/m32r/include/asm/bitops.h:22,
>                     from include/linux/bitops.h:38,
>                     from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:9,
>                     from lib///lzo/lzo1x_compress.c:14:
>    include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
>     #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN

I did now get around to looking at this, sorry for the delay.

The thing is that the warning shows an actual bug when it was previously
broken silently. The configuration sets CONFIG_CPU_LITTLE_ENDIAN
but the compiler only supports big-endian mode.

The m32r architecture is being removed in linux-4.17 as we have shown
that there are no remaining users, so I would suggest not doing anything
here and leaving the warning in place.

       Arnd

Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20959C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7052146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfBTRAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:00:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:46554 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfBTRAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:00:25 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gwVEH-0003Zn-Uj; Wed, 20 Feb 2019 20:00:18 +0300
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20190219214940.391081-1-arnd@arndb.de>
 <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com>
Date:   Wed, 20 Feb 2019 20:00:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/19 5:51 PM, Arnd Bergmann wrote:
> On Wed, Feb 20, 2019 at 3:45 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>>
>> On Tue, Feb 19, 2019 at 10:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> Building an arm64 allmodconfig kernel with clang results in over 140 warnings
>>> about overly large stack frames, the worst ones being:
>>>
>>> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size of 20224 bytes in function 'st7789v_prepare'
>>> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12: error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
>>> drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes in function 'max3421_spi_thread'
>>> drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes in function 'slic_ds26522_probe'
>>> drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in function 'ccp_run_cmd'
>>> drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840 bytes in function 'stv0367ter_algo'
>>>
>>> None of these happen with gcc today, and almost all of these are the result
>>> of a single known bug in llvm.  Hopefully it will eventually get fixed with the
>>> clang-9 release.
>>>
>>> In the meantime, the best idea I have is to turn off asan-stack for clang-8
>>> and earlier, so we can produce a kernel that is safe to run.
>>
>> Hi Arnd,
>>
>> I don't think it's good to disable KASAN stack instrumentation for the
>> whole kernel by default with clang. It makes more sense to disable
>> stack instrumentation only for these few drivers.
> 
> Do you mean just the 114 files that we get warnings for in allmodconfig,
> or also those that run into the same bug but stay below the warning limit,
> and the ones that don't warn in allmodconfig but do warn in other
> configurations?
> 
> I would have to some more research, but I expect several hundred
> patches before we get to a clean randconfig build with a broken
> compiler.

Manually maintaining asan-stack parameter for the sake of one broken compiler isn't a great idea either.

Couple alternative suggestions:

1) If we can't fix the problem or the cost of fixing is too high, maybe just hide it? Disable -Wframe-larger-then on pre clang-9 compilers.

2) Fallback cflags. The idea is to try to compile every the file with "-mllvm -asan-stack=1 -Wframe-larger-than=2048 -Werror" at first,
 and fallback to "-mllvm -asan-stack=0" if failed. So it would be something similar to $(call cc-option, -mllvm -asan-stack=1 -Wframe-larger-than=2048 -Werror, -mllvm -asan-stack=0)
 except that "cc-option" tries options only once on some code example while  we need to try options on every file that we actually compile.
 Honestly, I'm not sure that it's worthy to hack Kbuild engine for that particular use-case.
 

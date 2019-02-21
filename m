Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FDAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292622147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfBUKGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:06:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:49990 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfBUKGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:06:07 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gwlEu-0007TL-Ng; Thu, 21 Feb 2019 13:06:00 +0300
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com>
 <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <d50cf232-f38e-4060-2742-27ba07e2ae9c@virtuozzo.com>
Date:   Thu, 21 Feb 2019 13:06:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/19 8:35 PM, Arnd Bergmann wrote:
> On Wed, Feb 20, 2019 at 6:00 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>> On 2/20/19 5:51 PM, Arnd Bergmann wrote:
>>> On Wed, Feb 20, 2019 at 3:45 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>>> I would have to some more research, but I expect several hundred
>>> patches before we get to a clean randconfig build with a broken
>>> compiler.
>>
>> Manually maintaining asan-stack parameter for the sake of one broken compiler isn't a great idea either.
>>
>> Couple alternative suggestions:
>>
>> 1) If we can't fix the problem or the cost of fixing is too high, maybe just hide it? Disable -Wframe-larger-then on pre clang-9 compilers.
>>
>> 2) Fallback cflags. The idea is to try to compile every the file with "-mllvm -asan-stack=1 -Wframe-larger-than=2048 -Werror" at first,
>>  and fallback to "-mllvm -asan-stack=0" if failed. So it would be something similar to $(call cc-option, -mllvm -asan-stack=1 -Wframe-larger-than=2048 -Werror, -mllvm -asan-stack=0)
>>  except that "cc-option" tries options only once on some code example while  we need to try options on every file that we actually compile.
>>  Honestly, I'm not sure that it's worthy to hack Kbuild engine for that particular use-case.
> 
> My original plan was to put this under CONFIG_KASAN_EXTRA to allow you
> to still enable it in older compilers, but you just removed that option ;-)
> 
> Maybe bringing it back would be a compromise? That way it's hidden from
> all the build testing bots (because of the !CONFIG_COMPILE_TEST dependency),
> but anyone who really wants it can still have the option, and set
> CONFIG_FRAME_WARN
> to whichever value they like.
> 


I think there is much simpler solution:

---
 lib/Kconfig.kasan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 219cddc913ac..6cd035f06cee 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -105,6 +105,8 @@ endchoice
 
 config KASAN_STACK
 	int
+	range 0 1
+	prompt "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && (CLANG_VERSION < 90000)
 	default 0 if CC_IS_CLANG && (CLANG_VERSION < 90000)
 	default 1
 	help
-- 


AFAIK, randconfig is not able to randomize int config options, so it will be disabled for build robots,
but users still will be able to enable it.

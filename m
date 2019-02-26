Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A92EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9812173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBZQUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:20:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:37852 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfBZQUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:20:40 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gyfT4-0000Sr-Sq; Tue, 26 Feb 2019 19:20:31 +0300
Subject: Re: [PATCH] [v2] kasan: turn off asan-stack for clang-8 and earlier
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kbuild@vger.kernel.org
References: <20190222222950.3997333-1-arnd@arndb.de>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6cf9d8ee-1dca-b886-4eaa-ce0c25bf6459@virtuozzo.com>
Date:   Tue, 26 Feb 2019 19:20:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222222950.3997333-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/19 1:29 AM, Arnd Bergmann wrote:
> Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> about overly large stack frames, the worst ones being:
> 
> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size of 20224 bytes in function 'st7789v_prepare'
> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12: error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
> drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes in function 'max3421_spi_thread'
> drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes in function 'slic_ds26522_probe'
> drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in function 'ccp_run_cmd'
> drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840 bytes in function 'stv0367ter_algo'
> 
> None of these happen with gcc today, and almost all of these are the result
> of a single known issue in llvm.  Hopefully it will eventually get fixed with
> the clang-9 release.
> 
> In the meantime, the best idea I have is to turn off asan-stack for clang-8
> and earlier, so we can produce a kernel that is safe to run.
> 
> I have posted three patches that address the frame overflow warnings that are
> not addressed by turning off asan-stack, so in combination with this change,
> we get much closer to a clean allmodconfig build, which in turn is necessary
> to do meaningful build regression testing.
> 
> It is still possible to turn on the CONFIG_ASAN_STACK option on all versions
> of clang, and it's always enabled for gcc, but when CONFIG_COMPILE_TEST is
> set, the option remains invisible, so allmodconfig and randconfig builds
> (which are normally done with a forced CONFIG_COMPILE_TEST) will still result
> in a mostly clean build.
> 
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38809
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

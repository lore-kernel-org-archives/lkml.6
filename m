Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB521C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831C920878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbfAKSqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:46:33 -0500
Received: from relay.sw.ru ([185.231.240.75]:41754 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfAKSqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:46:33 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gi1p6-0006fL-JJ; Fri, 11 Jan 2019 21:46:28 +0300
Subject: Re: [PATCH] kasan: fix kasan_check_read/write definitions
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20181211133453.2835077-1-arnd@arndb.de>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <478333ec-1866-2908-1111-8b3dda135278@virtuozzo.com>
Date:   Fri, 11 Jan 2019 21:46:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181211133453.2835077-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 4:34 PM, Arnd Bergmann wrote:
> Building little-endian allmodconfig kernels on arm64 started failing
> with the generated atomic.h implementation, since we now try to call
> kasan helpers from the EFI stub:
> 
> aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: in function `atomic_set':
> include/generated/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'
> 
> I suspect that we get similar problems in other files that explicitly
> disable KASAN for some reason but call atomic_t based helper functions.
> 
> We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
> that the compiler sets instead of checking CONFIG_KASAN, but this in turn
> requires a small hack in mm/kasan/common.c so we do see the extern
> declaration there instead of the inline function.
> 
> Fixes: b1864b828644 ("locking/atomics: build atomic headers as required")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

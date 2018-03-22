Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeCVXTq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:19:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43655 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeCVXTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:19:44 -0400
X-Google-Smtp-Source: AG47ELtiY0dMpK9xoFiJo/0PtSiq1nsKhHG5eL8cWdAtoO71MtDuu8nTHAXYnQ92glm1bUnBW0f77Q==
Subject: Re: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
To: Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>, Dave.Martin@arm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180322212705.141175-1-mka@chromium.org>
 <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
 <20180322224456.GB78232@google.com>
From: Greg Hackmann <ghackmann@google.com>
Message-ID: <fc921bfb-1f49-08f9-515c-07bd442a1e11@google.com>
Date: Thu, 22 Mar 2018 16:19:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322224456.GB78232@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 03:44 PM, Matthias Kaehlcke wrote:
> El Thu, Mar 22, 2018 at 10:26:18PM +0000 Nick Desaulniers ha dit:
> 
>> Note that a patch in this form has previously been implemented by:
>>
>> Andrey Konovalov <andreyknvl@google.com>:
>> https://gist.github.com/xairy/ee11682ea86044a45c0291c528cd936f
>>
>> and another by:
>>
>> Greg Hackmann <ghackmann@google.com>:
>> https://android-review.googlesource.com/c/kernel/common/+/645181
>>
>> If you used either as a reference, you may want to credit them with a
>> `Suggested-by:` in the commit message.
> 
> Not really, but I think I prefer Greg's version over mine and might
> use it in a respin if nobody raises objections.

NAK.  There's a reason I didn't send my change upstream.

As Marc pointed out (https://lkml.org/lkml/2018/3/16/987), the "r"
prefix tells gcc to pick the appropriate register width.  "x" makes it
unconditionally use the entire 64-bit register width.  Just swapping out
one for the other changes the macro's semantics.

Unfortunately since this was breaking builds in android-4.14 and we
didn't have an immediate-term fix, I bit the bullet and added the above
commit -- but *only* as a short-term workaround.  For the one caller we
currently have in 4.14.y, gcc was using the entire 64-bit width for all
its inputs anyway, so "r" vs. "x" didn't make a difference.  But that
might not be true if/when someone introduces other SMCCC 1.1 callers.

Unfortunately I don't see a better way to deal with this than waiting
for clang to support "r"-style constraints on ARM64.

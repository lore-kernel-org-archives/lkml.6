Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CE7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E78321929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbfBOSub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:50:31 -0500
Received: from foss.arm.com ([217.140.101.70]:37700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389581AbfBOSua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:50:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF6EA78;
        Fri, 15 Feb 2019 10:50:30 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99813F589;
        Fri, 15 Feb 2019 10:50:28 -0800 (PST)
Date:   Fri, 15 Feb 2019 18:50:26 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
Message-ID: <20190215185026.GE15084@fuggles.cambridge.arm.com>
References: <20190215013959.21320-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215013959.21320-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 06:39:59PM -0700, Nathan Chancellor wrote:
> After commit cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR
> implementation"), Clang builds for arm64 started failing with the
> following error message.
> 
> arch/arm64/lib/xor-neon.c:58:28: error: incompatible pointer types
> assigning to 'const unsigned long *' from 'uint64_t *' (aka 'unsigned
> long long *') [-Werror,-Wincompatible-pointer-types]
>                 v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 + 6));
>                                          ^~~~~~~~
> /usr/lib/llvm-9/lib/clang/9.0.0/include/arm_neon.h:7538:47: note:
> expanded from macro 'vld1q_u64'
>   __ret = (uint64x2_t) __builtin_neon_vld1q_v(__p0, 51); \
>                                               ^~~~
> 
> There has been quite a bit of debate and triage that has gone into
> figuring out what the proper fix is, viewable at the link below, which
> is still ongoing. Ard suggested disabling this warning with Clang with a
> pragma so no neon code will have this type of error. While this is not
> at all an ideal solution, this build error is the only thing preventing
> KernelCI from having successful arm64 defconfig and allmodconfig builds
> on linux-next. Getting continuous integration running is more important
> so new warnings/errors or boot failures can be caught and fixed quickly.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/283
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm64/include/asm/neon-intrinsics.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> index 2ba6c6b9541f..71abfc7612b2 100644
> --- a/arch/arm64/include/asm/neon-intrinsics.h
> +++ b/arch/arm64/include/asm/neon-intrinsics.h
> @@ -36,4 +36,8 @@
>  #include <arm_neon.h>
>  #endif
>  
> +#ifdef CONFIG_CC_IS_CLANG
> +#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
> +#endif

I'd like Ard's ack on this one, please.

Will

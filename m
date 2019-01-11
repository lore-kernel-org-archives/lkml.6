Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA92C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DB72133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390219AbfAKSy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:54:58 -0500
Received: from relay.sw.ru ([185.231.240.75]:42060 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbfAKSy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:54:57 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gi1xE-0006iS-Kt; Fri, 11 Jan 2019 21:54:52 +0300
Subject: Re: [RESEND PATCH] x86_64: increase stack size for KASAN_EXTRA
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20181228020639.80425-1-cai@lca.pw>
 <20190109215209.2903-1-cai@lca.pw>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <07c92470-7954-a1e1-5489-529134d738b8@virtuozzo.com>
Date:   Fri, 11 Jan 2019 21:55:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109215209.2903-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/19 12:52 AM, Qian Cai wrote:
> If the kernel is configured with KASAN_EXTRA, the stack size is
> increasted significantly due to enable this option will set
> "-fstack-reuse" to "none" in GCC [1]. As the results, it could trigger
> stack overrun quite often with 32k stack size compiled using GCC 8. For
> example, this reproducer
> 
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/\
> syscalls/madvise/madvise06.c
> 
> could trigger a "corrupted stack end detected inside scheduler" very
> reliably with CONFIG_SCHED_STACK_END_CHECK enabled.
> 
> There are just too many functions that could have a large stack with
> KASAN_EXTRA due to large local variables that have been called over and
> over again without being able to reuse the stacks. Some noticiable ones
> are,
> 
> size
> 7648 shrink_page_list
> 3584 xfs_rmap_convert
> 3312 migrate_page_move_mapping
> 3312 dev_ethtool
> 3200 migrate_misplaced_transhuge_page
> 3168 copy_process
> 
> There are other 49 functions are over 2k in size while compiling kernel
> with "-Wframe-larger-than=" even with a related minimal config on this
> machine. Hence, it is too much work to change Makefiles for each object
> to compile without "-fsanitize-address-use-after-scope" individually.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23
> 
> Although there is a patch in GCC 9 to help the situation, GCC 9 probably
> won't be released in a few months and then it probably take another
> 6-month to 1-year for all major distros to include it as a default.
> Hence, the stack usage with KASAN_EXTRA can be revisited again in 2020
> when GCC 9 is everywhere. Until then, this patch will help users avoid
> stack overrun.
> 
> This has already been fixed for arm64 for the same reason via
> 6e8830674ea (arm64: kasan: Increase stack size for KASAN_EXTRA).
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/include/asm/page_64_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index 8f657286d599..0ce558a8150d 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -7,7 +7,11 @@
>  #endif
>  
>  #ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_EXTRA
> +#define KASAN_STACK_ORDER 2

So the kernel stack becomes 4-order page. That's above PAGE_ALLOC_COSTLY_ORDER, so people
will start seeing fork() failures with -ENOMEM due to high memory fragmentation. I don't think
we can afford such change.

Give that use-after-scope has proven to be almost useless for the kernel, I think we should just
remove it entirely.

> +#else
>  #define KASAN_STACK_ORDER 1
> +#endif
>  #else
>  #define KASAN_STACK_ORDER 0
>  #endif
> 

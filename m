Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EE0206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfAIWCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:02:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAIWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:02:04 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8FDC1B55;
        Wed,  9 Jan 2019 22:02:03 +0000 (UTC)
Date:   Wed, 9 Jan 2019 14:02:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86_64: increase stack size for KASAN_EXTRA
Message-Id: <20190109140201.4434ff87880ee29bdedb37cc@linux-foundation.org>
In-Reply-To: <20190109215209.2903-1-cai@lca.pw>
References: <20181228020639.80425-1-cai@lca.pw>
        <20190109215209.2903-1-cai@lca.pw>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 16:52:09 -0500 Qian Cai <cai@lca.pw> wrote:

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

Sounds good.

> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -7,7 +7,11 @@
>  #endif
>  
>  #ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_EXTRA
> +#define KASAN_STACK_ORDER 2
> +#else
>  #define KASAN_STACK_ORDER 1
> +#endif
>  #else
>  #define KASAN_STACK_ORDER 0
>  #endif

I'm suspecting this logic could be performed in Kconfig, for all
architectures.  Add a new always-defined CONFIG_KASAN_STACK_ORDER?


Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7022AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412D5218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbeL1DMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:12:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeL1DMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:12:00 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8ACCB6D;
        Fri, 28 Dec 2018 03:11:59 +0000 (UTC)
Date:   Thu, 27 Dec 2018 19:11:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     will.deacon@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mmotm] arm64: fix build for MAX_USER_VA_BITS
Message-Id: <20181227191158.db19ed656f902629d203b58f@linux-foundation.org>
In-Reply-To: <20181224210312.56539-1-cai@lca.pw>
References: <20181224210312.56539-1-cai@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018 16:03:12 -0500 Qian Cai <cai@lca.pw> wrote:

> Some code in 9b31cf493ff was lost during merging into the -mmotm tree
> for some reasons,
> 
> In file included from ./arch/arm64/include/asm/processor.h:46,
>                  from ./include/linux/rcupdate.h:43,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
> 		 from arch/arm64/kernel/asm-offsets.c:22:
> ./arch/arm64/include/asm/pgtable-hwdef.h:83:30: error:
> 'MAX_USER_VA_BITS' undeclared here (not in a function); did you mean
> 'MAX_USER_PRIO'?
>  #define PTRS_PER_PGD  (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>                               ^~~~~~~~~~~~~~~~
> ./arch/arm64/include/asm/pgtable.h:442:26: note: in expansion of macro
> 'PTRS_PER_PGD'
>  extern pgd_t init_pg_dir[PTRS_PER_PGD];
>
> ...
>
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -67,6 +67,12 @@
>  #define KERNEL_START      _text
>  #define KERNEL_END        _end
>  
> +#ifdef CONFIG_ARM64_USER_VA_BITS_52
> +#define MAX_USER_VA_BITS	52
> +#else
> +#define MAX_USER_VA_BITS	VA_BITS
> +#endif
> +
>  /*
>   * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
>   * address space for the shadow region respectively. They can bloat the stack

hm, that was presumably me getting lost in a maze of rejects.  It seems
OK now.


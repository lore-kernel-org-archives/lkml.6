Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE051C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5BC21509
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5BC21509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeHOXFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbeHOXFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:05:01 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313DA21509;
        Wed, 15 Aug 2018 20:11:24 +0000 (UTC)
Date:   Wed, 15 Aug 2018 16:11:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zong Li <zong@andestech.com>
Cc:     <green.hu@gmail.com>, <deanbo422@gmail.com>, <mingo@redhat.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <zongbox@gmail.com>, <greentime@andestech.com>
Subject: Re: [PATCH 1/6] nds32/ftrace: Support static function tracer
Message-ID: <20180815161121.06c9b531@gandalf.local.home>
In-Reply-To: <8ae0dc897f904d8bcd6f8d8a5085f6b352c6708f.1534323834.git.zong@andestech.com>
References: <cover.1534323834.git.zong@andestech.com>
        <8ae0dc897f904d8bcd6f8d8a5085f6b352c6708f.1534323834.git.zong@andestech.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 17:35:18 +0800
Zong Li <zong@andestech.com> wrote:

> This patch support the static function tracer. On nds32 ABI, we need to
> always push return address to stack for __builtin_return_address can
> work correctly, otherwise, it will get the wrong value of $lp at leaf
> function.
> 
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/nds32/Kconfig              |  1 +
>  arch/nds32/Makefile             |  4 ++++
>  arch/nds32/include/asm/ftrace.h | 20 ++++++++++++++++++++
>  arch/nds32/kernel/Makefile      |  6 ++++++
>  arch/nds32/kernel/ftrace.c      | 28 ++++++++++++++++++++++++++++
>  5 files changed, 59 insertions(+)
>  create mode 100644 arch/nds32/include/asm/ftrace.h
>  create mode 100644 arch/nds32/kernel/ftrace.c
> 
> diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
> index 34f7222..af30e1a 100644
> --- a/arch/nds32/Kconfig
> +++ b/arch/nds32/Kconfig
> @@ -40,6 +40,7 @@ config NDS32
>  	select NO_IOPORT_MAP
>  	select RTC_LIB
>  	select THREAD_INFO_IN_TASK
> +	select HAVE_FUNCTION_TRACER
>  	help
>  	  Andes(nds32) Linux support.
>  
> diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
> index 031c676..3ca8172 100644
> --- a/arch/nds32/Makefile
> +++ b/arch/nds32/Makefile
> @@ -5,6 +5,10 @@ KBUILD_DEFCONFIG := defconfig
>  
>  comma = ,
>  
> +ifdef CONFIG_FUNCTION_TRACER
> +arch-y += -malways-save-lp -mno-relax
> +endif
> +
>  KBUILD_CFLAGS	+= $(call cc-option, -mno-sched-prolog-epilog)
>  KBUILD_CFLAGS	+= -mcmodel=large
>  
> diff --git a/arch/nds32/include/asm/ftrace.h b/arch/nds32/include/asm/ftrace.h
> new file mode 100644
> index 0000000..bac7657
> --- /dev/null
> +++ b/arch/nds32/include/asm/ftrace.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_NDS32_FTRACE_H
> +#define __ASM_NDS32_FTRACE_H
> +
> +#ifdef CONFIG_FUNCTION_TRACER
> +
> +#define HAVE_FUNCTION_GRAPH_FP_TEST
> +
> +#define MCOUNT_ADDR ((unsigned long)(_mcount))
> +/* mcount call is composed of three instructions:
> + * sethi + ori + jral
> + */
> +#define MCOUNT_INSN_SIZE 12
> +
> +extern void _mcount(unsigned long parent_ip);
> +
> +#endif /* CONFIG_FUNCTION_TRACER */
> +
> +#endif /* __ASM_NDS32_FTRACE_H */
> diff --git a/arch/nds32/kernel/Makefile b/arch/nds32/kernel/Makefile
> index 4279274..27cded3 100644
> --- a/arch/nds32/kernel/Makefile
> +++ b/arch/nds32/kernel/Makefile
> @@ -21,3 +21,9 @@ extra-y := head.o vmlinux.lds
>  
>  
>  obj-y				+= vdso/
> +
> +obj-$(CONFIG_FUNCTION_TRACER)   += ftrace.o
> +
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +endif
> diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
> new file mode 100644
> index 0000000..563f64c
> --- /dev/null
> +++ b/arch/nds32/kernel/ftrace.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/ftrace.h>
> +#include <linux/uaccess.h>
> +#include <asm/cacheflush.h>
> +
> +extern void (*ftrace_trace_function)(unsigned long, unsigned long,
> +				     struct ftrace_ops*, struct pt_regs*);
> +
> +noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
> +				  struct ftrace_ops *op, struct pt_regs *regs)
> +{
> +	__asm__ ("");  /* avoid to optimize as pure function */
> +}
> +
> +noinline void _mcount(unsigned long parent_ip)
> +{

Wow! The NDS32 arch allows for _mcount to be a C function! That's
nice :-)

-- Steve

> +	/* save all state by the compiler prologue */
> +
> +	unsigned long ip = (unsigned long)__builtin_return_address(0);
> +
> +	if (ftrace_trace_function != ftrace_stub)
> +		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
> +				      NULL, NULL);
> +
> +	/* restore all state by the compiler epilogue */
> +}
> +EXPORT_SYMBOL(_mcount);


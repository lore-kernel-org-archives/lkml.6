Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E2C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802A25AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1802A25AB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934415AbeF0PND (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:13:03 -0400
Received: from foss.arm.com ([217.140.101.70]:33056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933133AbeF0PNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:13:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D33E418A;
        Wed, 27 Jun 2018 08:13:01 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A36503F266;
        Wed, 27 Jun 2018 08:13:01 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 88B351AE3692; Wed, 27 Jun 2018 16:13:39 +0100 (BST)
Date:   Wed, 27 Jun 2018 16:13:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v9 3/6] module: use relative references for __ksymtab
 entries
Message-ID: <20180627151339.GD30631@arm.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180626182802.19932-4-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626182802.19932-4-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 26, 2018 at 08:27:58PM +0200, Ard Biesheuvel wrote:
> An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
> entries, each consisting of two 64-bit fields containing absolute
> references, to the symbol itself and to a char array containing
> its name, respectively.

[...]

> diff --git a/include/linux/export.h b/include/linux/export.h
> index ea7df303d68d..ae072bc5aacf 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -18,12 +18,6 @@
>  #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
>  
>  #ifndef __ASSEMBLY__
> -struct kernel_symbol
> -{
> -	unsigned long value;
> -	const char *name;
> -};
> -
>  #ifdef MODULE
>  extern struct module __this_module;
>  #define THIS_MODULE (&__this_module)
> @@ -54,17 +48,47 @@ extern struct module __this_module;
>  #define __CRC_SYMBOL(sym, sec)
>  #endif
>  
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#include <linux/compiler.h>
> +/*
> + * Emit the ksymtab entry as a pair of relative references: this reduces
> + * the size by half on 64-bit architectures, and eliminates the need for
> + * absolute relocations that require runtime processing on relocatable
> + * kernels.
> + */
> +#define __KSYMTAB_ENTRY(sym, sec)					\
> +	__ADDRESSABLE(sym)						\
> +	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
> +	    "	.balign	8					\n"	\

Can we use KSYM_ALIGN here instead of 8, or do we need the 8-byte alignment
even on 32-bit architectures?

Will

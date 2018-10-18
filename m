Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E19C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485512086E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485512086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJSA7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:59:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbeJSA7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:59:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFED0341;
        Thu, 18 Oct 2018 09:57:59 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85BAA3F5D3;
        Thu, 18 Oct 2018 09:57:57 -0700 (PDT)
Subject: Re: [PATCH 2/4] kernel hacking: new config NO_AUTO_INLINE to disable
 compiler auto-inline optimizations
To:     Du Changbin <changbin.du@gmail.com>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com,
        linux@armlinux.org.uk, akpm@linux-foundation.org
Cc:     linux-kbuild@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Changbin Du <changbin.du@intel.com>,
        linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181018162548.6399-1-changbin.du@gmail.com>
 <20181018162548.6399-3-changbin.du@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <62bcdf3d-87be-407f-b971-5a53dbb1e4b8@arm.com>
Date:   Thu, 18 Oct 2018 17:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018162548.6399-3-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/18 17:25, Du Changbin wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
> 
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>   Makefile          |  6 ++++++
>   lib/Kconfig.debug | 25 +++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index e8b599b4dcde..757d6507cb5c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -749,6 +749,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
>   		   $(call cc-option,-fno-var-tracking)
>   endif
>   
> +ifdef CONFIG_NO_AUTO_INLINE
> +KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
> +		   $(call cc-option, -fno-inline-small-functions) \
> +		   $(call cc-option, -fno-inline-functions-called-once)
> +endif
> +
>   ifdef CONFIG_FUNCTION_TRACER
>   ifdef CONFIG_FTRACE_MCOUNT_RECORD
>     # gcc 5 supports generating the mcount tables directly
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4966c4fbe7f7..0f9b4fa78b1c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -211,6 +211,31 @@ config GDB_SCRIPTS
>   	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
>   	  for further details.
>   
> +config NO_AUTO_INLINE
> +	bool "Disable compiler auto-inline optimizations"
> +	help
> +	  This will prevent the compiler from optimizing the kernel by
> +	  auto-inlining functions not marked with the inline keyword.
> +	  With this option, only functions explicitly marked with
> +	  "inline" will be inlined. This will allow the function tracer
> +	  to trace more functions because it only traces functions that
> +	  the compiler has not inlined.
> +
> +	  Enabling this function can help debugging a kernel if using
> +	  the function tracer. But it can also change how the kernel
> +	  works, because inlining functions may change the timing,
> +	  which could make it difficult while debugging race conditions.
> +
> +	  If unsure, select N.
> +
> +config ENABLE_WARN_DEPRECATED

This part doesn't look like it belongs in this patch, and judging by the 
commit message in 771c035372a0 wouldn't be welcome back anyway.

Robin.

> +	bool "Enable __deprecated logic"
> +	default y
> +	help
> +	  Enable the __deprecated logic in the kernel build.
> +	  Disable this to suppress the "warning: 'foo' is deprecated
> +	  (declared at kernel/power/somefile.c:1234)" messages.
> +
>   config ENABLE_MUST_CHECK
>   	bool "Enable __must_check logic"
>   	default y
> 

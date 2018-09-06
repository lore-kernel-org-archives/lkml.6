Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6787CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264E520857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264E520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeIFOjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:39:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIFOjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:39:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC4E41596;
        Thu,  6 Sep 2018 03:05:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CF683F575;
        Thu,  6 Sep 2018 03:05:09 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 377EF1AE358D; Thu,  6 Sep 2018 11:05:24 +0100 (BST)
Date:   Thu, 6 Sep 2018 11:05:24 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC PATCH v2 3/3] dynamic_debug: Add support for dynamic
 register trace
Message-ID: <20180906100523.GE3592@arm.com>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
 <9015a7a4aafa9935be769c07918743df63d6f648.1535119711.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9015a7a4aafa9935be769c07918743df63d6f648.1535119711.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 08:15:27PM +0530, Sai Prakash Ranjan wrote:
> Introduce dynamic debug filtering mechanism to register
> tracing as dynamic_rtb() which will reduce a lot of
> overhead otherwise of tracing all the register reads/writes
> in all files.
> 
> Now we can just specify the file name or any wildcard pattern
> as any other dynamic debug facility in bootargs and dynamic rtb
> will just trace them and the output can be seen in pstore.
> 
> TODO: Now we use same 'p' flag but will add a separate flag for register trace
> later.
> 
> Also add asm-generic/io-instrumented.h file for instrumentation of IO
> operations such as read/write{b,w,l,q} as per Will's suggestion to not touch
> arch code and let core generate instrumentation.
> This can be extended to arm as well later for tracing.
> 
> Example for tracing all register reads/writes in drivers/soc/qcom/* below:
> 
>   # dyndbg="file drivers/soc/qcom/* +p" in bootargs
>   # reboot -f
>   # mount -t pstore pstore /sys/fs/pstore
>   # cat /sys/fs/pstore/rtb-ramoops-0
>     [LOGK_WRITE] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>     [LOGK_WRITE] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/include/asm/io.h           | 26 +++++++++-------------
>  include/asm-generic/io-instrumented.h | 32 +++++++++++++++++++++++++++
>  include/linux/dynamic_debug.h         | 13 +++++++++++
>  kernel/trace/Kconfig                  |  1 +
>  4 files changed, 56 insertions(+), 16 deletions(-)
>  create mode 100644 include/asm-generic/io-instrumented.h
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 35b2e50f17fb..aafd4b0be9f0 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h

The arm64 bits look fine to me, but please can you split them into a
separate patch?

> diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
> new file mode 100644
> index 000000000000..ce273742b98c
> --- /dev/null
> +++ b/include/asm-generic/io-instrumented.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
> +#define _ASM_GENERIC_IO_INSTRUMENTED_H
> +
> +#include <linux/dynamic_debug.h>
> +
> +#define __raw_write(v, a, _t) ({			\
> +	volatile void __iomem *_a = (a);		\

Does this actually need to be volatile?

> +	dynamic_rtb("LOGK_WRITE", (void __force *)(_a));\
> +	arch_raw_write##_t((v), _a);			\
> +	})
> +
> +#define __raw_writeb(v, a)	__raw_write((v), a, b)
> +#define __raw_writew(v, a)	__raw_write((v), a, w)
> +#define __raw_writel(v, a)	__raw_write((v), a, l)
> +#define __raw_writeq(v, a)	__raw_write((v), a, q)
> +
> +#define __raw_read(a, _l, _t)    ({					\
> +	_t __a;								\
> +	const volatile void __iomem *_a = (const volatile void __iomem *)(a);\

Again, can't this just be void __iomem * ?

> +	dynamic_rtb("LOGK_READ", (void __force *)(_a));			\
> +	__a = arch_raw_read##_l(_a);					\
> +	__a;								\
> +	})
> +
> +#define __raw_readb(a)	__raw_read((a), b, u8)
> +#define __raw_readw(a)	__raw_read((a), w, u16)
> +#define __raw_readl(a)	__raw_read((a), l, u32)
> +#define __raw_readq(a)	__raw_read((a), q, u64)

I find the way you've defined the __raw_{read,write} macros quite confusing.
They both have an _t parameter, but it's totally unrelated between the two!

Will

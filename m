Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeBYMVX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 07:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbeBYMVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 07:21:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15EE21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sun, 25 Feb 2018 21:21:18 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>, Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Long <dave.long@linaro.org>
Subject: Re: [PATCH 2/2] arm: kprobes: Prohibit kprobes on get_user
 functions
Message-Id: <20180225212118.ee09db43772a338151762730@kernel.org>
In-Reply-To: <151945939903.11045.1486072728379559979.stgit@devbox>
References: <151945937038.11045.14421944772744094357.stgit@devbox>
        <151945939903.11045.1486072728379559979.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2018 17:03:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since do_undefinstr() uses get_user to get the undefined
> instruction, it can be called before kprobes processes
> recursive check. This can cause an infinit recursive
> exception.
> Prohibit probing on get_user functions.
> 
> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm/include/asm/assembler.h |    8 ++++++++
>  arch/arm/lib/getuser.S           |   10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index bc8d4bbd82e2..dd5e7f30eaed 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -536,4 +536,12 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  #endif
>  	.endm
>  
> +#ifdef CONFIG_KPROBES
> +# define _ASM_NOKPROBE(entry)				\
> +	.pushsection "_kprobe_blacklist", "aw" ;	\
> +	.balign 4 ;					\
> +	.long entry;					\
> +	.popsection

Oops, I missed #else block... which cause build error if !CONFIG_KPROBES.
I'll update it soon.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

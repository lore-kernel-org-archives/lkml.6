Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226972098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4oOx8Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226972098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJROsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeJROsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:48:21 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB0421473;
        Thu, 18 Oct 2018 06:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539845330;
        bh=yUBR8uWXBdESI9vTVsRfMmfIuy8cgWJmA5JK7nKpzXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W4oOx8WdDZ0Nq2jlmoOMO09bX1Z7ByNCc+x1uR6923IINe3eMfILaPaFrh4XLxy8y
         pSW9NZav6oMDBsbrpYLJRJ5ajcfRqeeXnxVxpWVrq85SrZJhrBWrA3xX3Ok1loycYK
         xIFgjT6eNwLND3KBpzfWpHoxuuqUrgGmmgNGK4xM=
Date:   Thu, 18 Oct 2018 15:48:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86: ptrace.h: Make regs_get_kernel_stack_nth() not
 fault on bad stack
Message-Id: <20181018154846.8d055466316359525b94a87a@kernel.org>
In-Reply-To: <20181017165951.09119177@gandalf.local.home>
References: <20181017165951.09119177@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 16:59:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Andy had some concerns about using regs_get_kernel_stack_nth() in a new
> function regs_get_kernel_argument() as if there's any error in the stack
> code, it could cause a bad memory access. To be on the safe side, call
> probe_kernel_read() on the stack address to be extra careful in accessing
> the memory. A helper function, regs_get_kernel_stack_nth_addr(), was added
> to just return the stack address (or NULL if not on the stack), that will be
> used to find the address (and could be used by other functions) and read the
> address with kernel_probe_read().
> 
> Link: http://lkml.kernel.org/r/CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com
> Requested-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
> 
> Changes since v1:
> 
>    - Make regs_get_kernel_stack_nth() not fault, and not have a
>      separate function. Only tracing uses it anyway.
> 
>  arch/x86/include/asm/ptrace.h | 43 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index c2304b25e2fd..055f632ce711 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -237,23 +237,52 @@ static inline int regs_within_kernel_stack(struct pt_regs *regs,
>  }
>  
>  /**
> + * regs_get_kernel_stack_nth_addr() - get the address of the Nth entry on stack
> + * @regs:	pt_regs which contains kernel stack pointer.
> + * @n:		stack entry number.
> + *
> + * regs_get_kernel_stack_nth() returns the address of the @n th entry of the
> + * kernel stack which is specified by @regs. If the @n th entry is NOT in
> + * the kernel stack, this returns NULL.
> + */
> +static inline unsigned long *regs_get_kernel_stack_nth_addr(struct pt_regs *regs,
> +							    unsigned int n)
> +{
> +	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
> +
> +	addr += n;
> +	if (regs_within_kernel_stack(regs, (unsigned long)addr))
> +		return addr;
> +	else
> +		return NULL;
> +}
> +
> +/* To avoid include hell, we can't include uaccess.h */
> +extern long probe_kernel_read(void *dst, const void *src, size_t size);
> +
> +/**
>   * regs_get_kernel_stack_nth() - get Nth entry of the stack
>   * @regs:	pt_regs which contains kernel stack pointer.
>   * @n:		stack entry number.
>   *
>   * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
> - * is specified by @regs. If the @n th entry is NOT in the kernel stack,
> + * is specified by @regs. If the @n th entry is NOT in the kernel stack
>   * this returns 0.
>   */
>  static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
>  						      unsigned int n)
>  {
> -	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
> -	addr += n;
> -	if (regs_within_kernel_stack(regs, (unsigned long)addr))
> -		return *addr;
> -	else
> -		return 0;
> +	unsigned long *addr;
> +	unsigned long val;
> +	long ret;
> +
> +	addr = regs_get_kernel_stack_nth_addr(regs, n);
> +	if (addr) {
> +		ret = probe_kernel_read(&val, addr, sizeof(val));
> +		if (!ret)
> +			return val;
> +	}
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.13.6
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

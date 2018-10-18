Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D374ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E563221470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PQKngz3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E563221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeJRK1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:27:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43644 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeJRK1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:27:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so13574731plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 19:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+L4D7XDhh+kEBuedNpv8EV6q2jFmxDPKi+i9gP+IlgU=;
        b=PQKngz3pvVgsik0deidXkm2NTg4UeA6HZLrlbaxhdma+kTC4yICeK+GpTY+j0wR5eg
         IS1ebIAqa2nKsULfq7K9zoM8L+xbOcOulEXe/X7auvL0IB2bHrUUj6qSAsSpdY5QNbj6
         soTC8uSJKJ1zC964HHBFiOUIkMkorIDx6jviI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+L4D7XDhh+kEBuedNpv8EV6q2jFmxDPKi+i9gP+IlgU=;
        b=bzWEsLbAwRxXBY8t2pTYkoy8dbE5fvabCfxDC7pgU5xMv+hJEvBho2HkEt6HcBL7Cd
         wxqD6OqG6iGEGfB3OReeS1HqQe11lv4H5XC9idKkWG2GCwtonVmZs0p+JIVEPwTRM7xF
         85CqR4i1d2L5oz9SMtjQn8XIGnzw3+KS6YKyWW30YWUXrI3BHhxT66W71edgfmfiubo+
         tHsNXQbSowvXQ5VBBmh3qr5qicXKMQgLaWPFVeWDoXYKuPR8CsUezEm2rmDuBNTLExfY
         DCzyq9rj4INj1n6pUk/99Y311YlDjOEw9nz125LhhiL64hLzoYZKYywJiy67pjPhVAHA
         urHA==
X-Gm-Message-State: ABuFfogjdu4yVJ1LgqS9/1QQZPMdG596HhsSRlWnGTTNP5RuhNQHyn4s
        +AC5KCE4VVAmzTCgidJM9s8w1w==
X-Google-Smtp-Source: ACcGV60CYRw78QFiGh1shlKHzhVXzyHv2gH8MJZ7fbxajiaVJxmfNYaxQWTKRjPIMmEzYWuOzSk8+A==
X-Received: by 2002:a17:902:6843:: with SMTP id f3-v6mr28236899pln.64.1539829723024;
        Wed, 17 Oct 2018 19:28:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id x13-v6sm30780195pge.13.2018.10.17.19.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 19:28:41 -0700 (PDT)
Date:   Wed, 17 Oct 2018 19:28:40 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86: ptrace.h: Make regs_get_kernel_stack_nth() not
 fault on bad stack
Message-ID: <20181018022840.GC99677@joelaf.mtv.corp.google.com>
References: <20181017165951.09119177@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017165951.09119177@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 04:59:51PM -0400, Steven Rostedt wrote:
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
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


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

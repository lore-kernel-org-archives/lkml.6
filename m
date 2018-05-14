Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeENTCE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:02:04 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:55682 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeENTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:02:02 -0400
Date: Mon, 14 May 2018 20:00:29 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 08/18] arm64: convert raw syscall invocation to C
Message-ID: <20180514180029.GA23250@light.dominikbrodowski.net>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-9-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-9-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
> +{
> +	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
> +				   regs->regs[2], regs->regs[3],
> +				   regs->regs[4], regs->regs[5]);
> +}

Any specific reason to have this in a separate function? This seems to be
called only from one instance, namely

> +asmlinkage void invoke_syscall(struct pt_regs *regs, int scno, int sc_nr,
> +			       syscall_fn_t syscall_table[])
> +{
> +	if (scno < sc_nr) {
> +		syscall_fn_t syscall_fn;
> +		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
> +		__invoke_syscall(regs, syscall_fn);
> +	} else {
> +		regs->regs[0] = do_ni_syscall(regs);
> +	}
> +}

and result in a one-liner in the last patch of the series.

Thanks,
	Dominik

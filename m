Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeERMqt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:46:49 -0400
Received: from foss.arm.com ([217.140.101.70]:52138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeERMqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:46:48 -0400
Date: Fri, 18 May 2018 13:46:36 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180518124605.GA13470@e103592.cambridge.arm.com>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180517181932.GW7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517181932.GW7753@e103592.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 07:19:43PM +0100, Dave Martin wrote:

[...]

> kernel_neon_begin() could then do
> 
> 	local_fpsimd_context_lock();
> 
> 	/* ... */
> 
> 	preempt_disable();
> 	local_unlock(fpsimd_context_lock);
> 
> ... with the following in kernel_neon_end():
> 
> 	local_unlock(fpsimd_lock);
> 	preempt_enable();
> 
> 
> If kernel-mode NEON was considered harmful to RT due to the context
> switch overheads, then the above might be overkill.  SVE will be worse
> in that regard, and also needs thinking about at some point -- I've not
> looked at if from the RT angle at all.

Hmmm, !KERNEL_MODE_NEON breaks EFI, so this probably does want looking
at.  Ard's recent rework to enable voluntary preemption the crypto
backends for arm64 [1] should reduce the fpsimd_lock blackouts, but it
still depends on the backends playing nice.

Cheers
---Dave

[1] [PATCH resend 00/10] crypto: arm64 - play nice with CONFIG_PREEMPT
lists.infradead.org/pipermail/linux-arm-kernel/2018-April/574819.html

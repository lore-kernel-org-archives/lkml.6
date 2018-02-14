Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbeBNI40 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:56:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbeBNI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:56:24 -0500
Date: Wed, 14 Feb 2018 09:56:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180214085614.GT25181@hirez.programming.kicks-ass.net>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 05:49:47PM -0800, Tim Chen wrote:

>  static inline void firmware_restrict_branch_speculation_start(void)
>  {
> +	if (this_cpu_inc_return(spec_ctrl_ibrs_fw_depth) == 1)
> +		alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
>  			      X86_FEATURE_USE_IBRS_FW);
>  }
>  
>  static inline void firmware_restrict_branch_speculation_end(void)
>  {
> +	if (this_cpu_dec_return(spec_ctrl_ibrs_fw_depth) == 0)
> +		alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
> +				      X86_FEATURE_USE_IBRS_FW);
>  }


At the very least this must disable and re-enable preemption, such that
we guarantee we inc/dec the same counter. ISTR some firmware calls (EFI)
actually are preemptible so that wouldn't work.

Further, consider:

	this_cpu_inc_return()		// 0->1
	<NMI>
		this_cpu_inc_return()	// 1->2
		call_broken_arse_firmware()
		this_cpu_dec_return()	// 2->1
	</NMI>
	wrmsr(SPEC_CTRL, IBRS);

	/* from dodgy firmware crap */

	this_cpu_dec_return()		// 1->0
	wrmsr(SPEC_CTRL, 0);

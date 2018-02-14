Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966796AbeBNETz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:19:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:9959 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966705AbeBNETy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:19:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="31241308"
Subject: Re: [PATCH] x86/entry/64: Fix CR3 restore order in paranoid_exit()
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
References: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9f6d258e-8191-9b57-4839-aa7c84e4c829@intel.com>
Date: Tue, 13 Feb 2018 20:19:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 06:27 PM, Josh Poimboeuf wrote:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1167,10 +1167,10 @@ ENTRY(paranoid_exit)
>  	UNWIND_HINT_REGS
>  	DISABLE_INTERRUPTS(CLBR_ANY)
>  	TRACE_IRQS_OFF_DEBUG
> +	RESTORE_CR3	scratch_reg=%r15 save_reg=%r14
>  	testl	%ebx, %ebx			/* swapgs needed? */
>  	jnz	.Lparanoid_exit_no_swapgs
>  	TRACE_IRQS_IRETQ
> -	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
>  	SWAPGS_UNSAFE_STACK
>  	jmp	.Lparanoid_exit_restore
>  .Lparanoid_exit_no_swapgs:

TRACE_IRQS_* call non-entry functions that are not mapped by the user
CR3.  How can this possibly work?  What am I missing?

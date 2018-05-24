Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969570AbeEXMBc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:01:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969155AbeEXMB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:01:26 -0400
Date: Thu, 24 May 2018 13:01:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 09/14] arm64: ssbd: Introduce thread flag to control
 userspace mitigation
Message-ID: <20180524120121.pjdw7qaybcsbf4fl@lakrids.cambridge.arm.com>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-10-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522150648.28297-10-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 04:06:43PM +0100, Marc Zyngier wrote:
> In order to allow userspace to be mitigated on demand, let's
> introduce a new thread flag that prevents the mitigation from
> being turned off when exiting to userspace, and doesn't turn
> it on on entry into the kernel (with the assumtion that the

Nit: s/assumtion/assumption/

> mitigation is always enabled in the kernel itself).
> 
> This will be used by a prctl interface introduced in a later
> patch.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

On the assumption that this flag cannot be flipped while a task is in
userspace:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/thread_info.h | 1 +
>  arch/arm64/kernel/entry.S            | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 740aa03c5f0d..cbcf11b5e637 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -94,6 +94,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_32BIT		22	/* 32bit process */
>  #define TIF_SVE			23	/* Scalable Vector Extension in use */
>  #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
> +#define TIF_SSBD		25	/* Wants SSB mitigation */
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index e6f6e2339b22..28ad8799406f 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -147,6 +147,8 @@ alternative_cb	arm64_enable_wa2_handling
>  alternative_cb_end
>  	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
>  	cbz	\tmp2, \targ
> +	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
> +	tbnz	\tmp2, #TIF_SSBD, \targ
>  	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
>  	mov	w1, #\state
>  alternative_cb	arm64_update_smccc_conduit
> -- 
> 2.14.2
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

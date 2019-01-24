Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D77C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAC02184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfAXRST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:18:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfAXRST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:18:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20877A78;
        Thu, 24 Jan 2019 09:18:19 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A9253F5AF;
        Thu, 24 Jan 2019 09:18:17 -0800 (PST)
Date:   Thu, 24 Jan 2019 17:18:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v14 07/12] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20190124171814.GD5531@lakrids.cambridge.arm.com>
References: <cover.1548346225.git.christophe.leroy@c-s.fr>
 <067ad3f669bdf5ad562186e9875b588f25732406.1548346225.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <067ad3f669bdf5ad562186e9875b588f25732406.1548346225.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:19:43PM +0000, Christophe Leroy wrote:
> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
> 
> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.
> 
> This has the following consequences:
> - thread_info is now located at the beginning of task_struct.
> - The 'cpu' field is now in task_struct, and only exists when
> CONFIG_SMP is active.
> - thread_info doesn't have anymore the 'task' field.
> 
> This patch:
> - Removes all recopy of thread_info struct when the stack changes.
> - Changes the CURRENT_THREAD_INFO() macro to point to current.
> - Selects CONFIG_THREAD_INFO_IN_TASK.
> - Modifies raw_smp_processor_id() to get ->cpu from current without
> including linux/sched.h to avoid circular inclusion and without
> including asm/asm-offsets.h to avoid symbol names duplication
> between ASM constants and C constants.
> - Modifies klp_init_thread_info() to take a task_struct pointer
> argument.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

[...]

> +ifdef CONFIG_SMP
> +prepare: task_cpu_prepare
> +
> +task_cpu_prepare: prepare0
> +	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TI_CPU") print $$3;}' include/generated/asm-offsets.h))
> +endif

[...]

> -#define raw_smp_processor_id()	(current_thread_info()->cpu)
> +/*
> + * This is particularly ugly: it appears we can't actually get the definition
> + * of task_struct here, but we need access to the CPU this task is running on.
> + * Instead of using task_struct we're using _TASK_CPU which is extracted from
> + * asm-offsets.h by kbuild to get the current processor ID.
> + *
> + * This also needs to be safeguarded when building asm-offsets.s because at
> + * that time _TASK_CPU is not defined yet. It could have been guarded by
> + * _TASK_CPU itself, but we want the build to fail if _TASK_CPU is missing
> + * when building something else than asm-offsets.s
> + */
> +#ifdef GENERATING_ASM_OFFSETS
> +#define raw_smp_processor_id()		(0)
> +#else
> +#define raw_smp_processor_id()		(*(unsigned int *)((void *)current + _TASK_CPU))
> +#endif
>  #define hard_smp_processor_id() 	(smp_hw_index[smp_processor_id()])

On arm64 we have the per-cpu offset in a CPU register (TPIDR_EL1), so we
can do:

DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);

#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))

... but I guess that's not possible on PPC for some reason?

I think I asked that before, but I couldn't find the thread.

Otherwise, this all looks sound to me, but I don't know much about PPC.

Thanks,
Mark.

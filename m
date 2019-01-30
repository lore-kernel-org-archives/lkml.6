Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB84C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583E420855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfA3M1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:27:08 -0500
Received: from ozlabs.org ([203.11.71.1]:51647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfA3M1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:27:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qN0R0rxpz9sBZ;
        Wed, 30 Jan 2019 23:27:03 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org
Cc:     Balbir Singh <bsingharora@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 1/4] powerpc/64s: Clear on-stack exception marker upon exception return
In-Reply-To: <20190122155724.27557-2-joe.lawrence@redhat.com>
References: <20190122155724.27557-1-joe.lawrence@redhat.com> <20190122155724.27557-2-joe.lawrence@redhat.com>
Date:   Wed, 30 Jan 2019 23:27:02 +1100
Message-ID: <87tvhqpbzd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Lawrence <joe.lawrence@redhat.com> writes:
> From: Nicolai Stange <nstange@suse.de>
>
> The ppc64 specific implementation of the reliable stacktracer,
> save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
> trace" whenever it finds an exception frame on the stack. Stack frames
> are classified as exception frames if the STACK_FRAME_REGS_MARKER magic,
> as written by exception prologues, is found at a particular location.
>
> However, as observed by Joe Lawrence, it is possible in practice that
> non-exception stack frames can alias with prior exception frames and thus,
> that the reliable stacktracer can find a stale STACK_FRAME_REGS_MARKER on
> the stack. It in turn falsely reports an unreliable stacktrace and blocks
> any live patching transition to finish. Said condition lasts until the
> stack frame is overwritten/initialized by function call or other means.
>
> In principle, we could mitigate this by making the exception frame
> classification condition in save_stack_trace_tsk_reliable() stronger:
> in addition to testing for STACK_FRAME_REGS_MARKER, we could also take into
> account that for all exceptions executing on the kernel stack
> - their stack frames's backlink pointers always match what is saved
>   in their pt_regs instance's ->gpr[1] slot and that
> - their exception frame size equals STACK_INT_FRAME_SIZE, a value
>   uncommonly large for non-exception frames.
>
> However, while these are currently true, relying on them would make the
> reliable stacktrace implementation more sensitive towards future changes in
> the exception entry code. Note that false negatives, i.e. not detecting
> exception frames, would silently break the live patching consistency model.
>
> Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
> rely on STACK_FRAME_REGS_MARKER as well.
>
> Make the exception exit code clear the on-stack STACK_FRAME_REGS_MARKER
> for those exceptions running on the "normal" kernel stack and returning
> to kernelspace: because the topmost frame is ignored by the reliable stack
> tracer anyway, returns to userspace don't need to take care of clearing
> the marker.
>
> Furthermore, as I don't have the ability to test this on Book 3E or
> 32 bits, limit the change to Book 3S and 64 bits.
>
> Finally, make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
> PPC_BOOK3S_64 for documentation purposes. Before this patch, it depended
> on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN implies
> PPC_BOOK3S_64, there's no functional change here.

That has nothing to do with the fix and should really be in a separate
patch.

I can split it when applying.

cheers

> Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  arch/powerpc/Kconfig           | 2 +-
>  arch/powerpc/kernel/entry_64.S | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2890d36eb531..73bf87b1d274 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -220,7 +220,7 @@ config PPC
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_RCU_TABLE_FREE		if SMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> -	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
> +	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
>  	select HAVE_IRQ_TIME_ACCOUNTING
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 435927f549c4..a2c168b395d2 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1002,6 +1002,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	ld	r2,_NIP(r1)
>  	mtspr	SPRN_SRR0,r2
>  
> +	/*
> +	 * Leaving a stale exception_marker on the stack can confuse
> +	 * the reliable stack unwinder later on. Clear it.
> +	 */
> +	li	r2,0
> +	std	r2,STACK_FRAME_OVERHEAD-16(r1)
> +
>  	ld	r0,GPR0(r1)
>  	ld	r2,GPR2(r1)
>  	ld	r3,GPR3(r1)
> -- 
> 2.20.1

Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45030C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F241926942
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F241926942
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964884AbeFZKbW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:31:22 -0400
Received: from foss.arm.com ([217.140.101.70]:43126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933870AbeFZKbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:31:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E39027A9;
        Tue, 26 Jun 2018 03:31:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251F23F5AF;
        Tue, 26 Jun 2018 03:31:17 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:31:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        peter.maydell@linaro.org
Subject: Re: [PATCH 1/3] arm64: rseq: Implement backend rseq calls and select
 HAVE_RSEQ
Message-ID: <20180626103114.ddu62cccupjdo2ia@lakrids.cambridge.arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-2-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529949285-11013-2-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 06:54:43PM +0100, Will Deacon wrote:
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 28ad8799406f..1eda9e1a1f4a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -904,6 +904,7 @@ ENDPROC(el0_error)
>  ret_fast_syscall:
>  	disable_daif
>  	str	x0, [sp, #S_X0]			// returned x0
> +#ifndef CONFIG_DEBUG_RSEQ
>  	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
>  	and	x2, x1, #_TIF_SYSCALL_WORK
>  	cbnz	x2, ret_fast_syscall_trace
> @@ -911,6 +912,7 @@ ret_fast_syscall:
>  	cbnz	x2, work_pending
>  	enable_step_tsk x1, x2
>  	kernel_exit 0
> +#endif
>  ret_fast_syscall_trace:
>  	enable_daif
>  	b	__sys_trace_return_skipped	// we already saved x0

I *think* this is ok, since we re-check the TIF bits in
syscall_trace_exit().

This does mean that we'd now always call audit_syscall_exit(),
regardless of TIF_AUDIT, but there are already cases when we call that
with TIF_AUDIT clear, so I think if that's a problem it's a latent bug.
Likewise for audit_syscall_entry().

It seems we're in the same boat as other architectures there,
regardless.

FWIW, for the entry bits:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

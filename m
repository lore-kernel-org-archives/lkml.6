Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D227C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46E021477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46E021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeJRVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:55:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34633 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeJRVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:55:13 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gD8kF-0001PK-Q4; Thu, 18 Oct 2018 15:53:47 +0200
Date:   Thu, 18 Oct 2018 15:53:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 10/13] x86/speculation: Add per thread STIBP flag
In-Reply-To: <1e4031d6642d6a835d33651fd5d8f614d95daee5.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181548540.1647@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <1e4031d6642d6a835d33651fd5d8f614d95daee5.1539798901.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Tim Chen wrote:

Again the subject is misleading, It's suggesting that it adds a per thread
flag. But the patch does way more than that.

> Add per thread STIBP flag. When context switching to a process thread that
> has the STIBP flag, the STIBP bit in the SPEC_CTRL MSR will be turned
> on to guard against application to application Spectre v2 attack. When
> switching to a non-security sensitive thread that doesn't have STIBP flag,
> the STIBP bit in the SPEC_CTRL MSR is turned off.

I think I gave you quite some examples how such a changelog should look like.

> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -83,6 +83,7 @@ struct thread_info {
>  #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
>  #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>  #define TIF_SECCOMP		8	/* secure computing */
> +#define TIF_STIBP              9       /* Single threaded indirect branch predict */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
>  #define TIF_UPROBE		12	/* breakpointed or singlestepping */
>  #define TIF_PATCH_PENDING	13	/* pending live patching update */
> @@ -110,6 +111,7 @@ struct thread_info {
>  #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> +#define _TIF_STIBP		(1 << TIF_STIBP)
>  #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
> @@ -146,7 +148,8 @@ struct thread_info {
>  
>  /* flags to check in __switch_to() */
>  #define _TIF_WORK_CTXSW							\
> -	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
> +	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
> +	 _TIF_SSBD|_TIF_STIBP)

These flags are at random locations. I wonder whether they should be
grouped together. Might not influence code generation, but at least worth
to have a look.

> +	/*
> +	 * Need STIBP defense against Spectre v2 attack
> +	 * if SMT is in use and we don't have enhanced IBRS.

and enhanced IBRS is not supported.

> +	 */
> +	if (static_branch_likely(&cpu_smt_enabled) &&
> +	    !static_branch_unlikely(&spectre_v2_enhanced_ibrs))
> +		msr |= stibp_tif_to_spec_ctrl(tifn);
> +
>  	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
>  }

Thanks,

	tglx

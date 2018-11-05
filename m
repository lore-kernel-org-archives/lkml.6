Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B2720882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B2720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeKFI07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:26:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeKFI07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:26:59 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJnv9-0006tq-8T; Tue, 06 Nov 2018 00:04:35 +0100
Date:   Tue, 6 Nov 2018 00:04:34 +0100 (CET)
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
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [Patch v4 17/18] x86/speculation: Update SPEC_CTRL MSRs of remote
 CPUs
In-Reply-To: <ea646842-bd32-3615-bf38-27b568a2d81e@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811052326040.1659@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <a14236d8b56dafe6988ce1b266a6e929be5296a8.1540923609.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811042042060.10744@nanos.tec.linutronix.de>
 <ea646842-bd32-3615-bf38-27b568a2d81e@linux.intel.com>
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

Tim,

On Mon, 5 Nov 2018, Tim Chen wrote:
> How about sending an IPI if a remote CPU needs to have its SPEC_CTRL MSR
> updated?
> 
> Something like the following to replace this patch?

...

> +static void spec_ctrl_update_func(void *info)
> +{
> +	speculation_ctrl_update(task_thread_info(current)->flags);
> +}
> +
>  static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
>  {
>  	bool update = false;
> +	int cpu;
>  
>  	if (!static_branch_unlikely(&spectre_v2_app_lite))
>  		return;
> @@ -789,6 +795,12 @@ static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
>  
>  	if (tsk == current)
>  		speculation_ctrl_update_current();
> +	else {
> +		cpu = task_cpu(tsk);
> +		if (cpu != smp_processor_id())
> +			smp_call_function_single(cpu, spec_ctrl_update_func,
> +						 NULL, false); 
> +	}


Aside of the condition being pointless in that case, that issues an IPI
whether the task is running or not. So this allows a task to issue tons of
async IPIs disturbing others by toggling the control.

I'm less and less convinced that piggybacking this on dumpable is a good
idea. It's lots of extra code and the security people are not really happy
about the whole thing either.

Can we please start out with the SSBD model and make use of the PRCTL and
the seccomp mitigation control?

Kees?

Thanks,

	tglx



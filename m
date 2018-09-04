Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE58C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8021320661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8021320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDUox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:44:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57512 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeIDUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:44:53 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxE2Z-000293-N5; Tue, 04 Sep 2018 18:18:55 +0200
Date:   Tue, 4 Sep 2018 18:18:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm>
Message-ID: <alpine.DEB.2.21.1809041804080.3395@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Jiri Kosina wrote:
>  		if (tsk && tsk->mm &&
>  		    tsk->mm->context.ctx_id != last_ctx_id &&
> -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> +		    ___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))

Uurgh. If X86_FEATURE_USE_IBPB is not enabled, then the whole
__ptrace_may_access() overhead is just done for nothing.

>  			indirect_branch_prediction_barrier();

This really wants to be runtime patched:

		if (static_cpu_has(X86_FEATURE_USE_IBPB))
			stop_speculation(tsk, last_ctx_id);			

and have an inline for that:

static inline void stop_speculation(struct task_struct *tsk, u64 last_ctx_id)
{
	if (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
		___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
		indirect_branch_prediction_barrier();
}

which also makes the whole mess readable.

Hmm?

Thanks,

	tglx




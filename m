Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31145C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3132145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3132145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeJRXcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:32:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbeJRXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:32:53 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDAGN-0004As-2o; Thu, 18 Oct 2018 17:31:03 +0200
Date:   Thu, 18 Oct 2018 17:31:02 +0200 (CEST)
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
Subject: Re: [Patch v3 13/13] x86/speculation: Create PRCTL interface to
 restrict indirect branch speculation
In-Reply-To: <a04ba925a19af6ad5eaad2bc5501b7ea1ece66a9.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181717410.3566@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <a04ba925a19af6ad5eaad2bc5501b7ea1ece66a9.1539798901.git.tim.c.chen@linux.intel.com>
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

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4196,7 +4196,10 @@
>  			lite   - turn on mitigation for non-dumpable
>  				 processes (i.e. protect daemons and other
>  				 privileged processes that tend to be
> -				 non-dumpable).
> +				 non-dumpable), and processes that has indirect
> +				 branch speculation restricted via prctl's
> +				 PR_SET_SPECULATION_CTRL option

				Protect processes which are marked non-dumpable and
				processes which have requested restricted indirect
				branch speculation via the PR_SET_SPECULATION_CTRL
				ptrcl().

> @@ -92,3 +92,13 @@ Speculation misfeature controls
>     * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
>     * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
>     * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
> +
> +- PR_INDIR_BRANCH: Indirect Branch Speculation in Applications
> +                   (Mitigate Spectre V2 style user space application
> +                    to application attack)

No. Please do not create a random name space. We have

    PR_SPEC_STORE_BYPASS

so the logical name for this is

    PR_SPEC_INDIR_BRANCH


> +static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
> +{
> +	bool update;
> +
> +	switch (ctrl) {
> +	case PR_SPEC_ENABLE:
> +		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
> +			return 0;
> +		/*
> +		 * Indirect branch speculation is always disabled in
> +		 * strict mode or if the application is non dumpable
> +		 * in lite mode. 
> +		 */
> +		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
> +			return -ENXIO;

Please stay consistent with ssb_prctl_set(). EPERM is what you want here.

> +		if (task->mm && get_dumpable(task->mm) != SUID_DUMP_USER)
> +			return -ENXIO;

Ditto

> +		task_clear_spec_indir_branch_disable(task);
> +		update = test_and_clear_tsk_thread_flag(task, TIF_STIBP);
> +		break;
> +	case PR_SPEC_DISABLE:
> +		/*
> +		 * Indirect branch speculation is always enabled when
> +		 * app to app mitigation is off.
> +		 */
> +		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
> +			return -ENXIO;
> +		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
> +			return 0;
> +		task_set_spec_indir_branch_disable(task);
> +		update = !test_and_set_tsk_thread_flag(task, TIF_STIBP);
> +		break;
> +	case PR_SPEC_FORCE_DISABLE:
> +		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
> +			return -ENXIO;
> +		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
> +			return 0;
> +		task_set_spec_indir_branch_disable(task);
> +		task_set_spec_indir_branch_force_disable(task);
> +		update = !test_and_set_tsk_thread_flag(task, TIF_STIBP);
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	/*
> +	 * If being set on non-current task, delay setting the CPU
> +	 * mitigation until it is next scheduled.
> +	 * Use speculative_store_bypass_update will update SPEC_CTRL MSR

Stale comment.

> +	 */
> +	if (task == current && update)
> +		speculation_ctrl_update_current();
> +
> +	return 0;
> +}

Aside of that several patches have trailing whitespace. Please be more careful.

Thanks,

	tglx

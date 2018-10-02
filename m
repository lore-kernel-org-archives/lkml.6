Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CD020652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CD020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJCCt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:49:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60928 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:49:28 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Qtq-0002K0-7H; Tue, 02 Oct 2018 22:04:06 +0200
Date:   Tue, 2 Oct 2018 22:04:05 +0200 (CEST)
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
Subject: Re: [Patch v2 1/4] x86/speculation: Option to select app to app
 mitigation for spectre_v2
In-Reply-To: <cb7314d6deb8d1c58e2ead56fef8848b642e4e5a.1537920575.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810022145570.1435@nanos.tec.linutronix.de>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com> <cb7314d6deb8d1c58e2ead56fef8848b642e4e5a.1537920575.git.tim.c.chen@linux.intel.com>
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

On Tue, 25 Sep 2018, Tim Chen wrote:
> +enum spectre_v2_app2app_mitigation {
> +	SPECTRE_V2_APP2APP_NONE,
> +	SPECTRE_V2_APP2APP_LITE,
> +	SPECTRE_V2_APP2APP_STRICT,
> +};
>  
>  static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
>  	SPECTRE_V2_NONE;
>  
> +static enum spectre_v2_mitigation spectre_v2_app2app_enabled __ro_after_init =

Copy and paste. The enum type is wrong.

> +	SPECTRE_V2_APP2APP_NONE;
> +

> +static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_app2app_cmdline(void)

Ditto

> +{
> +	char arg[20];
> +	int ret, i;
> +	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_APP2APP_CMD_AUTO;

Please use reverse fir tree ordering of the variables:

	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_APP2APP_CMD_AUTO;
	char arg[20];
	int ret, i;

> +
> +	ret = cmdline_find_option(boot_command_line, "spectre_v2_app2app", arg, sizeof(arg));

Line break around 78 please

> @@ -325,6 +383,9 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  
>  static bool stibp_needed(void)
>  {
> +	if (static_branch_unlikely(&spectre_v2_app_lite))
> +		return false;
> +
>  	if (spectre_v2_enabled == SPECTRE_V2_NONE)
>  		return false;
>  
> @@ -366,7 +427,9 @@ void arch_smt_update(void)
>  static void __init spectre_v2_select_mitigation(void)
>  {
>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> +	enum spectre_v2_app2app_mitigation_cmd app2app_cmd = spectre_v2_parse_app2app_cmdline();

Please avoid these overlong lines. Move the initialization to the code if
it does not fit into the declaration part.

>  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> +	enum spectre_v2_app2app_mitigation app2app_mode = SPECTRE_V2_APP2APP_NONE;

>  	/*
>  	 * If the CPU is not affected and the command line mode is NONE or AUTO
> @@ -376,6 +439,17 @@ static void __init spectre_v2_select_mitigation(void)
>  	    (cmd == SPECTRE_V2_CMD_NONE || cmd == SPECTRE_V2_CMD_AUTO))
>  		return;
>  
> +	switch (app2app_cmd) {
> +	case SPECTRE_V2_APP2APP_CMD_LITE:
> +	case SPECTRE_V2_APP2APP_CMD_AUTO:
> +		app2app_mode = SPECTRE_V2_APP2APP_LITE;
> +		break;
> +
> +	case SPECTRE_V2_APP2APP_CMD_STRICT:
> +		app2app_mode = SPECTRE_V2_APP2APP_STRICT;
> +		break;
> +	}
> +
>  	switch (cmd) {
>  	case SPECTRE_V2_CMD_NONE:
>  		return;
> @@ -427,6 +501,11 @@ static void __init spectre_v2_select_mitigation(void)
>  	}
>  
>  specv2_set_mode:
> +	spectre_v2_app2app_enabled = app2app_mode;
> +	pr_info("%s\n", spectre_v2_app2app_strings[app2app_mode]);
> +	if (app2app_mode == SPECTRE_V2_APP2APP_LITE)
> +		static_branch_enable(&spectre_v2_app_lite);
> +
>  	spectre_v2_enabled = mode;
>  	pr_info("%s\n", spectre_v2_strings[mode]);
>  
> @@ -441,8 +520,8 @@ static void __init spectre_v2_select_mitigation(void)
>  	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
>  	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
>  
> -	/* Initialize Indirect Branch Prediction Barrier if supported */
> -	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> +	/* Initialize Indirect Branch Prediction Barrier if supported and not disabled */
> +	if (boot_cpu_has(X86_FEATURE_IBPB) && app2app_mode != SPECTRE_V2_APP2APP_NONE) {

Line breaks exist for a reason. Applies to comments and code.

>  		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
>  		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
>  	}
> @@ -875,8 +954,16 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
>  
>  	case X86_BUG_SPECTRE_V2:
>  		mutex_lock(&spec_ctrl_mutex);
> -		ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> -			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
> +		if (static_branch_unlikely(&spectre_v2_app_lite))
> +			ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> +			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB-lite" : "",
> +			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
> +			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
> +			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
> +			       spectre_v2_module_string());
> +		else
> +			ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> +			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB-strict" : "",
>  			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
>  			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
>  			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",

Why do you need to copy the whole thing? What's wrong with using
spectre_v2_app2app_enabled for getting the proper string for the IBPB
mitigation?

> -	 * Check if the current (previous) task has access to the memory
> -	 * of the @tsk (next) task. If access is denied, make sure to
> +	 * For lite protection mode, we only protect the non-dumpable
> +	 * processes.
> +	 *
> +	 * Otherwise check if the current (previous) task has access to the memory
> +	 * of the @tsk (next) task for strict app to app protection.
> +	 * If access is denied, make sure to
>  	 * issue a IBPB to stop user->user Spectre-v2 attacks.
>  	 *
>  	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
>  	 */
> -	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
> -			__ptrace_may_access(tsk, PTRACE_MODE_IBPB));

Needs to be updated to the latest code in tip x86/pti

> +	/* skip IBPB if no context changes */
> +	if (!tsk || !tsk->mm || tsk->mm->context.ctx_id == last_ctx_id)
> +		return false;
> +
> +	if (static_branch_unlikely(&spectre_v2_app_lite))
> +		return (get_dumpable(tsk->mm) != SUID_DUMP_USER);
> +	else
> +		return (__ptrace_may_access(tsk, PTRACE_MODE_IBPB));

Neither of the branches needs braces for the return 

Thanks,

	tglx

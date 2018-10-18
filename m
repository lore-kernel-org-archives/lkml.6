Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3164C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AEF20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AEF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeJRXOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:14:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35162 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeJRXOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:14:51 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gD9yv-0003nb-VV; Thu, 18 Oct 2018 17:13:02 +0200
Date:   Thu, 18 Oct 2018 17:12:58 +0200 (CEST)
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
Subject: Re: [Patch v3 11/13] x86/speculation: Add Spectre v2 lite app to
 app protection mode
In-Reply-To: <a03fbbc07890ef40efece08680c597faea2a1d26.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181617060.3566@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <a03fbbc07890ef40efece08680c597faea2a1d26.1539798901.git.tim.c.chen@linux.intel.com>
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

> Currently the STIBP is always turned on for CPUs vulnerable to Spectre V2.
> A new lite protection mode option is created.  In this new mode, we protect
> security sensitive processes with STIBP and IBPB against application to
> application attack based on its process property or security level. This
> will allow non security sensitive processes not needing the protection
> avoid overhead associated with STIBP and IBPB.

This is again a big lump with no significant structure. Please reword.

> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  18 ++++
>  arch/x86/include/asm/nospec-branch.h            |   7 ++
>  arch/x86/kernel/cpu/bugs.c                      | 135 ++++++++++++++++++++++--
>  arch/x86/mm/tlb.c                               |  19 +++-
>  4 files changed, 166 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 64a3bf5..2feb6b2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4186,6 +4186,24 @@
>  			Not specifying this option is equivalent to
>  			spectre_v2=auto.
>  
> +	spectre_v2_app2app=
> +			[X86] Control mitigation of Spectre variant 2
> +		        application to application (indirect branch speculation)
> +			vulnerability.
> +
> +			off    - turn off Spectre v2 application to
> +				 application attack mitigation

  Please start the explanations with an upper case letter. And there is no
  point to repeat the 'Spectre v2 application to application attack' thing
  over and over. It's explained above with the command line switch.

       	Disable mitigation

  is really sufficient.

> +			lite   - turn on mitigation for non-dumpable
> +				 processes (i.e. protect daemons and other
> +				 privileged processes that tend to be
> +				 non-dumpable).

  			tend to be?

	 Turn on mitigation for processes, which are
	 marked non-dumpable.

> +			strict - protect against attacks for all user processes

  	 Protect all processes

> +			auto   - let kernel decide lite or strict mode

  	 Kernel selects the mode

> +			Not specifying this option is equivalent to
> +			spectre_v2_app2app=auto.  Setting spectre_v2=off will 
> +			also turn off this mitigation.

Please split this into two paragraphs so the latter stands out more.

> +enum spectre_v2_app2app_mitigation_cmd {
> +	SPECTRE_V2_APP2APP_CMD_NONE,
> +	SPECTRE_V2_APP2APP_CMD_AUTO,
> +	SPECTRE_V2_APP2APP_CMD_LITE,
> +	SPECTRE_V2_APP2APP_CMD_STRICT,
> +};
> +
>  static const char *spectre_v2_strings[] = {
>  	[SPECTRE_V2_NONE]			= "Vulnerable",
>  	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
> @@ -142,6 +149,17 @@ static const char *spectre_v2_strings[] = {
>  	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
>  };
>  
> +static const char *spectre_v2_app2app_strings[] = {
> +	[SPECTRE_V2_APP2APP_NONE]   = "App-App Vulnerable",
> +	[SPECTRE_V2_APP2APP_LITE]   = "App-App Mitigation: Protect non-dumpable"
> +				      " and indirect branch restricted process",

Please do not split strings. 

> +	[SPECTRE_V2_APP2APP_STRICT] = "App-App Mitigation: Full app to app"
> +				      " attack protection",
> +};
> +
> +DEFINE_STATIC_KEY_FALSE(spectre_v2_app_lite);
> +EXPORT_SYMBOL(spectre_v2_app_lite);
> +
>  DEFINE_STATIC_KEY_FALSE(spectre_v2_enhanced_ibrs);
>  EXPORT_SYMBOL(spectre_v2_enhanced_ibrs);
>  
> @@ -151,6 +169,9 @@ EXPORT_SYMBOL(spectre_v2_enhanced_ibrs);
>  static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
>  	SPECTRE_V2_NONE;
>  
> +static enum spectre_v2_app2app_mitigation
> +	spectre_v2_app2app_enabled __ro_after_init = SPECTRE_V2_APP2APP_NONE;
> +
>  void
>  x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
>  {
> @@ -172,6 +193,9 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
>  		    static_cpu_has(X86_FEATURE_AMD_SSBD))
>  			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
>  
> +		if (static_branch_unlikely(&spectre_v2_app_lite))
> +			hostval |= stibp_tif_to_spec_ctrl(ti->flags);
> +
>  		if (hostval != guestval) {
>  			msrval = setguest ? guestval : hostval;
>  			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
> @@ -278,6 +302,52 @@ static const struct {
>  	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
>  };
>  
> +static const struct {
> +	const char *option;
> +	enum spectre_v2_app2app_mitigation_cmd cmd;
> +	bool secure;
> +} app2app_mitigation_options[] = {
> +	{ "off",	SPECTRE_V2_APP2APP_CMD_NONE,   false },
> +	{ "lite",	SPECTRE_V2_APP2APP_CMD_LITE,   false },
> +	{ "strict",	SPECTRE_V2_APP2APP_CMD_STRICT, false },
> +	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,   false },

So all of those options are insecure, right? Why do we need them at all?

> +};
> +
> +static enum spectre_v2_app2app_mitigation_cmd __init
> +		spectre_v2_parse_app2app_cmdline(void)
> +{
> +	enum spectre_v2_app2app_mitigation_cmd cmd;
> +	char arg[20];
> +	int ret, i;
> +
> +	cmd = SPECTRE_V2_APP2APP_CMD_AUTO;
> +	ret = cmdline_find_option(boot_command_line, "spectre_v2_app2app",
> +					arg, sizeof(arg));

Please align the first argument in the second line with the first argument
of the upper line.

> +	if (ret < 0)
> +		return SPECTRE_V2_APP2APP_CMD_AUTO;
> +
> +	for (i = 0; i < ARRAY_SIZE(app2app_mitigation_options); i++) {
> +		if (!match_option(arg, ret,
> +				  app2app_mitigation_options[i].option))

If you'd shorten the length of that array name, you could spare the ugly
line breaks.

> +			continue;
> +		cmd = app2app_mitigation_options[i].cmd;
> +		break;
> +	}
> +
> +	if (i >= ARRAY_SIZE(app2app_mitigation_options)) {
> +		pr_err("unknown app to app protection option (%s). "
> +		       "Switching to AUTO select\n", arg);
> +		return SPECTRE_V2_APP2APP_CMD_AUTO;
> +	}
> +
> +	if (app2app_mitigation_options[i].secure)
> +		spec2_print_if_secure(app2app_mitigation_options[i].option);
> +	else
> +		spec2_print_if_insecure(app2app_mitigation_options[i].option);
> +
> +	return cmd;
> +}
> +
>  static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  {
>  	char arg[20];
> @@ -330,14 +400,22 @@ static bool stibp_needed(void)
>  	/*
>  	 * Determine if we want to leave STIBP always on.
>  	 * Using enhanced IBRS makes using STIBP unnecessary.
> +	 * For lite option, we enable STIBP based on a process's
> +	 * flag during context switch.
>  	 */
>  
>  	if (static_branch_unlikely(&spectre_v2_enhanced_ibrs))
>  		return false;
>  
> +	if (static_branch_unlikely(&spectre_v2_app_lite))
> +		return false;
> +
>  	if (spectre_v2_enabled == SPECTRE_V2_NONE)
>  		return false;

This should be the first check, really because everything else is
irrelevant when this is false. I missed that in the patch which added the
enhanced ibrs check above.

> +	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
> +		return false;
> +
>  	if (!boot_cpu_has(X86_FEATURE_STIBP))
>  		return false;
>  
> @@ -377,7 +455,11 @@ static void __init spectre_v2_select_mitigation(void)
>  {
>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
>  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> +	enum spectre_v2_app2app_mitigation_cmd app2app_cmd;
> +	enum spectre_v2_app2app_mitigation app2app_mode;
>  
> +	app2app_cmd = spectre_v2_parse_app2app_cmdline();

You can avoid the parsing when neither IBPB nor STIBP are available. So
please move this further down.

> +	app2app_mode = SPECTRE_V2_APP2APP_NONE;

This can go right before the IBPB or STIBP check.

>  	/*
>  	 * If the CPU is not affected and the command line mode is NONE or AUTO
>  	 * then nothing to do.
> @@ -398,7 +480,7 @@ static void __init spectre_v2_select_mitigation(void)
>  			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
>  			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>  			static_branch_enable(&spectre_v2_enhanced_ibrs);
> -			goto specv2_set_mode;
> +			goto specv2_app_set_mode;
>  		}
>  		if (IS_ENABLED(CONFIG_RETPOLINE))
>  			goto retpoline_auto;
> @@ -437,7 +519,31 @@ static void __init spectre_v2_select_mitigation(void)
>  		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
>  	}
>  
> +specv2_app_set_mode:
> +	if (!boot_cpu_has(X86_FEATURE_IBPB) ||
> +	    !boot_cpu_has(X86_FEATURE_STIBP))
> +		goto specv2_set_mode;	
> +
> +	switch (app2app_cmd) {
> +	case SPECTRE_V2_APP2APP_CMD_NONE:
> +		break;	
> +
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
>  specv2_set_mode:
> +	spectre_v2_app2app_enabled = app2app_mode;
> +	pr_info("%s\n", spectre_v2_app2app_strings[app2app_mode]);
> +	if (app2app_mode == SPECTRE_V2_APP2APP_LITE)
> +		static_branch_enable(&spectre_v2_app_lite);
> +
>  	spectre_v2_enabled = mode;
>  	pr_info("%s\n", spectre_v2_strings[mode]);

This is weird. Why can't you leave the current code as is including the
jump label and then add the app2app stuff underneath. I really wondered
where mode is gone and it makes the code hard to follow for no value. The
the second label becomes specv2_app_set_mode, which actually makes way more
sense than the above convolution.

>  	case X86_BUG_SPECTRE_V2:
> -		return sprintf(buf, "%s%s%s%s%s%s\n",
> +		return sprintf(buf, "%s%s%s%s%s%s%s\n",
>  			spectre_v2_strings[spectre_v2_enabled],
> -			boot_cpu_has(X86_FEATURE_USE_IBPB) ?
> -				   ", IBPB" : "",
> +			spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE ||
> +			    !boot_cpu_has(X86_FEATURE_USE_IBPB) ?
> +				   "" :
> +			    spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_LITE ?
> +				   ", IBPB-lite" : ", IBPB-strict",
> +			spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE ||
> +		            spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED ||
> +			    !boot_cpu_has(X86_FEATURE_STIBP) ?
> +				   "" :
> +			    spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_LITE ?
> +				   ", STIBP-lite" : ", STIBP-strict",

So by now this is completely unparseable really. Please split it apart.

>  			boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ?
>  				   ", IBRS_FW" : "",
>  			spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED ?
> -				   ", Enhanced IBRS" :
> -			    (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ?
> -				   ", STIBP" : "",
> +				   ", Enhanced IBRS" : "",
>  			boot_cpu_has(X86_FEATURE_RSB_CTXSW) ?
>  				   ", RSB filling" : "",
>  			spectre_v2_module_string());
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 073b8df..1bd1597 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -184,14 +184,25 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
>  static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
>  {
>  	/*
> -	 * Check if the current (previous) task has access to the memory
> -	 * of the @tsk (next) task. If access is denied, make sure to
> +	 * For lite protection mode, we protect processes  
> +	 * marked with STIBP flag needing app to app proection.
> +	 *

  	 * If lite protection mode is enabled, check the STIBP thread flag.

Hmm?

> +	 * Otherwise check if the current (previous) task has access to the
> +	 * the memory of the @tsk (next) task for strict app to app protection.
> +	 * If access is denied, make sure to
>  	 * issue a IBPB to stop user->user Spectre-v2 attacks.

Sigh. Can you please format the result properly?

>  	 *
>  	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
>  	 */
> -	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
> -		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
> +
> +	/* skip IBPB if no context changes */

Sentences start with capital letters.

	/*
	 * Don't issue IBPB when switching to kernel threads or staying in the
	 * same mm context.
	 */

Gives a bit more accurate information, hmm?

> +	if (!tsk || !tsk->mm || tsk->mm->context.ctx_id == last_ctx_id)
> +		return false;

And this check along with the comment wants to move above the other comment
which is related to the below:

> +
> +	if (static_branch_unlikely(&spectre_v2_app_lite))
> +		return task_thread_info(tsk)->flags & _TIF_STIBP;
> +	else
> +		return ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB);
>  }

Thanks,

	tglx

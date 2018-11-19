Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA06CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EE32080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE32080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbeKTHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:12:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39719 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbeKTHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:12:27 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOqRR-0002Wd-Ca; Mon, 19 Nov 2018 21:46:45 +0100
Date:   Mon, 19 Nov 2018 21:46:44 +0100 (CET)
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811192133240.1669@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
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

On Fri, 16 Nov 2018, Tim Chen wrote:
> +static const struct {
> +	const char *option;
> +	enum spectre_v2_app2app_mitigation_cmd cmd;
> +	bool secure;
> +} app2app_options[] = {
> +	{ "off",	SPECTRE_V2_APP2APP_CMD_NONE,   false },
> +	{ "lite",	SPECTRE_V2_APP2APP_CMD_LITE,   false },
> +	{ "strict",	SPECTRE_V2_APP2APP_CMD_STRICT, false },
> +	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,   false },
> +	/*
> +	 * The "on" option is kept as last entry. It is implied by
> +	 * spectre_v2=on boot parameter and it is not checked
> +	 * in spectre_v2_app2app boot parameter.
> +	 */
> +	{ "on",		SPECTRE_V2_APP2APP_CMD_FORCE,  true  },

FORCE is the same as STRICT. What's the point?

> @@ -376,6 +464,8 @@ static void __init spectre_v2_select_mitigation(void)
>  {
>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
>  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> +	enum spectre_v2_app2app_mitigation_cmd app2app_cmd;
> +	enum spectre_v2_app2app_mitigation app2app_mode;
>  
>  	/*
>  	 * If the CPU is not affected and the command line mode is NONE or AUTO
> @@ -452,12 +542,6 @@ static void __init spectre_v2_select_mitigation(void)
>  	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
>  	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
>  
> -	/* Initialize Indirect Branch Prediction Barrier if supported */
> -	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> -		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> -		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
> -	}
> -
>  	/*
>  	 * Retpoline means the kernel is safe because it has no indirect
>  	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
> @@ -474,6 +558,43 @@ static void __init spectre_v2_select_mitigation(void)
>  		pr_info("Enabling Restricted Speculation for firmware calls\n");
>  	}
>  
> +	app2app_mode = SPECTRE_V2_APP2APP_NONE;
> +	if (!boot_cpu_has(X86_FEATURE_IBPB) ||
> +	    !boot_cpu_has(X86_FEATURE_STIBP))
> +		goto set_app2app_mode;

So before that change IBPB was usable without STIBP, now not longer. What's
the rationale?

This patch changes a gazillion things at once and is completely
unreviewable.

Thanks,

	tglx

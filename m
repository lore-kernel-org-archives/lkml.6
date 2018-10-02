Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3426C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF5F20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBCwSrfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF5F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJBQFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:05:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39498 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeJBQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:05:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so586164wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pgbXP7GwmmN+py9xOZsbQYjAr0SryI0mb3a5P/gh0o=;
        b=fBCwSrfwfRLe7lFwaT0Mg0l9A8so/Fm8Y3OnocWmCcD9XQyfBEpIYj8+pj8kslekW6
         UPn/6YHcO/c9ISmIeq86I2ymHnbmxKsBekR0MagNllxJY6/qc/pwvANMhgOQyTpH51OG
         mARE8iYEqbgQ5TNY6oaMOdtQ86fSCXATRosDYJ97WK+vraMnbsLdD31ytPkaWwhel+I8
         Aijz49bMRgc1s43iE1JwECjWkcssQH48Bspz7LZ/SSSnOTxxqw508XYooDbJyZkmR9pA
         z7yL6ODTGqJUxET7l02VRXrnkux/Z3TlgitmQVK/L/O8AznwwENAX2yfMM4AC4DPr+9X
         5exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pgbXP7GwmmN+py9xOZsbQYjAr0SryI0mb3a5P/gh0o=;
        b=YYWZ1jbPJiz1is6PM3gb4rfv9l2J+rw1axSdU6UgbBQquJxKEUT4vqxTU5ab1NDUt1
         JYpCWl6vm5s5TWM+PYjO7NqYOPH3QQUtTirJMDnrmW2tXReXQ0eKiYhJPyNSryIvFagz
         rRh1JZbMjdTC79FGYg6m6Wcz40gi5DaL85Zjv/KCvAT38BP+276Y9h5feHk0Wsh5bM0r
         arn5KNMMplGyNzhQp2ytbmwA7uoylk9ZdSOrBOUDdBf3JIyxY4xRhMnU52z3D4FyLF4i
         ktETj0rLjDhsL6O0hO8yqky/s0cu+miTE9P4wUUPNQ4iXn79ZYEfRQa0qWezZzK02+Ib
         eadg==
X-Gm-Message-State: ABuFfoiurt3YhCK3AguwOmOZJU9jRqDqTMyZFqATXUrnEndfxMhmA61C
        Ft8NJCGiBWx5zdUF6kg3kKc=
X-Google-Smtp-Source: ACcGV626Y6/A/s1wG5OSKXIkZBwk1aCR/yir5QSUYfbdJLWpv9A1IefbWZtqbs7BemjyJ9uq3hf+JA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr8571010wrx.215.1538472211898;
        Tue, 02 Oct 2018 02:23:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i7-v6sm16827295wrb.30.2018.10.02.02.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:23:31 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:23:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20181002092328.GA122128@gmail.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
 <cb7314d6deb8d1c58e2ead56fef8848b642e4e5a.1537920575.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7314d6deb8d1c58e2ead56fef8848b642e4e5a.1537920575.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> Subject: x86/speculation: Option to select app to app mitigation for spectre_v2
>

We prefer to start commit titles with verbs, not nouns, so this should be something like:

  x86/speculation: Add option to select app to app mitigation for spectre_v2

> Jiri Kosina's patch makes IBPB and STIBP available for
> general spectre v2 app to app mitigation.  IBPB will be issued for
> switching to an app that's not ptraceable by the previous
> app and STIBP will be always turned on.
> 
> However, app to app exploit is in general difficult
> due to address space layout randomization in apps and
> the need to know an app's address space layout ahead of time.
> Users may not wish to incur app to app performance
> overhead from IBPB and STIBP for general non security sensitive apps.
> 
> This patch provides a lite option for spectre_v2 app to app
> mitigation where IBPB is only issued for security sensitive
> non-dumpable app.
> 
> The strict option will keep system at high security level
> where IBPB and STIBP are used to defend all apps against
> spectre_v2 app to app attack.

s/system
 /the system

s/attack
  attacks

> +	spectre_v2_app2app=
> +			[X86] Control app to app mitigation of Spectre variant 2
> +			(indirect branch speculation) vulnerability.
> +
> +			lite   - only turn on mitigation for non-dumpable processes
> +			strict - protect against attacks for all user processes
> +			auto   - let kernel decide lite or strict mode

Perhaps add:
			lite   - only turn on mitigation for non-dumpable processes (i.e. 
				 protect daemons and other privileged processes that tend
				 to be non-dumpable)

?

> +
> +			Not specifying this option is equivalent to
> +			spectre_v2_app2app=auto.
> +
>  	spec_store_bypass_disable=
>  			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
>  			(Speculative Store Bypass vulnerability)
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index fd2a8c1..c59a6c4 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -3,6 +3,7 @@
>  #ifndef _ASM_X86_NOSPEC_BRANCH_H_
>  #define _ASM_X86_NOSPEC_BRANCH_H_
>  
> +#include <linux/static_key.h>
>  #include <asm/alternative.h>
>  #include <asm/alternative-asm.h>
>  #include <asm/cpufeatures.h>
> @@ -217,6 +218,12 @@ enum spectre_v2_mitigation {
>  	SPECTRE_V2_IBRS_ENHANCED,
>  };
>  
> +enum spectre_v2_app2app_mitigation {
> +	SPECTRE_V2_APP2APP_NONE,
> +	SPECTRE_V2_APP2APP_LITE,
> +	SPECTRE_V2_APP2APP_STRICT,
> +};
> +
>  /* The Speculative Store Bypass disable variants */
>  enum ssb_mitigation {
>  	SPEC_STORE_BYPASS_NONE,
> @@ -228,6 +235,8 @@ enum ssb_mitigation {
>  extern char __indirect_thunk_start[];
>  extern char __indirect_thunk_end[];
>  
> +DECLARE_STATIC_KEY_FALSE(spectre_v2_app_lite);
> +
>  /*
>   * On VMEXIT we must ensure that no RSB predictions learned in the guest
>   * can be followed in the host, by overwriting the RSB completely. Both
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index ee46dcb..c967012 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -133,6 +133,12 @@ enum spectre_v2_mitigation_cmd {
>  	SPECTRE_V2_CMD_RETPOLINE_AMD,
>  };
>  
> +enum spectre_v2_app2app_mitigation_cmd {
> +	SPECTRE_V2_APP2APP_CMD_AUTO,
> +	SPECTRE_V2_APP2APP_CMD_LITE,
> +	SPECTRE_V2_APP2APP_CMD_STRICT,
> +};
> +
>  static const char *spectre_v2_strings[] = {
>  	[SPECTRE_V2_NONE]			= "Vulnerable",
>  	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
> @@ -142,12 +148,24 @@ static const char *spectre_v2_strings[] = {
>  	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
>  };
>  
> +static const char *spectre_v2_app2app_strings[] = {
> +	[SPECTRE_V2_APP2APP_NONE]		= "App-App Vulnerable",
> +	[SPECTRE_V2_APP2APP_LITE]		= "App-App Mitigation: Protect only non-dumpable process",
> +	[SPECTRE_V2_APP2APP_STRICT]		= "App-App Mitigation: Full app to app attack protection",
> +};
> +
> +DEFINE_STATIC_KEY_FALSE(spectre_v2_app_lite);
> +EXPORT_SYMBOL(spectre_v2_app_lite);

EXPORT_SYMBOL_GPL() I suspect?

> +
>  #undef pr_fmt
>  #define pr_fmt(fmt)     "Spectre V2 : " fmt
>  
>  static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
>  	SPECTRE_V2_NONE;
>  
> +static enum spectre_v2_mitigation spectre_v2_app2app_enabled __ro_after_init =
> +	SPECTRE_V2_APP2APP_NONE;
> +
>  void
>  x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
>  {
> @@ -275,6 +293,46 @@ static const struct {
>  	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
>  };
>  
> +static const struct {
> +	const char *option;
> +	enum spectre_v2_app2app_mitigation_cmd cmd;
> +	bool secure;
> +} app2app_mitigation_options[] = {
> +	{ "lite",	SPECTRE_V2_APP2APP_CMD_LITE,   false },
> +	{ "strict",	SPECTRE_V2_APP2APP_CMD_STRICT, false },
> +	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,   false },
> +};

Am I reading this right that it's not possible to configure this to 'none', i.e. to disable the 
protection altogether?


> +	 * For lite protection mode, we only protect the non-dumpable
> +	 * processes.
> +	 *
> +	 * Otherwise check if the current (previous) task has access to the memory
> +	 * of the @tsk (next) task for strict app to app protection.
> +	 * If access is denied, make sure to
>  	 * issue a IBPB to stop user->user Spectre-v2 attacks.

s/a IBPB
 /an IBPB

Thanks,

	Ingo

Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87112C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E989206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AJSdH7yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E989206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390641AbeKVKT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:19:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387923AbeKVKTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:19:55 -0500
Received: from zn.tnic (p200300EC2BD0AB00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:ab00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E8D391EC09F7;
        Thu, 22 Nov 2018 00:43:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542843800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b2BoDnyHStx9YQZQYuzLeILrce5xFjIQr77SrEG7SdE=;
        b=AJSdH7yBUosYqU/omSOxUWI4dUKOiE0M82LLva/2G7R9j1B1TS+/s3ihzcHznksuK1nb3q
        IwWJdfR19ZlP/EyOT+EoNyonuMxV5EqxGK0rXtmCHlsszzqwvFDhsLEVjPDol09g0as/8p
        d6g0SbkJDl0xY+u+pcTC53hq4N6KAf8=
Date:   Thu, 22 Nov 2018 00:43:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 15/24] x86/speculation: Add command line control for
 indirect branch speculation
Message-ID: <20181121234312.GI27559@zn.tnic>
References: <20181121201430.559770965@linutronix.de>
 <20181121201723.764150349@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121201723.764150349@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:14:45PM +0100, Thomas Gleixner wrote:
> Add command line control for application to application indirect branch
> speculation mitigations.
> 
> The initial options are:
> 
>     -  on:   Unconditionally enabled
>     - off:   Unconditionally disabled
>     -auto:   Kernel selects mitigation (default off for now)
> 
> When the spectre_v2= command line argument is either 'on' or 'off' this
> implies that the application to application control follows that state even
> if when a contradicting spectre_v2_app2app= argument is supplied.
> 
> Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   22 +++
>  arch/x86/include/asm/nospec-branch.h            |   10 +
>  arch/x86/kernel/cpu/bugs.c                      |  133 ++++++++++++++++++++----
>  3 files changed, 146 insertions(+), 19 deletions(-)

...

> +static void __init
> +spectre_v2_app2app_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
> +{
> +	enum spectre_v2_app2app_mitigation mode = SPECTRE_V2_APP2APP_NONE;
> +	bool smt_possible = IS_ENABLED(CONFIG_SMP);
> +
> +	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
> +		return;
> +
> +	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
> +	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
> +		smt_possible = false;
> +
> +	switch (spectre_v2_parse_app2app_cmdline(v2_cmd)) {
> +	case SPECTRE_V2_APP2APP_CMD_AUTO:
> +	case SPECTRE_V2_APP2APP_CMD_NONE:
> +		goto set_mode;
> +	case SPECTRE_V2_APP2APP_CMD_FORCE:
> +	       mode = SPECTRE_V2_APP2APP_STRICT;
> +	       break;
> +	}
> +
> +	/* Initialize Indirect Branch Prediction Barrier */
> +	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> +		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> +		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
> +	}

So AFAICT, if coming in here with AUTO, we won't enable IBPB and I
*think* AMD wants IBPB enabled. At least the whitepaper says:

"IBPB combined with Reptoline software support is the AMD recommended
setting for Linux mitigation of Google Project Zero Variant 2
(Spectre)."

from https://www.amd.com/en/corporate/security-updates

Tom, am I completely off base here?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA66FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B2D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B2D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbeKTHVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:21:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:52004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730771AbeKTHUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:20:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3857BAD24;
        Mon, 19 Nov 2018 20:55:29 +0000 (UTC)
Date:   Mon, 19 Nov 2018 21:55:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
In-Reply-To: <alpine.DEB.2.21.1811192133240.1669@nanos.tec.linutronix.de>
Message-ID: <nycvar.YFH.7.76.1811192153470.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811192133240.1669@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Thomas Gleixner wrote:

> > @@ -452,12 +542,6 @@ static void __init spectre_v2_select_mitigation(void)
> >  	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
> >  	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
> >  
> > -	/* Initialize Indirect Branch Prediction Barrier if supported */
> > -	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> > -		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> > -		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
> > -	}
> > -
> >  	/*
> >  	 * Retpoline means the kernel is safe because it has no indirect
> >  	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
> > @@ -474,6 +558,43 @@ static void __init spectre_v2_select_mitigation(void)
> >  		pr_info("Enabling Restricted Speculation for firmware calls\n");
> >  	}
> >  
> > +	app2app_mode = SPECTRE_V2_APP2APP_NONE;
> > +	if (!boot_cpu_has(X86_FEATURE_IBPB) ||
> > +	    !boot_cpu_has(X86_FEATURE_STIBP))
> > +		goto set_app2app_mode;
> 
> So before that change IBPB was usable without STIBP, now not longer. What's
> the rationale?
> 
> This patch changes a gazillion things at once and is completely
> unreviewable.

The patchset actually ties together IBPB and STIBP pretty closely, which 
is IMO a good thing; there is no good reason why anone would want just one 
of those (or each in a different mode), at least before this magical 
coscheduling exists.

But I guess this fact should be documented somewhere.

-- 
Jiri Kosina
SUSE Labs


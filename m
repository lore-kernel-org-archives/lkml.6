Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D0EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FFB214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FFB214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeKVAI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:08:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44135 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeKVAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:08:57 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPSdk-0001ti-Fa; Wed, 21 Nov 2018 14:34:00 +0100
Date:   Wed, 21 Nov 2018 14:33:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: Re: [Patch v7 10/18] x86/speculation: Turn on or off STIBP according
 to a task's TIF_STIBP
In-Reply-To: <b6a7deb9f976680d5d96a2c1affc032604bb1879.1542758656.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811211426470.1665@nanos.tec.linutronix.de>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com> <b6a7deb9f976680d5d96a2c1affc032604bb1879.1542758656.git.tim.c.chen@linux.intel.com>
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

On Tue, 20 Nov 2018, Tim Chen wrote:
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 74bef48..48fcd46 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -406,6 +406,8 @@ static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
>  	if (static_cpu_has(X86_FEATURE_SSBD))
>  		msr |= ssbd_tif_to_spec_ctrl(tifn);
>  
> +	msr |= stibp_tif_to_spec_ctrl(tifn);

This is wrong. If STIBP is disabled, but the TIF flag is set to control
IBPB and this path is entered to handle a SSBD change, then this will set
STIBP as well.

> +
>  	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
>  }
>  
> @@ -418,7 +420,17 @@ static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
>  static __always_inline void __speculation_ctrl_update(unsigned long tifp,
>  						      unsigned long tifn)
>  {
> -	bool updmsr = false;
> +	bool updmsr;
> +
> +	/*
> +	 * Need STIBP defense against Spectre v2 attack
> +	 * if SMT is in use and enhanced IBRS is unsupported.
> +	 */
> +	if (static_cpu_has(X86_FEATURE_STIBP) && cpu_use_smt_and_hotplug &&
> +	    !static_cpu_has(X86_FEATURE_USE_IBRS_ENHANCED))
> +		updmsr = !!((tifp ^ tifn) & _TIF_SPEC_INDIR_BRANCH);

At the end of the series this has then two alternative patch bits and two
static keys. This can be done with a single static key which is controlled
from the bug code.

I'll send out a cleaned up version of that stuff later today.

Thanks,

	tglx

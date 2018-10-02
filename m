Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB1C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69082147C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69082147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJCBzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:55:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:55:43 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Q45-0001cA-52; Tue, 02 Oct 2018 21:10:37 +0200
Date:   Tue, 2 Oct 2018 21:10:36 +0200 (CEST)
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
Subject: Re: [Patch v2 2/4] x86/speculation: Provide application property
 based STIBP protection
In-Reply-To: <ce0454aa84320b34de5b00058a56daefdd817e22.1537920575.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810022104480.1435@nanos.tec.linutronix.de>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com> <ce0454aa84320b34de5b00058a56daefdd817e22.1537920575.git.tim.c.chen@linux.intel.com>
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

> This patch provides an application property based spectre_v2

# git grep 'This patch' Documentation/process/

> protection with STIBP against attack from another app from

s/app/application/ please. This is not android.

> a sibling hyper-thread.  For security sensitive non-dumpable
> app, STIBP will be turned on before switching to it for Intel
> processors vulnerable to spectre_v2.

What has this to do with Intel processors?

> -static __always_inline void intel_set_ssb_state(unsigned long tifn)
> +static __always_inline void set_spec_ctrl_state(unsigned long tifn)
>  {
> -	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
> +	u64 msr = x86_spec_ctrl_base;
> +
> +	if (static_cpu_has(X86_FEATURE_SSBD))
> +		msr |= ssbd_tif_to_spec_ctrl(tifn);
> +
> +	if (cpu_smt_control == CPU_SMT_ENABLED)
> +		msr |= stibp_tif_to_spec_ctrl(tifn);

Oh no. We are not adding yet another conditional into switch to. Either
that's done unconditionally or this wants to have a static key.

>  	wrmsrl(MSR_IA32_SPEC_CTRL, msr);

Thanks,

	tglx

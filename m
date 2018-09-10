Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9031C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3E92086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3E92086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeIJO53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:57:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIJO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:57:29 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzJ32-0004dD-SS; Mon, 10 Sep 2018 12:04:01 +0200
Date:   Mon, 10 Sep 2018 12:04:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 2/2] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
In-Reply-To: <nycvar.YFH.7.76.1809101123520.15880@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1809101158080.1402@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101123520.15880@cbobk.fhfr.pm>
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

On Mon, 10 Sep 2018, Jiri Kosina wrote:
> +static void update_stibp_msr(void *info)
> +{
> +	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +}
> +
> +void arch_smt_update(void)
> +{
> +	if (stibp_needed()) {

  	if (!stib_needed())
		return;

spares you an indentation level.

> +		u64 mask;

Newline between declarations and code please.

> +		mutex_lock(&spec_ctrl_mutex);
> +		mask = x86_spec_ctrl_base;
> +		if (cpu_smt_control == CPU_SMT_ENABLED)
> +			mask |= SPEC_CTRL_STIBP;
> +		else
> +			mask &= ~SPEC_CTRL_STIBP;
> +
> +		if (mask != x86_spec_ctrl_base) {
> +			pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
> +					cpu_smt_control == CPU_SMT_ENABLED ?
> +						"Enabling" : "Disabling");
> +			x86_spec_ctrl_base = mask;
> +			on_each_cpu(update_stibp_msr, NULL, 1);
> +		}
> +		mutex_unlock(&spec_ctrl_mutex);
> +	}
> +}
> +

That looks much more palatable. One missing piece is the sysfs mitigation
file for spectre v2. That should reflect STIPB state as well.

Thanks,

	tglx

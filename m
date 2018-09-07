Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F5CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9792083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9792083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeIGT6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:58:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbeIGT6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:58:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 516ED40711D3;
        Fri,  7 Sep 2018 15:17:01 +0000 (UTC)
Received: from treble (ovpn-125-2.rdu2.redhat.com [10.10.125.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC47B2027EA0;
        Fri,  7 Sep 2018 15:17:00 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:16:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 2/2] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
Message-ID: <20180907151659.thhi4e4jjqngj2ku@treble>
References: <nycvar.YFH.7.76.1809061013160.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809061032540.3446@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1809061032540.3446@gjva.wvxbf.pm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 15:17:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 15:17:01 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:33:39AM +0200, Jiri Kosina wrote:
> +/*
> + * The read-modify-write of the MSR doesn't need any race protection here,
> + * as we're running in atomic context.
> + */
> +static void enable_stibp(void *info)
> +{
> +	u64 mask;
> +	rdmsrl(MSR_IA32_SPEC_CTRL, mask);
> +	mask |= SPEC_CTRL_STIBP;
> +	wrmsrl(MSR_IA32_SPEC_CTRL, mask);
> +}
> +
> +static void disable_stibp(void *info)
> +{
> +	u64 mask;
> +	rdmsrl(MSR_IA32_SPEC_CTRL, mask);
> +	mask &= ~SPEC_CTRL_STIBP;
> +	wrmsrl(MSR_IA32_SPEC_CTRL, mask);
> +}
> +
> +void arch_smt_enable_errata(void)
> +{
> +	if (stibp_needed()) {
> +		pr_info("Spectre v2 cross-process SMT mitigation: Enabling STIBP\n");
> +		on_each_cpu(enable_stibp, NULL, 1);
> +	}
> +}

Shouldn't this add the STIBP bit to 'x86_spec_ctrl_base'?  Otherwise
won't it get overwritten in places like vmexit,
firmware_restrict_branch_speculation_end(), intel_set_ssb_state(), etc?

-- 
Josh

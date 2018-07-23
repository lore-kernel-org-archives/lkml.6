Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A37FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE60C20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCAnr3yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE60C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbeGWQB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:01:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388060AbeGWQB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kxZpPRf1XJW825aDEzTaX0FZjL3eNaa3peVdctIsD7A=; b=rCAnr3yCqLyZTDeX+7Nbqf3DW
        7nI810XbLnMzg8EXQn7d9PvIuxPyp3EdnRqompE/h5nYRTUrG/By3nlY2FtaGX4NCNNF2Vgoc6ULL
        N9Ku1IVy2CcLQzs5ChoHsGHGwoz4FbHCjpq8wpMLEi77W7MIdTM5+siEJ5Eu4Hiwr3MGCzUbRIOOV
        95jtIFz/KNMGsRbaSWVnnNWJHZ8rCnVL7mU9cvWkQLf+cJPldlWaVZMHeZgXAi4f0ZUs5JsW/lUMC
        nV8mI3Fdhc2dxNotsWnwrxLfYbWB0baHuJ7gknLaQDXrx9BaoufAwI2CaXAy8+O6MdiEcz0TaGIqT
        pL4uULskQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhcJP-0005o9-6G; Mon, 23 Jul 2018 14:59:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9820A20275F38; Mon, 23 Jul 2018 16:59:44 +0200 (CEST)
Date:   Mon, 23 Jul 2018 16:59:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com
Subject: Re: [PATCH 3/4] perf/x86/intel/ds: Handle PEBS overflow for fixed
 counters
Message-ID: <20180723145944.GB2458@hirez.programming.kicks-ass.net>
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
 <20180309021542.11374-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309021542.11374-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 06:15:41PM -0800, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index ef47a418d819..86149b87cce8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2280,7 +2280,10 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  	 * counters from the GLOBAL_STATUS mask and we always process PEBS
>  	 * events via drain_pebs().
>  	 */
> -	status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
> +	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
> +		status &= ~(cpuc->pebs_enabled & EXTENDED_PEBS_COUNTER_MASK);
> +	else
> +		status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
>  
>  	/*
>  	 * PEBS overflow sets bit 62 in the global status register

Doesn't this re-introduce the problem fixed in commit fd583ad1563be,
where pebs_enabled:32-34 are PEBS Load Latency, instead of fixed
counters?

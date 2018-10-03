Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B607DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC72098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1GWNKazE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCC72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJCXRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:17:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kQ1rRl9OuXdMPdG1ow54PfPs+MXmgNyULwmAPnsnDKE=; b=1GWNKazEoWJlaF1t376iBN8Pc
        1VGpGS+INFRN3WhECbG2pYvU2cw8svjpOnWKFIJropfvJW04Tq1On5XS1WCWsZItm7Wm53za40Jta
        32uwhi/2NCU1DWM1UIKHM0hMnU/jq69KkGDL3V3tK9HYU17zhvGuy7m1BxEFcJpxZPfO+CkNw4L3z
        PAV1PBj2TWyKxR5rEa7KpBsjAia4eesy4oPpBAjpJL0hNswjhQyaKVP60WhoHWA5QTXbgCIhRjaCQ
        XNydPJZbUcR+Q0gZ8nheOoiMMsiYEgvjofyZLyDxPiocGTysNlwVxbB2ksE0SQxkJCRtlTiQ5QKKP
        tPM/Dh4Qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7k0D-0003JM-Ql; Wed, 03 Oct 2018 16:27:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4115520289D0C; Wed,  3 Oct 2018 18:27:19 +0200 (CEST)
Date:   Wed, 3 Oct 2018 18:27:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 08/14] sched/topology: Disable EAS on inappropriate
 platforms
Message-ID: <20181003162719.GB19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-9-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-9-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:03AM +0100, Quentin Perret wrote:
> @@ -288,6 +321,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
>  			goto free;
>  		tmp->next = pd;
>  		pd = tmp;
> +
> +		/*
> +		 * Count performance domains and capacity states for the
> +		 * complexity check.
> +		 */
> +		nr_pd++;
> +		nr_cs += em_pd_nr_cap_states(pd->obj);
> +	}
> +
> +	/* Bail out if the Energy Model complexity is too high. */
> +	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
> +		if (sched_debug())
> +			pr_info("rd %*pbl: EM complexity is too high\n ",
> +						cpumask_pr_args(cpu_map));
> +		goto free;
>  	}

I would make than an unconditional WARN, we do not really expect that to
trigger, but then it does, we really don't want to hide it.

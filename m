Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D101C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6295218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBAMLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:11:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBAML3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:11:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED61580D;
        Fri,  1 Feb 2019 04:11:28 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF213F59C;
        Fri,  1 Feb 2019 04:11:27 -0800 (PST)
Date:   Fri, 1 Feb 2019 12:11:25 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 4/5] cpufreq: arm_big_little: Register an Energy Model
Message-ID: <20190201121123.ir4iodxj6iovsknn@queper01-lin>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-5-quentin.perret@arm.com>
 <20190201115357.GB10042@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201115357.GB10042@e107155-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 Feb 2019 at 11:53:57 (+0000), Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 09:31:00AM +0000, Quentin Perret wrote:
> > From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >
> > Now that PM_OPP provides a helper function to estimate the power
> > consumed by CPUs, make sure to try and register an Energy Model (EM)
> > from the arm_big_little CPUFreq driver, hence ensuring interested
> > subsystems (the task scheduler, for example) can make use of that
> > information when available.
> >
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  drivers/cpufreq/arm_big_little.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> > index cf62a1f64dd7..18b05bcb2614 100644
> > --- a/drivers/cpufreq/arm_big_little.c
> > +++ b/drivers/cpufreq/arm_big_little.c
> > @@ -487,6 +487,14 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
> >  	policy->cpuinfo.transition_latency =
> >  				arm_bL_ops->get_transition_latency(cpu_dev);
> >
> > +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> > +	if (ret <= 0) {
> > +		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> > +		return -EPROBE_DEFER;
> > +	}
> 
> The only user of this has the check in init_opp_table that gets called from
> get_cluster_clk_and_freq_table. So the above is not necessary, you can drop
> it.

Will do.

Thanks,
Quentin

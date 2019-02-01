Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52A9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43C0218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfBAMKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:10:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58850 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBAMKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:10:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2A5880D;
        Fri,  1 Feb 2019 04:09:59 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3169A3F59C;
        Fri,  1 Feb 2019 04:09:58 -0800 (PST)
Date:   Fri, 1 Feb 2019 12:09:53 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201120453.GC10042@e107155-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Friday 01 Feb 2019 at 12:04:53 (+0000), Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 09:30:57AM +0000, Quentin Perret wrote:
> > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > +{
> > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > +	int ret, cpu = cpumask_first(cpus);
> > +	struct device *cpu_dev;
> > +	struct device_node *np;
> > +	u32 cap;
> > +
> > +	cpu_dev = get_cpu_device(cpu);
> > +	if (!cpu_dev)
> > +		return;
> > +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np)
> > +		return;
> > +
> 
> Does it make sense to add the check for OPP count here. You need not pass
> that as parameter. Just makes one less thing to check in new drivers adding
> this support. Thoughts ?

Yeah Matthias had the same suggestion. I don't mind moving it here TBH.
It's just that some users already do the opp count before calling this
function, so I figured I could as well use that data instead of counting
again.

But yeah, that's one less thing to worry about on the driver side so
I'll move the OPP count in there for v4 and we'll see if people ask me
to move it out to optimize things ;-)

Thanks,
Quentin

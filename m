Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id t1FCHHaAGlsLOAAAmS7hNA
	; Fri, 08 Jun 2018 13:11:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D9BF7608BA; Fri,  8 Jun 2018 13:11:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 52952601D2;
	Fri,  8 Jun 2018 13:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52952601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFHNLR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:11:17 -0400
Received: from foss.arm.com ([217.140.101.70]:33640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeFHNLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:11:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E9C1529;
        Fri,  8 Jun 2018 06:11:13 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 944523F59D;
        Fri,  8 Jun 2018 06:11:09 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:11:04 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180608131104.GA7838@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
 <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
 <5a7b8177-7cbe-df90-7d00-8aad0a0f5f08@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7b8177-7cbe-df90-7d00-8aad0a0f5f08@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jun 2018 at 14:39:33 (+0200), Dietmar Eggemann wrote:
> In your current '(3)* Arm/Arm64 init code' (* see at the end of this email)
> you have this dev_pm_opp_of_estimate_power() em_data_callback active_power
> function.
> 
> Let's say thermal and the task scheduler would initialize the EM
> independently. They would still end up using C from dt, and f, V and P from
> opp library in your example.

Ah, that's where the confusion comes from ... The task scheduler or
thermal _don't_ initialize the EM. They just use it if it's there.
The _drivers_ (typically, but not limited to, CPUFreq drivers)
initialize the EM. I'll try to make that clearer in the diagram for v4.

> IMHO, this information should be only provided once from one source per
> platform.

Yes, I think so too. That's why all but the first registration of the
same frequency domain is ignored.

> > > Even though we would be forced to get cpufreq's related cpumask from
> > > somewhere.
> > 
> > That's the easy part. The difficult part is, where do you get power
> > values from ? You have to let the lower layers register those values
> > in a centralized location on a voluntary basis. And then it becomes easy
> > for consumers to access that data, because they know where it is.
> 
> The code in the arch could use the same struct em_data_callback em_cb = {
> &dev_pm_opp_of_estimate_power } that the cpufreq driver is currently using?

How do you know from the arch code if you should get power from DT
with dev_pm_opp_of_estimate_power or use another callback that reads
power from firmware (SCMI) ?

I don't think it is reasonable to assume a single source of information for
an arch. It is is already an incorrect assumption even if just you look at
the Arm world.

> > Again, I don't think that's possible. You have to let the lower layers
> > tell you where the power values come from, at the very least. You could
> > let the archs do that aggregation I suppose, but I don't really see the
> > benefit over one centralized framework with a generic interface ...
> > What's your opinion ?
> 
> Don't understand the '... let the lower layers tell you where the power
> values come from ...' part. Where is the difference whether the arch or the
> cpufreq driver uses em_data_callback?

Because different CPUFreq drivers can be used for one arch. There are
different CPUFreq drivers because there are different ways of getting
information about the platform, even just for the Arm world (DT, SCPI,
SCMI, ...). It's the same thing for power values, they don't necessarily
come from DT.

The point of having a centralized EM framework with a standardized
callback prototype is flexibility. You can implement a callback that
estimates power from the DT. You can implement a callback that reads
power from firmware. But you can also have a completely ad-hoc EM
provider in a module if you like. All you have to do to provide data to
the framework is respect the callback API.

> > So I think I'll drop patch 10/10 for v4 ... That part should be
> > discussed separately, with the rest of the Arm-specific changes.
> 
> Maybe 3 clearly separated parts of the patch-set; (1) EM (2) EAS uses EM (3)
> Arm/Arm64 init code ?

Right, that sounds like the right thing to do :-)

Thanks,
Quentin

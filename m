Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12C1C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8214C20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8214C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeJLWh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:37:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeJLWh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:37:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8BCDF;
        Fri, 12 Oct 2018 08:04:34 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A435F3F5BC;
        Fri, 12 Oct 2018 08:04:31 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:04:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org,
        khilman@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Message-ID: <20181012150429.GH3401@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011210609.GD2371@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:06:09PM -0600, Lina Iyer wrote:
> On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
[...]

> >
> > Is DDR managed by Linux ? I assumed it was handled by higher exception
> > levels. Can you give examples of resources used by CPU in this context.
> > When CPU can be powered on or woken up without Linux intervention, the
> > same holds true for CPU power down or sleep states. I still see no reason
> > other than the firmware has no support to talk to RPMH.
> >
> DDR, shared clocks, regulators etc. Imagine you are running something on
> the screen and CPUs enter low power mode, while the CPUs were active,
> there was a need for bunch of display resources, and things the app may
> have requested resources, while the CPU powered down the requests may
> not be needed the full extent as when the CPU was running, so they can
> voted down to a lower state of in some cases turn off the resources
> completely. What the driver voted for is dependent on the runtime state
> and the usecase currently active. The 'sleep' state value is also
> determined by the driver/framework.
>

Why does CPU going down says that another (screen - supposedly shared)
resource needs to be relinquished ? Shouldn't display decide that on it's
own ? I have no idea why screen/display is brought into this discussion.
CPU can just say: hey I am going down and I don't need my resource.
How can it say: hey I am going down and display or screen also doesn't
need the resource. On a multi-cluster, how will the last CPU on one know
that it needs to act on behalf of the shared resource instead of another
cluster.

I think we are mixing the system sleep states with CPU idle here.
If it's system sleeps states, the we need to deal it in some system ops
when it's the last CPU in the system and not the cluster/power domain.

[...]

> > Oh interesting, wasn't aware RPMH really needs to care about exception
> > level. For me, we know CPU is powering down, so it needs to release all
> > the resource. RPMH needs to know that and any exception level can let
> > RPMH know that. Sorry may be I don't have enough knowledge on SDM SoC.
> >
> Some resources are secure resources used in secure environments. They
> cannot be requested from non-secure. Hence secure levels are voters of
> their own accord.
>

I still don't think RPMH can more than refcounting and all I am saying
is for CPU's EL3 can manage that refcount on behalf of all ELx

> Now, since we are considering linux and secure (infact linux,hyp,secure)
> as separate voters they have to each request their votes and release
> their votes separately. PSCI cannot release a request made from Linux.

Why should Linux make that request at the first instance as CPU is
already up and running.

> This is how the SoC is designed. All exception levels will abide by
> that.
>
> > > Yes, we are close to having a platform have both, possibly.
> > >
> >
> > Comparison numbers please :)
> >
> We are far from it, for that, atleast now. But we will get there.
>

Hopefully one day. We are waiting for that day for few years now :)

> > Having to adapt DT to the firmware though the feature is fully discoverable
> > is not at all good IMO. So the DT in this series *should work* with OSI
> > mode if the firmware has the support for it, it's as simple as that.
> >
> The firmware is ATF and does not support OSI.
>

OK, to keep it simple: If a platform with PC mode only replaces the firmware
with one that has OSI mode, we *shouldn't need* to change DT to suite it.
I think I asked Ulf to add something similar in DT bindings.

--
Regards,
Sudeep

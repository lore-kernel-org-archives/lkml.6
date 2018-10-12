Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE3C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02E21476
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF02E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJMAeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:34:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJMAeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E341596;
        Fri, 12 Oct 2018 10:00:52 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7093F5D3;
        Fri, 12 Oct 2018 10:00:49 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:00:40 +0100
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
Message-ID: <20181012170040.GA21057@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
 <20181012150429.GH3401@e107155-lin>
 <20181012160427.GG2371@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012160427.GG2371@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:04:27AM -0600, Lina Iyer wrote:
> On Fri, Oct 12 2018 at 09:04 -0600, Sudeep Holla wrote:

[...]

> > Why does CPU going down says that another (screen - supposedly shared)
> > resource needs to be relinquished ? Shouldn't display decide that on it's
> > own ? I have no idea why screen/display is brought into this discussion.
>
> > CPU can just say: hey I am going down and I don't need my resource.
> > How can it say: hey I am going down and display or screen also doesn't
> > need the resource. On a multi-cluster, how will the last CPU on one know
> > that it needs to act on behalf of the shared resource instead of another
> > cluster.
> >
> Fair questions. Now how would the driver know that the CPUs have powered
> down, to say, if you are not active, then you can put these resources in
> low power state?
> Well they don't, because sending out CPU power down notifications for
> all CPUs and the cluster are expensive and can lead to lot of latency.
> Instead, the drivers let the RPMH driver know that if and when the CPUs
> power down, then you could request these resources to be in that low
> power state. The CPU PD power off callbacks trigger the RPMH driver to
> flush and request a low power state on behalf of all the drivers.
>
> Drivers let know what their active state request for the resource is as
> well as their CPU powered down state request is, in advance. The
> 'active' request is made immediately, while the 'sleep' request is
> staged in. When the CPUs are to be powered off, this request is written
> into a hardware registers. The CPU PM domain controller, after powering
> down, will make these state requests in hardware thereby lowering the
> standby power. The resource state is brought back into the 'active'
> value before powering on the first CPU.
>

My understanding was in sync with most of the above except the staging
part in advance. So thanks for the detailed explanation.

Yes all these are fine but with multiple power-domains/cluster, it's
hard to determine the first CPU. You may be able to identify it within
the power domain but not system wide. So this doesn't scale with large
systems(e.g. 4 - 8 clusters with 16 CPUs).

> > I think we are mixing the system sleep states with CPU idle here.
> > If it's system sleeps states, the we need to deal it in some system ops
> > when it's the last CPU in the system and not the cluster/power domain.
> >
> I think the confusion for you is system sleep vs suspend. System sleep
> here (probably more of a QC terminology), refers to powering down the
> entire SoC for very small durations, while not actually suspended. The
> drivers are unaware that this is happening. No hotplug happens and the
> interrupts are not migrated during system sleep. When all the CPUs go
> into cpuidle, the system sleep state is activated and the resource
> requirements are lowered. The resources are brought back to their
> previous active values before we exit cpuidle on any CPU. The drivers
> have no idea that this happened. We have been doing this on QCOM SoCs
> for a decade, so this is not something new for this SoC. Every QCOM SoC
> has been doing this, albeit differently because of their architecture.
> The newer ones do most of these transitions in hardware as opposed to an
> remote CPU. But this is the first time, we are upstreaming this :)
>

Indeed, I know mobile platforms do such optimisations and I agree it may
save power. As I mentioned above it doesn't scale well with large systems
and also even with single power domains having multiple idle states where
only one state can do this system level idle but not all. As I mentioned
in the other email to Ulf, it's had to generalise this even with DT.
So it's better to have this dealt transparently in the firmware.

> Suspend is an altogether another idle state where drivers are notified
> and relinquish their resources before the CPU powers down. Similar
> things happen there as well, but at a much deeper level. Resources may
> be turned off completely instead of just lowering to a low power state.
>

Yes I understand the difference.

> For example, suspend happens when the screen times out on a phone.
> System sleep happens few hundred times when you are actively reading
> something on the phone.
>

Sure

> > > > Having to adapt DT to the firmware though the feature is fully discoverable
> > > > is not at all good IMO. So the DT in this series *should work* with OSI
> > > > mode if the firmware has the support for it, it's as simple as that.
> > > >
> > > The firmware is ATF and does not support OSI.
> > >
> >
> > OK, to keep it simple: If a platform with PC mode only replaces the firmware
> > with one that has OSI mode, we *shouldn't need* to change DT to suite it.
> > I think I asked Ulf to add something similar in DT bindings.
> >
> Fair point and that is what this RFC intends to bring. That PM domains
> are useful not just for PSCI, but also for Linux PM drivers such as this
> one. We will discuss more how we can fold in platform specific
> activities along with PSCI OSI state determination when the
> domain->power_off is called. I have some ideas on that. Was hoping to
> get to that after the inital idea is conveyed.
>

Got it. This is not a new discussion, I am sure this has been discussed
several times in the past. We have so much platform dependent code that
coming up with generic solution with DT is challenging. I have mentioned
just few of those. I am sure the list is much bigger. Hence the suggestion
is always to got with firmware based solution which is bested suited for
upstream and proven to work(e.g. on x86).

Have a nice weekend!

--
Regards,
Sudeep

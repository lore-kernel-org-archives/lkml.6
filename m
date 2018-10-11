Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4606BC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2A82085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2A82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeJLBF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:05:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41582 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeJLBF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:05:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D3AED1;
        Thu, 11 Oct 2018 10:37:42 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314F63F5D3;
        Thu, 11 Oct 2018 10:37:39 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:37:33 +0100
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
Message-ID: <20181011173733.GA26447@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011165822.GB2371@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:58:22AM -0600, Lina Iyer wrote:
> On Thu, Oct 11 2018 at 10:19 -0600, Sudeep Holla wrote:
> > On Thu, Oct 11, 2018 at 10:00:53AM -0600, Lina Iyer wrote:
> > > Sudeep,
> > >
> > > The CPU PD does not power off the domain from Linux. That is done from
> > > PSCI firmware (ATF). These patches are doing the part that Linux has do,
> > > when powering off the CPUs, to achieve a low standby power consumption.
> > >
> >
> > I don't understand why Linux *has do* this part as PSCI manages CPU PM.
> >
> If we don't do this, then we leave a lot of power saving on the table,
> when the CPU powered off. Why should the DDR and the shared busses and
> clocks be idling at high power, when not needed ? PSCI has no clue to
> what resource requests was made my Linux and its Linux's responsibility
> to relinquish them when not needed. Therefore has to done from Linux.
>

Is DDR managed by Linux ? I assumed it was handled by higher exception
levels. Can you give examples of resources used by CPU in this context.
When CPU can be powered on or woken up without Linux intervention, the
same holds true for CPU power down or sleep states. I still see no reason
other than the firmware has no support to talk to RPMH.

> > > On Thu, Oct 11 2018 at 05:20 -0600, Sudeep Holla wrote:
> > > > On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
> > > > > Use cpu hotplug callback mechanism to attach/dettach the cpu in
> > > > > the cpu power domain. During cpu hotplug callback registration,
> > > > > the starting callback is invoked on all online cpus. So there is
> > > > > no need to attach from device probe.
> > > > >
> > > >
> > > > To be more explicit, NACK to this series(patches 4-8 to be more specific)
> > > > unless you provide details on:
> > > >
> > > > 1. Why this is not in PSCI implementation ?
> > > This is a linux activity and there is no provision in ATF or QC firmware
> > > to do this activity. The task of physically powering down the domain,
> > > still is a firmware decision and is done through PSCI platform
> > > coordinated in the firmware.
> > >
> >
> > Yes that was my understanding. So the addon question here is: if PSCI
> > decides to abort entering the idle state, the Linux doing the RPMH
> > request is of no use which can be prevented if done once PSCI f/w is
> > about to enter the state. I know it may be corner case, but we have
> > whole OSI mode based on such corner cases.
> >
> Yes, it is a possibility and worth the chance taken. On an SoC, there
> are other processors that may vote against powering down the shared
> resources even when Linux has shutdown and it is a very likely
> possibility. Ex., when you are on a phone call, the CPU subsystem could
> be powered off and the flush of RPMH requests is a 'waste', but it is a
> chance we need to take. The alternate is a synchronization nightmare.
>

I am not against voting here. I am saying need not be done in Linux. The
last piece of software running before powering down is EL3 and it should
so the voting. I can understand for devices controlled in/by Linux. EL3
firmware controls the CPU PM, so that needs to vote and by that it's
assumed nothing is running in lower EL in that path.

> Even with all the unnecessary flushing it is totally worth it. OSI helps
> alleviates this a bit because it embodies the same CPU PD concepts at
> its core. Imagine if you didn't have CPU PM domain, the every CPU would
> be flushing RPMH request, whenever they power down, because you never know
> when all CPUs are going to be powered down at the same time. That is the
> biggest benefit of OSI over PC mode in PSCI.
>

I am not saying every CPU needs to do that, last CPU can do that in PSCI.

> > > > 2. If PSCI is used on this platform, how does it work/co-exist ?
> > > Yes PSCI is used in this platform. ATF is the firmware and that supports
> > > only Platform Coordinated. This SoC uses cpuidle and the regular PSCI
> > > methods to power off the domain from the firmware. However, Linux has
> > > responsibilities that it needs to complete before the power down can be
> > > beneficial.
> > >
> >
> > I understand the need to inform RPMH. So I take only reason to do that
> > in Linux is TF-A doesn't have any support to talk to RPMH ?
> >
> It may or may not, depending on which firmware you talk to. But consider
> this, if the firmware votes for lowering resource state, it is doing it
> for its exception level and not for Linux. So Linux has to take care of
> its own.
>

Oh interesting, wasn't aware RPMH really needs to care about exception
level. For me, we know CPU is powering down, so it needs to release all
the resource. RPMH needs to know that and any exception level can let
RPMH know that. Sorry may be I don't have enough knowledge on SDM SoC.

But IMO Linux shouldn't contribute to any votes around CPU PM as EL3/PSCI
is the one managing it and not Linux. If CPU can be powered up without
Linux voting for anything, why is it required for going down. I simply
fail to understand there and get completely lost :(

> > Now that we have some platform with PC, it's good to compare PC vs OSI
> > which we always lacked. Thanks for letting us know this platform is PC
> > based.
> >
> Can I take that you are okay with the OSI idea and this one, then :)
> Yes, we are close to having a platform have both, possibly.
>

Comparison numbers please :)

> > > Isn't sharing ideas a key aspect of working with the community? This
> > > series just goes to say that the idea of CPU PM domains are useful,
> > > whether PSCI uses it or not. If you still need clarifications, Raju and
> > > I will be happy to set up a meeting and go over the idea.
> > >
> > Ah OK, so this platform will have flattened cpu-idle-states list ? That's
> > absolutely fine. But what if we want to represent hierarchical PSCI based
> > PM domains and this power domain for some platform. That's the main
> > concern I raised. For me, the power-domains in DT introduced in this
> > is just to deal with RPMH though the actual work is done by PSCI.
> > That just doesn't look that good for me.
> >
> What problem do you see with that? It would help if you could clarify
> your concern.
>
Having to adapt DT to the firmware though the feature is fully discoverable
is not at all good IMO. So the DT in this series *should work* with OSI
mode if the firmware has the support for it, it's as simple as that.

--
Regards,
Sudeep

Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC62C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4FE2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4FE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeJKXr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:47:29 -0400
Received: from foss.arm.com ([217.140.101.70]:40642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:47:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89D8BED1;
        Thu, 11 Oct 2018 09:19:33 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776EB3F5B3;
        Thu, 11 Oct 2018 09:19:30 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:19:27 +0100
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
Message-ID: <20181011161927.GC28583@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011160053.GA2371@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:00:53AM -0600, Lina Iyer wrote:
> Sudeep,
>
> This is idea is based on GenPD/PM Domains, but solves for the CPU domain
> activities that need to be done from Linux when the CPU domain could be
> powered off. In that, it shares the same ideas from the series posted by
> Ulf. But this has no bearing on PSCI. The 845 SoC that Raju is working
> on, uses Platform-coordinated and so is largely deficient in meeting the
> power benefits achievable on this SoC, from Linux.
>

Interesting to know we have some QCOM part with PC mode.

> If you have looked at the patches, you probably know by now, there are
> two things this patch does when the CPUs are powered off -
> - Flush RPMH requests to the controller (shared resource state requests
>  after the CPU is powered off and resume to the current state before
>  the CPU wakes up).
> - Setup the wakeup time for the CPUs in the hardware registers such that
>  the hardware blocks are awake before a CPU is powered back on. This is
>  like a back-off time for handling timer wakeups faster.
>

Yes I understand these.

> The CPU PD does not power off the domain from Linux. That is done from
> PSCI firmware (ATF). These patches are doing the part that Linux has do,
> when powering off the CPUs, to achieve a low standby power consumption.
>

I don't understand why Linux *has do* this part as PSCI manages CPU PM.

> On Thu, Oct 11 2018 at 05:20 -0600, Sudeep Holla wrote:
> > On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
> > > Use cpu hotplug callback mechanism to attach/dettach the cpu in
> > > the cpu power domain. During cpu hotplug callback registration,
> > > the starting callback is invoked on all online cpus. So there is
> > > no need to attach from device probe.
> > >
> >
> > To be more explicit, NACK to this series(patches 4-8 to be more specific)
> > unless you provide details on:
> >
> > 1. Why this is not in PSCI implementation ?
> This is a linux activity and there is no provision in ATF or QC firmware
> to do this activity. The task of physically powering down the domain,
> still is a firmware decision and is done through PSCI platform
> coordinated in the firmware.
>

Yes that was my understanding. So the addon question here is: if PSCI
decides to abort entering the idle state, the Linux doing the RPMH
request is of no use which can be prevented if done once PSCI f/w is
about to enter the state. I know it may be corner case, but we have
whole OSI mode based on such corner cases.

> > 2. If PSCI is used on this platform, how does it work/co-exist ?
> Yes PSCI is used in this platform. ATF is the firmware and that supports
> only Platform Coordinated. This SoC uses cpuidle and the regular PSCI
> methods to power off the domain from the firmware. However, Linux has
> responsibilities that it needs to complete before the power down can be
> beneficial.
>

I understand the need to inform RPMH. So I take only reason to do that
in Linux is TF-A doesn't have any support to talk to RPMH ?

> > 3. Is this a shortcut approached taken to bypass the CPU genpd attempts
> >   from Lina/Ulf ?
> >
> This is an incorrect interpretation and an unwarranted accusation. There
> is no need to bypass CPU genpd attempts. That series stands on its own
> merits. (Thank you, Ulf). Raju has mentioned in the cover letter
> explicitly, that Ulf's patches posted here are for completeness of the
> concept, as that series is a dependency. But it will merged as part of
> Ulf's efforts.
>

Sorry if it sounded like accusation. I didn't mean to. I was checking
if this was alternative solution. I do understand the need to deal with
product pressures.

Now that we have some platform with PC, it's good to compare PC vs OSI
which we always lacked. Thanks for letting us know this platform is PC
based.

> Isn't sharing ideas a key aspect of working with the community? This
> series just goes to say that the idea of CPU PM domains are useful,
> whether PSCI uses it or not. If you still need clarifications, Raju and
> I will be happy to set up a meeting and go over the idea.
>
Ah OK, so this platform will have flattened cpu-idle-states list ? That's
absolutely fine. But what if we want to represent hierarchical PSCI based
PM domains and this power domain for some platform. That's the main
concern I raised. For me, the power-domains in DT introduced in this
is just to deal with RPMH though the actual work is done by PSCI.
That just doesn't look that good for me.

--
Regards,
Sudeep

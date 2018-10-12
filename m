Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DCC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10621205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10621205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJMA6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:58:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeJMA6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:58:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95EF8F;
        Fri, 12 Oct 2018 10:25:09 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F79E3F5D3;
        Fri, 12 Oct 2018 10:25:06 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:25:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org,
        khilman@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Message-ID: <20181012172500.GA23170@e107155-lin>
References: <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
 <20181012150429.GH3401@e107155-lin>
 <20181012160427.GG2371@codeaurora.org>
 <20181012170040.GA21057@e107155-lin>
 <20181012171910.GI2371@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012171910.GI2371@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:19:10AM -0600, Lina Iyer wrote:
> On Fri, Oct 12 2018 at 11:01 -0600, Sudeep Holla wrote:
> > On Fri, Oct 12, 2018 at 10:04:27AM -0600, Lina Iyer wrote:
> > > On Fri, Oct 12 2018 at 09:04 -0600, Sudeep Holla wrote:
> >
> > [...]
> >
> > Yes all these are fine but with multiple power-domains/cluster, it's
> > hard to determine the first CPU. You may be able to identify it within
> > the power domain but not system wide. So this doesn't scale with large
> > systems(e.g. 4 - 8 clusters with 16 CPUs).
> >
> We would probably not worry too much about power savings in a msec
> scale, if we have that big a system. The driver is a platform specific
> driver, primarily intended for a mobile class CPU and usage. In fact, we
> haven't done this for QC's server class CPUs.
>

OK, along as there's no attempt to make it generic and keep it platform
specific, I am not that bothered.

> > > > I think we are mixing the system sleep states with CPU idle here.
> > > > If it's system sleeps states, the we need to deal it in some system ops
> > > > when it's the last CPU in the system and not the cluster/power domain.
> > > >
> > > I think the confusion for you is system sleep vs suspend. System sleep
> > > here (probably more of a QC terminology), refers to powering down the
> > > entire SoC for very small durations, while not actually suspended. The
> > > drivers are unaware that this is happening. No hotplug happens and the
> > > interrupts are not migrated during system sleep. When all the CPUs go
> > > into cpuidle, the system sleep state is activated and the resource
> > > requirements are lowered. The resources are brought back to their
> > > previous active values before we exit cpuidle on any CPU. The drivers
> > > have no idea that this happened. We have been doing this on QCOM SoCs
> > > for a decade, so this is not something new for this SoC. Every QCOM SoC
> > > has been doing this, albeit differently because of their architecture.
> > > The newer ones do most of these transitions in hardware as opposed to an
> > > remote CPU. But this is the first time, we are upstreaming this :)
> > >
> >
> > Indeed, I know mobile platforms do such optimisations and I agree it may
> > save power. As I mentioned above it doesn't scale well with large systems
> > and also even with single power domains having multiple idle states where
> > only one state can do this system level idle but not all. As I mentioned
> > in the other email to Ulf, it's had to generalise this even with DT.
> > So it's better to have this dealt transparently in the firmware.
> >
> Good, then we are on agreement here.

No worries.

> But this is how this platform is. It cannot be done in firmware and what
> we doing here is a Linux platform driver that cleans up nicely without
> having to piggy back on an external dependency.
>
Yes Qcom always says it can't be done in firmware. Even PSCI was adopted 
after couple of years of pushback.

--
Regards,
Sudeep

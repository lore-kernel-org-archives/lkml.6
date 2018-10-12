Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8085C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651972098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651972098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeJMAGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:06:37 -0400
Received: from foss.arm.com ([217.140.101.70]:54230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeJMAGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:06:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D91F;
        Fri, 12 Oct 2018 09:33:18 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 621EA3F5D3;
        Fri, 12 Oct 2018 09:33:15 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:33:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lina Iyer <ilina@codeaurora.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Message-ID: <20181012163309.GA14841@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
 <20181012150429.GH3401@e107155-lin>
 <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 05:46:13PM +0200, Ulf Hansson wrote:
[...]

>
> Apologize for sidetracking the discussion, just want to fold in a few comments.
>
No need to apologize, you are just contributing to get better
understanding of the system.

> This is becoming a complicated story. May I suggest we pick the GIC as
> an example instead?
>

Sure.

> Let's assume the simple case, we have one cluster and when the cluster
> becomes powered off, the GIC needs to be re-configured and wakeups
> must be routed through some "always on" external logic.
>

OK, but is the cluster powered off with any wakeup configured(idling)
or with selected wakeups(system suspend/idle)

> The PSCI spec mentions nothing about how to manage this and not the
> rest of the SoC topology for that matter. Hence if the GIC is managed
> by Linux - then Linux also needs to take actions before cluster power
> down and after cluster power up. So, if PSCI FW can't deal with GIC,
> how would manage it?
>

To add to the complications, some of the configurations in GIC can be
done only in higher exception level. So we expect PSCI to power down
the GIC if possible and move the wakeup source accordingly based on the
platform. So PSCI F/W unable to deal with GIC is simply impossible.
It configures Group0/1 interrupts and generally Linux deals with Group 1.
E.g. First 8 SGI are put in Group 0 which is secure interrupts.

So by default, GIC driver in Linux sets MASK_ON_SUSPEND which ensures
only wake-up sources are kept enabled before entering suspend. If the
GIC is being powered down, secure side has to do it's book-keeping if
any and transfer the wakeups to any external always on wakeup controller.

> >
> > I think we are mixing the system sleep states with CPU idle here.
> > If it's system sleeps states, the we need to deal it in some system ops
> > when it's the last CPU in the system and not the cluster/power domain.
>
> What is really a system sleep state? One could consider it just being
> another idles state, having heaver residency targets and greater
> enter/exit latency values, couldn't you?
>

Yes, but theses are user triggered states where the system resources are
informed before entering it. By that I am referring system_suspend_ops.

> In the end, there is no reason to keep things powered on, unless they
> are being in used (or soon to be used), that is main point.
>

I assume by "they", you refer the GIC for example.

> We are also working on S2I at Linaro. We strive towards being able to
> show the same power numbers as for S2R, but then we need to get these
> cluster-idle things right.
>

I don't think anything prevents it. You may need to check how to execute
cpu_pm_suspend which in case S2R gets executed as syscore_suspend_ops.

We can't assume any idle states will take the GIC down and do that
always. At the same, representing this is DT is equal challenging as we
can't assume single idle state power domains. So the platform specific
firmware need to handle this transparently for OSPM.

> [...]
>
> Have a nice weekend!
>

You too have a nice one.

--
Regards,
Sudeep

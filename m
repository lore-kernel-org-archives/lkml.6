Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6527C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3C42148C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3C42148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeHONgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:36:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeHONgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:36:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1355418A;
        Wed, 15 Aug 2018 03:44:45 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE3443F5BC;
        Wed, 15 Aug 2018 03:44:41 -0700 (PDT)
Date:   Wed, 15 Aug 2018 11:44:50 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Message-ID: <20180815104449.GA29108@red-moon>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan>
 <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan>
 <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
 <20180808180248.GC27850@codeaurora.org>
 <20180809102504.GB13428@e107981-ln.cambridge.arm.com>
 <20180810201815.GE5081@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810201815.GE5081@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 02:18:15PM -0600, Lina Iyer wrote:

[...]

> >>But, the OSI feature is critical for QCOM mobile platforms. The
> >>last man activities during cpuidle save quite a lot of power.
> >
> >What I expressed above was that, in PSCI based systems (OSI or PC
> >alike), it is up to firmware/hardware to detect "the last man" not
> >the kernel.
> >
> >I need to understand what you mean by "last man activities" to
> >provide feedback here.
> >
> When the last CPU goes down during deep sleep, the following would be
> done
> - Lower resource requirements for shared resources such as clocks,
>  busses and regulators that were used by drivers in AP. These shared
>  resources when not used by other processors in the SoC may be turned
>  off and put in low power state by a remote processor. [1][2]
> - Enable and setup wakeup capable interrupts on an always-on interrupt
>  controller, so the GIC and the GPIO controllers may be put in low
>  power state. [3][4]
> - Write next known wakeup value to the timer, so the blocks that were
>  powered off, may be brought back into operational before the wakeup.
>  [4][5]
> 
> These are commonly done during suspend, but to achieve a good power
> efficiency, we have to do this when all the CPUs are just executing CPU
> idle. Also, they cannot be done from the firmware (because the data
> required for all this is part of Linux). OSI plays a crucial role in
> determining when to do all this.

No it does not. It is the power domain cpumasks that allow this code to
make an educated guess on the last cpu running (the kernel), PSCI OSI is
not crucial at all (it is crucial in QC platforms because that's the
only mode supported but that's not a reason I accept as valid since it
does not comply with the PSCI specifications).

As I mentioned in another thread[1] the generic part of this
series may be applicable in a platform agnostic way to the
CPUidle framework, whether that's beneficial it has to be proven
and it is benchmark specific anyway.

Lorenzo

[1]: https://marc.info/?l=linux-pm&m=153382916513032&w=2 

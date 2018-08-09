Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4CCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0707421C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0707421C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbeHIMtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:49:23 -0400
Received: from foss.arm.com ([217.140.101.70]:51628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbeHIMtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:49:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D5618A;
        Thu,  9 Aug 2018 03:25:10 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E1BD3F5D4;
        Thu,  9 Aug 2018 03:25:07 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:25:04 +0100
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
Message-ID: <20180809102504.GB13428@e107981-ln.cambridge.arm.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan>
 <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan>
 <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
 <20180808180248.GC27850@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808180248.GC27850@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:02:48PM -0600, Lina Iyer wrote:
> On Wed, Aug 08 2018 at 04:56 -0600, Lorenzo Pieralisi wrote:
> >On Mon, Aug 06, 2018 at 11:37:55AM +0200, Rafael J. Wysocki wrote:
> >>On Fri, Aug 3, 2018 at 1:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>> [...]
> >>>
> >>>>>
> >>>>> Assuming that I have got that right, there are concerns, mostly regarding
> >>>>> patch [07/26], but I will reply to that directly.
> >>>>
> >>>> Well, I haven't got that right, so never mind.
> >>>>
> >>>> There are a few minor things to address, but apart from that the general
> >>>> genpd patches look ready.
> >>>
> >>> Alright, thanks!
> >>>
> >>> I will re-spin the series and post a new version once 4.19 rc1 is out.
> >>> Hopefully we can queue it up early in next cycle to get it tested in
> >>> next for a while.
> >>>
> >>>>
> >>>>> The $subject patch is fine by me by itself, but it obviously depends on the
> >>>>> previous ones.  Patches [01-02/26] are fine too, but they don't seem to be
> >>>>> particularly useful without the rest of the series.
> >>>>>
> >>>>> As far as patches [10-26/26] go, I'd like to see some review comments and/or
> >>>>> tags from the people with vested interest in there, in particular from Daniel
> >>>>> on patch [12/26] and from Sudeep on the PSCI ones.
> >>>>
> >>>> But this still holds.
> >>>
> >>> Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
> >>> on patch 12.
> >>>
> >>> In regards to the rest of the series, some of the PSCI/ARM changes
> >>> have been reviewed by Mark Rutland, however several changes have not
> >>> been acked.
> >>>
> >>> On the other hand, one can also interpret the long silence in regards
> >>> to PSCI/ARM changes as they are good to go. :-)
> >>
> >>Well, in that case giving an ACK to them should not be an issue for
> >>the people with a vested interest I suppose.
> >
> >Apologies to everyone for the delay in replying.
> >
> >Side note: cpu_pm_enter()/exit() are also called through syscore ops in
> >s2RAM/IDLE, you know that but I just wanted to mention it to compound
> >the discussion.
> >
> >As for PSCI patches I do not personally think PSCI OSI enablement is
> >beneficial (and my position has always been the same since PSCI OSI was
> >added to the specification, I am not even talking about this patchset)
> >and Arm Trusted Firmware does not currently support it for the same
> >reason.
> >
> >We (if Mark and Sudeep agree) will enable PSCI OSI if and when we have a
> >definitive and constructive answer to *why* we have to do that that is
> >not a dogmatic "the kernel knows better" but rather a comprehensive
> >power benchmark evaluation - I thought that was the agreement reached
> >at OSPM but apparently I was mistaken.
> >
> I will not speak to any comparison of benchmarks between OSI and PC.
> AFAIK, there are no platforms supporting both.

PSCI specifications, 5.20.1:

"The platform will boot in platform-coordinated mode."

So all platforms implementing OSI have to support both.

> But, the OSI feature is critical for QCOM mobile platforms. The
> last man activities during cpuidle save quite a lot of power.

What I expressed above was that, in PSCI based systems (OSI or PC
alike), it is up to firmware/hardware to detect "the last man" not
the kernel.

I need to understand what you mean by "last man activities" to
provide feedback here.

> Powering off the clocks, busses, regulators and even the oscillator is
> very important to have a reasonable battery life when using the phone.
> Platform coordinated approach falls quite short of the needs of a
> powerful processor with a desired battery efficiency.

I am sorry but if you want us to merge PSCI patches in this series you
will have to back the claim above with a detailed technical explanation
of *why* platform-coordination falls short of QCOM (or whoever else)
needs wrt PSCI OSI.

Thanks,
Lorenzo

Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D456C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135792086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfBHMQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:16:59 -0500
Received: from foss.arm.com ([217.140.101.70]:50016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:16:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708CC80D;
        Fri,  8 Feb 2019 04:16:58 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802F53F719;
        Fri,  8 Feb 2019 04:16:56 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:16:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190208121653.GC13043@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208110053.GA7913@e107155-lin>
 <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
 <20190208115122.GA13043@e107155-lin>
 <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:04:18PM +0100, Marek Szyprowski wrote:
> Hi Sudeep,
>
> On 2019-02-08 12:51, Sudeep Holla wrote:
> > On Fri, Feb 08, 2019 at 12:47:06PM +0100, Marek Szyprowski wrote:
> >> On 2019-02-08 12:00, Sudeep Holla wrote:
> >>> On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
> >>>> Dear All,
> >>>>
> >>>> This is a scenario that triggers the above issue:
> >>> [...]
> >>>> 1. system disables non-boot cpu's at the end of system suspend procedure,
> >>>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
> >>>> 3. early in the system resume procedure all cpus are got back to online
> >>>>    state,
> >>>> 4. this in turn causes cpufreq to be initialized for the newly onlined
> >>>>    cpus,
> >>>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
> >>>>    ->init() callback,
> >>> This is strictly not just restricted to cpufreq-dt, but to any driver
> >>> supporting multiple policies. So we need a generic fix not just
> >>> cpufreq-dt specific.
> >> Could you point which other driver needs similar fix? Here in cpufreq-dt
> >> the problem was caused by using regulator api (indirectly) from
> >> ->init(). All other drivers, which have regulators support, are for old,
> >> obsolete, uni-processor systems, which don't have the problem of
> >> secondary cpu suspend during system suspend/resume cycle.
> >>
> > scmi_cpufreq for instance. We can fix that in driver my moving to polling
> > to get cpufreq_get_rate, but we support both polling and interrupt based.
> > We may wait for remote processor interrupt in get_rate.
>
> Frankly, I don't feel I know enough to touch this driver and I don't
> think that this can even be fixed in a generic way in the cpufreq core.

Why not ? IIUC it's only to get/set the frequency you would need to talk
to remote processor or external chip over I2C which can be deferred until
resume. Rafael has valid concerns on messed up init implementations, still
wondering if there's any chance to solve this in the core.

> Maybe a comment somewhere is needed that ->init() might be called during
> early system resume with irqs off and driver is responsible for handling
> such case until the proper resume?
>

I agree and +1 for comment, but every driver needs to deal with that,
which is fine. Just trying to see if we can avoid it.

--
Regards,
Sudeep

Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B459EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8633C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJJW0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:26:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53652 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJW0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:26:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E573315B2;
        Wed, 10 Oct 2018 08:03:49 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034143F5B3;
        Wed, 10 Oct 2018 08:03:46 -0700 (PDT)
Date:   Wed, 10 Oct 2018 16:03:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 06/11] cpuidle: dt: Support hierarchical CPU idle
 states
Message-ID: <20181010150344.GC4844@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-7-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003143824.13059-7-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 04:38:19PM +0200, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Currently CPU's idle states are represented in a flattened model, via the
> "cpu-idle-states" binding from within the CPU's device nodes.
> 
> Support the hierarchical layout during parsing and validating of the CPU's
> idle states. This is simply done by calling the new OF helper,
> of_get_cpu_state_node().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/dt_idle_states.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index 53342b7f1010..13f9b7cd32d1 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -118,8 +118,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
>  	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
>  	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
>  		cpu_node = of_cpu_device_node_get(cpu);

We can get rid of above and the of_node_put below if we move this into
of_get_cpu_state_node as suggested in earlier patch.

Apart from these, I don't see any issues with the subset unless there
are users for these. I will dig the v8 and comment.

-- 
Regards,
Sudeep

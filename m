Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B02C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72A206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfADLBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:01:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40102 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADLBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:01:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA3715AD;
        Fri,  4 Jan 2019 03:01:51 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EAC43F575;
        Fri,  4 Jan 2019 03:01:48 -0800 (PST)
Date:   Fri, 4 Jan 2019 11:01:42 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, Douglas.Raillard@arm.com,
        "4 . 20" <stable@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Message-ID: <20190104110142.GA28483@e107155-lin>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 03:14:33PM +0530, Viresh Kumar wrote:
> Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> failures or on invocations of the policy->exit() callback.
>
> Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> called from these drivers instead of dev_pm_opp_cpumask_remove_table().
>
> In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> opp_list isn't getting accessed simultaneously from other parts of the
> OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> the opp_table->lock while traversing through the OPP list. And to
> accomplish that, this patch also creates _opp_kref_release_unlocked()
> which can be called from this new helper with the opp_table lock already
> held.
>

I did test it but since I couldn't reproduce the original issue, my
tested-by is not that worth. Anyways the changes look fine to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE7FC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986CA206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfADKkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:40:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39788 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfADKkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:40:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78EB15AD;
        Fri,  4 Jan 2019 02:40:10 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0B03F575;
        Fri,  4 Jan 2019 02:40:08 -0800 (PST)
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Douglas.Raillard@arm.com, "4 . 20" <stable@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <96b57b5b-7c6f-2118-05a0-8a568d7cb245@arm.com>
Date:   Fri, 4 Jan 2019 10:40:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/01/2019 09:44, Viresh Kumar wrote:
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
> Cc: 4.20 <stable@vger.kernel.org> # v4.20
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Gave it a spin on my Juno, and I don't see the refcount warning anymore so:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks for having a look at this.

[...]

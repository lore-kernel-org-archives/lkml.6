Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E29C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977EB2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfAKKir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:38:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55160 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbfAKKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:38:46 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 089072fae489c38b; Fri, 11 Jan 2019 11:38:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Douglas.Raillard@arm.com, "4 . 20" <stable@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Date:   Fri, 11 Jan 2019 11:37:57 +0100
Message-ID: <13587320.TAQQ9Zc4eI@aspire.rjw.lan>
In-Reply-To: <20190104110142.GA28483@e107155-lin>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com> <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org> <20190104110142.GA28483@e107155-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 4, 2019 12:01:42 PM CET Sudeep Holla wrote:
> On Fri, Jan 04, 2019 at 03:14:33PM +0530, Viresh Kumar wrote:
> > Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> > _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> > automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> > affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> > failures or on invocations of the policy->exit() callback.
> >
> > Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> > called from these drivers instead of dev_pm_opp_cpumask_remove_table().
> >
> > In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> > opp_list isn't getting accessed simultaneously from other parts of the
> > OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> > the opp_table->lock while traversing through the OPP list. And to
> > accomplish that, this patch also creates _opp_kref_release_unlocked()
> > which can be called from this new helper with the opp_table lock already
> > held.
> >
> 
> I did test it but since I couldn't reproduce the original issue, my
> tested-by is not that worth. Anyways the changes look fine to me.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied and pushed to Linus, thanks!


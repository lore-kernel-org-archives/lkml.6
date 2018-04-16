Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDPReR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:34:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeDPReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:34:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E054607E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 16 Apr 2018 11:34:12 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/26] PM / Domains: Deal with multiple states but no
 governor in genpd
Message-ID: <20180416173412.GE1209@codeaurora.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
 <1523531671-27491-3-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1523531671-27491-3-git-send-email-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12 2018 at 05:14 -0600, Ulf Hansson wrote:
>A caller of pm_genpd_init() that provides some states for the genpd via the
>->states pointer in the struct generic_pm_domain, should also provide a
>governor. This because it's the job of the governor to pick a state that
>satisfies the constraints.
>
>Therefore, let's print a warning to inform the user about such bogus
>configuration and avoid to bail out, by instead picking the shallowest
>state before genpd invokes the ->power_off() callback.
>
>Cc: Lina Iyer <ilina@codeaurora.org>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/base/power/domain.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index c2ef944..9aff79d 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -466,6 +466,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> 			return -EAGAIN;
> 	}
>
>+	/* Default to shallowest state. */
>+	if (!genpd->gov)
>+		genpd->state_idx = 0;
>+
> 	if (genpd->power_off) {
> 		int ret;
>
>@@ -1694,6 +1698,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> 		ret = genpd_set_default_power_state(genpd);
> 		if (ret)
> 			return ret;
>+	} else if (!gov) {
>+		pr_warn("%s : no governor for states\n", genpd->name);
> 	}
>
> 	mutex_lock(&gpd_list_lock);
>--
>2.7.4
>

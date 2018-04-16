Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeDPRdd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:33:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeDPRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:33:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65E7260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 16 Apr 2018 11:33:26 -0600
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
Subject: Re: [PATCH v7 01/26] PM / Domains: Don't treat zero found compatible
 idle states as an error
Message-ID: <20180416173326.GD1209@codeaurora.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
 <1523531671-27491-2-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1523531671-27491-2-git-send-email-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12 2018 at 05:14 -0600, Ulf Hansson wrote:
>Instead of returning -EINVAL from of_genpd_parse_idle_states() in case none
>compatible states was found, let's return 0 to indicate success. Assign
>also the out-parameter *states to NULL and *n to 0, to indicate to the
>caller that zero states have been found/allocated.
>
>This enables the caller of of_genpd_parse_idle_states() to easier act on
>the returned error code.
>
>Cc: Lina Iyer <ilina@codeaurora.org>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/base/power/domain.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 1ea0e25..c2ef944 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -2331,8 +2331,8 @@ static int genpd_iterate_idle_states(struct device_node *dn,
>  *
>  * Returns the device states parsed from the OF node. The memory for the states
>  * is allocated by this function and is the responsibility of the caller to
>- * free the memory after use. If no domain idle states is found it returns
>- * -EINVAL and in case of errors, a negative error code.
>+ * free the memory after use. If any or zero compatible domain idle states is
>+ * found it returns 0 and in case of errors, a negative error code is returned.
>  */
> int of_genpd_parse_idle_states(struct device_node *dn,
> 			struct genpd_power_state **states, int *n)
>@@ -2341,8 +2341,14 @@ int of_genpd_parse_idle_states(struct device_node *dn,
> 	int ret;
>
> 	ret = genpd_iterate_idle_states(dn, NULL);
>-	if (ret <= 0)
>-		return ret < 0 ? ret : -EINVAL;
>+	if (ret < 0)
>+		return ret;
>+
>+	if (!ret) {
>+		*states = NULL;
>+		*n = 0;
>+		return 0;
>+	}
>
> 	st = kcalloc(ret, sizeof(*st), GFP_KERNEL);
> 	if (!st)
>--
>2.7.4
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeCNRil (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:38:41 -0400
Received: from foss.arm.com ([217.140.101.70]:57266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCNRij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:38:39 -0400
Date: Wed, 14 Mar 2018 17:38:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 20/25] drivers: firmware: psci: Introduce
 psci_dt_topology_init()
Message-ID: <20180314173833.dyu7jtweu233rfi4@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-21-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521046715-30683-21-git-send-email-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:58:30PM +0100, Ulf Hansson wrote:
> In case the hierarchical layout is used in DT, we want to initialize the
> corresponding PM domain topology for the CPUs, by using the generic PM
> domain (aka genpd) infrastructure.
> 
> At first glance, it may seem feasible to hook into the existing
> psci_dt_init() function, although because it's called quite early in the
> boot sequence, allocating the dynamic data structure for a genpd doesn't
> work.
> 
> Therefore, let's export a new init function for PSCI,
> psci_dt_topology_init(), which the ARM machine code should call from a
> suitable initcall.
> 
> Succeeding to initialize the PM domain topology, which means at least one
> instance of a genpd becomes created, allows us to continue to enable the
> PSCI OS initiated mode for the platform. If everything turns out fine,
> let's print a message in log to inform the user about the changed mode.
> 
> In case of any failures, we stick to the default PSCI Platform Coordinated
> mode.

For kexec/kdump we'll need to explicitly set the suspend mode to
platform coordinated if for whatever reason we choose not to use OSI.

> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/firmware/psci.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/psci.h    |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 463f78c..45d55fc 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -723,6 +723,37 @@ int __init psci_dt_init(void)
>  	return ret;
>  }
>  
> +int __init psci_dt_topology_init(void)
> +{
> +	struct device_node *np;
> +	int ret;
> +
> +	if (!psci_has_osi_support())
> +		return 0;
> +
> +	np = of_find_matching_node_and_match(NULL, psci_of_match, NULL);
> +	if (!np)
> +		return -ENODEV;
> +
> +	/* Initialize the CPU PM domains based on topology described in DT. */
> +	ret = psci_dt_init_pm_domains(np);
> +	if (ret <= 0)
> +		goto out;
> +
> +	/* Enable OSI mode. */
> +	ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> +			     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);

IIUC, this patch will need to be moved after the subsequent two patches
to ensure that this series bisects cleanly.

Thanks,
Mark.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeCNR0G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:26:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57036 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCNR0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:26:04 -0400
Date: Wed, 14 Mar 2018 17:25:58 +0000
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
Subject: Re: [PATCH v6 15/25] drivers: firmware: psci: Simplify error path of
 psci_dt_init()
Message-ID: <20180314172558.akbzw6c7cwnah3sb@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-16-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521046715-30683-16-git-send-email-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:58:25PM +0100, Ulf Hansson wrote:
> Instead of having each psci init function taking care of the of_node_put(),
> let's deal with that from psci_dt_init(), as this enables a bit simpler
> error path for each psci init function.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Nice cleanup!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/psci.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 256b4ed..3888100 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -608,9 +608,9 @@ static int __init psci_0_2_init(struct device_node *np)
>  	int err;
>  
>  	err = get_set_conduit_method(np);
> -
>  	if (err)
> -		goto out_put_node;
> +		return err;
> +
>  	/*
>  	 * Starting with v0.2, the PSCI specification introduced a call
>  	 * (PSCI_VERSION) that allows probing the firmware version, so
> @@ -618,11 +618,7 @@ static int __init psci_0_2_init(struct device_node *np)
>  	 * can be carried out according to the specific version reported
>  	 * by firmware
>  	 */
> -	err = psci_probe();
> -
> -out_put_node:
> -	of_node_put(np);
> -	return err;
> +	return psci_probe();
>  }
>  
>  /*
> @@ -634,9 +630,8 @@ static int __init psci_0_1_init(struct device_node *np)
>  	int err;
>  
>  	err = get_set_conduit_method(np);
> -
>  	if (err)
> -		goto out_put_node;
> +		return err;
>  
>  	pr_info("Using PSCI v0.1 Function IDs from DT\n");
>  
> @@ -660,9 +655,7 @@ static int __init psci_0_1_init(struct device_node *np)
>  		psci_ops.migrate = psci_migrate;
>  	}
>  
> -out_put_node:
> -	of_node_put(np);
> -	return err;
> +	return 0;
>  }
>  
>  static const struct of_device_id psci_of_match[] __initconst = {
> @@ -677,6 +670,7 @@ int __init psci_dt_init(void)
>  	struct device_node *np;
>  	const struct of_device_id *matched_np;
>  	psci_initcall_t init_fn;
> +	int ret;
>  
>  	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
>  
> @@ -684,7 +678,10 @@ int __init psci_dt_init(void)
>  		return -ENODEV;
>  
>  	init_fn = (psci_initcall_t)matched_np->data;
> -	return init_fn(np);
> +	ret = init_fn(np);
> +
> +	of_node_put(np);
> +	return ret;
>  }
>  
>  #ifdef CONFIG_ACPI
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

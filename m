Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C577C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CC420693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CC420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGSLG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:06:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46514 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeGSLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:06:57 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 87e891bf6d43d026; Thu, 19 Jul 2018 12:24:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/26] PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
Date:   Thu, 19 Jul 2018 12:22:47 +0200
Message-ID: <3889041.sTGkQNs1Ck@aspire.rjw.lan>
In-Reply-To: <20180620172226.15012-6-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-6-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 20, 2018 7:22:05 PM CEST Ulf Hansson wrote:
> Introduce two new genpd helper functions, of_genpd_attach|detach_cpu(),
> which takes the CPU-number as an in-parameter.
> 
> To attach a CPU to a genpd, of_genpd_attach_cpu() starts by fetching the
> struct device belonging to the CPU. Then it calls genpd_dev_pm_attach(),
> which via DT tries to hook up the CPU device to its corresponding PM
> domain. If it succeeds, of_genpd_attach_cpu() continues to prepare/enable
> runtime PM of the device.
> 
> To detach a CPU from its PM domain, of_genpd_attach_cpu() reverse the
> operations made from of_genpd_attach_cpu(). However, first it checks that
> the CPU device has a valid PM domain pointer assigned, as to make sure it
> belongs to genpd.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  9 +++++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6149ce0bfa7b..299fa2febbec 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2445,6 +2445,75 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>  
> +/*
> + * of_genpd_attach_cpu() - Attach a CPU to its PM domain
> + * @cpu: The CPU to be attached.
> + *
> + * Parses the OF node of the CPU's device, to find a PM domain specifier. If
> + * such is found, attaches the CPU's device to the retrieved pm_domain ops and
> + * enables runtime PM for it. This to allow the CPU to be power managed through
> + * its PM domain.
> + *
> + * Returns zero when successfully attached the CPU's device to its PM domain,
> + * else a negative error code.
> + */
> +int of_genpd_attach_cpu(int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +	int ret;
> +
> +	if (!dev) {
> +		pr_warn("genpd: no dev for cpu%d\n", cpu);
> +		return -ENODEV;
> +	}

I'm not sure about the value of the above.  Is it possible even?

> +
> +	ret = genpd_dev_pm_attach(dev);
> +	if (ret != 1) {
> +		dev_warn(dev, "genpd: attach cpu failed %d\n", ret);

This looks like a debug message.  Do you really want to print it with high prio?

> +		return ret < 0 ? ret : -ENODEV;
> +	}
> +
> +	pm_runtime_irq_safe(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	dev_info(dev, "genpd: attached cpu\n");

This definitely is a debug message.

> +	return 0;
> +}
> +EXPORT_SYMBOL(of_genpd_attach_cpu);
> +
> +/**
> + * of_genpd_detach_cpu() - Detach a CPU from its PM domain
> + * @cpu: The CPU to be detached.
> + *
> + * Detach the CPU's device from its corresponding PM domain. If detaching is
> + * completed successfully, disable runtime PM and restore the runtime PM usage
> + * count for the CPU's device.
> + */
> +void of_genpd_detach_cpu(int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	if (!dev) {
> +		pr_warn("genpd: no dev for cpu%d\n", cpu);
> +		return;
> +	}
> +
> +	/* Check that the device is attached to a genpd. */
> +	if (!(dev->pm_domain && dev->pm_domain->detach == genpd_dev_pm_detach))
> +		return;
> +
> +	genpd_dev_pm_detach(dev, true);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_reinit(dev);
> +
> +	dev_info(dev, "genpd: detached cpu\n");
> +}
> +EXPORT_SYMBOL(of_genpd_detach_cpu);
> +
>  static const struct of_device_id idle_state_match[] = {
>  	{ .compatible = "domain-idle-state", },
>  	{ }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3f67ff0c1c69..2c09cf80b285 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -243,6 +243,8 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>  int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  					 unsigned int index);
> +int of_genpd_attach_cpu(int cpu);
> +void of_genpd_detach_cpu(int cpu);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>  					struct generic_pm_domain *genpd)
> @@ -294,6 +296,13 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	return NULL;
>  }
>  
> +static inline int of_genpd_attach_cpu(int cpu)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void of_genpd_detach_cpu(int cpu) {}
> +
>  static inline
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
> 

I'd combine this with patch [04/26].  The split here is somewhat artificial IMO.


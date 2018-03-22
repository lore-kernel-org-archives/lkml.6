Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeCVJ3B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:29:01 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37520 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeCVJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:28:58 -0400
X-Google-Smtp-Source: AG47ELsW675jPPJM0Yn6cEBja60ODDgAY7Prq62HyFPQMVfER5QxMaNkVrbfst3WOm2GODVPNgcsBp8iITXedw2h9iU=
MIME-Version: 1.0
In-Reply-To: <627a1c8658a1c0cd4b96ae087c87bb3dfa1ee70a.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <627a1c8658a1c0cd4b96ae087c87bb3dfa1ee70a.1513926033.git.viresh.kumar@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Mar 2018 10:28:57 +0100
Message-ID: <CAPDyKFr3hz8MqQoOCYzcfMPN7z-yg58L_evytSb4w32oq9fmCw@mail.gmail.com>
Subject: Re: [PATCH 1/7] PM / OPP: Implement dev_pm_opp_of_add_table_indexed()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 December 2017 at 08:26, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The "operating-points-v2" property can contain a list of phandles now,
> specifically for the power domain providers that provide multiple
> domains.
>
> Add support to parse that.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/opp/of.c       | 50 +++++++++++++++++++++++++++++++++++++++++---------
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 47 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index cb716aa2f44b..22c9bd191f62 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -250,20 +250,17 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>
>  /* Returns opp descriptor node for a device node, caller must
>   * do of_node_put() */
> -static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np)
> +static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
> +                                                    int index)
>  {
> -       /*
> -        * There should be only ONE phandle present in "operating-points-v2"
> -        * property.
> -        */
> -
> -       return of_parse_phandle(np, "operating-points-v2", 0);
> +       /* "operating-points-v2" can be an array for power domain providers */
> +       return of_parse_phandle(np, "operating-points-v2", index);
>  }
>
>  /* Returns opp descriptor node for a device, caller must do of_node_put() */
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
>  {
> -       return _opp_of_get_opp_desc_node(dev->of_node);
> +       return _opp_of_get_opp_desc_node(dev->of_node, 0);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
>
> @@ -509,6 +506,41 @@ int dev_pm_opp_of_add_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
>
> +/**
> + * dev_pm_opp_of_add_table_indexed() - Initialize indexed opp table from device tree
> + * @dev:       device pointer used to lookup OPP table.
> + * @index:     Index number.
> + *
> + * Register the initial OPP table with the OPP library for given device only
> + * using the "operating-points-v2" property.
> + *
> + * Return:
> + * 0           On success OR
> + *             Duplicate OPPs (both freq and volt are same) and opp->available
> + * -EEXIST     Freq are same and volt are different OR
> + *             Duplicate OPPs (both freq and volt are same) and !opp->available
> + * -ENOMEM     Memory allocation failure
> + * -ENODEV     when 'operating-points' property is not found or is invalid data
> + *             in device node.
> + * -ENODATA    when empty 'operating-points' property is found
> + * -EINVAL     when invalid entries are found in opp-v2 table
> + */
> +int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
> +{
> +       struct device_node *opp_np;
> +       int ret;
> +
> +       opp_np = _opp_of_get_opp_desc_node(dev->of_node, index);
> +       if (!opp_np)
> +               return -ENODEV;
> +
> +       ret = _of_add_opp_table_v2(dev, opp_np);
> +       of_node_put(opp_np);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
> +
>  /* CPU device specific helpers */
>
>  /**
> @@ -613,7 +645,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>                 }
>
>                 /* Get OPP descriptor node */
> -               tmp_np = _opp_of_get_opp_desc_node(cpu_np);
> +               tmp_np = _opp_of_get_opp_desc_node(cpu_np, 0);
>                 of_node_put(cpu_np);
>                 if (!tmp_np) {
>                         pr_err("%pOF: Couldn't find opp node\n", cpu_np);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 6c2d2e88f066..f042fdeaaa3c 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -303,6 +303,7 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
>
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
>  int dev_pm_opp_of_add_table(struct device *dev);
> +int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
>  void dev_pm_opp_of_remove_table(struct device *dev);
>  int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
>  void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
> @@ -314,6 +315,11 @@ static inline int dev_pm_opp_of_add_table(struct device *dev)
>         return -ENOTSUPP;
>  }
>
> +static inline int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
> +{
> +       return -ENOTSUPP;
> +}
> +
>  static inline void dev_pm_opp_of_remove_table(struct device *dev)
>  {
>  }
> --
> 2.15.0.194.g9af6a3dea062
>

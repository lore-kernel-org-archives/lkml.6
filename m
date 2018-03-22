Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeCVJcG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:32:06 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51466 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeCVJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:32:03 -0400
X-Google-Smtp-Source: AG47ELt1bled41ngRKWmARWtHLGC9WReXJxB9ucck2l/pcJhoCJh+eEPpvBzxhTdqUmhQkSRevpDFuEdbpntQ6uE8ac=
MIME-Version: 1.0
In-Reply-To: <755aabf2ad16d3a2131483407d7f580431571a00.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <755aabf2ad16d3a2131483407d7f580431571a00.1513926033.git.viresh.kumar@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Mar 2018 10:32:02 +0100
Message-ID: <CAPDyKFrviW6BkjL3-2=587xrdrNaR=VNf_2tOSzzqcRzMc+u=A@mail.gmail.com>
Subject: Re: [PATCH 5/7] PM / Domain: Implement of_dev_pm_genpd_get_performance_state()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>,
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
> This implements of_dev_pm_genpd_get_performance_state() which can be
> used from the device drivers or the OPP core to find the performance
> state encoded in the "required-opp" property of a node. Different

Please add a two newlines after "node".

> platforms may encode the performance state differently using the OPP
> table (they may simply return value of opp-hz or opp-microvolt, or apply
> some algorithm on top of those values) and so a new callback is
> implemented to allow platform specific drivers to convert the power
> domain OPP to a performance state.

Could you perhaps clarify at what typical point(s) the drivers or the
OPP core should call this new API? That is useful information in the
changelog.

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 11 +++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1ad4ad0b0de0..ef43b75982fa 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2415,6 +2415,54 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +/**
> + * of_dev_pm_genpd_get_performance_state- Gets performance state of device's
> + * power domain corresponding to a DT node's "required-opp" property.
> + *
> + * @dev: Device for which the performance-state needs to be found.
> + * @np: DT node where the "required-opp" property is present. This can be
> + *     the device node itself (if it doesn't have an OPP table) or a node
> + *     within the OPP table of a device (if device has an OPP table).
> + * @state: Pointer to return performance state.
> + *
> + * Returns performance state corresponding to the "required-opp" property of
> + * a DT node. This calls platform specific genpd->get_performance_state()
> + * callback to translate power domain OPP to performance state.
> + *
> + * Returns performance state on success and 0 on failure.
> + */
> +unsigned int of_dev_pm_genpd_get_performance_state(struct device *dev,
> +                                                  struct device_node *np)

First: To clarify the API, perhaps change to "...struct device_node *opp_node)"

Second, the function name is confusing. To me, it sounds like an API
that will get the dynamically requested performance state for the
device and that isn't the case.

So, I would rather name it something along the lines of,
"of_genpd_opp_to_performance_state()". Can you please consider
renaming it?

> +{
> +       struct generic_pm_domain *genpd;
> +       struct dev_pm_opp *opp;
> +       int state = 0;
> +
> +       genpd = dev_to_genpd(dev);
> +       if (IS_ERR(genpd))
> +               return 0;
> +
> +       if (unlikely(!genpd->set_performance_state))
> +               return 0;
> +
> +       genpd_lock(genpd);
> +
> +       opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
> +       if (IS_ERR(opp)) {
> +               state = PTR_ERR(opp);
> +               goto unlock;
> +       }
> +
> +       state = genpd->get_performance_state(genpd, opp);
> +       dev_pm_opp_put(opp);
> +
> +unlock:
> +       genpd_unlock(genpd);
> +
> +       return state;
> +}
> +EXPORT_SYMBOL_GPL(of_dev_pm_genpd_get_performance_state);
> +
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index aaacaa35005d..4edbdaa54cec 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -47,6 +47,7 @@ struct genpd_power_state {
>  };
>
>  struct genpd_lock_ops;
> +struct dev_pm_opp;
>
>  struct generic_pm_domain {
>         struct device dev;
> @@ -68,6 +69,8 @@ struct generic_pm_domain {
>         unsigned int performance_state; /* Aggregated max performance state */
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
> +       unsigned int (*get_performance_state)(struct generic_pm_domain *genpd,
> +                                             struct dev_pm_opp *opp);

According to the comments above, please rename the callback to:
"opp_to_performance_state", or whatever better name you can come up with. :-)

>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
>         struct gpd_dev_ops dev_ops;
> @@ -244,6 +247,8 @@ extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
>  extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  extern int of_genpd_parse_idle_states(struct device_node *dn,
>                         struct genpd_power_state **states, int *n);
> +extern unsigned int of_dev_pm_genpd_get_performance_state(struct device *dev,
> +                               struct device_node *np);
>
>  int genpd_dev_pm_attach(struct device *dev);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> @@ -279,6 +284,12 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
>         return -ENODEV;
>  }
>
> +static inline unsigned int of_dev_pm_genpd_get_performance_state(struct device *dev,
> +                                       struct device_node *np)
> +{
> +       return -ENODEV;
> +}
> +
>  static inline int genpd_dev_pm_attach(struct device *dev)
>  {
>         return -ENODEV;
> --
> 2.15.0.194.g9af6a3dea062
>

Mostly minor things, so overall this looks good to me!

Kind regards
Uffe

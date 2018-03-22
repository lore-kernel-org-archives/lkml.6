Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeCVJbG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:31:06 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43909 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeCVJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:31:02 -0400
X-Google-Smtp-Source: AG47ELvE/+VWGMMGWOp6TMojx7AjQsAdn6iePU/Jxg351maXLKSn8o8dWEgcuwH4XIs9SQxpQFMubxy/t7mpgBqGnRc=
MIME-Version: 1.0
In-Reply-To: <596dd0d16dcb31fd35d6a38835d1a3d56254b6ce.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <596dd0d16dcb31fd35d6a38835d1a3d56254b6ce.1513926033.git.viresh.kumar@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Mar 2018 10:31:01 +0100
Message-ID: <CAPDyKFontDwvpS97xBskNE-FLMo3HPDLthCEkviZv8rKdA8t=g@mail.gmail.com>
Subject: Re: [PATCH 4/7] PM / Domain: Add support to parse domain's OPP table
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
> Parse the OPP table for power domains if they have their
> set_performance_state() callback set.

Nitpick:
This is a bit too short, please elaborate a bit on the why and what
this change does.

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 78 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 62 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 013c1e206167..1ad4ad0b0de0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
> @@ -1900,15 +1901,33 @@ int of_genpd_add_provider_simple(struct device_node *np,
>
>         mutex_lock(&gpd_list_lock);
>
> -       if (genpd_present(genpd)) {
> -               ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
> -               if (!ret) {
> -                       genpd->provider = &np->fwnode;
> -                       genpd->has_provider = true;
> -                       genpd->dev.of_node = np;
> +       if (!genpd_present(genpd))
> +               goto unlock;
> +
> +       genpd->dev.of_node = np;
> +
> +       /* Parse genpd OPP table */
> +       if (genpd->set_performance_state) {
> +               ret = dev_pm_opp_of_add_table(&genpd->dev);
> +               if (ret) {
> +                       dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
> +                               ret);
> +                       goto unlock;
>                 }
>         }
>
> +       ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
> +       if (ret) {
> +               if (genpd->set_performance_state)
> +                       dev_pm_opp_of_remove_table(&genpd->dev);
> +
> +               goto unlock;
> +       }
> +
> +       genpd->provider = &np->fwnode;
> +       genpd->has_provider = true;
> +
> +unlock:
>         mutex_unlock(&gpd_list_lock);
>
>         return ret;
> @@ -1923,6 +1942,7 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
>  int of_genpd_add_provider_onecell(struct device_node *np,
>                                   struct genpd_onecell_data *data)
>  {
> +       struct generic_pm_domain *genpd;
>         unsigned int i;
>         int ret = -EINVAL;
>
> @@ -1935,14 +1955,27 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                 data->xlate = genpd_xlate_onecell;
>
>         for (i = 0; i < data->num_domains; i++) {
> -               if (!data->domains[i])
> +               genpd = data->domains[i];
> +
> +               if (!genpd)
>                         continue;
> -               if (!genpd_present(data->domains[i]))
> +               if (!genpd_present(genpd))
>                         goto error;
>
> -               data->domains[i]->provider = &np->fwnode;
> -               data->domains[i]->has_provider = true;
> -               data->domains[i]->dev.of_node = np;
> +               genpd->dev.of_node = np;
> +
> +               /* Parse genpd OPP table */
> +               if (genpd->set_performance_state) {
> +                       ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
> +                       if (ret) {
> +                               dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
> +                                       i, ret);
> +                               goto error;
> +                       }
> +               }
> +
> +               genpd->provider = &np->fwnode;
> +               genpd->has_provider = true;
>         }
>
>         ret = genpd_add_provider(np, data->xlate, data);
> @@ -1955,10 +1988,16 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>
>  error:
>         while (i--) {
> -               if (!data->domains[i])
> +               genpd = data->domains[i];
> +
> +               if (!genpd)
>                         continue;
> -               data->domains[i]->provider = NULL;
> -               data->domains[i]->has_provider = false;
> +
> +               genpd->provider = NULL;
> +               genpd->has_provider = false;
> +
> +               if (genpd->set_performance_state)
> +                       dev_pm_opp_of_remove_table(&genpd->dev);
>         }
>
>         mutex_unlock(&gpd_list_lock);
> @@ -1985,10 +2024,17 @@ void of_genpd_del_provider(struct device_node *np)
>                          * provider, set the 'has_provider' to false
>                          * so that the PM domain can be safely removed.
>                          */
> -                       list_for_each_entry(gpd, &gpd_list, gpd_list_node)
> -                               if (gpd->provider == &np->fwnode)
> +                       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +                               if (gpd->provider == &np->fwnode) {
>                                         gpd->has_provider = false;
>
> +                                       if (!gpd->set_performance_state)
> +                                               continue;

Nitpick, perhaps change this to:

if (gpd->set_performance_state)
       dev_pm_opp_of_remove_table(&gpd->dev);

> +
> +                                       dev_pm_opp_of_remove_table(&gpd->dev);
> +                               }
> +                       }
> +
>                         list_del(&cp->link);
>                         of_node_put(cp->node);
>                         kfree(cp);
> --
> 2.15.0.194.g9af6a3dea062
>

When fixed the nitpicks, feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA713C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780E320835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTGHx3Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780E320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeJLWlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:41:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35502 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeJLWlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:41:25 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so18660416itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uGw5A5Y7mpJdGnl41LhXv8eQvD5m2+LjeqzVWSZ7tUA=;
        b=DTGHx3YeeXT4aa7zslb+MRgBMeqxqzaxXpqGxYIpr6q9fRyWivtBC9RKvT3xu2PPdK
         9OlpW+RNQVm8qg0uz+HoQgA0VgZg7eLIcNaLz0YmWLNQyheP7ymAGwCrNnHLqtq+8Zgo
         LOpVuWKWYJthlqf3gnTuTEpEbJjbaExUOIwO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uGw5A5Y7mpJdGnl41LhXv8eQvD5m2+LjeqzVWSZ7tUA=;
        b=Ehn3pzoZrzdRhOnJpYdxDOA9txji5o+s6gVPLIOszVrLwQ6h3ONt/qLq4BbOAW3oGA
         Pm1L0IkWJ5lpsOvQUpzzheSKedNf0vy2b4CP8tVX6/CmXEqux97oQxT8RfyGRMB7lBAq
         Ocdh2LmQhqMo8NUqIJcjNBDFl+KqTQaBPnRlQI4XsKfjmQc15IfY0pbWTha03L1dD+hn
         URv89+LR6baVIW0v18wZuGqQYb806N0tuUcqzWzAPHXnYBCr9f3TIG5Duz97HGsJa3MC
         QorGw0bVWfJc6f1nFaAk5rT3zhEh6MPAh1IbQJ+nr0oNAkZ7oy2d86N00jMs+5bWfrFn
         dj9Q==
X-Gm-Message-State: ABuFfohuQ5GkvanmzYJgFg8641DtG2fGYPu18v8326E25F9AaxMbdWPz
        IEChPKpJxlLvIYvuD2WITvLwSTj7jBBAWcwSpYCo4g==
X-Google-Smtp-Source: ACcGV60PcTOdUtFKgZxNDJyuvKGROOfoaO3C7w0YOQEudrarA5X/ICoHwVUY+/lkQWDjaPiCMW67ta0Q7aSmZR7trdQ=
X-Received: by 2002:a24:4795:: with SMTP id t143-v6mr4821806itb.78.1539356910532;
 Fri, 12 Oct 2018 08:08:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:07:50
 -0700 (PDT)
In-Reply-To: <ec154fa205967507c7352a2d0088346aba562ff2.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <ec154fa205967507c7352a2d0088346aba562ff2.1539341929.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 17:07:50 +0200
Message-ID: <CAPDyKFpTbSdyqkKUY0HrkOo_YHcRJZ25FrJxVtzPOJ_aHRaE8Q@mail.gmail.com>
Subject: Re: [PATCH V2 5/9] PM / Domains: Add genpd_opp_to_performance_state()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP core currently stores the performance state in the consumer
> device's OPP table, but that is going to change going forward and
> performance state will rather be set directly in the genpd's OPP table.
>
> For that we need to get the performance state for genpd's device
> structure instead of the consumer device's structure. Add a new helper
> to do that.

I guess what puzzles me a bit here is that we are using a struct
device, while we actually should be talking about an OPP cookie
instead, right?

So the "genpd's device structure" here is not the same as the virtual
devices created by genpd to support multiple PM domains, right? Or is
it?

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  8 ++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4b5714199490..2c82194d2a30 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2508,6 +2508,45 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +/**
> + * genpd_opp_to_performance_state- Gets performance state of the genpd from its OPP node.

Please rename to:

pm_genpd_opp_to_perfromance_state().

> + *
> + * @genpd_dev: Genpd's device for which the performance-state needs to be found.

Maybe "genpd_dev" is the correct name to use here, as I understand
it's actually the device representing the genpd. However, in other
patches in this series you are also using "genpd_dev", while those
instead corresponds to the virtual created devices by genpd.

I would appreciate if we could make that more clear in the code.

Maybe distinguish them as:

genpd_dev
genpd_virt_dev

or just:

dev
virt_dev

> + * @opp: struct dev_pm_opp of the OPP for which we need to find performance
> + *     state.
> + *
> + * Returns performance state encoded in the OPP of the genpd. This calls
> + * platform specific genpd->opp_to_performance_state() callback to translate
> + * power domain OPP to performance state.
> + *
> + * Returns performance state on success and 0 on failure.
> + */
> +unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                           struct dev_pm_opp *opp)
> +{
> +       struct generic_pm_domain *genpd = NULL, *temp;
> +       int state;
> +
> +       lockdep_assert_held(&gpd_list_lock);

What's this?

> +
> +       list_for_each_entry(temp, &gpd_list, gpd_list_node) {
> +               if (&temp->dev == genpd_dev) {
> +                       genpd = temp;
> +                       break;
> +               }
> +       }

I think we can do better than this.

We really don't want to walk the list of genpds while doing this. The
caller should already know (if not now, we should fix it) that the
struct device is used to represent a genpd.

In other words, I am thinking using a container_of() or a finding a
function pointer through the struct device, in any case, it would be
better.

If it all sounds fuzzy, let me think a bit about it and come back with
a more clear suggestion.

> +
> +       if (unlikely(!genpd || !genpd->opp_to_performance_state))
> +               return 0;
> +
> +       genpd_lock(genpd);

.... so in the end, this is the only lock that should be needed.

> +       state = genpd->opp_to_performance_state(genpd, opp);
> +       genpd_unlock(genpd);
> +
> +       return state;
> +}
> +EXPORT_SYMBOL_GPL(genpd_opp_to_performance_state);
> +
>  /**
>   * of_genpd_opp_to_performance_state- Gets performance state of device's
>   * power domain corresponding to a DT node's "required-opps" property.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 776c546d581a..e03f300f7468 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -233,6 +233,8 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent,
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
> +unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                           struct dev_pm_opp *opp);
>  unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>                                 struct device_node *np);
>
> @@ -274,6 +276,12 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
>         return -ENODEV;
>  }
>
> +static inline unsigned int
> +genpd_opp_to_performance_state(struct device *genpd_dev, struct dev_pm_opp *opp)
> +{
> +       return 0;
> +}
> +
>  static inline unsigned int
>  of_genpd_opp_to_performance_state(struct device *dev,
>                                   struct device_node *np)
> --
> 2.18.0.rc1.242.g61856ae69a2c
>

Besides the comments above, I am all in for the approach as such.

Kind regards
Uffe

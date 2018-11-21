Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABFD21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gQpmcWw6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jnt4qwpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABFD21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeKUPgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:36:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:36:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 667DF60B26; Wed, 21 Nov 2018 05:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542776589;
        bh=a/sKkIigTj5t3YYrLeV5uIZRrBlvcyhEZvcRM+DDdF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gQpmcWw6rK0xwds5CnRlmVMPlhBs8PTMeAwTdysin4jivcTAyve+G++5SRJNmXvaL
         k2lXtDTFaFcQv3+dWTZF2vvvPzvVYJeczCe3/Z3hwAsKA5Kk9DHwxwALP85HDJUZGz
         6qz2co52AWfG7v8kKwxh+NqVVgV9z1ztafMcxGVY=
Received: from [10.79.128.198] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A34B6053B;
        Wed, 21 Nov 2018 05:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542776586;
        bh=a/sKkIigTj5t3YYrLeV5uIZRrBlvcyhEZvcRM+DDdF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jnt4qwpd6sOmVZkKYND3eGG9a9bcWEW3eKf4Ceecdo9GvGEG3HkjYTWcV72r0ohv/
         nxACPaw5AHOA94T9WR1w2UAuk3KJUT/MY2V2b/Ru7KS5K3THTSLt+4TlBWYskadccV
         fdb63PVdnCNm9BuZkzO39B1rMLw6Cpm0xrR9IYHk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A34B6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
To:     Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
Date:   Wed, 21 Nov 2018 10:33:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> This commit updates genpd core to start propagating performance state
> updates to master domains that have their set_performance_state()
> callback set.
> 
> A genpd handles two type of performance states now. The first one is the
> performance state requirement put on the genpd by the devices and
> sub-domains under it, which is already represented by
> genpd->performance_state. The second type, introduced in this commit, is
> the performance state requirement(s) put by the genpd on its master
> domain(s). There is a separate value required for each master that the
> genpd has and so a new field is added to the struct gpd_link
> (link->performance_state), which represents the link between a genpd and
> its master. The struct gpd_link also got another field
> prev_performance_state, which is used by genpd core as a temporary
> variable during transitions.
> 
> We need to propagate setting performance state while powering-on a genpd
> as well, as we ignore performance state requirements from sub-domains
> which are powered-off. For this reason _genpd_power_on() also received
> the additional parameter, depth, which is used for hierarchical locking
> within genpd.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/base/power/domain.c | 107 +++++++++++++++++++++++++++++-------
>   include/linux/pm_domain.h   |   4 ++
>   2 files changed, 92 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6d2e9b3406f1..81e02c5f753f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -239,28 +239,86 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>   static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>   #endif
>   
> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +					   unsigned int state, int depth);
> +
>   static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> -					unsigned int state)
> +					unsigned int state, int depth)
>   {
> +	struct generic_pm_domain *master;
> +	struct gpd_link *link;
> +	unsigned int mstate;
>   	int ret;
>   
>   	if (!genpd_status_on(genpd))
>   		goto out;

This check here would mean we only propogate performance state
to masters if the genpd is ON?

thanks,
Rajendra

>   
> +	/* Propagate to masters of genpd */
> +	list_for_each_entry(link, &genpd->slave_links, slave_node) {
> +		master = link->master;
> +
> +		if (!master->set_performance_state)
> +			continue;
> +
> +		/* Find master's performance state */
> +		mstate = dev_pm_opp_xlate_performance_state(genpd->opp_table,
> +				master->opp_table, state);
> +		if (unlikely(!mstate))
> +			goto err;
> +
> +		genpd_lock_nested(master, depth + 1);
> +
> +		link->prev_performance_state = link->performance_state;
> +		link->performance_state = mstate;
> +		ret = _genpd_reeval_performance_state(master, mstate, depth + 1);
> +		if (ret)
> +			link->performance_state = link->prev_performance_state;
> +
> +		genpd_unlock(master);
> +
> +		if (ret)
> +			goto err;
> +	}
> +
>   	ret = genpd->set_performance_state(genpd, state);
>   	if (ret)
> -		return ret;
> +		goto err;
>   
>   out:
>   	genpd->performance_state = state;
>   	return 0;
> +
> +err:
> +	/* Encountered an error, lets rollback */
> +	list_for_each_entry_continue_reverse(link, &genpd->slave_links,
> +					     slave_node) {
> +		master = link->master;
> +
> +		if (!master->set_performance_state)
> +			continue;
> +
> +		genpd_lock_nested(master, depth + 1);
> +
> +		mstate = link->prev_performance_state;
> +		link->performance_state = mstate;
> +
> +		if (_genpd_reeval_performance_state(master, mstate, depth + 1)) {
> +			pr_err("%s: Failed to roll back to %d performance state\n",
> +			       master->name, mstate);
> +		}
> +
> +		genpd_unlock(master);
> +	}
> +
> +	return ret;
>   }
>   
>   static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> -					   unsigned int state)
> +					   unsigned int state, int depth)
>   {
>   	struct generic_pm_domain_data *pd_data;
>   	struct pm_domain_data *pdd;
> +	struct gpd_link *link;
>   
>   	/* New requested state is same as Max requested state */
>   	if (state == genpd->performance_state)
> @@ -278,21 +336,30 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>   			state = pd_data->performance_state;
>   	}
>   
> -	if (state == genpd->performance_state)
> -		return 0;
> -
>   	/*
> -	 * We aren't propagating performance state changes of a subdomain to its
> -	 * masters as we don't have hardware that needs it. Over that, the
> -	 * performance states of subdomain and its masters may not have
> -	 * one-to-one mapping and would require additional information. We can
> -	 * get back to this once we have hardware that needs it. For that
> -	 * reason, we don't have to consider performance state of the subdomains
> -	 * of genpd here.
> +	 * Traverse all powered-on subdomains within the domain. This can be
> +	 * done without any additional locking as the link->performance_state
> +	 * field is protected by the master genpd->lock, which is already taken.
> +	 *
> +	 * Also note that link->performance_state (subdomain's performance state
> +	 * requirement to master domain) is different from
> +	 * link->slave->performance_state (current performance state requirement
> +	 * of the devices/sub-domains of the subdomain) and so can have a
> +	 * different value.
>   	 */
> +	list_for_each_entry(link, &genpd->master_links, master_node) {
> +		if (!genpd_status_on(link->slave))
> +			continue;
> +
> +		if (link->performance_state > state)
> +			state = link->performance_state;
> +	}
> +
> +	if (state == genpd->performance_state)
> +		return 0;
>   
>   update_state:
> -	return _genpd_set_performance_state(genpd, state);
> +	return _genpd_set_performance_state(genpd, state, depth);
>   }
>   
>   /**
> @@ -336,7 +403,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>   	prev = gpd_data->performance_state;
>   	gpd_data->performance_state = state;
>   
> -	ret = _genpd_reeval_performance_state(genpd, state);
> +	ret = _genpd_reeval_performance_state(genpd, state, 0);
>   	if (ret)
>   		gpd_data->performance_state = prev;
>   
> @@ -346,7 +413,8 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>   
> -static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> +static int
> +_genpd_power_on(struct generic_pm_domain *genpd, bool timed, int depth)
>   {
>   	unsigned int state_idx = genpd->state_idx;
>   	ktime_t time_start;
> @@ -367,7 +435,8 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>   	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>   
>   	if (unlikely(genpd->set_performance_state)) {
> -		ret = genpd->set_performance_state(genpd, genpd->performance_state);
> +		ret = _genpd_set_performance_state(genpd,
> +					genpd->performance_state, depth);
>   		if (ret) {
>   			pr_warn("%s: Failed to set performance state %d (%d)\n",
>   				genpd->name, genpd->performance_state, ret);
> @@ -557,7 +626,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>   		}
>   	}
>   
> -	ret = _genpd_power_on(genpd, true);
> +	ret = _genpd_power_on(genpd, true, depth);
>   	if (ret)
>   		goto err;
>   
> @@ -962,7 +1031,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>   			genpd_unlock(link->master);
>   	}
>   
> -	_genpd_power_on(genpd, false);
> +	_genpd_power_on(genpd, false, depth);
>   
>   	genpd->status = GPD_STATE_ACTIVE;
>   }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ad101362aef..dd364abb649a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -136,6 +136,10 @@ struct gpd_link {
>   	struct list_head master_node;
>   	struct generic_pm_domain *slave;
>   	struct list_head slave_node;
> +
> +	/* Sub-domain's per-master domain performance state */
> +	unsigned int performance_state;
> +	unsigned int prev_performance_state;
>   };
>   
>   struct gpd_timing_data {
> 

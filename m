Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB67C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D6C2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DlrNC1Rx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oXx6+Aq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D6C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeKUPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:37:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34252 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeKUPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:37:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F6E36053B; Wed, 21 Nov 2018 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542776699;
        bh=WXPbaJoUKqpS/c8qlX0MqZMkYKsFGXfemQT4NSg08go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DlrNC1RxiOGwXMLpbva81nOcv6zwkttbfu3+ABFqssZXSa7pYNI6jtvRduNVGcShy
         /WrJcXvJcuNhV/R/5uzAtim8kPKYyftIYeWCRF8NndR6Fsn/EUxcjHAZq0aFOdzmI6
         jzbFQFxRSqaDfBewsR0UcNl+IkekqxY//L1W8yDw=
Received: from [10.79.128.198] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2BFC6053B;
        Wed, 21 Nov 2018 05:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542776698;
        bh=WXPbaJoUKqpS/c8qlX0MqZMkYKsFGXfemQT4NSg08go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oXx6+Aq05sdKR3WPbFGHSOt1lBX/Y8jMCMckCWnCXV8Pj0NUzbpfCayqUFrw/jsvk
         OKF3Ne8aGOhLERJ7SFf1yLH6lw9zbpfqKbYChMt1OUeDJrT1EPKJuJCr980a0hjEyQ
         nVLRvtcP6lEj471TSfoFV1NKYSOfP3o5rVjPoVs0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2BFC6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
Date:   Wed, 21 Nov 2018 10:34:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> be used to translate from pstate of a device to another one.
> 
> Initially this will be used by genpd to find pstate of a master domain
> using its sub-domain's pstate.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pm_opp.h |  7 ++++++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0eaa954b3f6c..010a4268e8dd 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
>   		dev_err(virt_dev, "Failed to find required device entry\n");
>   }
>   
> +/**
> + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> + * @src_table: OPP table which has dst_table as one of its required OPP table.

So I have a case where the src_table and dst_table are shared/same. Can you explain how would
it work in such a case?

> + * @dst_table: Required OPP table of the src_table.
> + * @pstate: Current performance state of the src_table.
> + *
> + * This Returns pstate of the OPP (present in @dst_table) pointed out by the
> + * "required-opps" property of the OPP (present in @src_table) which has
> + * performance state set to @pstate.
> + *
> + * Return: Positive performance state on success, otherwise 0 on errors.
> + */
> +unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
> +						struct opp_table *dst_table,
> +						unsigned int pstate)
> +{
> +	struct dev_pm_opp *opp;
> +	unsigned int dest_pstate = 0;
> +	int i;
> +
> +	for (i = 0; i < src_table->required_opp_count; i++) {
> +		if (src_table->required_opp_tables[i] == dst_table)
> +			break;
> +	}
> +
> +	if (unlikely(i == src_table->required_opp_count)) {
> +		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> +		       __func__, src_table, dst_table);
> +		return 0;
> +	}
> +
> +	mutex_lock(&src_table->lock);
> +
> +	list_for_each_entry(opp, &src_table->opp_list, node) {
> +		if (opp->pstate == pstate) {
> +			dest_pstate = opp->required_opps[i]->pstate;
> +			goto unlock;
> +		}
> +	}
> +
> +	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
> +	       dst_table);
> +
> +unlock:
> +	mutex_unlock(&src_table->lock);
> +
> +	return dest_pstate;
> +}
> +
>   /**
>    * dev_pm_opp_add()  - Add an OPP table from a table definitions
>    * @dev:	device for which we do this operation
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 2b2c3fd985ab..5a64a81a1789 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -128,6 +128,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
>   void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>   struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
>   void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
> +unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>   int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>   int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>   int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> @@ -280,6 +281,12 @@ static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev
>   }
>   
>   static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
> +
> +static inline unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
> +{
> +	return 0;
> +}
> +
>   static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   {
>   	return -ENOTSUPP;
> 

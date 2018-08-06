Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C74C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D15521A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIzg0zae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D15521A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbeHFSzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:55:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeHFSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:55:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so6468519pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QmggztETeJTY/9ckwRA94v4E424lF7pzp0NKo+mgo4c=;
        b=jIzg0zaeoNyWcouRDg0d1VAe7l0r5o1WNr078Zhg9F7vhFAmPjElg6zllU1djLHp6j
         rmBXmwd//mb6x1pz+oJ5a6Gsq3jveZZjJJ74pcEPw5mLuJoheVZEjgs/FB0bGwda0Taj
         r/w4iaCdOdDCtp5PN4xkueK85EALy/F5Ok5EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmggztETeJTY/9ckwRA94v4E424lF7pzp0NKo+mgo4c=;
        b=a0Kvz0QnD2hAUtMPWzjfOXES4Zz1t7OPDyAXgf188qbKNa5CGUS+qU5eGyB36tncVV
         nvyUXk9XNIKW4YfiUsgNCMRFi1NvHXLKK9TtQvktA/5Y9fGmta4HvKbL3bqviWfEl+wf
         xoaKQ2IWYOc+uIvTYBkyoFRlHJaLDTwYnoeRfrVDmwHh90KpyQu72iCMptpux91qmUtU
         yOqPCxZ+vfA+X+9hWY9XUWdZ4RglYw1ezKP1yPGBuug6AhrMZkB0gh4KzMmWdMQPxhnr
         bp7JfDzvWcMJQRrZlLr9z1aqOQ4t7ZOZu5DBO/lIo6MwOxCpU97TAkJOmhviXbvunBmh
         aDow==
X-Gm-Message-State: AOUpUlGq0HeOiAfuyBiErEVCSAR0eGnIY5JAZmP4QbBlsqoepdkqVLLE
        iJX3vXBP6F13o2zGaPqKPrv+Cw==
X-Google-Smtp-Source: AAOMgpeEDG9NwFJkEXaZtMtXva2o5STKwob72ktzwhyo4C6lYzvnlBRgN9fJH0S0WF0ayYD5JvqdoA==
X-Received: by 2002:a62:954:: with SMTP id e81-v6mr17911642pfd.231.1533573930147;
        Mon, 06 Aug 2018 09:45:30 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m15-v6sm18634270pfk.149.2018.08.06.09.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 09:45:29 -0700 (PDT)
Date:   Mon, 6 Aug 2018 09:48:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sibis@codeaurora.org,
        ulf.hansson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: q6v5: Add support to vote for rpmh power
 domains
Message-ID: <20180806164848.GA21235@tuxbook-pro>
References: <20180629102035.2757-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629102035.2757-1-rnayak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 Jun 03:20 PDT 2018, Rajendra Nayak wrote:

> With rpmh ARC resources being modelled as power domains with
> performance state, add support to proxy vote on these for SDM845.
> Add support to vote on multiple of them, now that genpd supports
> associating multiple power domains to a device.
> 

Thanks for writing up this patch Rajendra.

> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> This patch is dependent on the rpmh powerdomain driver
> still under review,
> https://lkml.org/lkml/2018/6/27/7
> 
>  drivers/remoteproc/qcom_q6v5_pil.c | 77 +++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index 2bf8e7c49f2a..2b5be6d15779 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -25,6 +25,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
> @@ -132,6 +134,7 @@ struct rproc_hexagon_res {
>  	char **proxy_clk_names;
>  	char **reset_clk_names;
>  	char **active_clk_names;
> +	char **pd_names;
>  	int version;
>  	bool need_mem_protection;
>  	bool has_alt_reset;
> @@ -161,9 +164,11 @@ struct q6v5 {
>  	struct clk *active_clks[8];
>  	struct clk *reset_clks[4];
>  	struct clk *proxy_clks[4];
> +	struct device *pd_devs[3];
>  	int active_clk_count;
>  	int reset_clk_count;
>  	int proxy_clk_count;
> +	int pd_count;
>  
>  	struct reg_info active_regs[1];
>  	struct reg_info proxy_regs[3];
> @@ -324,6 +329,23 @@ static void q6v5_clk_disable(struct device *dev,
>  		clk_disable_unprepare(clks[i]);
>  }
>  
> +static int q6v5_powerdomain_enable(struct device *dev, struct device **devs,
> +				   int count)
> +{
> +	int i;
> +
> +	if (!count)
> +		return 0;
> +
> +	if (count > 1)
> +		for (i = 0; i < count; i++)
> +			dev_pm_genpd_set_performance_state(devs[i], INT_MAX);
> +	else
> +		dev_pm_genpd_set_performance_state(dev, INT_MAX);

I would prefer if we could just set the performance state during
initialization, but I see that we only aggregate the state during
dev_pm_genpd_set_performance_state().

As such you need to also reduce the votes in the disable path; or we
will just max out any shared corners from the first time we boot this
remoteproc.


For this to work I believe _genpd_power_o{n,ff}() would need to
aggregate the performance state of all enabled consumers, something that
would make the interface more convenient to use.

> +
> +	return pm_runtime_get_sync(dev);
> +}
> +
[..]
> @@ -1142,6 +1173,35 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
>  	return i;
>  }
>  
> +static int q6v5_powerdomain_init(struct device *dev, struct device **devs,
> +				 char **pd_names)
> +{
> +	int i = 0, num_pds;
> +
> +	if (!pd_names)
> +		return 0;
> +
> +	while (pd_names[i])
> +		i++;
> +
> +	num_pds = i;
> +
> +	if (num_pds > 1) {
> +		for (i = 0; i < num_pds; i++) {
> +			devs[i] = genpd_dev_pm_attach_by_id(dev, i);

This should be done by_name

> +			if (IS_ERR(devs[i]))
> +				return PTR_ERR(devs[i]);
> +			if (!device_link_add(dev, devs[i], DL_FLAG_STATELESS |
> +					     DL_FLAG_PM_RUNTIME))
> +				return -EINVAL;
> +		}
> +	}
> +
> +	pm_runtime_enable(dev);

Don't you need a call to something like pm_suspend_ignore_children()
here as well, to prevent a pm_runtime_get_sync() in a child device to
power on our rails at runtime?

> +
> +	return num_pds;
> +};
> +
>  static int q6v5_init_reset(struct q6v5 *qproc)
>  {
>  	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,

Regards,
Bjorn

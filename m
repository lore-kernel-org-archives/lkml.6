Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278DE2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXyu9UKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278DE2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeJALz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 07:55:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34121 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbeJALz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 07:55:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so2908522pgs.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 22:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZNepvVin512d3+WA7lhYg2Xcy6C6uCToYmc3IggMMIU=;
        b=GXyu9UKv/9rDp+kVU1a49tuSsvQwMX2Huu1DwZ/tcxSfwrB2+6/ON0Xo7uzQjf/4ke
         4jbWTaoy0OojzJ4hQjBEoLBnDQQn7hI0LSTT7Lqu+uvWO60Ze10VRz9LBCkUSCeTydsY
         A2M+MpKwBRNmKVvsojbF4m8ERswGtVONh2FX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZNepvVin512d3+WA7lhYg2Xcy6C6uCToYmc3IggMMIU=;
        b=Hv2miJfS5jY3olmPc+BvnRdJcDWhK/0N6YvhmV8fcdtATpYcn+GyYpYLea2b1HXeWT
         n74D9EPGHBTwEQ4Ob2YtER8OAbR8xl2c9CAL4HcMhpBisINvUzHAlx9Ks3EIYMNjoUvc
         IlZBEmXgSx8IpBr7gy77fLD+10bR+rVWUlYRvUUD45ym71f3zfcoZZSNDTT91xlAfSY+
         12cwWALen5B+KLaVPl2Ikjg99O8+7mmVocwn7zxOmb8yJ2TLuGZQWTOqRAM/hIa+JuC4
         tUDf+dvRS2HpOaERiOKzUxyj6TwI+tYDpEW8H+yhGoXiYn+SQ2mg8rSmJZf13rpci7Ff
         Az6Q==
X-Gm-Message-State: ABuFfoitNJc4sjoXaXCxakd5BmQgQsmCCvQfoChXGbaUS+lY/N/tUTXb
        YXumNjOcP5etj5MjknFmcV2pIQ==
X-Google-Smtp-Source: ACcGV60yrxjKRoWyWLZJ/uI3GVJFsJGgQhVX/p9+nN80JZnhZq2PS7VTwr1GWjosKgIRmNxOm73vlg==
X-Received: by 2002:a17:902:6501:: with SMTP id b1-v6mr10021330plk.31.1538371169643;
        Sun, 30 Sep 2018 22:19:29 -0700 (PDT)
Received: from localhost ([122.172.136.196])
        by smtp.gmail.com with ESMTPSA id t14-v6sm13465158pgu.0.2018.09.30.22.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 22:19:28 -0700 (PDT)
Date:   Mon, 1 Oct 2018 10:49:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Keerthy J <j-keerthy@ti.com>
Subject: Re: [PATCH] PM / OPP: Refactor counting of added OPPs for v2 to
 avoid unsupported OPPs
Message-ID: <20181001051925.u3lpcg537xomsckp@vireshk-i7>
References: <20180822031035.6937-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822031035.6937-1-d-gerlach@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-18, 22:10, Dave Gerlach wrote:

Please ping people back if you haven't received a response for too long. Sorry
that I missed getting to this at an earlier point of time.

> Currently the _of_add_opp_table_v2 call loops through the OPP nodes in
> the operating-points-v2 table in the device tree and calls
> _opp_add_static_v2 for each to add them to the table. It counts each
> iteration through this loop as an added OPP, however on platforms making
> use of the opp-supported-hw property, _opp_add_static_v2 does not add
> OPPs that are not seen as supported on the platform but still returns
> success, as this is valid. Because of this the count variable will
> contain the number of OPP nodes in the table in device tree but not
> necessarily the ones that are supported and actually added.
> 
> As this count value is what is checked to determine if there are any
> valid OPPs, if a platform has an operating-points-v2 table with all OPP
> nodes containing opp-supported-hw values that are not currently
> supported then _of_add_opp_table_v2 will fail to abort as it should due
> to an empty table.
> 
> Additionally, since commit 3ba98324e81a ("PM / OPP: Get
> performance state using genpd helper"), the same count variable is
> compared against the number of OPPs containing performance states and
> requires that either all or none have pstates set, however in the case
> of any opp table that has any entries that do not get added by
> _opp_add_static_v2 due to incompatible opp-supported-hw fields, these
> numbers will not match and _of_add_opp_table_v2 will incorrectly fail.
> 
> In order to ensure the count variable reflects the number of OPPs
> actually in the table, increment it during the existing loop which walks
> the opp table to check if pstate is set and then use that for the
> aforementioned checks.
> 
> Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/opp/of.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 7af0ddec936b..f288f83a2e62 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -399,8 +399,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  
>  	/* We have opp-table node now, iterate over it and add OPPs */
>  	for_each_available_child_of_node(opp_np, np) {
> -		count++;
> -
>  		ret = _opp_add_static_v2(opp_table, dev, np);
>  		if (ret) {
>  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
> @@ -411,15 +409,22 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  		}
>  	}
>  
> +	/*
> +	 * Iterate over the list of OPPs that were actually added, as
> +	 * OPPs not supported by the hardware will be ignored by
> +	 * _opp_add_static_v2 above.
> +	 */
> +	list_for_each_entry(opp, &opp_table->opp_list, node) {
> +		count++;
> +		pstate_count += !!opp->pstate;
> +	}

So the problem is genuine and is still true with the latest code in linux-next,
but this patch wouldn't fix all cases. What if some OPPs were dynamically added
using dev_pm_opp_add() and everything failed in this routine? We will still have
the problem you are trying to fix here.

What needs to be done is to identify the case where the OPP wasn't supported.
Maybe return the new OPPs pointer from _opp_add_static_v2(), return -ve ERR_PTR
values on error and NULL for the case where OPP isn't added but that's not an
error. Apart from your example another case is of duplicate OPPs where we return
0 without adding the OPP.

Please post patch against linux-next as some updates are already pushed for OPP
core there.

-- 
viresh

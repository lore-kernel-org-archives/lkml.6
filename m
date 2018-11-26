Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C770CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A18920664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtjJVSKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A18920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeKZQ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:57:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39060 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:57:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so6034133pfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e8v7qQ0zwbh4zCU2GQz0mvIikah8p0wT7A12tJYMPPE=;
        b=AtjJVSKliVeY9zMQ2IFAjUTZn9Q/kC+cBKIVAGuI67uiDa8qT5IbMDlnRMXnu8lGPS
         E8aYLm0qbzYCcMUm4adDU/fwIKfNU1qG7QxtpFw5mtR0r1W005dSUPT5HTvBaZXHwWI6
         GgK6J3dQuPVGH/SDz8lNwHSaPDIWzHUPTLA2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e8v7qQ0zwbh4zCU2GQz0mvIikah8p0wT7A12tJYMPPE=;
        b=m+NW55wu0m9co1P0cEB5NGheeqq87C1gosLwMXYgwiKyxVaJ8zjdA6CjwO2DyPI0AD
         AvP6bHTdflRURkLyv5saSQGlJcEGeFowNuA6WHmRiK1l5Vf2+4rjz3IUIfleSYQDSj4O
         llGr/3Qojw3lFGMsZYI7wv3Uoz7N32rolcX0koMKvwQW+1+mrYubmVnLdtsWCK9y3gi4
         fk6ChFf1adtQ3nIEilB5qOaVbA8crmBF/u+wJLMzFNqCcrNHJGG7K5k8f9nZpwFcRIEK
         8ugp8f1LmwRgBKMUiDvaz8yupfzhNyR3M3Gnel22lKwHqIlv258146LrM4T1BHiimqpc
         zH+A==
X-Gm-Message-State: AGRZ1gL+sQ8Z8qJ+ji7nWSKlfejMo76I56GOh78Cq9xRmBYAg6Pw1r8H
        8LuH64wfWGxF3yx39mGns62bxg==
X-Google-Smtp-Source: AJdET5eWCsYJdaddk6/WQMpbS2jLJYHdTwK5gOHYY4nOxbB0I2vcWkh0FgaBivU6kPpe12PaetGN/g==
X-Received: by 2002:aa7:804e:: with SMTP id y14-v6mr25955007pfm.73.1543212285824;
        Sun, 25 Nov 2018 22:04:45 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id i1sm46191316pgb.46.2018.11.25.22.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 22:04:45 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:34:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] cpufreq: imx6q: remove unused code
Message-ID: <20181126060443.augwfzdlpc26cvxb@vireshk-i7>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-18, 02:59, Anson Huang wrote:
> In voltage scale down path, the return value is NOT
> used at all, remove them to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index d8c3595..8cb9683 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -177,22 +177,16 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	/* scaling down?  scale voltage after frequency */
>  	if (new_freq < old_freq) {
>  		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> -		if (ret) {
> +		if (ret)
>  			dev_warn(cpu_dev,
>  				 "failed to scale vddarm down: %d\n", ret);
> -			ret = 0;
> -		}
>  		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
> -		if (ret) {
> +		if (ret)
>  			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
> -			ret = 0;
> -		}
>  		if (!IS_ERR(pu_reg)) {
>  			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> -			if (ret) {
> +			if (ret)
>  				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
> -				ret = 0;
> -			}
>  		}
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

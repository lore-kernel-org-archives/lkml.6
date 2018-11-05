Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FFAECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2522082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UR6tybkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2522082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeKELtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:49:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39292 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeKELtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:49:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id n11-v6so3642781pfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 18:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NOExC7WZL6/tLlWcYLUTYTnUTQQLn2NAKAtgN8cJfFI=;
        b=UR6tybkI/nEBjBSpOdO9IZVVg/WfeuaDWXKfQQAKHFMmMQdwkP2RhqMnfE2DizcKz6
         ZjBrsGGm6w5gZUfKnGJZSOcNSR4Ho0tJz2wS1gLtejncrHABrL1IPCHNNmEvATRrGbct
         Ulnx9yal4VbQuUdGmsfRV45lrtlrdib10mmec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NOExC7WZL6/tLlWcYLUTYTnUTQQLn2NAKAtgN8cJfFI=;
        b=t3ouRJvboQujmcdctsJptBERTa4UF7tvb/cLEvRNiOatYxKtBZ/HBNsrrZD3zWPmKI
         WkCpCdPuCkaOiVu/0WMoTm3FruNAP1F/stiQpsrhtcjJegLg/PMcnB5teEyZSUx6E3qO
         dFd6IVtB7DXocDWSxRlAhUZjSbun8XO9DAA9SDigpOZq9LRwoAB6Dw2Eth5jjhxthqTP
         Zg7TYtzcWqzabHPd5OfsSTCwYwDh421VUoJPVAevyRqjY3GNzftQNjdrXADLAcTKng0t
         UCfkNmg+iM0RVrG+xTkI0b4nR6mGRKvK4Vqh9KyQMN5PBtTj7RAaFVDDYOKYPepfhPal
         9ADA==
X-Gm-Message-State: AGRZ1gI5L4lk/WB53rxYYQ6fwve0sQnydDQoWX+LDtvAL8TjTdvH3MdC
        +M9usZ1rK1Uj474lE20rsEeefeddMVM=
X-Google-Smtp-Source: AJdET5fwMZ1GNNRTUMykJ4j0nyDWl6zxsNp8IRHBSFH45DyXRvnDQN2YeQrJfGQmAVY85O6Y9BGpCg==
X-Received: by 2002:a62:c20b:: with SMTP id l11-v6mr20680456pfg.251.1541385115803;
        Sun, 04 Nov 2018 18:31:55 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id 7-v6sm42930612pgk.31.2018.11.04.18.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 18:31:55 -0800 (PST)
Date:   Mon, 5 Nov 2018 08:01:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] cpufreq: imx6q: add return value check for voltage scale
Message-ID: <20181105023152.pldy2i7rvsysijha@vireshk-i7>
References: <1541379270-30149-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541379270-30149-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-18, 00:59, Anson Huang wrote:
> Add return value check for voltage scale when ARM clock
> rate change fail.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 8cfee0a..d8c3595 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -160,8 +160,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	/* Ensure the arm clock divider is what we expect */
>  	ret = clk_set_rate(clks[ARM].clk, new_freq * 1000);
>  	if (ret) {
> +		int ret1;
> +
>  		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> -		regulator_set_voltage_tol(arm_reg, volt_old, 0);
> +		ret1 = regulator_set_voltage_tol(arm_reg, volt_old, 0);
> +		if (ret1)
> +			dev_warn(cpu_dev,
> +				 "failed to restore vddarm voltage: %d\n", ret1);
>  		return ret;
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

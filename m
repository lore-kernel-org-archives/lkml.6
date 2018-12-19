Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86EAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD84E2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHt6qhdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeLSMIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:08:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34402 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeLSMIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:08:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so19298121wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IaqOoapHzjoMgO9YBbjQ3EZTwNanLJVjZn5hJwj2FMk=;
        b=GHt6qhdGISkevDdYgX9XDmZqTUrpsOtUkVOBKIbGbZmHTLRgl/a+k11cej4RUqVO3/
         ftHAHNyASYjk3Cd+UVAXnV/gXUqm/+ebm8lFCLivPHR6828aha3qN+KY1Bac208b8d6I
         vW4h4x4r6Fik7GSpklOsMsRdqoFGTvmty9v2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IaqOoapHzjoMgO9YBbjQ3EZTwNanLJVjZn5hJwj2FMk=;
        b=Qzvxo6Cp2Uvfg2qu484Hk5xSUw+sT6aU2wTlV4SgYbjDIItKK5e3J6c0T0bPJ9Nwdp
         8Rx2M6cEbogYsHHdycEfr3lv7hMY/2j0Jqvw826bM/kNYD9Rbc+igG6RJ26TaG3v6yeH
         zHBUpzdrX0fFST0Y9BdX6vX5W1FfUocPa6V+y2kavDAmf9TuNQcF89PbjgaWjHwpsUQN
         dwJbxcmGSMYrToClRC2rtWvm8KEKfS4pv5j9QHBbjQie+d5gq1pXEK+52EiO7RLF8Y5i
         DGf4vC8oUQ9b6bi7bJsghwX0jHzZadZDs2vozONmhlYBHBmEaJe2/RTPB6Tm8NVbrlmH
         sOSA==
X-Gm-Message-State: AA+aEWZF1bID38taujx8QYBrWriLqsuJdToaHmKVbj1FDbFy5CY9F9uY
        VI/4BAVPiQZegNfPPxDd/GQzgI+wp5g=
X-Google-Smtp-Source: AFSGD/W57nD1tL27pfIe1rKnlQoQOhHACPw0m7wioQ4cwubuZPACAukH4mCrqnxpy06Gle4OvJUPBg==
X-Received: by 2002:adf:8143:: with SMTP id 61mr17875097wrm.47.1545221322006;
        Wed, 19 Dec 2018 04:08:42 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
        by smtp.googlemail.com with ESMTPSA id e142sm12036003wmf.46.2018.12.19.04.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:08:41 -0800 (PST)
Subject: Re: [PATCH v10 14/27] drivers: firmware: psci: Simplify error path of
 psci_dt_init()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-15-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e5218407-f08b-9eda-9a67-0acea0e04e6e@linaro.org>
Date:   Wed, 19 Dec 2018 13:08:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-15-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> Instead of having each psci init function taking care of the of_node_put(),
> let's deal with that from psci_dt_init(), as this enables a bit simpler
> error path for each psci init function.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/firmware/psci/psci.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 631e20720a22..6bfa47cbd174 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -609,9 +609,9 @@ static int __init psci_0_2_init(struct device_node *np)
>  	int err;
>  
>  	err = get_set_conduit_method(np);
> -
>  	if (err)
> -		goto out_put_node;
> +		return err;
> +
>  	/*
>  	 * Starting with v0.2, the PSCI specification introduced a call
>  	 * (PSCI_VERSION) that allows probing the firmware version, so
> @@ -619,11 +619,7 @@ static int __init psci_0_2_init(struct device_node *np)
>  	 * can be carried out according to the specific version reported
>  	 * by firmware
>  	 */
> -	err = psci_probe();
> -
> -out_put_node:
> -	of_node_put(np);
> -	return err;
> +	return psci_probe();
>  }
>  
>  /*
> @@ -635,9 +631,8 @@ static int __init psci_0_1_init(struct device_node *np)
>  	int err;
>  
>  	err = get_set_conduit_method(np);
> -
>  	if (err)
> -		goto out_put_node;
> +		return err;
>  
>  	pr_info("Using PSCI v0.1 Function IDs from DT\n");
>  
> @@ -661,9 +656,7 @@ static int __init psci_0_1_init(struct device_node *np)
>  		psci_ops.migrate = psci_migrate;
>  	}
>  
> -out_put_node:
> -	of_node_put(np);
> -	return err;
> +	return 0;
>  }
>  
>  static const struct of_device_id psci_of_match[] __initconst = {
> @@ -678,6 +671,7 @@ int __init psci_dt_init(void)
>  	struct device_node *np;
>  	const struct of_device_id *matched_np;
>  	psci_initcall_t init_fn;
> +	int ret;
>  
>  	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
>  
> @@ -685,7 +679,10 @@ int __init psci_dt_init(void)
>  		return -ENODEV;
>  
>  	init_fn = (psci_initcall_t)matched_np->data;
> -	return init_fn(np);
> +	ret = init_fn(np);
> +
> +	of_node_put(np);
> +	return ret;
>  }
>  
>  #ifdef CONFIG_ACPI
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


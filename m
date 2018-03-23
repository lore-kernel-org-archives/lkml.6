Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeCWTO0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:14:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCWTOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:14:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 671F6603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
To: Tirupathi Reddy <tirupath@codeaurora.org>, dmitry.torokhov@gmail.com,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
From: Trilok Soni <tsoni@codeaurora.org>
Message-ID: <240c6cbc-886f-94c6-cba4-3c4eb3ed0b45@codeaurora.org>
Date: Fri, 23 Mar 2018 12:14:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tirupathi,

>   
> +static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
> +{
> +	struct pm8941_pwrkey *pwrkey = _data;
> +	unsigned int sts;
> +	int error;
> +	u32 key_code = pwrkey->resin_key_code;
> +
> +	error = regmap_read(pwrkey->regmap,
> +			    pwrkey->baseaddr + PON_RT_STS, &sts);
> +	if (error)
> +		return IRQ_HANDLED;
> +
> +	input_report_key(pwrkey->input, key_code, !!(sts & PON_RESIN_N_SET));
> +	input_sync(pwrkey->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
>   {
>   	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
> @@ -153,9 +175,56 @@ static int __maybe_unused pm8941_pwrkey_resume(struct device *dev)
>   static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
>   			 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
>   
> +static int pm8941_resin_key_init(struct pm8941_pwrkey *pwrkey,
> +			struct device_node *np)
> +{
> +	int error, irq;
> +	bool pull_up;
> +
> +	/*
> +	 * Get the standard-key parameters. This might not be
> +	 * specified if there is no key mapping on the reset line.
> +	 */
> +	error = of_property_read_u32(np, "linux,code", &pwrkey->resin_key_code);
> +	if (error) {
> +		dev_err(pwrkey->dev, "failed to read key-code for resin key\n");
> +		return error;
> +	}
> +
> +	pull_up = of_property_read_bool(np, "bias-pull-up");
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq < 0) {
> +		dev_err(pwrkey->dev, "failed to get resin irq\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register key configuration */
> +	input_set_capability(pwrkey->input, EV_KEY, pwrkey->resin_key_code);
> +
> +	error = regmap_update_bits(pwrkey->regmap,
> +				   pwrkey->baseaddr + PON_PULL_CTL,
> +				   PON_RESIN_PULL_UP,
> +				   pull_up ? PON_RESIN_PULL_UP : 0);
> +	if (error) {
> +		dev_err(pwrkey->dev, "failed to set resin pull: %d\n", error);
> +		return error;
> +	}
> +
> +	error = devm_request_threaded_irq(pwrkey->dev, irq, NULL,
> +					  pm8941_resinkey_irq, IRQF_ONESHOT,
> +					  "pm8941_resinkey", pwrkey);
> +	if (error)
> +		dev_err(pwrkey->dev, "failed requesting resin key IRQ: %d\n",
> +			error);
> +
> +	return error;
> +}
> +
>   static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   {
>   	struct pm8941_pwrkey *pwrkey;
> +	struct device_node *np = NULL;
>   	bool pull_up;
>   	u32 req_delay;
>   	int error;
> @@ -241,6 +310,18 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   		return error;
>   	}
>   
> +	np = of_find_node_by_name(pdev->dev.of_node, "resin");
> +	if (np) {
> +		/* resin key capabilities are defined in device node */
> +		error = pm8941_resin_key_init(pwrkey, np);


What happens if interrupts comes as soon as you have done the 
key_init(..) here? I see that you are registering the input device after 
it, right? Looks like you should do this at the end of probe?

> +		of_node_put(np);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed resin key initialization: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +
>   	error = input_register_device(pwrkey->input);
>   	if (error) {
>   		dev_err(&pdev->dev, "failed to register input device: %d\n",
> 

-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project

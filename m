Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeCMTYS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:24:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeCMTYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:24:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5CC2600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH V2] Input: pm8941-pwrkey: add resin key capabilities
To: Tirupathi Reddy <tirupath@codeaurora.org>, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1520930158-5854-1-git-send-email-tirupath@codeaurora.org>
From: Trilok Soni <tsoni@codeaurora.org>
Message-ID: <dff22ba9-2b83-9861-e7f2-700a10fdbcdf@codeaurora.org>
Date: Tue, 13 Mar 2018 12:24:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1520930158-5854-1-git-send-email-tirupath@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tirupathi,

On 3/13/2018 1:35 AM, Tirupathi Reddy wrote:
> Add resin key support to handle different types of key events
> defined in different platforms.

Describe "resin"  in the commit text? or just call it same as power key 
or different purpose?

>   
> +static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
> +{
> +	struct pm8941_pwrkey *pwrkey = _data;
> +	unsigned int sts;
> +	int error;
> +
> +	error = regmap_read(pwrkey->regmap,
> +			    pwrkey->baseaddr + PON_RT_STS, &sts);
> +	if (error)
> +		return IRQ_HANDLED;

You may want to document here why you still return as IRQ_HANDLED on the 
error after reading the status register?

>   
> +	resin_irq = platform_get_irq_byname(pdev, "resin");
> +	if (resin_irq < 0 && resin_irq != -ENXIO) {
> +		if (resin_irq != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get resin irq\n");
> +		return resin_irq;
> +	} else if (resin_irq >= 0) {
> +		/* resin key capabilities are defined in device node */
> +		error = pm8941_resin_key_init(pwrkey, resin_irq);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed resin key initialization: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +

Any reason you don't want to create different driver for "resin" key? Is 
this going to be physically different key on the platform? Please 
describe why it needs to be part of the power key driver.

---Trilok Soni

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C062C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6C72054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6C72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeH3Pqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:46:45 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49390 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727499AbeH3Pqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:46:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UBidYN007995;
        Thu, 30 Aug 2018 06:44:49 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2m34h1xq1j-1;
        Thu, 30 Aug 2018 06:44:49 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 5177F611CE60;
        Thu, 30 Aug 2018 06:46:29 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 Aug 2018
 12:44:48 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7UBilsO012304;        Thu, 30 Aug 2018 12:44:47 +0100
Subject: Re: [PATCH v10 2/2] irqchip: Add driver for Cirrus Logic Madera
 codecs
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <lee.jones@linaro.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20180828130934.18135-1-rf@opensource.cirrus.com>
 <20180828130934.18135-2-rf@opensource.cirrus.com>
 <alpine.DEB.2.21.1808301154040.1210@nanos.tec.linutronix.de>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <4aa5941b-547d-7218-1b8f-4cd2a01a4fa5@opensource.cirrus.com>
Date:   Thu, 30 Aug 2018 12:44:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808301154040.1210@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=711 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808300123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/18 11:31, Thomas Gleixner wrote:
> On Tue, 28 Aug 2018, Richard Fitzgerald wrote:
>> @@ -0,0 +1,244 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Interrupt support for Cirrus Logic Madera codecs
>> + *
>> + * Copyright (C) 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
> 
> You have the SPDX identifier above, which makes this boilerplate
> superfluous.
> 

Our legal people want it left here.
They are ok with the SPDX reference, but they want to keep an
explicit statement of the license that was intended.

>> +#ifdef CONFIG_PM_SLEEP
>> +static int madera_suspend_noirq(struct device *dev)
>> +{
>> +	struct madera *madera = dev_get_drvdata(dev->parent);
>> +
>> +	dev_dbg(madera->irq_dev, "No IRQ suspend, reenabling IRQ\n");
>> +
>> +	enable_irq(madera->irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int madera_suspend(struct device *dev)
>> +{
>> +	struct madera *madera = dev_get_drvdata(dev->parent);
>> +
>> +	dev_dbg(madera->irq_dev, "Suspend, disabling IRQ\n");
>> +
>> +	disable_irq(madera->irq);
>> +
>> +	return 0;
>> +}
> 
> This really wants a comment why you are disabling it first and reenabling
> it afterwards. I have no idea why you are doing this and it doesn't make
> much sense from the S/R perspective either.
> 
>> +	/*
>> +	 * Read the flags from the interrupt controller if not specified
>> +	 * by pdata
>> +	 */
>> +	irq_flags = madera->pdata.irq_flags;
>> +	if (!irq_flags) {
>> +		irq_data = irq_get_irq_data(madera->irq);
>> +		if (!irq_data) {
>> +			dev_err(&pdev->dev, "Invalid IRQ: %d\n", madera->irq);
>> +			return -EINVAL;
>> +		}
>> +
>> +		irq_flags = irqd_get_trigger_type(irq_data);
>> +
>> +		/* Codec defaults to trigger low, use this if no flags given */
>> +		if (irq_flags == IRQ_TYPE_NONE)
>> +			irq_flags = IRQF_TRIGGER_LOW;
>> +	}
>> +
>> +	if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
>> +		dev_err(&pdev->dev, "Host interrupt not level-triggered\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (irq_flags & IRQF_TRIGGER_HIGH) {
>> +		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
>> +					 MADERA_IRQ_POL_MASK, 0);
>> +		if (ret) {
>> +			dev_err(&pdev->dev,
>> +				"Failed to set IRQ polarity: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
> 
> This looks wrong. Why are you only updating the polarity for trigger HIGH?
> 
>> diff --git a/include/linux/irqchip/irq-madera.h b/include/linux/irqchip/irq-madera.h
>> new file mode 100644
>> index 000000000000..5aeb7e6adc82
>> --- /dev/null
>> +++ b/include/linux/irqchip/irq-madera.h
>> @@ -0,0 +1,135 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Interrupt support for Cirrus Logic Madera codecs
>> + *
>> + * Copyright 2016-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
> 
> See above.
> 
> Thanks,
> 
> 	tglx
> 


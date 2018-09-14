Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF6820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF6820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeINVqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:46:50 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33254 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbeINVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:46:50 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EGTJP7011279;
        Fri, 14 Sep 2018 11:31:24 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mcbu09pwb-1;
        Fri, 14 Sep 2018 11:31:23 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 9B011611C8B5;
        Fri, 14 Sep 2018 11:33:15 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 14 Sep 2018
 17:31:22 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w8EGVMnY009829;        Fri, 14 Sep 2018 17:31:22 +0100
Subject: Re: [PATCH v13] irqchip: Add driver for Cirrus Logic Madera codecs
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20180914152809.18248-1-rf@opensource.cirrus.com>
 <86pnxgvztr.wl-marc.zyngier@arm.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <edb4c59d-cbfe-c5ca-8787-10dfcf4ee375@opensource.cirrus.com>
Date:   Fri, 14 Sep 2018 17:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86pnxgvztr.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809140168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/18 16:55, Marc Zyngier wrote:
> On Fri, 14 Sep 2018 16:28:09 +0100,
> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>
>> The Cirrus Logic Madera codecs (Cirrus Logic CS47L35/85/90/91 and WM1840)
>> are highly complex devices containing up to 7 programmable DSPs and many
>> other internal sources of interrupts plus a number of GPIOs that can be
>> used as interrupt inputs. The large number (>150) of internal interrupt
>> sources are managed by an on-board interrupt controller.
>>
>> This driver provides the handling for the interrupt controller. As the
>> codec is accessed via regmap, we can make use of the generic IRQ
>> functionality from regmap to do most of the work. Only around half of
>> the possible interrupt source are currently of interest from the driver
>> so only this subset is defined. Others can be added in future if needed.
>>
>> The KConfig options are not user-configurable because this driver is
>> mandatory so is automatically included when the parent MFD driver is
>> selected.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> ---
>> Only difference from v11 is the copyright headers
>> ---
>>   MAINTAINERS                        |   2 +
>>   drivers/irqchip/Kconfig            |   3 +
>>   drivers/irqchip/Makefile           |   1 +
>>   drivers/irqchip/irq-madera.c       | 256 +++++++++++++++++++++++++++++++++++++
>>   include/linux/irqchip/irq-madera.h | 132 +++++++++++++++++++
>>   5 files changed, 394 insertions(+)
>>   create mode 100644 drivers/irqchip/irq-madera.c
>>   create mode 100644 include/linux/irqchip/irq-madera.h
>>
> 
> [...]
> 
>> diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
>> new file mode 100644
>> index 000000000000..e9256dee1a45
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-madera.c
> 
> [...]
> 
>> +static int madera_irq_probe(struct platform_device *pdev)
>> +{
>> +	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
>> +	struct irq_data *irq_data;
>> +	unsigned int irq_flags = 0;
>> +	int ret;
>> +
>> +	dev_dbg(&pdev->dev, "probe\n");
>> +
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
>> +	/*
>> +	 * The silicon always starts at active-low, check if we need to
>> +	 * switch to active-high.
>> +	 */
>> +	if (irq_flags & IRQF_TRIGGER_HIGH) {
> 
> Is it safe to assume that the HW is in its reset state? What if the
> firmware has configured it otherwise, or if gone through kexec?
> 

The parent mfd probe always resets the silicon before registering the children.
If this driver were to be removed and reprobed without reprobing the parent mfd,
these lines of code are irrelevant because the regmap cache would still preserve
the correct setting.
The DSP firmware is not allowed to change the host IRQ configuration or reset
the silicon. Firmwares can only be loaded via ALSA/ASoC and the driver for that
cannot complete probe until the irqchip driver has probed,

>> +		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
>> +					 MADERA_IRQ_POL_MASK, 0);
>> +		if (ret) {
>> +			dev_err(&pdev->dev,
>> +				"Failed to set IRQ polarity: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * NOTE: regmap registers this against the OF node of the parent of
>> +	 * the regmap - that is, against the mfd driver
>> +	 */
>> +	ret = regmap_add_irq_chip(madera->regmap, madera->irq, IRQF_ONESHOT, 0,
>> +				  &madera_irq_chip, &madera->irq_data);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "add_irq_chip failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Save dev in parent MFD struct so it is accessible to siblings */
>> +	madera->irq_dev = &pdev->dev;
>> +
>> +	return 0;
>> +}
> 
> Thanks,
> 
> 	M.
> 


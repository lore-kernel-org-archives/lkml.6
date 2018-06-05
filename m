Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeFEXK4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:10:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54565 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeFEXKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:52 -0400
X-Google-Smtp-Source: ADUXVKLV+8zeW31Hm/bmBWzj74m0n4H2fC35YbPpZ7lkCpEPRppkYXmRo/sh4sqV3TnU5s4E4tEtBA==
Subject: Re: [PATCH v3 07/10] mfd: da9063: Add custom IRQ map for DA9063L
To: Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-7-marek.vasut+renesas@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941AD6EC@SW-EX-MBX02.diasemi.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <34944098-1b33-7847-8309-1aeb2a6ff4db@gmail.com>
Date: Wed, 6 Jun 2018 00:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB701941AD6EC@SW-EX-MBX02.diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 09:52 PM, Steve Twiss wrote:
> Hi Marek,

Hi,

> Thanks.
> 
> On 02 June 2018 11:12, Marek Vasut wrote,
> 
>> Subject: [PATCH v3 07/10] mfd: da9063: Add custom IRQ map for DA9063L
>>
>> While the datasheet for DA9063L (2v1, 23-Mar-2017) lists the RTC register
>> block, the DA9063L does not have an RTC. Add custom IRQ map for DA9063L to
>> ignore the Alarm and Tick IRQs from the PMIC.
> 
> I've added a request to remove the RTC references from the DA9063L datasheet.
> 
> Adding that first part to the sentence in the commit log: "While the datasheet for DA9063L
> (2v1, 23-Mar-2017) lists the RTC register block" is just pointing out an ambiguity from the
> datasheet since the it also identifies those registers in Table 102 on page 126 as
> "Reserved".
> 
> I would like to suggest, the commit log entry: "Add custom IRQ map for DA9063L to ignore
> the Alarm and Tick IRQs from the PMIC".

OK, I'll hide it.

>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V3: New patch
>> ---
>>  drivers/mfd/da9063-irq.c | 55
>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
>> index 5b406ecfc14a..b6a88861cc2e 100644
>> --- a/drivers/mfd/da9063-irq.c
>> +++ b/drivers/mfd/da9063-irq.c
>> @@ -74,8 +74,55 @@ static const struct regmap_irq_chip da9063_irq_chip = {
>>  	.init_ack_masked = true,
>>  };
>>
>> +static const struct regmap_irq da9063l_irqs[] = {
>> +	/* DA9063 event A register */
>> +	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY,
>> DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY,
>> DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY,
>> DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
>> +	/* DA9063 event B register */
>> +	REGMAP_IRQ_REG(DA9063_IRQ_WAKE,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_TEMP,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_WARN,
>> DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
>> +	/* DA9063 event C register */
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI0, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI0),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI1, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI1),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI2, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI2),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI3, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI3),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI4, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI4),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI5, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI5),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI6, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI6),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI7, DA9063_REG_EVENT_C_OFFSET,
>> DA9063_M_GPI7),
>> +	/* DA9063 event D register */
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI8, DA9063_REG_EVENT_D_OFFSET,
>> DA9063_M_GPI8),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI9, DA9063_REG_EVENT_D_OFFSET,
>> DA9063_M_GPI9),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI10,
>> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI11,
>> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI12,
>> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI13,
>> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI14,
>> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
>> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI15,
>> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
>> +};
>> +
>> +static const struct regmap_irq_chip da9063l_irq_chip = {
>> +	.name = "da9063l-irq",
>> +	.irqs = da9063l_irqs,
>> +	.num_irqs = DA9063_NUM_IRQ,
> 
> Isn't the number of IRQs in the DA9063L different to the standard DA9063
> because of the missing RTC?

I think this can even be replaced by ARRAY_SIZE() ?

-- 
Best regards,
Marek Vasut

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934746AbeBLQBK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:01:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeBLQBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:01:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B19F60A4E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 12 Feb 2018 16:01:06 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH v6 1/2] drivers: irqchip: pdc: Add PDC interrupt
 controller for QCOM SoCs
Message-ID: <20180212160106.GE7084@codeaurora.org>
References: <20180209165735.19151-1-ilina@codeaurora.org>
 <20180209165735.19151-2-ilina@codeaurora.org>
 <alpine.DEB.2.21.1802121430020.1158@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802121430020.1158@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12 2018 at 13:40 +0000, Thomas Gleixner wrote:
>On Fri, 9 Feb 2018, Lina Iyer wrote:
>> +/*
>> + * GIC does not handle falling edge or active low. To allow falling edge and
>> + * active low interrupts to be handled at GIC, PDC has an inverter that inverts
>> + * falling edge into a rising edge and active low into an active high.
>> + * For the inverter to work, the polarity bit in the IRQ_CONFIG register has to
>> + * set as per the table below.
>> + * (polarity, falling edge, rising edge ) POLARITY
>> + * 3'b0 00  Level sensitive active low    LOW
>> + * 3'b0 01  Rising edge sensitive         NOT USED
>> + * 3'b0 10  Falling edge sensitive        LOW
>> + * 3'b0 11  Dual Edge sensitive           NOT USED
>> + * 3'b1 00  Level sensitive active High   HIGH
>> + * 3'b1 01  Falling Edge sensitive        NOT USED
>> + * 3'b1 10  Rising edge sensitive         HIGH
>> + * 3'b1 11  Dual Edge sensitive           HIGH
>> + */
>> +enum pdc_irq_config_bits {
>> +	PDC_POLARITY_LOW	= 0,
>> +	PDC_FALLING_EDGE	= 2,
>> +	PDC_POLARITY_HIGH	= 4,
>> +	PDC_RISING_EDGE		= 6,
>> +	PDC_DUAL_EDGE		= 7,
>
>My previous comment about using binary constants still stands. Please
>either address review comments or reply at least. Ignoring reviews is not
>an option.
>
I removed them from the enum definitions. Will remove them from the
comments as well. Sorry. It was not my intention to ignore any review
comments.

>Aside of that I really have to ask about the naming of these constants. Are
>these names hardware register nomenclature? If yes, they are disgusting. If
>no, they are still disgusting, but should be changed to sensible ones,
>which just match the IRQ_TYPE naming convention.
>
>    PDC_LEVEL_LOW	= 000b,
>    PDC_EDGE_FALLING	= 010b,
>    ....
>
>
They are named that way in spec :) Will change.

>> +	switch (type) {
>> +	case IRQ_TYPE_EDGE_RISING:
>> +		pdc_type = PDC_RISING_EDGE;
>> +		type = IRQ_TYPE_EDGE_RISING;
>
>Whats the point of assigning the same value again?
>
Failed to notice. Will fix.

Thanks,
Lina

>> +		break;
>> +	case IRQ_TYPE_EDGE_FALLING:
>> +		pdc_type = PDC_FALLING_EDGE;
>> +		type = IRQ_TYPE_EDGE_RISING;
>> +		break;
>> +	case IRQ_TYPE_EDGE_BOTH:
>> +		pdc_type = PDC_DUAL_EDGE;
>> +		break;
>> +	case IRQ_TYPE_LEVEL_HIGH:
>> +		pdc_type = PDC_POLARITY_HIGH;
>> +		type = IRQ_TYPE_LEVEL_HIGH;
>
>Ditto
>
>Thanks,
>
>	tglx

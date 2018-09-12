Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20683C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EFE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EFE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeIMDhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:37:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:17634 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbeIMDhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:37:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 15:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,366,1531810800"; 
   d="scan'208";a="72742415"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.241.240.60]) ([10.241.240.60])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2018 15:31:06 -0700
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
References: <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <6a99dc09-b06d-88ee-2843-3bd88f883dc2@linux.intel.com>
Date:   Wed, 12 Sep 2018 15:31:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912203059.GA18201@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2018 1:30 PM, Guenter Roeck wrote:
> On Wed, Sep 12, 2018 at 01:10:45PM -0700, Jae Hyun Yoo wrote:
>> On 9/12/2018 12:58 PM, Guenter Roeck wrote:
>>> On Wed, Sep 12, 2018 at 09:54:51AM -0700, Jae Hyun Yoo wrote:
>>>> On 9/11/2018 6:34 PM, Guenter Roeck wrote:
>>>>> On Tue, Sep 11, 2018 at 04:58:44PM -0700, Jae Hyun Yoo wrote:
>>>>>> On 9/11/2018 4:33 PM, Guenter Roeck wrote:
>>>>>>> Looking into the patch, clearing the interrupt status at the end of an
>>>>>>> interrupt handler is always suspicious and tends to result in race
>>>>>>> conditions (because additional interrupts may have arrived while handling
>>>>>>> the existing interrupts, or because interrupt handling itself may trigger
>>>>>>> another interrupt). With that in mind, the following patch fixes the
>>>>>>> problem for me.
>>>>>>>
>>>>>>> Guenter
>>>>>>>
>>>>>>> ---
>>>>>>>
>>>>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>>>>>>> index c258c4d9a4c0..c488e6950b7c 100644
>>>>>>> --- a/drivers/i2c/busses/i2c-aspeed.c
>>>>>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>>>>>>> @@ -552,6 +552,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>>>>>>>   	spin_lock(&bus->lock);
>>>>>>>   	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>>>> +	/* Ack all interrupt bits. */
>>>>>>> +	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>>>>   	irq_remaining = irq_received;
>>>>>>>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
>>>>>>> @@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>>>>>>>   			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>>>>>>>   			irq_received, irq_handled);
>>>>>>> -	/* Ack all interrupt bits. */
>>>>>>> -	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>>>>   	spin_unlock(&bus->lock);
>>>>>>>   	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>>>>>>>   }
>>>>>>>
>>>>>>
>>>>>> My intention of putting the code at the end of interrupt handler was,
>>>>>> to reduce possibility of combined irq calls which is explained in this
>>>>>> patch. But YES, I agree with you. It could make a potential race
>>>>>
>>>>> Hmm, yes, but that doesn't explain why it would make sense to acknowledge
>>>>> the interrupt late. The interrupt ack only means "I am going to handle these
>>>>> interrupts". If additional interrupts arrive while the interrupt handler
>>>>> is active, those will have to be acknowledged separately.
>>>>>
>>>>> Sure, there is a risk that an interrupt arrives while the handler is
>>>>> running, and that it is handled but not acknowledged. That can happen
>>>>> with pretty much all interrupt handlers, and there are mitigations to
>>>>> limit the impact (for example, read the interrupt status register in
>>>>> a loop until no more interrupts are pending). But acknowledging
>>>>> an interrupt that was possibly not handled is always bad idea.
>>>>
>>>> Well, that's generally right but not always. Sometimes that depends on
>>>> hardware and Aspeed I2C is the case.
>>>>
>>>> This is a description from Aspeed AST2500 datasheet:
>>>>    I2CD10 Interrupt Status Register
>>>>    bit 2 Receive Done Interrupt status
>>>>          S/W needs to clear this status bit to allow next data receiving.
>>>>
>>>> It means, driver should hold this bit to prevent transition of hardware
>>>> state machine until the driver handles received data, so the bit should
>>>> be cleared at the end of interrupt handler.
>>>>
>>> That makes sense. Does that apply to the other status bits as well ?
>>> Reason for asking is that the current code actually gets stuck
>>> in transmit, not receive.
>>>
>> Only bit 2 has that description in datasheet. Is slave config enabled
>> for QEMU build? Does that get stuck in master sending or slave
>> receiving?
>>
> qemu does not support slave mode. Linux gets stuck in master tx.
> 
> I played with the code on both sides. I had to make changes in both
> the linux kernel and in qemu to get the code to work again.
> See attached.
> 
> Guenter
> 
> ---
> Linux:
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index c258c4d9a4c0..3d518e09369f 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -552,6 +552,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>   
>   	spin_lock(&bus->lock);
>   	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack all interrupts except for Rx done */
> +	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> +	       bus->base + ASPEED_I2C_INTR_STS_REG);
>   	irq_remaining = irq_received;
>   
>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
> @@ -584,8 +587,10 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>   			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>   			irq_received, irq_handled);
>   
> -	/* Ack all interrupt bits. */
> -	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack Rx done */
> +	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
> +		writel(ASPEED_I2CD_INTR_RX_DONE,
> +		       bus->base + ASPEED_I2C_INTR_STS_REG);
>   	spin_unlock(&bus->lock);
>   	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>   }
> 
> ---
> qemu:
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index c762c73..0d4aa08 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -180,6 +180,33 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
>       return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
>   }
>   
> +static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
> +{
> +    int ret;
> +
> +    if (!(bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
> +        return;
> +    }
> +    if (bus->intr_status & I2CD_INTR_RX_DONE) {
> +        return;
> +    }
> +
> +    aspeed_i2c_set_state(bus, I2CD_MRXD);
> +    ret = i2c_recv(bus->bus);
> +    if (ret < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
> +        ret = 0xff;
> +    } else {
> +        bus->intr_status |= I2CD_INTR_RX_DONE;
> +    }
> +    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
> +    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
> +        i2c_nack(bus->bus);
> +    }
> +    bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
> +    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
> +}
> +
>   /*
>    * The state machine needs some refinement. It is only used to track
>    * invalid STOP commands for the moment.
> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>   {
>       bus->cmd &= ~0xFFFF;
>       bus->cmd |= value & 0xFFFF;
> -    bus->intr_status = 0;
> +    bus->intr_status &= I2CD_INTR_RX_DONE;
>   
>       if (bus->cmd & I2CD_M_START_CMD) {
>           uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
> @@ -227,22 +254,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>       }
>   
>       if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
> -        int ret;
> -
> -        aspeed_i2c_set_state(bus, I2CD_MRXD);
> -        ret = i2c_recv(bus->bus);
> -        if (ret < 0) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
> -            ret = 0xff;
> -        } else {
> -            bus->intr_status |= I2CD_INTR_RX_DONE;
> -        }
> -        bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
> -        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
> -            i2c_nack(bus->bus);
> -        }
> -        bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
> -        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
> +        aspeed_i2c_handle_rx_cmd(bus);
>       }
>   
>       if (bus->cmd & I2CD_M_STOP_CMD) {
> @@ -263,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>                                    uint64_t value, unsigned size)
>   {
>       AspeedI2CBus *bus = opaque;
> +    int status;
>   
>       switch (offset) {
>       case I2CD_FUN_CTRL_REG:
> @@ -283,9 +296,16 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>           bus->intr_ctrl = value & 0x7FFF;
>           break;
>       case I2CD_INTR_STS_REG:
> +        status = bus->intr_status;
>           bus->intr_status &= ~(value & 0x7FFF);
> -        bus->controller->intr_status &= ~(1 << bus->id);
> -        qemu_irq_lower(bus->controller->irq);
> +        if (!bus->intr_status) {
> +            bus->controller->intr_status &= ~(1 << bus->id);
> +            qemu_irq_lower(bus->controller->irq);
> +        }
> +        if ((status & I2CD_INTR_RX_DONE) && !(bus->intr_status & I2CD_INTR_RX_DONE)) {
> +            aspeed_i2c_handle_rx_cmd(bus);
> +            aspeed_i2c_bus_raise_interrupt(bus);
> +        }
>           break;
>       case I2CD_DEV_ADDR_REG:
>           qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
> 

Nice fix! LGTM. I've tested the new patch and checked that it works well
on both low and high bus speed environments. Thanks a lot!

Can you please submit this patch?

Thanks,
Jae

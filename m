Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6264C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412CE20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412CE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIMNZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:25:25 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:60329 "EHLO
        5.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeIMNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:25:25 -0400
X-Greylist: delayed 7823 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 09:25:24 EDT
Received: from player157.ha.ovh.net (unknown [10.109.160.5])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2FCC01EB328
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:47:46 +0200 (CEST)
Received: from zorba.kaod.org (LFbn-1-10605-110.w90-89.abo.wanadoo.fr [90.89.196.110])
        (Authenticated sender: postmaster@kaod.org)
        by player157.ha.ovh.net (Postfix) with ESMTPSA id 7F378100081;
        Thu, 13 Sep 2018 07:47:34 +0200 (CEST)
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <285ea914-5407-7fde-036d-95978f95a430@kaod.org>
Date:   Thu, 13 Sep 2018 07:47:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 18014961462414117760
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrjeehgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 06:54 PM, Jae Hyun Yoo wrote:
> On 9/11/2018 6:34 PM, Guenter Roeck wrote:
>> On Tue, Sep 11, 2018 at 04:58:44PM -0700, Jae Hyun Yoo wrote:
>>> On 9/11/2018 4:33 PM, Guenter Roeck wrote:
>>>> Looking into the patch, clearing the interrupt status at the end of an
>>>> interrupt handler is always suspicious and tends to result in race
>>>> conditions (because additional interrupts may have arrived while handling
>>>> the existing interrupts, or because interrupt handling itself may trigger
>>>> another interrupt). With that in mind, the following patch fixes the
>>>> problem for me.
>>>>
>>>> Guenter
>>>>
>>>> ---
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>>>> index c258c4d9a4c0..c488e6950b7c 100644
>>>> --- a/drivers/i2c/busses/i2c-aspeed.c
>>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>>>> @@ -552,6 +552,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>>>>       spin_lock(&bus->lock);
>>>>       irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>>>> +    /* Ack all interrupt bits. */
>>>> +    writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>       irq_remaining = irq_received;
>>>>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
>>>> @@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>>>>               "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>>>>               irq_received, irq_handled);
>>>> -    /* Ack all interrupt bits. */
>>>> -    writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>>>>       spin_unlock(&bus->lock);
>>>>       return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>>>>   }
>>>>
>>>
>>> My intention of putting the code at the end of interrupt handler was,
>>> to reduce possibility of combined irq calls which is explained in this
>>> patch. But YES, I agree with you. It could make a potential race
>>
>> Hmm, yes, but that doesn't explain why it would make sense to acknowledge
>> the interrupt late. The interrupt ack only means "I am going to handle these
>> interrupts". If additional interrupts arrive while the interrupt handler
>> is active, those will have to be acknowledged separately.
>>
>> Sure, there is a risk that an interrupt arrives while the handler is
>> running, and that it is handled but not acknowledged. That can happen
>> with pretty much all interrupt handlers, and there are mitigations to
>> limit the impact (for example, read the interrupt status register in
>> a loop until no more interrupts are pending). But acknowledging
>> an interrupt that was possibly not handled is always bad idea.
> 
> Well, that's generally right but not always. Sometimes that depends on
> hardware and Aspeed I2C is the case.
> 
> This is a description from Aspeed AST2500 datasheet:
>   I2CD10 Interrupt Status Register
>   bit 2 Receive Done Interrupt status
>         S/W needs to clear this status bit to allow next data receiving.
> 
> It means, driver should hold this bit to prevent transition of hardware
> state machine until the driver handles received data, so the bit should
> be cleared at the end of interrupt handler.
> 
> Let me share my test result. Your code change works on 100KHz bus speed
> but doesn't work well on 1MHz bus speed. Investigated that interrupt
> handling is fast enough in 100KHz test but in 1MHz, most of data is
> corrupted because the bit is cleared at the beginning of interrupt
> handler so it allows receiving of the next data but the interrupt
> handler isn't fast enough to read the data buffer on time. I checked
> this problem on BMC-ME channel which ME sends lots of IPMB packets to
> BMC at 1MHz speed. You could simply check the data corruption problem on
> the BMC-ME channel.

OK.
 
> My thought is, the current code is right for real Aspeed I2C hardware.
> It seems that QEMU 3.0 model for witherspoon-bmc doesn't simulate the
> actual Aspeed I2C hardware correctly.

That might be very well possible yes. it also misses support for the slave 
mode and the DMA registers.

Thanks for the info,

C.

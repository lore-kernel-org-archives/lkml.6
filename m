Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE77C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C445A20890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C445A20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeILN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:29:52 -0400
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:58600 "EHLO
        11.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeILN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:29:52 -0400
X-Greylist: delayed 7829 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Sep 2018 09:29:51 EDT
Received: from player726.ha.ovh.net (unknown [10.109.143.220])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id DADAB17C9CC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:57:36 +0200 (CEST)
Received: from zorba.kaod.org (LFbn-1-10605-110.w90-89.abo.wanadoo.fr [90.89.196.110])
        (Authenticated sender: postmaster@kaod.org)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id 5AAAA2A0098;
        Wed, 12 Sep 2018 07:57:24 +0200 (CEST)
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f184e209-cb4b-55d4-e520-ae2cc9f0d963@kaod.org>
Date:   Wed, 12 Sep 2018 07:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911233302.GA18799@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12308337782753168372
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrjeefgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 01:33 AM, Guenter Roeck wrote:
> On Wed, Sep 12, 2018 at 08:23:29AM +0930, Joel Stanley wrote:
>> On Wed, 12 Sep 2018 at 07:48, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> On 9/11/2018 1:41 PM, Guenter Roeck wrote:
>>>> On Tue, Sep 11, 2018 at 01:30:41PM -0700, Jae Hyun Yoo wrote:
>>
>>>>> I checked this patch again but it doesn't have any change that could
>>>>> affect to the probing flow. I'll debug the issue on qemu 3.0 environment
>>>>> and will share if I find something.
>>>>>
>>>> The problem may be that qemu and the new code disagree how interrupts
>>>> should be generated and handled, and the new code does not handle the
>>>> interrupts it receives from the simulated hardware. This will result
>>>> in i2c device probe failure, which in turn can cause all kinds of
>>>> problems.
>>>>
>>>
>>> Yes, that makes sense. Looks like it should be reverted until the issue
>>> is fixed. Will submit a patch to revert it.
>>
>> Let's not rush. The qemu model was written in order to allow us to
>> test the kernel code, and was validated by the kernel driver we have.
>> We've had situations in the past (with the i2c driver in fact) where a
>> change in the driver required an update of the model to be more
>> accurate.
>>
>> I suggest we wait until Cedric has a chance to look at the issue
>> before reverting the patch.
>>
> 
> Looking into the patch, clearing the interrupt status at the end of an
> interrupt handler is always suspicious and tends to result in race

yes. That happened in the past with the I2C aspeed driver. I can not find
the thread anymore but we had to move up the ack of the interrupts. 

QEMU tends to be much faster to fire interrupts than real HW.


> conditions (because additional interrupts may have arrived while handling
> the existing interrupts, or because interrupt handling itself may trigger
> another interrupt). With that in mind, the following patch fixes the
> problem for me.

Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> Guenter
> 
> ---
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index c258c4d9a4c0..c488e6950b7c 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -552,6 +552,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  
>  	spin_lock(&bus->lock);
>  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack all interrupt bits. */
> +	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>  	irq_remaining = irq_received;
>  
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> @@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>  			irq_received, irq_handled);
>  
> -	/* Ack all interrupt bits. */
> -	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>  	spin_unlock(&bus->lock);
>  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>  }
> 


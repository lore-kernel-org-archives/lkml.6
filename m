Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72972C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212BF2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212BF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeILFAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:00:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:65090 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeILFAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:00:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="82726370"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2018 16:58:44 -0700
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
Date:   Tue, 11 Sep 2018 16:58:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911233302.GA18799@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 4:33 PM, Guenter Roeck wrote:
> Looking into the patch, clearing the interrupt status at the end of an
> interrupt handler is always suspicious and tends to result in race
> conditions (because additional interrupts may have arrived while handling
> the existing interrupts, or because interrupt handling itself may trigger
> another interrupt). With that in mind, the following patch fixes the
> problem for me.
> 
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
>   	spin_lock(&bus->lock);
>   	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack all interrupt bits. */
> +	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>   	irq_remaining = irq_received;
>   
>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
> @@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>   			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>   			irq_received, irq_handled);
>   
> -	/* Ack all interrupt bits. */
> -	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>   	spin_unlock(&bus->lock);
>   	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>   }
> 

My intention of putting the code at the end of interrupt handler was,
to reduce possibility of combined irq calls which is explained in this
patch. But YES, I agree with you. It could make a potential race
condition as you pointed out. I tested your code change and checked that
it works well. Let me take more sufficient test on real H/W. Will share
the test result.

Thanks a lot!

Jae

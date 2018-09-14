Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB920861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFB920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeINVrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:47:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:45349 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINVrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:47:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 09:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="80489367"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.151]) ([10.7.153.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Sep 2018 09:28:43 -0700
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
To:     Guenter Roeck <linux@roeck-us.net>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        linux-i2c@vger.kernel.org
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
Date:   Fri, 14 Sep 2018 09:28:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 8:30 PM, Guenter Roeck wrote:
> Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> properly") moved interrupt acknowledgment to the end of the interrupt
> handler. In part this was done because the AST2500 datasheet says:
> 
>   I2CD10 Interrupt Status Register
>     bit 2 Receive Done Interrupt status
>           S/W needs to clear this status bit to allow next data receiving.
> 
> Acknowledging Receive Done before receive data was handled resulted in
> receive errors on high speed I2C busses.
> 
> However, interrupt acknowledgment was not only moved to the end of the
> interrupt handler for Receive Done Interrupt status, but for all interrupt
> status bits. This could result in race conditions if a second interrupt was
> received during interrupt handling and not handled but still acknowledged
> at the end of the interrupt handler.
> 
> Acknowledge only "Receive Done Interrupt status" late in the interrupt
> handler to solve the problem.
> 
> Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/i2c/busses/i2c-aspeed.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
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

Looks good to me. Thanks! :)

Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

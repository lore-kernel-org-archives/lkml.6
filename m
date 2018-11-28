Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C793C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CD720863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CD720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeK2I5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:57:48 -0500
Received: from sauhun.de ([88.99.104.3]:41670 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2I5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:57:48 -0500
Received: from localhost (pd95c76c9.dip0.t-ipconnect.de [217.92.118.201])
        by pokefinder.org (Postfix) with ESMTPSA id 292FC2E3542;
        Wed, 28 Nov 2018 22:54:41 +0100 (CET)
Date:   Wed, 28 Nov 2018 22:54:40 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH i2c-next v9 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
Message-ID: <20181128215434.GA1666@kunai>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
 <20181030210917.32711-6-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030210917.32711-6-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:09:16PM -0700, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so a
> case can be happened that this master tries to send data through
> the master_xfer function but slave data from peer master is still
> being processed by this driver.

So, that I get this correct: your IP core cannot detect a bus busy state
when its own slave address is acessed? Well, I know HW can have bugs,
but I still wonder because a bus is busy as soon as another START has
been detected, independent of which device is going to be accessed.

Even if so, why can't you use a mutex to prevent any master_xfer while
slave_xfer is ongoing?

Shouldn't that be enough according to the above description? Why do you
need the delay? I might be missing something...

> To prevent any state corruption in the case, this patch adds
> checking code if any slave operation is ongoing and it waits up to
> the bus timeout duration before starting a master_xfer operation.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 55 ++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 833b6b6a4c7e..30c3ab3a4844 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> @@ -115,6 +116,9 @@
>  /* 0x18 : I2CD Slave Device Address Register   */
>  #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
>  
> +/* Busy checking */
> +#define ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US		(10 * 1000)
> +
>  enum aspeed_i2c_master_state {
>  	ASPEED_I2C_MASTER_INACTIVE,
>  	ASPEED_I2C_MASTER_START,
> @@ -156,6 +160,8 @@ struct aspeed_i2c_bus {
>  	int				cmd_err;
>  	/* Protected only by i2c_lock_bus */
>  	int				master_xfer_result;
> +	/* Multi-master */
> +	bool				multi_master;
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  	struct i2c_client		*slave;
>  	enum aspeed_i2c_slave_state	slave_state;
> @@ -596,27 +602,44 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>  }
>  
> +static int aspeed_i2c_check_bus_busy(struct aspeed_i2c_bus *bus)
> +{
> +	unsigned long timeout;
> +
> +	if (bus->multi_master) {
> +		might_sleep();
> +		/* Initialize it only when multi_master is set */
> +		timeout = jiffies + bus->adap.timeout;
> +	}
> +
> +	for (;;) {
> +		if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> +		      ASPEED_I2CD_BUS_BUSY_STS))
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +			if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
> +#endif
> +				return 0;
> +		if (!bus->multi_master)
> +			break;
> +		if (time_after(jiffies, timeout))
> +			break;
> +		usleep_range((ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US >> 2) + 1,
> +			     ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US);
> +	}
> +
> +	return aspeed_i2c_recover_bus(bus);
> +}
> +
>  static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>  				  struct i2c_msg *msgs, int num)
>  {
>  	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
>  	unsigned long time_left, flags;
> -	int ret = 0;
>  
> -	spin_lock_irqsave(&bus->lock, flags);
> -	bus->cmd_err = 0;
> -
> -	/* If bus is busy, attempt recovery. We assume a single master
> -	 * environment.
> -	 */
> -	if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
> -		spin_unlock_irqrestore(&bus->lock, flags);
> -		ret = aspeed_i2c_recover_bus(bus);
> -		if (ret)
> -			return ret;
> -		spin_lock_irqsave(&bus->lock, flags);
> -	}
> +	if (aspeed_i2c_check_bus_busy(bus))
> +		return -EAGAIN;
>  
> +	spin_lock_irqsave(&bus->lock, flags);
>  	bus->cmd_err = 0;
>  	bus->msgs = msgs;
>  	bus->msgs_index = 0;
> @@ -827,7 +850,9 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!of_property_read_bool(pdev->dev.of_node, "multi-master"))
> +	if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
> +		bus->multi_master = true;
> +	else
>  		fun_ctrl_reg |= ASPEED_I2CD_MULTI_MASTER_DIS;
>  
>  	/* Enable Master Mode */
> -- 
> 2.19.1
> 

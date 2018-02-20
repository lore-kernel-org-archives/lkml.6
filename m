Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeBTT7H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:59:07 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:44903 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeBTT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:59:06 -0500
Date: Tue, 20 Feb 2018 20:58:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
Message-ID: <20180220195854.GG18058@piout.net>
References: <20180216194415.6103-1-david.daney@cavium.com>
 <20180220110344.GE18058@piout.net>
 <4dfd0a27-7c03-13a0-acdb-890817e47bfc@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dfd0a27-7c03-13a0-acdb-890817e47bfc@caviumnetworks.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2018 at 11:43:47 -0800, David Daney wrote:
> On 02/20/2018 03:03 AM, Alexandre Belloni wrote:
> [...]
> 
> 
> > > diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
> > > new file mode 100644
> > > index 000000000000..29e5bdf96c67
> > > --- /dev/null
> > > +++ b/drivers/rtc/rtc-isl12026.c
> > > @@ -0,0 +1,529 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * An I2C driver for the Intersil ISL 12026
> > > + *
> > > + * Copyright (c) 2018 Cavium, Inc.
> > > + */
> > > +#include <linux/bcd.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/nvmem-provider.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/rtc.h>
> > > +#include <linux/slab.h>
> > > +
> > > +/* register offsets */
> > > +#define ISL12026_REG_PWR	0x14
> > > +# define ISL12026_REG_PWR_BSW	BIT(6)
> > > +# define ISL12026_REG_PWR_SBIB	BIT(7)
> > > +#define ISL12026_REG_SC		0x30
> > > +#define ISL12026_REG_HR		0x32
> > > +# define ISL12026_REG_HR_MIL	BIT(7)	/* military or 24 hour time */
> > > +#define ISL12026_REG_SR		0x3f
> > > +# define ISL12026_REG_SR_RTCF	BIT(0)
> > > +# define ISL12026_REG_SR_WEL	BIT(1)
> > > +# define ISL12026_REG_SR_RWEL	BIT(2)
> > > +# define ISL12026_REG_SR_MBZ	BIT(3)
> > > +# define ISL12026_REG_SR_OSCF	BIT(4)
> > > +
> > > +/* The EEPROM array responds at i2c address 0x57 */
> > > +#define ISL12026_EEPROM_ADDR	0x57
> > > +
> > > +#define ISL12026_PAGESIZE 16
> > > +#define ISL12026_NVMEM_WRITE_TIME 20
> > > +
> > > +struct isl12026 {
> > > +	struct rtc_device *rtc;
> > > +	struct i2c_client *nvm_client;
> > > +	struct nvmem_config nvm_cfg;
> > > +	/*
> > > +	 * RTC write operations require that multiple messages be
> > > +	 * transmitted, we hold the lock for all accesses to the
> > > +	 * device so that these sequences cannot be disrupted.  Also,
> > > +	 * the write cycle to the nvmem takes many ms during which the
> > > +	 * device does not respond to commands, so holding the lock
> > > +	 * also prevents access during these times.
> > > +	 */
> > > +	struct mutex lock;
> > > +};
> > > +
> > > +static int isl12026_read_reg(struct i2c_client *client, int reg)
> > > +{
> > > +	struct isl12026 *priv = i2c_get_clientdata(client);
> > > +	u8 addr[] = {0, reg};
> > > +	u8 val;
> > > +	int ret;
> > > +
> > > +	struct i2c_msg msgs[] = {
> > > +		{
> > > +			.addr	= client->addr,
> > > +			.flags	= 0,
> > > +			.len	= sizeof(addr),
> > > +			.buf	= addr
> > > +		}, {
> > > +			.addr	= client->addr,
> > > +			.flags	= I2C_M_RD,
> > > +			.len	= 1,
> > > +			.buf	= &val
> > > +		}
> > > +	};
> > 
> > I'm pretty sure you can use regmap instead of open coding all the i2c
> > transfers, did you try?
> 
> I couldn't figure out how to make it do the device-atomic stores to SR.RWEL
> and SR.WEL that must precede certain register store operations. Also,
> dealing with locking across multiple i2c target addresses seems
> problematical with the regmap helpers.
> 
> The open coding doesn't clutter things up too much, and allows us to follow
> the isl12026 protocol without having to jump through too many hoops.
> 
> > 
> > > +
> > > +	mutex_lock(&priv->lock);
> > > +
> > 
> > Also, regmap will remove the need for that lock.
> 
> Since
> 
> 
> > 
> > > +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> > > +	if (ret != ARRAY_SIZE(msgs)) {
> > > +		dev_err(&client->dev, "read reg error, ret=%d\n", ret);
> > > +		ret = ret < 0 ? ret : -EIO;
> > > +	} else {
> > > +		ret = val;
> > > +	}
> > > +
> > > +	mutex_unlock(&priv->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
> > > +{
> > > +	struct isl12026 *priv = i2c_get_clientdata(client);
> > > +	int ret;
> > > +	u8 op[3];
> > > +	struct i2c_msg msg = {
> > > +		.addr	= client->addr,
> > > +		.flags	= 0,
> > > +		.len	= 1,
> > > +		.buf	= op
> > > +	};
> > > +
> > > +	mutex_lock(&priv->lock);
> > > +
> > > +	/* Set SR.WEL */
> > > +	op[0] = 0;
> > > +	op[1] = ISL12026_REG_SR;
> > > +	op[2] = ISL12026_REG_SR_WEL;
> > > +	msg.len = 3;
> > > +	ret = i2c_transfer(client->adapter, &msg, 1);
> > > +	if (ret != 1) {
> > > +		dev_err(&client->dev, "write error SR.WEL, ret=%d\n", ret);
> > > +		ret = ret < 0 ? ret : -EIO;
> > > +		goto out;
> > > +	}
> > 
> > If you don't clear SR.WEL, I don't think you need to set it each time
> > you write to the RTC. I would just set SR.WEL at probe time and let it
> > there. That removes two i2c writes for each write operation.
> 
> I don't like the idea of leaving the thing partially armed when write
> operations should be rare.
> 

Ok, then, can you at least factorize the write enabling/disabling in two
functions. That would make the code smaller.

> > > +	ret = rtc_valid_tm(tm);
> > 
> > This rtc_valid_tm is unnecessary, you can simply return 0.
> 
> It may be possible for invalid values to be programmed into the RTC, this
> would catch that case.
> 

Which will be caught by the core anyway.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

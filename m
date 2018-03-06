Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeCFIse (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:48:34 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39674 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeCFIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:48:32 -0500
X-Google-Smtp-Source: AG47ELs9exMWoUKT4KBHxONB4lPqMwRdhfQgn4mbu/XW0Oaq/+NDVHOijWz73SlwtLia7tP/5mHD6g==
From: Jan Glauber <jglauber@cavium.com>
X-Google-Original-From: Jan Glauber <jglauber@caviumnetworks.com>
Date: Tue, 6 Mar 2018 09:48:29 +0100
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de
Subject: Re: [PATCHv2 1/3] i2c: xlp9xx: Check for Bus state before every
 transfer
Message-ID: <20180306084829.GB11729@wintermute>
References: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know how valuable same-company reviewed-by's are in the end, 
but the patches look good to me with the small change in SMBalert, so you
could add:

Reviewed-by: Jan Glauber <jglauber@cavium.com>

--Jan

On Tue, Feb 27, 2018 at 01:26:18PM +0000, George Cherian wrote:
> I2C bus enters the STOP condition after the DATA_DONE interrupt is raised.
> Essentially the driver should be checking the bus state before sending
> any transaction. In case a transaction is initiated while the
> bus is busy, the prior transaction's stop condition is not achieved.
> Add the check to make sure the bus is not busy before every transaction.
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/i2c/busses/i2c-xlp9xx.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
> index 1f6d780..42dd1fa 100644
> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/delay.h>
>  
>  #define XLP9XX_I2C_DIV			0x0
>  #define XLP9XX_I2C_CTRL			0x1
> @@ -36,6 +37,8 @@
>  #define XLP9XX_I2C_TIMEOUT		0X10
>  #define XLP9XX_I2C_GENCALLADDR		0x11
>  
> +#define XLP9XX_I2C_STATUS_BUSY		BIT(0)
> +
>  #define XLP9XX_I2C_CMD_START		BIT(7)
>  #define XLP9XX_I2C_CMD_STOP		BIT(6)
>  #define XLP9XX_I2C_CMD_READ		BIT(5)
> @@ -71,6 +74,7 @@
>  #define XLP9XX_I2C_HIGH_FREQ		400000
>  #define XLP9XX_I2C_FIFO_SIZE		0x80U
>  #define XLP9XX_I2C_TIMEOUT_MS		1000
> +#define XLP9XX_I2C_BUSY_TIMEOUT		50
>  
>  #define XLP9XX_I2C_FIFO_WCNT_MASK	0xff
>  #define XLP9XX_I2C_STATUS_ERRMASK	(XLP9XX_I2C_INTEN_ARLOST | \
> @@ -241,6 +245,26 @@ static irqreturn_t xlp9xx_i2c_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static int xlp9xx_i2c_check_bus_status(struct xlp9xx_i2c_dev *priv)
> +{
> +	u32 status;
> +	u32 busy_timeout = XLP9XX_I2C_BUSY_TIMEOUT;
> +
> +	while (busy_timeout) {
> +		status = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_STATUS);
> +		if ((status & XLP9XX_I2C_STATUS_BUSY) == 0)
> +			break;
> +
> +		busy_timeout--;
> +		usleep_range(1000, 1100);
> +	}
> +
> +	if (!busy_timeout)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static int xlp9xx_i2c_init(struct xlp9xx_i2c_dev *priv)
>  {
>  	u32 prescale;
> @@ -363,6 +387,14 @@ static int xlp9xx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	int i, ret;
>  	struct xlp9xx_i2c_dev *priv = i2c_get_adapdata(adap);
>  
> +	ret = xlp9xx_i2c_check_bus_status(priv);
> +	if (ret) {
> +		xlp9xx_i2c_init(priv);
> +		ret = xlp9xx_i2c_check_bus_status(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i = 0; i < num; i++) {
>  		ret = xlp9xx_i2c_xfer_msg(priv, &msgs[i], i == num - 1);
>  		if (ret != 0)
> -- 
> 2.1.4

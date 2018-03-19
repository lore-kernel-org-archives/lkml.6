Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbeCSJgq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:36:46 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:44679 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeCSJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:36:43 -0400
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <c9b7a9c9-4924-cadc-c539-0775aab23368@electromag.com.au>
Date: Mon, 19 Mar 2018 17:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 18:53, Pierre-Yves MORDRET wrote:
> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
> and releases SCL/SDA signals but preserves I2C registers.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>      v1:
>         * Initial
> ---
> ---
>   drivers/i2c/busses/i2c-stm32f7.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 69a2e5e..3808bc9 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -718,6 +718,20 @@ static void stm32f7_i2c_smbus_reload(struct stm32f7_i2c_dev *i2c_dev)
>   	writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
>   }
>   
> +static int stm32f7_i2c_recover_bus(struct i2c_adapter *i2c_adap)
> +{
> +	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
> +
> +	dev_info(i2c_dev->dev, "Trying to recover bus\n");
> +
> +	stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1,
> +			     STM32F7_I2C_CR1_PE);

This only "releases" the scl / sda on the stm32f7 end (outputs are hiz I guess).
It doesn't trigger the scl clocking needed to recover a stuck device  via i2c recovery
from what I can see in the data sheet.


> +
> +	stm32f7_i2c_hw_config(i2c_dev);

Nothing in here either I think.


> +
> +	return 0;
> +}
> +
>   static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
>   {
>   	u32 status;
> @@ -727,12 +741,18 @@ static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
>   					 status,
>   					 !(status & STM32F7_I2C_ISR_BUSY),
>   					 10, 1000);
> +	if (!ret)
> +		return 0;
> +
> +	dev_info(i2c_dev->dev, "bus busy\n");
> +
> +	ret = i2c_recover_bus(&i2c_dev->adap);
>   	if (ret) {
> -		dev_dbg(i2c_dev->dev, "bus busy\n");
> -		ret = -EBUSY;
> +		dev_err(i2c_dev->dev, "Failed to recover the bus (%d)\n", ret);
> +		return ret;
>   	}
>   
> -	return ret;
> +	return -EBUSY;
>   }
>   
>   static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
> @@ -1476,6 +1496,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
>   	if (status & STM32F7_I2C_ISR_BERR) {
>   		dev_err(dev, "<%s>: Bus error\n", __func__);
>   		writel_relaxed(STM32F7_I2C_ICR_BERRCF, base + STM32F7_I2C_ICR);
> +		i2c_recover_bus(&i2c_dev->adap);
>   		f7_msg->result = -EIO;
>   	}
>   
> @@ -1760,6 +1781,10 @@ static struct i2c_algorithm stm32f7_i2c_algo = {
>   	.unreg_slave = stm32f7_i2c_unreg_slave,
>   };
>   
> +static struct i2c_bus_recovery_info stm32f7_i2c_recovery_info = {
> +	.recover_bus = stm32f7_i2c_recover_bus,
> +};
> +
>   static int stm32f7_i2c_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> @@ -1879,6 +1904,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>   	adap->algo = &stm32f7_i2c_algo;
>   	adap->dev.parent = &pdev->dev;
>   	adap->dev.of_node = pdev->dev.of_node;
> +	adap->bus_recovery_info = &stm32f7_i2c_recovery_info;
>   
>   	init_completion(&i2c_dev->complete);
>   
> 


-- 
Regards
Phil

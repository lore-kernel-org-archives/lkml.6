Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeDIU5B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:57:01 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:31846 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbeDIU47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:56:59 -0400
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is
 called
To: Baolin Wang <baolin.wang@linaro.org>, <wsa@the-dreams.de>
CC: <broonie@kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <557074eb-e988-8ff5-bec0-c85bb9dcb8ec@ti.com>
Date: Mon, 9 Apr 2018 15:56:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2018 01:40 AM, Baolin Wang wrote:
> Add one flag to indicate if the i2c controller has been in suspend state,
> which can prevent i2c accesses after i2c controller is suspended following
> system suspend.

This usually indicates some bigger problem - there should be no i2c access to
 the I2C driver once it's suspended. But if happens - 
it means suspend dependencies between drivers are broken or there some 
scheduling primitives are not disabled properly.
(possible sources - kthreads, delayed works, timers or even threaded irqs)

> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>   drivers/i2c/busses/i2c-sprd.c |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> index 25fcc3c..2fdad63 100644
> --- a/drivers/i2c/busses/i2c-sprd.c
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -86,6 +86,7 @@ struct sprd_i2c {
>   	u32 count;
>   	int irq;
>   	int err;
> +	bool is_suspended;
>   };
>   
>   static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
> @@ -283,6 +284,9 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
>   	struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
>   	int im, ret;
>   
> +	if (i2c_dev->is_suspended)
> +		return -EBUSY;
> +
>   	ret = pm_runtime_get_sync(i2c_dev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -586,11 +590,23 @@ static int sprd_i2c_remove(struct platform_device *pdev)
>   
>   static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
>   {
> +	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +
> +	i2c_lock_adapter(&i2c_dev->adap);
> +	i2c_dev->is_suspended = true;
> +	i2c_unlock_adapter(&i2c_dev->adap);
> +
>   	return pm_runtime_force_suspend(pdev);
>   }
>   
>   static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
>   {
> +	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
> +
> +	i2c_lock_adapter(&i2c_dev->adap);
> +	i2c_dev->is_suspended = false;
> +	i2c_unlock_adapter(&i2c_dev->adap);
> +
>   	return pm_runtime_force_resume(pdev);
>   }
>   
> 

-- 
regards,
-grygorii

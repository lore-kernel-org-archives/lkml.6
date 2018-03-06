Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeCFJSv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:18:51 -0500
Received: from anchovy3.45ru.net.au ([203.30.46.155]:53743 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeCFJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:18:49 -0500
Subject: Re: [PATCH 3/3] i2c: xlp9xx: Add support for SMBAlert
To: Jan Glauber <jglauber@cavium.com>,
        George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, Kamlakant Patel <kamlakant.patel@cavium.com>
References: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
 <1519737980-27997-3-git-send-email-george.cherian@cavium.com>
 <20180306083647.GA11729@wintermute>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <b78f0a77-403d-a5e5-e274-8c4f08a2cd20@electromag.com.au>
Date: Tue, 6 Mar 2018 17:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306083647.GA11729@wintermute>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/2018 16:36, Jan Glauber wrote:
> On Tue, Feb 27, 2018 at 01:26:20PM +0000, George Cherian wrote:
>> Add support for SMBus alert mechanism to i2c-xlp9xx driver.
>> The second interrupt is parsed to use for SMBus alert.
>> The first interrupt is the i2c controller main interrupt.
>>
>> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/i2c/busses/i2c-xlp9xx.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
>> index eb8913e..9462eab 100644
>> --- a/drivers/i2c/busses/i2c-xlp9xx.c
>> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/completion.h>
>>   #include <linux/i2c.h>
>> +#include <linux/i2c-smbus.h>
>>   #include <linux/init.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> @@ -84,6 +85,8 @@ struct xlp9xx_i2c_dev {
>>   	struct device *dev;
>>   	struct i2c_adapter adapter;
>>   	struct completion msg_complete;
>> +	struct i2c_smbus_alert_setup alert_data;
>> +	struct i2c_client *ara;
>>   	int irq;
>>   	bool msg_read;
>>   	bool len_recv;
>> @@ -447,6 +450,21 @@ static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
>>   	return 0;
>>   }
>>   
>> +static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
>> +				  struct platform_device *pdev)
>> +{
>> +	if (!priv->alert_data.irq)
>> +		return -EINVAL;
>> +
>> +	priv->alert_data.alert_edge_triggered = 0;
> 
> Hi George,
> 
> I think this is not needed anymore, see:
> 9b9f2b8bc2ac i2c: i2c-smbus: Use threaded irq for smbalert
> 
> --Jan

Yes.

And also all of this is not needed if named interrupts.
- interrupt-names
	"irq", "wakeup" and "smbus_alert" names are recognized by I2C core,
	other names are	left to individual drivers.

presence of named irq smbus_alert should result in alert handler being
created for that bus by the core

> 
>> +
>> +	priv->ara = i2c_setup_smbus_alert(&priv->adapter, &priv->alert_data);
>> +	if (!priv->ara)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +
>>   static int xlp9xx_i2c_probe(struct platform_device *pdev)
>>   {
>>   	struct xlp9xx_i2c_dev *priv;
>> @@ -467,6 +485,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
>>   		dev_err(&pdev->dev, "invalid irq!\n");
>>   		return priv->irq;
>>   	}
>> +	/* SMBAlert irq */
>> +	priv->alert_data.irq = platform_get_irq(pdev, 1);
>> +	if (priv->alert_data.irq <= 0)
>> +		priv->alert_data.irq = 0;
>>   
>>   	xlp9xx_i2c_get_frequency(pdev, priv);
>>   	xlp9xx_i2c_init(priv);
>> @@ -493,6 +515,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
>>   	if (err)
>>   		return err;
>>   
>> +	err = xlp9xx_i2c_smbus_setup(priv, pdev);
>> +	if (err)
>> +		dev_info(&pdev->dev, "No active SMBus alert %d\n", err);
>> +
>>   	platform_set_drvdata(pdev, priv);
>>   	dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
>>   
>> -- 
>> 2.1.4
> 
> 


-- 
Regards
Phil Reid

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeCZIVi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:21:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42321 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751195AbeCZIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:21:36 -0400
Subject: Re: [PATCH v2 6/6] i2c: i2c-stm32f7: Implement I2C recovery mechanism
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-7-git-send-email-pierre-yves.mordret@st.com>
 <20180324225630.6jen6mvboxbhyp7n@ninjato>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <ad11f5a5-4552-eb4a-7d7f-e0966bc340ea@st.com>
Date: Mon, 26 Mar 2018 10:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324225630.6jen6mvboxbhyp7n@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/24/2018 11:56 PM, Wolfram Sang wrote:
> On Wed, Mar 21, 2018 at 05:49:00PM +0100, Pierre-Yves MORDRET wrote:
>> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
>> and releases SCL/SDA signals but preserves I2C registers.
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>     v1:
>>        * Initial
>>     v2:
>>        * Don't use i2c engine recovery mechanism since driver
>>          procedure only recover master and not the slave.
> 
> s/recovery/release/ throughout the patch, please. Recovery is really
> something else. Also, I think the dev_info's are too noisy in the log
> files. I'd think the whole driver could be lifted from quite some
> logging...
> 

ok. will do.
Do you have example of info's that we should get rid of ?

>> ---
>> ---
>>  drivers/i2c/busses/i2c-stm32f7.c | 27 ++++++++++++++++++++++++---
>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
>> index 91f73e0..9a9c469 100644
>> --- a/drivers/i2c/busses/i2c-stm32f7.c
>> +++ b/drivers/i2c/busses/i2c-stm32f7.c
>> @@ -718,6 +718,20 @@ static void stm32f7_i2c_smbus_reload(struct stm32f7_i2c_dev *i2c_dev)
>>  	writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
>>  }
>>  
>> +static int stm32f7_i2c_recover_bus(struct i2c_adapter *i2c_adap)
>> +{
>> +	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
>> +
>> +	dev_info(i2c_dev->dev, "Trying to recover bus\n");
>> +
>> +	stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1,
>> +			     STM32F7_I2C_CR1_PE);
>> +
>> +	stm32f7_i2c_hw_config(i2c_dev);
>> +
>> +	return 0;
>> +}
>> +
>>  static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
>>  {
>>  	u32 status;
>> @@ -727,12 +741,18 @@ static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
>>  					 status,
>>  					 !(status & STM32F7_I2C_ISR_BUSY),
>>  					 10, 1000);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	dev_info(i2c_dev->dev, "bus busy\n");
>> +
>> +	ret = stm32f7_i2c_recover_bus(&i2c_dev->adap);
>>  	if (ret) {
>> -		dev_dbg(i2c_dev->dev, "bus busy\n");
>> -		ret = -EBUSY;
>> +		dev_err(i2c_dev->dev, "Failed to recover the bus (%d)\n", ret);
>> +		return ret;
>>  	}
>>  
>> -	return ret;
>> +	return -EBUSY;
>>  }
>>  
>>  static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
>> @@ -1474,6 +1494,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
>>  	if (status & STM32F7_I2C_ISR_BERR) {
>>  		dev_err(dev, "<%s>: Bus error\n", __func__);
>>  		writel_relaxed(STM32F7_I2C_ICR_BERRCF, base + STM32F7_I2C_ICR);
>> +		stm32f7_i2c_recover_bus(&i2c_dev->adap);
>>  		f7_msg->result = -EIO;
>>  	}
>>  
>> -- 
>> 2.7.4
>>

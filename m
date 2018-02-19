Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeBSLYF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:24:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeBSLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:24:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 19 Feb 2018 16:54:01 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] i2c: qup: fix buffer overflow for multiple msg of
 maximum xfer len
In-Reply-To: <246915f4-5351-c1b5-761b-45d88e4a3845@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-10-git-send-email-absahu@codeaurora.org>
 <246915f4-5351-c1b5-761b-45d88e4a3845@codeaurora.org>
Message-ID: <c04d40862c2158b7a175fddda83dd339@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-16 10:51, Sricharan R wrote:
> Hi Abhishek,
> 
> On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
>> The BAM mode requires buffer for start tag data and tx, rx SG
>> list. Currently, this is being taken for maximum transfer length
>> (65K). But an I2C transfer can have multiple messages and each
>> message can be of this maximum length so the buffer overflow will
>> happen in this case. Since increasing buffer length won’t be
>> feasible since an I2C transfer can contain any number of messages
>> so this patch does following changes to make i2c transfers working
>> for multiple messages case.
>> 
>> 1. Calculate the required buffers for 2 maximum length messages
>>    (65K * 2).
>> 2. Split the descriptor formation and descriptor scheduling.
>>    The idea is to fit as many messages in one DMA transfers for 65K
>>    threshold value (max_xfer_sg_len). Whenever the sg_cnt is
>>    crossing this, then schedule the BAM transfer and subsequent
>>    transfer will again start from zero.

  <snip>

>> +static void qup_i2c_bam_clear_tag_buffers(struct qup_i2c_dev *qup)
>> +{
>> +	qup->btx.sg_cnt = 0;
>> +	qup->brx.sg_cnt = 0;
>> +	qup->tag_buf_pos = 0;
>> +}
>> +
>>  static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg 
>> *msg,
>>  			    int num)
>>  {
>>  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
>>  	int ret = 0;
>> +	int idx = 0;
>> 
>>  	enable_irq(qup->irq);
>>  	ret = qup_i2c_req_dma(qup);
>> @@ -905,9 +916,34 @@ static int qup_i2c_bam_xfer(struct i2c_adapter 
>> *adap, struct i2c_msg *msg,
>>  		goto out;
>> 
>>  	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
>> +	qup_i2c_bam_clear_tag_buffers(qup);
>> +
>> +	for (idx = 0; idx < num; idx++) {
>> +		qup->msg = msg + idx;
>> +		qup->is_last = idx == (num - 1);
>> +
>> +		ret = qup_i2c_bam_make_desc(qup, qup->msg);
>> +		if (ret)
>> +			break;
>> +
>> +		/*
>> +		 * Make DMA descriptor and schedule the BAM transfer if its
>> +		 * already crossed the maximum length. Since the memory for all
>> +		 * tags buffers have been taken for 2 maximum possible
>> +		 * transfers length so it will never cross the buffer actual
>> +		 * length.
>> +		 */
>> +		if (qup->btx.sg_cnt > qup->max_xfer_sg_len ||
>> +		    qup->brx.sg_cnt > qup->max_xfer_sg_len ||
>> +		    qup->is_last) {
>> +			ret = qup_i2c_bam_schedule_desc(qup);
>> +			if (ret)
>> +				break;
>> +
>> +			qup_i2c_bam_clear_tag_buffers(qup);
>> +		}
>> +	}
>> 
> 
>   hmm, is this because of only stress tests or was there any device 
> which
>   was using i2c for multiple messages exceeding 64k bytes ?

  Its mainly part of stress test but we have test slave devices which
  supports the multiple messages exceeding 64k bytes. Also, in I2C EEPROM
  we can send the multiple messages exceeding 64k bytes. It will roll 
over
  to starting address after its capacity.

> 
>   Infact we are trying to club two separate messages together across 
> 64k
>   boundaries. Not sure if its really correct. So either we club all 
> messages
>   fully or club only up to the length that would cover the whole 
> message < 64K
>   and send the remaining whole messages in next transfer.
> 

  The QUP DMA can be used for any transfer length. It supports greater 
than
  64k also in one go. Only restriction is descriptors memory. clubing all
  messages won't be feasible since there is no restriction on the number 
of
  messages due to which we can't determine the required descriptors size.

  whole message < 64K will require more code changes since we need to 
calculate
  the number of required descriptors in advance. Again in descriptor 
formation,
  the number of required descriptors will be calculated and filled. To 
make the
  code less complicated, I have taken the memory for 128K xfer length 
which
  will make the current code working without any major code changes.

  Thanks,
  Abhishek

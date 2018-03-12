Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeCLNzJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:55:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932147AbeCLNzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:55:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 12 Mar 2018 19:25:05 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: "Christ, Austin" <austinwc@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] i2c: qup: fix buffer overflow for multiple msg of
 maximum xfer len
In-Reply-To: <99d007e0-7983-f0bf-1ca0-d37f2ea4d8fa@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-10-git-send-email-absahu@codeaurora.org>
 <99d007e0-7983-f0bf-1ca0-d37f2ea4d8fa@codeaurora.org>
Message-ID: <732eadb6cf4304c6fb963f7b901ca4bf@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-28 03:36, Christ, Austin wrote:
> Hey Abhishek,
> 
> 
> On 2/3/2018 12:58 AM, Abhishek Sahu wrote:
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
>>     (65K * 2).
>> 2. Split the descriptor formation and descriptor scheduling.
>>     The idea is to fit as many messages in one DMA transfers for 65K
>>     threshold value (max_xfer_sg_len). Whenever the sg_cnt is
>>     crossing this, then schedule the BAM transfer and subsequent
>>     transfer will again start from zero.
>> 

<snip>

>> @@ -1603,7 +1640,7 @@ static int qup_i2c_probe(struct platform_device 
>> *pdev)
>>   	one_bit_t = (USEC_PER_SEC / clk_freq) + 1;
>>   	qup->one_byte_t = one_bit_t * 9;
>>   	qup->xfer_timeout = TOUT_MIN * HZ +
>> -			    usecs_to_jiffies(MX_TX_RX_LEN * qup->one_byte_t);
>> +		usecs_to_jiffies(2 * MX_TX_RX_LEN * qup->one_byte_t);
> 
> Maybe it would make sense to add a comment here explaining why the
> magic number 2 has been added.

  Thanks Austin for reviewing the patches.

  Now in v2, I have used the new macro MX_DMA_TX_RX_LEN  which will make
  this multiplication by 2 more clear. This 2 is for allocating memory
  by taking 2 maximum length messages.

  https://lkml.org/lkml/2018/3/12/423

  Thanks,
  Abhishek

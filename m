Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeCGWjz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:39:55 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.46]:37546 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933251AbeCGWjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:39:54 -0500
Subject: Re: [PATCH] rtc: remove VLA usage
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180307201133.GA5860@embeddedgus>
 <20180307212506.GO3035@piout.net>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <3e8e1515-0f0e-73d4-72eb-3a2a2fbf04e9@embeddedor.com>
Date: Wed, 7 Mar 2018 16:39:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307212506.GO3035@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.24.133
X-Source-L: No
X-Exim-ID: 1ethiz-000jxh-7P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-24-133.static.axtel.net ([192.168.3.98]) [187.162.24.133]:53450
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 03/07/2018 03:25 PM, Alexandre Belloni wrote:
> On 07/03/2018 at 14:11:33 -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with a fixed-length array instead.
>>
> You should probably explain what VLA is and why this is important to do.

Sure. I can elaborate a little bit more.

>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/rtc/rtc-bq32k.c  | 2 +-
>>   drivers/rtc/rtc-mcp795.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
>> index e8698e9..e4b234a 100644
>> --- a/drivers/rtc/rtc-bq32k.c
>> +++ b/drivers/rtc/rtc-bq32k.c
>> @@ -74,7 +74,7 @@ static int bq32k_read(struct device *dev, void *data, uint8_t off, uint8_t len)
>>   static int bq32k_write(struct device *dev, void *data, uint8_t off, uint8_t len)
>>   {
>>   	struct i2c_client *client = to_i2c_client(dev);
>> -	uint8_t buffer[len + 1];
>> +	uint8_t buffer[256];
>>   
> You chose to change len to 255, probably because this is a uint8_t but

Correct.

> this is way too much for this rtc, it only has 10 consecutive registers.

In that case probably the best solution is to add the following line to 
the module:

#define MAX_LEN 10

and update the rest of the code as follows:

uint8_t buffer[MAX_LEN + 1];


>>   	buffer[0] = off;
>>   	memcpy(&buffer[1], data, len);
>> diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
>> index 79e24ea..00e11c1 100644
>> --- a/drivers/rtc/rtc-mcp795.c
>> +++ b/drivers/rtc/rtc-mcp795.c
>> @@ -82,7 +82,7 @@ static int mcp795_rtcc_write(struct device *dev, u8 addr, u8 *data, u8 count)
>>   {
>>   	struct spi_device *spi = to_spi_device(dev);
>>   	int ret;
>> -	u8 tx[2 + count];
>> +	u8 tx[257];

For this particular case it seems to me that the following works just fine:

#define MAX_COUNT 7

u8 tx[MAX_COUNT + 2];

What do you think?

Thanks for your feedback.
--
Gustavo

>>   
>>   	tx[0] = MCP795_WRITE;
>>   	tx[1] = addr;
>> -- 
>> 2.7.4
>>

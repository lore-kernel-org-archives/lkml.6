Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754866AbeCGXL2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:11:28 -0500
Received: from gateway23.websitewelcome.com ([192.185.48.104]:29972 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754052AbeCGXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:11:27 -0500
Subject: Re: [PATCH] rtc: remove VLA usage
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180307201133.GA5860@embeddedgus>
 <20180307212506.GO3035@piout.net>
 <3e8e1515-0f0e-73d4-72eb-3a2a2fbf04e9@embeddedor.com>
 <20180307230136.GB20370@piout.net>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <b41ed6bc-7f8b-031c-84a8-ec857b165ca0@embeddedor.com>
Date: Wed, 7 Mar 2018 17:09:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307230136.GB20370@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.24.133
X-Source-L: No
X-Exim-ID: 1etiBY-001F3W-Vp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-24-133.static.axtel.net ([192.168.3.98]) [187.162.24.133]:20646
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2018 05:01 PM, Alexandre Belloni wrote:
> On 07/03/2018 at 16:39:51 -0600, Gustavo A. R. Silva wrote:
>> Hi Alexandre,
>>
>> On 03/07/2018 03:25 PM, Alexandre Belloni wrote:
>>> On 07/03/2018 at 14:11:33 -0600, Gustavo A. R. Silva wrote:
>>>> In preparation to enabling -Wvla, remove VLA and replace it
>>>> with a fixed-length array instead.
>>>>
>>> You should probably explain what VLA is and why this is important to do.
>> Sure. I can elaborate a little bit more.
>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>> ---
>>>>    drivers/rtc/rtc-bq32k.c  | 2 +-
>>>>    drivers/rtc/rtc-mcp795.c | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
>>>> index e8698e9..e4b234a 100644
>>>> --- a/drivers/rtc/rtc-bq32k.c
>>>> +++ b/drivers/rtc/rtc-bq32k.c
>>>> @@ -74,7 +74,7 @@ static int bq32k_read(struct device *dev, void *data, uint8_t off, uint8_t len)
>>>>    static int bq32k_write(struct device *dev, void *data, uint8_t off, uint8_t len)
>>>>    {
>>>>    	struct i2c_client *client = to_i2c_client(dev);
>>>> -	uint8_t buffer[len + 1];
>>>> +	uint8_t buffer[256];
>>> You chose to change len to 255, probably because this is a uint8_t but
>> Correct.
>>
>>> this is way too much for this rtc, it only has 10 consecutive registers.
>> In that case probably the best solution is to add the following line to the
>> module:
>>
>> #define MAX_LEN 10
>>
>> and update the rest of the code as follows:
>>
>> uint8_t buffer[MAX_LEN + 1];
>>
> Seems better, yes.
>
>>>>    	buffer[0] = off;
>>>>    	memcpy(&buffer[1], data, len);
>>>> diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
>>>> index 79e24ea..00e11c1 100644
>>>> --- a/drivers/rtc/rtc-mcp795.c
>>>> +++ b/drivers/rtc/rtc-mcp795.c
>>>> @@ -82,7 +82,7 @@ static int mcp795_rtcc_write(struct device *dev, u8 addr, u8 *data, u8 count)
>>>>    {
>>>>    	struct spi_device *spi = to_spi_device(dev);
>>>>    	int ret;
>>>> -	u8 tx[2 + count];
>>>> +	u8 tx[257];
>> For this particular case it seems to me that the following works just fine:
>>
>> #define MAX_COUNT 7
>>
>> u8 tx[MAX_COUNT + 2];
>>
>> What do you think?
>>
> Nope, that RTC has a section of 255 bytes that could be read at once so
> 257 is the correct value.
>

I see...

I was looking into this piece of code drivers/rtc/rtc-mcp795.c:302:

         tmp[0] = (tmp[0] & 0x80) | bin2bcd(alm->time.tm_sec);
         tmp[1] = (tmp[1] & 0x80) | bin2bcd(alm->time.tm_min);
         tmp[2] = (tmp[2] & 0xE0) | bin2bcd(alm->time.tm_hour);
         tmp[3] = (tmp[3] & 0x80) | bin2bcd(alm->time.tm_wday + 1);
         /* set alarm match: seconds, minutes, hour, day, date and month */
         tmp[3] |= (MCP795_ALM0C2_BIT | MCP795_ALM0C1_BIT | 
MCP795_ALM0C0_BIT);
         tmp[4] = (tmp[4] & 0xC0) | bin2bcd(alm->time.tm_mday);
         tmp[5] = (tmp[5] & 0xE0) | bin2bcd(alm->time.tm_mon + 1);

         ret = mcp795_rtcc_write(dev, MCP795_REG_ALM0_SECONDS, tmp, 
sizeof(tmp));


OK. I'll work on v2 of this patch. I'll send it shortly.

Thanks
--
Gustavo

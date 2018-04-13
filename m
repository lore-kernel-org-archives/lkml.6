Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeDMJrI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:47:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47607 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753254AbeDMJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:47:06 -0400
Subject: Re: [PATCH v2 1/2] dmaengine: stm32-mdma: align TLEN and buffer
 length on burst
To: Robin Murphy <robin.murphy@arm.com>, Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-2-git-send-email-pierre-yves.mordret@st.com>
 <9a2a267c-2b0b-0d6a-c762-47e7d37f84ea@arm.com>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <22bd0af7-9820-57c5-9215-8185839d7d27@st.com>
Date: Fri, 13 Apr 2018 11:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9a2a267c-2b0b-0d6a-c762-47e7d37f84ea@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin

On 04/11/2018 05:14 PM, Robin Murphy wrote:
> On 11/04/18 15:44, Pierre-Yves MORDRET wrote:
>> Both buffer Transfer Length (TLEN if any) and transfer size have to be
>> aligned on burst size (burst beats*bus width).
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>    Version history:
>>      v1:
>>         * Initial
>>      v2:
>> ---
>> ---
>>   drivers/dma/stm32-mdma.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
>> index daa1602..fbcffa2 100644
>> --- a/drivers/dma/stm32-mdma.c
>> +++ b/drivers/dma/stm32-mdma.c
>> @@ -413,7 +413,7 @@ static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
>>   	u32 best_burst = max_burst;
>>   	u32 burst_len = best_burst * width;
>>   
>> -	while ((burst_len > 0) && (tlen % burst_len)) {
>> +	while ((burst_len > 0) && (((tlen | buf_len) & (burst_len - 1)) != 0)) {
>>   		best_burst = best_burst >> 1;
>>   		burst_len = best_burst * width;
>>   	}
> 
> FWIW, doesn't that whole loop come down to just:
> 
> 	burst_len = min(ffs(tlen | buf_len), max_burst * width);

No sure it ends as expected. or I miss something or don't understand this statement
I tried with "relevant value" : i.e. best_burst = 32, Tlen=128(default) and
buf_len = 64, width= 4. This statements gets me something wrong output => 7
instead of 16 * 4.
I doubt :)

> 
> ?
> 
> Robin.
> 

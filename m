Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D7C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfAIRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:43:14 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.111]:29662 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbfAIRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:43:14 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 153D9DB547
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 11:43:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hHsjgYgjZ4FKphHsjg01Ag; Wed, 09 Jan 2019 11:43:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=53380 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghHsj-003wIM-28; Wed, 09 Jan 2019 11:43:09 -0600
Subject: Re: [PATCH] dmaengine: st_fdma: use struct_size() in kzalloc()
To:     Patrice CHOTARD <patrice.chotard@st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190104184322.GA9615@embeddedor>
 <d5817730-980d-0295-d4fb-43bd34b89e7e@st.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e9895775-f1d6-cc64-6df9-f6b75cc2bb5c@embeddedor.com>
Date:   Wed, 9 Jan 2019 11:43:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d5817730-980d-0295-d4fb-43bd34b89e7e@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghHsj-003wIM-28
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:53380
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 2:50 AM, Patrice CHOTARD wrote:
> Hi Gustavo
> 
> On 1/4/19 7:43 PM, Gustavo A. R. Silva wrote:
>> One of the more common cases of allocation size calculations is finding the
>> size of a structure that has a zero-sized array at the end, along with memory
>> for some number of elements for that array. For example:
>>

[..]

>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/dma/st_fdma.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
>> index 07c20aa2e955..df6b73028ecb 100644
>> --- a/drivers/dma/st_fdma.c
>> +++ b/drivers/dma/st_fdma.c
>> @@ -243,8 +243,7 @@ static struct st_fdma_desc *st_fdma_alloc_desc(struct st_fdma_chan *fchan,
>>   	struct st_fdma_desc *fdesc;
>>   	int i;
>>   
>> -	fdesc = kzalloc(sizeof(*fdesc) +
>> -			sizeof(struct st_fdma_sw_node) * sg_len, GFP_NOWAIT);
>> +	fdesc = kzalloc(struct_size(fdesc, node, sg_len), GFP_NOWAIT);
>>   	if (!fdesc)
>>   		return NULL;
>>   
>>
> 
> 
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> 

Thanks, Patrice.

--
Gustavo

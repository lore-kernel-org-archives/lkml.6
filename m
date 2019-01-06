Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94C6C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844432070C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAFUeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 15:34:00 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.104]:15012 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbfAFUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 15:34:00 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 34E8C2FD7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 14:33:59 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gF7PgJfRq2PzOgF7PgyqtO; Sun, 06 Jan 2019 14:33:59 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=58960 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ggF7O-002pd3-R8; Sun, 06 Jan 2019 14:33:58 -0600
Subject: Re: [PATCH] dmaengine: fsl-edma: use struct_size() in kzalloc()
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190104212545.GA16927@embeddedor>
 <20190106194059.GA2120@jerusalem>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ea4226b9-2bdc-1125-29e0-ea9158898283@embeddedor.com>
Date:   Sun, 6 Jan 2019 14:33:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190106194059.GA2120@jerusalem>
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
X-Exim-ID: 1ggF7O-002pd3-R8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:58960
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/19 1:40 PM, Angelo Dureghello wrote:
> On Fri, Jan 04, 2019 at 03:25:45PM -0600, Gustavo A. R. Silva wrote:
>> One of the more common cases of allocation size calculations is finding the
>> size of a structure that has a zero-sized array at the end, along with memory
>> for some number of elements for that array. For example:
>>
>> struct foo {
>>      int stuff;
>>      void *entry[];
>> };
>>
>> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can now
>> use the new struct_size() helper:
>>
>> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/dma/fsl-edma-common.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>> index 8876c4c1bb2c..fe529100674f 100644
>> --- a/drivers/dma/fsl-edma-common.c
>> +++ b/drivers/dma/fsl-edma-common.c
>> @@ -339,9 +339,7 @@ static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
>>   	struct fsl_edma_desc *fsl_desc;
>>   	int i;
>>   
>> -	fsl_desc = kzalloc(sizeof(*fsl_desc) +
>> -			   sizeof(struct fsl_edma_sw_tcd) *
>> -			   sg_len, GFP_NOWAIT);
>> +	fsl_desc = kzalloc(struct_size(fsl_desc, tcd, sg_len), GFP_NOWAIT);
>>   	if (!fsl_desc)
>>   		return NULL;
>>
> 
> Tested-by: Angelo Dureghello <angelo@sysam.it>
> 

Thanks, Angelo.

--
Gustavo

Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28730C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6521B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392057AbfBOJJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:09:30 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56042 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726986AbfBOJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:09:29 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1F91vIP022581;
        Fri, 15 Feb 2019 10:09:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmwsurrqb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 15 Feb 2019 10:09:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B1C038;
        Fri, 15 Feb 2019 09:09:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DAF0F2A55;
        Fri, 15 Feb 2019 09:09:15 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Feb
 2019 10:09:15 +0100
Subject: Re: [net-next] net: stmmac: handle endianness in dwmac4_get_timestamp
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1550165176-10099-1-git-send-email-alexandre.torgue@st.com>
 <59a381e6-02eb-3c97-bc63-5a8f511a1901@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a60a1a29-5f68-9573-1fde-35b7e721c964@st.com>
Date:   Fri, 15 Feb 2019 10:09:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <59a381e6-02eb-3c97-bc63-5a8f511a1901@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/19 7:09 PM, Florian Fainelli wrote:
> On 2/14/19 9:26 AM, Alexandre Torgue wrote:
>> GMAC IP is little-endian and used on several kind of CPU (big or little
>> endian). Main callbacks functions of the stmmac drivers take care about
>> it. It was not the case for dwmac4_get_timestamp function.
> 
> This is clearly a bugfix, so you should be targeting the 'net' tree and
> provide a Fixes: tag so this can be backported to relevant stable kernels.
> 

Ok Florian, I just have to find the right commit to fix :)

>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> index 20299f6..736e296 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> @@ -241,15 +241,18 @@ static inline void dwmac4_get_timestamp(void *desc, u32 ats, u64 *ts)
>>   static int dwmac4_rx_check_timestamp(void *desc)
>>   {
>>   	struct dma_desc *p = (struct dma_desc *)desc;
>> +	unsigned int rdes0 = le32_to_cpu(p->des0);
>> +	unsigned int rdes1 = le32_to_cpu(p->des1);
>> +	unsigned int rdes3 = le32_to_cpu(p->des3);
>>   	u32 own, ctxt;
>>   	int ret = 1;
>>   
>> -	own = p->des3 & RDES3_OWN;
>> -	ctxt = ((p->des3 & RDES3_CONTEXT_DESCRIPTOR)
>> +	own = rdes3 & RDES3_OWN;
>> +	ctxt = ((rdes3 & RDES3_CONTEXT_DESCRIPTOR)
>>   		>> RDES3_CONTEXT_DESCRIPTOR_SHIFT);
>>   
>>   	if (likely(!own && ctxt)) {
>> -		if ((p->des0 == 0xffffffff) && (p->des1 == 0xffffffff))
>> +		if ((rdes0 == 0xffffffff) && (rdes1 == 0xffffffff))
>>   			/* Corrupted value */
>>   			ret = -EINVAL;
>>   		else
>>
> 
> 

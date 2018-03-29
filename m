Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeC2O5Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:57:24 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54029 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeC2O5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:57:22 -0400
Subject: Re: [net-next,v2,01/10] soc: ti: K2G: enhancement to support QMSS in
 NSS
To: Grygorii Strashko <grygorii.strashko@ti.com>, <robh+dt@kernel.org>,
        <ssantosh@kernel.org>, <malat@debian.org>, <w-kwok2@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>
CC: <mark.rutland@arm.com>
References: <1522168309-12338-2-git-send-email-m-karicheri2@ti.com>
 <1ccf03e7-17b4-cf00-176d-0e41038c88f8@ti.com>
From: Murali Karicheri <m-karicheri2@ti.com>
Organization: Texas Instruments
Message-ID: <feb354cc-2556-c82c-6061-bea6ee819ed5@ti.com>
Date: Thu, 29 Mar 2018 10:59:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1ccf03e7-17b4-cf00-176d-0e41038c88f8@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2018 03:01 PM, Grygorii Strashko wrote:
> Hi Murali,
> 

>>   
>> +enum qmss_version {
>> +	QMSS,
>> +	QMSS_LITE,
> 
> QMSS_66AK2G
> 

OK.

>> +};
>> +
>>   struct knav_device {
>>   	struct device				*dev;
>>   	unsigned				base_id;
>> @@ -305,6 +310,7 @@ struct knav_device {
>>   	struct list_head			pools;
>>   	struct list_head			pdsps;
>>   	struct list_head			qmgrs;
>> +	enum qmss_version			version;
>>   };
>>   
> 
> [...]
> 
>>   }
>>   
>> +/* Match table for of_platform binding */
>> +static const struct of_device_id keystone_qmss_of_match[] = {
>> +	{
>> +		.compatible = "ti,keystone-navigator-qmss",
> 
> 		.data	= (void *)QMSS,

This seems to be unnecessary as QMSS is actually defined as zero. Also 
this static. So that value is zero already in memory.
> 
>> +	},
>> +	{
>> +		.compatible = "ti,keystone-navigator-qmss-l",
>> +		.data	= (void *)QMSS_LITE,
>> +	},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
>> +
>>   static int knav_queue_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *node = pdev->dev.of_node;
>>   	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
>> +	const struct of_device_id *match;
>>   	struct device *dev = &pdev->dev;
>>   	u32 temp[2];
>>   	int ret;
>> @@ -1700,6 +1749,10 @@ static int knav_queue_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	}
>>   
>> +	match = of_match_device(of_match_ptr(keystone_qmss_of_match), dev);
>> +	if (match && match->data)
>> +		kdev->version = QMSS_LITE;
> 
> 	if (match)
> 		kdev->version = match->data;
> 	else
> 		error?

Similar to above. This private memory is allocated using kzalloc which initializes
everything to zero. So the else part is unnecessary.

Murali

> [...]
> 


-- 
Murali Karicheri
Linux Kernel, Keystone

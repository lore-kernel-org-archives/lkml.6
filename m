Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCNTxV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:53:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751289AbeCNTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:53:19 -0400
Subject: Re: [PATCH 2/2] watchdog: aspeed: Allow configuring for alternate
 boot
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, wim@linux-watchdog.org,
        Milton Miller <miltonm@us.ibm.com>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520632700-25800-3-git-send-email-eajames@linux.vnet.ibm.com>
 <20180309220610.GB32606@roeck-us.net>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 14:53:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309220610.GB32606@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031419-0004-0000-0000-000013CD68A8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003054; UDB=6.00510441; IPR=6.00782384;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 19:53:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031419-0005-0000-0000-00008676D904
Message-Id: <bab2d3b4-536c-5dcb-4a13-95a29560d416@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2018 04:06 PM, Guenter Roeck wrote:
> On Fri, Mar 09, 2018 at 03:58:20PM -0600, Eddie James wrote:
>> From: Milton Miller <miltonm@us.ibm.com>
>>
>> Allow the device tree to specify a watchdog to fallover to
>> the alternate boot source.
>>
>> The aspeeed watchdog can set a latch directing flash chip select 0 to
>> chip select 1, allowing boot from an alternate media if the watchdog
>> is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
>> while on the ast2500 the chip selects are swapped.
>>
>> Signed-off-by: Milton Miller <miltonm@us.ibm.com>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> This is already documented in the bindings document, so the property
> should be ok.
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks. On a related note, our system has need of a way to determine if 
it's currently booted from the alternate chip or not. It seems the only 
way to tell is to look at the ast2400/2500 watchdog timeout status 
register. We can add some debugfs to the aspeed driver I guess, but I 
wonder if this is a common enough situation that the watchdog core could 
use some debugfs or sysfs for providing that info?

Thanks,
Eddie

>
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>> index d1987d6..f41d246 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -46,6 +46,7 @@ struct aspeed_wdt_config {
>>   #define WDT_RELOAD_VALUE	0x04
>>   #define WDT_RESTART		0x08
>>   #define WDT_CTRL		0x0C
>> +#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
>>   #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
>>   #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
>>   #define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
>> @@ -245,6 +246,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   	}
>>   	if (of_property_read_bool(np, "aspeed,external-signal"))
>>   		wdt->ctrl |= WDT_CTRL_WDT_EXT;
>> +	if (of_property_read_bool(np, "aspeed,alt-boot"))
>> +		wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
>>   
>>   	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>>   		/*
>> -- 
>> 1.8.3.1
>>

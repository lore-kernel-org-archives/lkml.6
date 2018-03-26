Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeCZWIX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:08:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751805AbeCZWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:08:22 -0400
Subject: Re: [PATCH] aspeed: watchdog: Add status function
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wim@linux-watchdog.org, joel@jms.id.au,
        openbmc@lists.ozlabs.org
References: <1522099028-20347-1-git-send-email-eajames@linux.vnet.ibm.com>
 <eeaa2de8-937d-4371-1b32-931b3221f6ce@roeck-us.net>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 17:08:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <eeaa2de8-937d-4371-1b32-931b3221f6ce@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18032622-0056-0000-0000-000004332D5F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008749; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01008851; UDB=6.00513873; IPR=6.00788133;
 MB=3.00020256; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-26 22:08:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032622-0057-0000-0000-000008753943
Message-Id: <e3870f44-fa97-bd2d-8871-732cf68dc147@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803260221
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/26/2018 05:00 PM, Guenter Roeck wrote:
> On 03/26/2018 02:17 PM, Eddie James wrote:
>> Populate the status watchdog operation to return the "timeout status"
>> register of the ASPEED watchdog.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c 
>> b/drivers/watchdog/aspeed_wdt.c
>> index a5b8eb2..d6dd5c9 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -55,6 +55,7 @@ struct aspeed_wdt_config {
>>   #define   WDT_CTRL_WDT_INTR        BIT(2)
>>   #define   WDT_CTRL_RESET_SYSTEM        BIT(1)
>>   #define   WDT_CTRL_ENABLE        BIT(0)
>> +#define WDT_TIMEOUT_STATUS    0x10
>>     /*
>>    * WDT_RESET_WIDTH controls the characteristics of the external 
>> pulse (if
>> @@ -138,6 +139,13 @@ static int aspeed_wdt_ping(struct 
>> watchdog_device *wdd)
>>       return 0;
>>   }
>>   +static unsigned int aspeed_wdt_status(struct watchdog_device *wdd)
>> +{
>> +    struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>> +
>> +    return readl(wdt->base + WDT_TIMEOUT_STATUS);
>> +}
>
> Does the register report WDIOF_* status flags/bits as defined in the 
> API ?
> This seems more than unlikely.

Ah, I see I'm misusing the API. It does not... I will rework.

Thanks,
Eddie

>
> Guenter
>
>> +
>>   static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>>                     unsigned int timeout)
>>   {
>> @@ -171,6 +179,7 @@ static int aspeed_wdt_restart(struct 
>> watchdog_device *wdd,
>>       .start        = aspeed_wdt_start,
>>       .stop        = aspeed_wdt_stop,
>>       .ping        = aspeed_wdt_ping,
>> +    .status        = aspeed_wdt_status,
>>       .set_timeout    = aspeed_wdt_set_timeout,
>>       .restart    = aspeed_wdt_restart,
>>       .owner        = THIS_MODULE,
>>
>

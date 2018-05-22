Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeEVFZk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 01:25:40 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:13208
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751278AbeEVFZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 01:25:36 -0400
Subject: Re: [PATCH v3 4/6] ALSA: xen-front: Implement handling of shared
 buffers
To: Takashi Iwai <tiwai@suse.de>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20180514062742.25879-1-andr2000@gmail.com>
 <20180514062742.25879-5-andr2000@gmail.com> <s5ho9hi56ds.wl-tiwai@suse.de>
 <e37b5170-4fab-0c06-8902-730e57118ceb@gmail.com>
 <s5h8t8l5ufq.wl-tiwai@suse.de>
 <19a2c003-6730-265a-29aa-1eedd37147b9@epam.com>
 <s5ho9he94s7.wl-tiwai@suse.de> <s5hh8n03gd4.wl-tiwai@suse.de>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <5aaef4e5-3e9d-9170-f92d-382e4cf5ffba@epam.com>
Date: Tue, 22 May 2018 08:25:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5hh8n03gd4.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.52]
X-ClientProxiedBy: AM6PR0402CA0025.eurprd04.prod.outlook.com
 (2603:10a6:209::38) To AM0PR0302MB3204.eurprd03.prod.outlook.com
 (2603:10a6:208:9::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3204;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;3:62v79xVtDJJLXLo04ViKsfaERYoTRWM0OLoD72PjJgelghfpEfkBjnHsTc9LfzJyE3WldiPDNKXA0t0dIxCMMYKqwtaQSEjZtNwhGX1qVV5B2UPtSH2wiekODKDADF9D9RpYMmRIHmkDzcirrF3Pbvm0jX2NnTPMY1w5u1v4N6yEAIh+BvQFHPM2f64HusVZQiSpzZENjmHOLnQWUqKcVWqaWXvDXGajtxs8kuplnz1czIndJJmgVTJQDSoNg/yH;25:xvg8Bb4hBnCtyRs2zISeZCkd7K9JW2+XH5XGRQEJhaGwaIxch00VQb0H34aidS8ViFok/6C1yrxDlQaYF9zsU1HJeh0P82Kl67Lx/MqzGq8/Wc+TA+YSr4xw2dKOP2QBGVfieGOJqrvnKbtGlnDlXnfFW5+EeVwz2iP/TK2OO1ctt+LCdoCFOUkzOsrw1wpwU5A9MoRP1FFdixW6gIKmiLSdyABgoAOIW+f/zV0tNK8xDB8nJj0G6ct9Qlpio+Dy2LNNlWUlH+2+0bq2OgsBB8Yp0JO1ZtSFeHSM6KNsAk6gnizGlpAKK6ojiwwaW5PxJSu6ASVvSjWk36EZheSabQ==;31:MhZw8j6B0dbsJYe4KJBQyI6qfjCZPv/Mh0xDxMTLAZVgOew7kl10cGU0p6VvOON9ouzH+h9ymqgBntdDWOW8mL11vlo+d9/OA0v0VlJNfJhcB27BvvGIt0t1g3LDQjN1wumOjDIasDaXwUjwyyNe81kNmarSRYbeSYrdShCxPLepz7GZPgCTw9FmA6AsbdhODWTa0iOGA3EVJjCmwXxF/mlGS/xqOOel5Ro11WmIk0A=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3204:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;20:nA/SFGtXidk0E2bNFoKPhsyMR1XE80Hr1tn0TvkqtCRMzON9wq5KuebT//UJyIFLl+/M2xECKLST62xp0KN4+D2JZyoFVO2Yo6lj9qnq7USQgtYzYy8HSCusNA4VTHEt4xKYLxDEH1FylASSyQoEKBv5DA5PMO4OJUI8R20wDkYDJbke1mrgYvekL6+iin/mjSS8XZrYEcSkNjI6M8CCg8bGnmD1EuFs4UMRabdks1yRyn376ltFi4xgpokxK6dPhpddrgDVMzMhCsbzqVUWMckd/SNPOnoaT0Z7xHiPbjE1Soyuo0eBFKJ9Wmv7mleImYKaUwgqdvYSAX+orA30FDyfpQGdrVfBoOqecviTLjNBb5KHTLYApq8EG67NK0e3ZXFttutGHp81f8ELMX0i7BOZJd40VIUqCI2IsOS38HqK92++pSbv/C72YvKTqHUoH0iCQrSCpVBBIaD5uXZxA2HpKL9ydHtPtAA36/s8AdniBfHUj7zeM43u2j+Y1w8i;4:MfOGo0IiZ28Svi7SG3KghDT+USMLaPOI0/hjTp+LbHwgENcO5W7DDmPhovLf0s/7cxRCWwHT1JJ6FyXQqObqOp5muEaoew8FC0ecVEQHp/Ws3d4V186WNfgEo+i6l0USYYMsftdls3GwVSGrOfyQn+sZDkNY36RisXbDkNRavM514QzdE574XORptw/uim8+kuNP3vivbidRNzB2A9uwO3Ey8EFMCCgPYiSUk/rmZ8ytTt0tTnP8LGgPqPOVdmA2eD3CxGhBmtEF4mM76A1F0U1aiE6+2g01SzXipRlyTlPMRIHAlKsj6eQjJMFDi2/I
X-Microsoft-Antispam-PRVS: <AM0PR0302MB320437355BE48DF3A76FED2AE7940@AM0PR0302MB3204.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3204;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3204;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(189003)(199004)(36756003)(31686004)(446003)(80792005)(386003)(2906002)(97736004)(23676004)(53936002)(76176011)(316002)(229853002)(77096007)(2870700001)(81156014)(6116002)(86362001)(6246003)(8676002)(26005)(81166006)(31696002)(55236004)(106356001)(486006)(47776003)(2486003)(52146003)(16576012)(52116002)(54906003)(11346002)(53546011)(65956001)(105586002)(3846002)(64126003)(66066001)(65806001)(476003)(478600001)(956004)(58126008)(2616005)(39060400002)(50466002)(6486002)(5660300001)(72206003)(6666003)(4326008)(68736007)(6916009)(67846002)(25786009)(8936002)(7736002)(16526019)(305945005)(186003)(65826007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3204;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDQ7MjM6anREa0pUWXI3MFBiWTE4czBKOWJYOU9v?=
 =?utf-8?B?TWxXb3p5ZS9CZVJ0WDdpbDNvYklQOE5LSnpaM0p6S3R2cGQ2TDZlSytXVzBy?=
 =?utf-8?B?NlpwQzRzc0dEQlhEM1ZDQTlvUXhSRmtQRStFdGdBam1veitqWm9sY2FuRjdQ?=
 =?utf-8?B?QTlwb2pvdnBEOUN5L3g1S0VhSTU4My9TMDhlV0JrVURuVHpNL1AyMTFhOTRV?=
 =?utf-8?B?Y3UrcG1SVzFlLzV5UHQvcWhZUkxjTThRNmh4N2xCUSs0enVjd2RNbG5CWnJw?=
 =?utf-8?B?cVlLa2JmNDAybHNqMDBHNCt5WTV2Vm05R0pkSkRPRXBmRlFTdXNycWJ2T0Fj?=
 =?utf-8?B?RWxOemVnRzJOWlZ2M3lmNWJWRXd4aEZUV3JRMlZhL0cxRHV3cmV5d0hYT3Fk?=
 =?utf-8?B?UVJ4M2wwRzFKTERHTHZYUng1cHhBYmYyc1RTaUNrdEZFUC9NN1JBcUNGWkxC?=
 =?utf-8?B?ME0wMjBEMU5iVTRjbEY2aXIyV0lCNnVGd1FXTmJLRHBHUUFyWldickd5azFi?=
 =?utf-8?B?KzE4TzZwQ2dDV3VtNnZYY2w3dUdGM3JVZnpUVlNWaENxOEU4V0ZBNzM0R0tN?=
 =?utf-8?B?czU0VVRMWjlaM1JGMFR1UFlsVi96MlRqVnh2aDZ3L0VHOVAxczdDUVRMM2k3?=
 =?utf-8?B?Vk40bEJ3QTE0MWFxWE9Lb2FCUmF4VURJMDlhcmtNMHpqTk1ES09pRWkvcnI3?=
 =?utf-8?B?SVQrUHlxaHk1UWZ3ZmZSNzY4L283N0tXNm91TEc2OWhXb0RCWXRDSHJxdzhS?=
 =?utf-8?B?elZvaFJwYThGU2IybWlPOG5WOGdBZG14V2lNQzRkOXkvRW8xd3BnZlc3ODZx?=
 =?utf-8?B?MmNKVys5cXpRTzloWkMrWWVSNnRCTnZrT1RDakRPcTZSWUQrb1NibHFRVTJE?=
 =?utf-8?B?UTFSNmRlYXYzOGU4eGE5RVlrQ3NVeEVuWUNmWThWUEJwTXBXU3AyVldiWFFo?=
 =?utf-8?B?M3gyekZCRCtDYXY4MGNjdjdOMDJlS0FVaU9HWi8rZW9Mbm8vS1VSVnZhRS9v?=
 =?utf-8?B?RkYrek5rQW9CWkltZ0dPM2NEdWdQT0FsWDd4b2sweHdvalZuS2VadVo4VTdq?=
 =?utf-8?B?MWdMTW40TlB5d3EzenZ5cU0rRWIzQXBNTm8xaUdxZUZxVU90aVBNbnhWR2Fw?=
 =?utf-8?B?eFU5dmVYVStyWVdHb3JHa0lCU1c5YTRhOHJTNHZUaHo2aXFvSVRyZ212U29H?=
 =?utf-8?B?ODhHMk9Qay9NdDBzUTIxemEzV3RDS0U1SWNFQjhjZFY3bDV6WDlRMFZFMHAw?=
 =?utf-8?B?cU5GS0RCVzR1dmw2a1E1VTlTa0tQWExTb09ocnBXelMzSHNsSlNlL3Y2S2s2?=
 =?utf-8?B?NHptK1RjZVI5TGN6aEZHOTdrRElMdXVsZEpFODA2YlhpVEU1RXJDUkV1K0U5?=
 =?utf-8?B?L04ydUJaa2JiZ3RJZDR2c294ZUJOZmhXR3k3OVpMbUJiTzJxVmJqR0VCUDFQ?=
 =?utf-8?B?S0MyVS9pUEhIWUsrek1ab0FBOHg5S09vZ1ZubHArWkZhRkVLRFpYV012b3Ry?=
 =?utf-8?B?emlWRExPN0txakY3d3A2alZibjVQbXozbVhWYVl4WkhybXNwODNRendvdVZX?=
 =?utf-8?B?TmVubGNqTzJKR0ZkcjhDSWFiNkFkdmp5aXFUMGY2ZGI0Smo5NEFJNkg3eCsr?=
 =?utf-8?B?bEx0MUFocG1jV0VSa29TWXBrNSs2Zkc1QTVCMWk3S1BmZFRKUlVWUGhieDVB?=
 =?utf-8?B?ME9EUjNkOVE4bUlOL1MvRFZ5M2s0QVBBNCtPVTA4TlBvNE4zU25ROTlHT05S?=
 =?utf-8?B?dGFBMVl4UHhvYVdMbnAvY0ZwdmtQcHorcTRGcCs0cml3L0hWekNMS05xWGhl?=
 =?utf-8?B?RG1YdlI1cXZ5aE5nWElDUEROYlYzSkRmSHZxTDF1Y3RiRG16WU9ZK3lFekVH?=
 =?utf-8?B?MG05RWhHS1N2TDkra01KNUhuU2NJTkpWUjd1dXdaTUlMY0FXZXdzNUx0NkdV?=
 =?utf-8?B?Vk1WRjQvb3FhNEFnZks2NkxwSVBzVThQMkUybUhzc2JROFV5VC92SmVIVHdR?=
 =?utf-8?B?bnAyM3FqRGJKU0NRODF4WFFEVHJPbkJtT1ZCcWdrR1ZaRlBRVlhOZTZTanBC?=
 =?utf-8?B?bFBZdVJGenh6aGg1amU2OHlmT2IzdHRxTVp3U2J5VHZxQnNaQjcvQ2hNRFpH?=
 =?utf-8?Q?P5pQWqYts0hBzgeOd8PWCd3mY=3D?=
X-Microsoft-Antispam-Message-Info: 0PsdoGOXo5a1j1M//RievdzQA3i1eI7VS11lhbZ9Ym9wEcr3sGZbpFTykgJSxeVlHRC6TFnaNeU11JzHrqLSfHgpthGq/IqXra1Vbbq7JlRG7VbJDv7eve4znNXzlQvwfLHk5PqKwuUtcIruTFR5/aWF4P3VweOzio1mOgfB/jJzEWYBgq63SEN3Wy+p5/bI
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;6:mBCOTMU8BSoBcakfoKXYaOrba+hrvlTJ9oYMdrBIS63v3YCtnJikEnswCFvo2w5AFvk5ezIJrJ99TjWS+h2xXJ3UJqBV4E9I85X1riaWgsSLIGa35k0KkyZn42iOZ3CF6S2atqMyQvXriwnZjU/DDqN0ylE5bk9x7RmT0oX2gi8IaObg/s0C0LWtw6b+1TWARrbFjTVoo4qCgSL+LFW9BACOPBcpIdrsXetRCpnXQy8mBh8VV6LLSexHcGDX0ZNvlLIOXezZUWnsIvCHH+jxrQX8dWF18rkcVkkK97ZI44eeIBdtvJCP1MRC7WCsPF0eFizPVhY9PyNc3B7G9UXM852kFR586RyUAlnrPlg6XZJMBi/2Sn01w8tMrZHBPm6zJHs1bzNb+Qcnj/cB5ARMCq0RkGnszszZztX9Aj5lu5zBxLHT/1Ww9OiCzOq+VrsbJjW2VNbX1EfYRFGsppS5rQ==;5:Owi+d9+4IV7y9holATOzX3oxoZksTpMIL9vthki4oQLkLInTzi43zLdDhvdfdSeWZiu1jmnEzsjt2oEkYNFXoKIozgt0/OoIMBfl7RPidA/lz9tOqBrPjBYGS8RjqKYHk6XLgDLXJTvanN+vzEpJ48EUHRHpN4ppo3xwZojFDsk=;24:4z39k+fBh1ofs9Q4X8gyftaUeqCY6F4U57lTfUyMm6/j+AWLH7mDBvjuioMPKtp2+aboebx8gTpHo75VC4lAk7LhRwVYkNFrPJxMBNUrR54=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;7:NaRa4TmnZQu1UW9A8H95Fcn0k5Z0MOK4i4u+MuRL/uAY65dhydtHthL8d2cI5K3wAoK/rD/0eweGqgbDb2zzgA7etCg1OxzRxa95lXATuqjIN7L283IlOdwnWELUZTUmpMnbq1e35sIBZKTzm1GHrI47omwKe2+LzJJz79BbWqQgvQ2edXIw9Ku9KQin5/KH6M7KGoe+apyWhQpXr6hoWTRyvzaW/ui05dVZc9DbxmyOVchCJEdO/35o4e+ESjF4
X-MS-Office365-Filtering-Correlation-Id: d8ac2c70-7f4b-4a07-fdaa-08d5bfa47120
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 05:25:33.0853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ac2c70-7f4b-4a07-fdaa-08d5bfa47120
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 11:26 PM, Takashi Iwai wrote:
> On Thu, 17 May 2018 08:26:16 +0200,
> Takashi Iwai wrote:
>> On Tue, 15 May 2018 08:02:08 +0200,
>> Oleksandr Andrushchenko wrote:
>>> On 05/15/2018 09:01 AM, Takashi Iwai wrote:
>>>> On Tue, 15 May 2018 07:46:38 +0200,
>>>> Oleksandr Andrushchenko wrote:
>>>>> On 05/14/2018 11:28 PM, Takashi Iwai wrote:
>>>>>> On Mon, 14 May 2018 08:27:40 +0200,
>>>>>> Oleksandr Andrushchenko wrote:
>>>>>>> --- /dev/null
>>>>>>> +++ b/sound/xen/xen_snd_front_shbuf.c
>>>>>>> @@ -0,0 +1,193 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Xen para-virtual sound device
>>>>>>> + *
>>>>>>> + * Copyright (C) 2016-2018 EPAM Systems Inc.
>>>>>>> + *
>>>>>>> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <xen/xen.h>
>>>>>>> +#include <xen/xenbus.h>
>>>>>>> +
>>>>>>> +#include "xen_snd_front_shbuf.h"
>>>>>> Hm, with the local build test, I get the following error:
>>>>>>
>>>>>>      CC [M]  sound/xen/xen_snd_front_shbuf.o
>>>>>>      In file included from sound/xen/xen_snd_front_shbuf.c:11:0:
>>>>>>      ./include/xen/xen.h:18:8: error: unknown type name ‘bool’
>>>>>>       extern bool xen_pvh;
>>>>>>               ^~~~
>>>>>>       In file included from ./include/xen/interface/xen.h:30:0,
>>>>>>                        from ./include/xen/xen.h:29,
>>>>>>                        from sound/xen/xen_snd_front_shbuf.c:11:
>>>>>>      ./arch/x86/include/asm/xen/interface.h:92:21: error: unknown type name ‘uint64_t’
>>>>>>       DEFINE_GUEST_HANDLE(uint64_t);
>>>>>>                           ^
>>>>>> 			
>>>>>> Adding #include <linux/kernel.h> fixed the issue.
>>>>>>
>>>>>> Did you really test your patches with the latest Linus tree?
>>>>> My bad, it does build for ARM (which is my target), but also does
>>>>> need "#include <linux/kernel.h>" for x86 which I didn't build this time.
>>>>> Sorry about that.
>>>>>
>>>>> Do you want me to resend this single patch or you can make the change
>>>>> while applying?
>>>> Yes, it's fine.
>>> Thank you
>> FWIW, the patches are in topic/xen branch in sound.git tree, and I'll
>> keep boiling for a while to see if any issues are caught by 0day bot.
> ... and now the topic/xen branch got merged to for-next, targeted for
> 4.18.
>
> Thanks for your patient works!
>
>
> Takashi
Great news, thank you,
Oleksandr

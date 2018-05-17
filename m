Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeEQGdO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:33:14 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:49120
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751967AbeEQGdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:33:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
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
 <s5ho9he94s7.wl-tiwai@suse.de>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <847efda8-2b8e-fe71-454e-677566b7a825@epam.com>
Date: Thu, 17 May 2018 09:33:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5ho9he94s7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.52]
X-ClientProxiedBy: AM0PR06CA0065.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::42) To DB3PR0302MB3211.eurprd03.prod.outlook.com
 (2603:10a6:8:9::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;3:FAilgZJD2XWOYdktrHmHqKbC6KGCPh5iAUAaFN2nItE0s37BZkTBsq9pP9md4+NinWYRojwX0EllM2sBnJmUZBW4SwyPEWzmMtNUz6QeWDoxcT6ZuceCKrDgv9yH125AyiFLphuf+ww0vqrb87o9ddWCLChuS0Tc9+++FPHcvTx7jsTfU4RqbsGK47RaXr9OqqirPsfhVYKPrXckVNXSySDEszklDslWzuV95aWCm6XHwRKTQgCT5hp82iriW67Q;25:n34l4b4fNRJi1F+wFQfx3bq9OGnsjcCL3CiYajAqlU6G08cK+S3+wmW5PLvG9dTiJgssuHRwB0UoF/3TXWIfFF/BNUtZ4GSW3cU/3061jV5YTe/YkQgxi2pvuPzPEtPYZcpUrm2pujXSGDFXj8si60lz5PcbiBNQ3hYEYr53vX2/Yx3gtB+5Ivs3eI6vihgfawCnbWNfhRGTsuXog5g64C+LAYx/LVd1bulFpOnHfWSlSZLPOo1oGr1a74cKBGZEbOMq3HeyNt4H/yaBersamkgeatv/DQogBmCa+E932XgipPMJLUmmnNr32ww+XkxESNBVgkUKwciscQltYnS+AA==;31:Y+NEr22f2wwrDf3bbt1V+kdk0mDxXx85CVADLZ69MEb9WRBMMvQhUWXxfL9KJkCo7hRAXn1JUrCzb7NyJY5P/SZA6Yuguo1g7NsSi5ir3seqijcIWttdEmpI35c3olf+g0RvtzCSWkvvVXQZPgUR8slrMGjVPVigwzVku7YrGmtAqO1IY1sZ1jlzyd3HU9VXk6Gg+0TDPy/XDnI5++U9NUjmWOmDO9ZlxD3jEb4j92M=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3211:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;20:1C2UYtjd64mQgZmEucZw65JVWER6oMKYoLFXHHb5oYJy6dfEMjGcMBUdeu08FUCVwODHrAy6QAy6TKZBCcYOcOjHKixYLxz3xZr248JmhT/hBM1TtNVLh8YIFhnGnGHdKHhMQ+2CpZMv49syZ7k9OMgSezcOqA3cOBFB94MgXIkrrA/DtuWQuAXbgA6yTR2rgimZQRwJtFUQx7k0icZkl2Z0PoFLkq/yuguZrxpWYT6JSvaO1c+jvQphfAi37mMuf2szQqb96e//usuZ9sotZ9V2kgBb6tU8fCsbv7C+nrffPwLu5gwZjfsR+s9omHWwyv4yjq88ML/RMWvGUe/Yp/73HcG6VJbqUft39Nu3tI/YM9vHoImnjVmJvntkNyZrf6HVzV/KAAlV7ZqeZHFpD356dl6ihFeolsGA8/nFgi6aqCNa5XA8MO9i4KvSjOGsetZmvEmr1+awFrrGWxHgCvmYJ5b8xcMrZ9fQNz9UbOcLwGT6/tbjyeUNpbTXiZ8P;4:DWLazN824jPFeBYCY0mpCOE1Fy3SM/YQphepVRchrm85JsmFg6vYD/p7o6ooRvLXoEFH0RsID54RJxhVLzG3WrpqF+4B3RCxv5nEGqOlig0GRyR3dV32oVdNGacahPNaNo+uI4pXBkGtCj3K9YzB44HXgBt+CLyfvvDvIx8KLztocsBda1BAaC7bUVmoTjnumLZI+L1ysx3SXXWvlZl8CAm+G5QCnK/L3Ho4vrjskcUhC7mnlqEi6rmTyUGgKNmRcXHChSNbyIA1aJ2tHdXmhd69pn08rb6ezQoBRyswCNEVmhu9U3EwSHJCKTTfkZ3t
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3211C5F59015A31371657F83E7910@DB3PR0302MB3211.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3211;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3211;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(189003)(199004)(65826007)(11346002)(67846002)(2616005)(956004)(476003)(446003)(36756003)(68736007)(25786009)(316002)(16576012)(8936002)(58126008)(64126003)(6116002)(2486003)(3846002)(23676004)(55236004)(53546011)(50466002)(80792005)(52146003)(54906003)(93886005)(478600001)(76176011)(52116002)(97736004)(386003)(72206003)(31686004)(5660300001)(6666003)(6916009)(105586002)(106356001)(53936002)(486006)(39060400002)(31696002)(2870700001)(6486002)(65956001)(66066001)(65806001)(47776003)(229853002)(81166006)(2906002)(77096007)(4326008)(6246003)(7736002)(8676002)(81156014)(86362001)(305945005)(16526019)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3211;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTE7MjM6YUtLTjhyTWFFcDlBcng0azJDWnJaWmlp?=
 =?utf-8?B?N2VEZndnc2NSakk0c3JJQjhzaGI5TitORFZnZjFiTXlGcVRwYndnN2dKYllH?=
 =?utf-8?B?ZW5sMnluTWc0K1NzZXNhK2swNEs3SWFZRFY1Z2hUWnlONmdaM2RybXMvdFkz?=
 =?utf-8?B?SlhqRGQxS2RDTzdHY3cwcHZaU2dVQzQzcGdoQUROM3BUejRZSlZtWHZxNHlj?=
 =?utf-8?B?a2hUVnNlSldETVJrOUhrSDM3dFFkSG9rRitPVCtnSGgvVWJ2dGtFYUIyb3VT?=
 =?utf-8?B?WitsNzhMM09kVGRFQnF3NWhlcUw2aENCMUg5S1FWd1NhV3BQUkpxRVpHNjBC?=
 =?utf-8?B?dEZHbGt0N0FCWUFscGgzYVBpV3BNUDB1M2tCQUdGYTJ2MnNONkh1Z215UWxR?=
 =?utf-8?B?eUpsbjYyT29EM1NxQWNNVG1GZ2szdVUzeUkzY3lCSGpKRHdYMUJBU3crZk1m?=
 =?utf-8?B?dEZhcG5qMlh0ZDNMdisxRE9jYkpnMWhLdzRGWUdFcjFhOG92NGVUTjVWVit3?=
 =?utf-8?B?OGVVWFo5dkMzSnpOS0FFNFN6VUJOcTNPR1dRMFhnTEZzclFCYktGNEVMQkNs?=
 =?utf-8?B?NUMxN0RNTG9BSUkrclEvclZBVmV3bVJNZlhxUVRiUWp3Y1BEQ1BBY3hiTDFQ?=
 =?utf-8?B?aHk0dGNVaE9PMjZzTHR4YWgrc1pJMVFlQml6cW4zcDU5UStaNitaT3VXaG94?=
 =?utf-8?B?RkpXR2hWZks2bFBHVE9xZC9yaERtM2ZnUHVoM0puVW1wa2hmb05IU2N1cUxJ?=
 =?utf-8?B?ejl2bzJCSmpqallwTFI2aVdjb1NDY0hoUTlrK2ZtOVNlVVRwNTYwNkFTWUhu?=
 =?utf-8?B?V2dVNXJKVHE1aldsdXpnU3NJQUpaOG80RjZWeVp4R1ZDWFdxYkpTaGNOYjl1?=
 =?utf-8?B?alhFajgrZE83RDN4bDFuYUJHcDY3NzZVSW9hTDdvZkNpL2lKRHg3UTNLSUIv?=
 =?utf-8?B?QTlKYkdVS21yZ1JpRDY2aUhiQTZ2NUR3SlRNY3lPMGpxSFcxaFQ5QjNXeEs0?=
 =?utf-8?B?QngweWtOZUtsWklkU0dGbUtDbGxYZHlPVVo2UDJHcVhlc2ZUUEJHU3J1eHhw?=
 =?utf-8?B?bnljSDQ4d1VDU3ZvcDVKTGV0MXRHdkpGZHFjdjhmQldKdnEyZUtFZFc1TEh4?=
 =?utf-8?B?aG4rQXZNRUdlSjlldS9pYVpzVzJVM2RBb0xmcGVpZG12Q2xmeTAwQU80Mmpk?=
 =?utf-8?B?dkQvUHUyVjNPdzRqQ2cwaC9FQk1naXY2dkJRNjRiU0NiNEo1MFVNcmxpbEZu?=
 =?utf-8?B?OEc4ZHpMd3N5VG1mT3VMVEtvNEtWL2RRc0hlYzVyekp4WStIUUN6NmdyeXY0?=
 =?utf-8?B?OTFCSFFtSXZwOHFFT3VKRkp3dzFaRUI0VFdXYWI0cXFyKzFJb2QycjdDbWxZ?=
 =?utf-8?B?akhMYklYeGpmVkduTnpEa2pWVCtyN0xUS1lGTEF5bHMvL21jZGNlRFdhT2lz?=
 =?utf-8?B?OE1TZ2tjR2VRM0ovaHVVR1lmLzhKTVptaG5ib3E1cUtNOVN6N0QxWit0cWZP?=
 =?utf-8?B?MXlORFVGZzR0YlJYZmR5WFJBNDgvTDNjdmhTNUR2TDVKWno5OU5iN21XT1Nj?=
 =?utf-8?B?a21nTnZMUDl0Z256TVJOSjFkamRTVDZmeU0vN3AvbkRaU2xKSXI4bWRsSHJv?=
 =?utf-8?B?RFRFSXo1R0NUSjVPWEFaTlYxb0RTMmJXbG1ZOFdKdjA2Mm9YOTZOblg1Z3dx?=
 =?utf-8?B?WTRaQUlIT0NvN05QZmVCck5pcWx6cmdpY3RPMlV2a3pHRVEwNkhMRWNkNU1i?=
 =?utf-8?B?N3h2Y2FvQ2FhMjZpL2x3SytiUlk4SGQ2dnFTbUhiT25JVXRIRFQ5OS84NnVz?=
 =?utf-8?B?a1VSSEZqQmdUU0hseDBNM2V5ZG5waWdnNmdEaTFoTWhQRzJOK25HYVRsVHV0?=
 =?utf-8?B?RS9FV2plQ0NlMEk2YUlkbldPQ3dGcVhEaDc5ZTlBVGZsS0xrSTMwa1BCUUF3?=
 =?utf-8?B?OEh3QVd0aU9EZUhIVVRSMTh3S29YTUNQczBzUGh4Tm81dTNjTDd3aVNlMENa?=
 =?utf-8?B?VGdqcU1RSTNIcXVLc1BBT29TczZBR242QktaOVB5a20zT3hGWmxQVGNYekFC?=
 =?utf-8?B?bG9uYXRqK2JBUHM1R2h0OE1WVWorOGlSeWdDbWNvcUx2N2JBaGdISk1PQ2lH?=
 =?utf-8?Q?nQnS0IGrxf3EwHl7Y9hpwW9G8=3D?=
X-Microsoft-Antispam-Message-Info: IkPBoucRS9WL0OsD/94vZuSYJNAwBGfUl8NJYY7I8f1aMUOHgLBMqhKhHLXqo5Oj/10nhYbbLs6sMK4VkWTQXdMwmSPw7wnMZ1gpAtR3/gsDX4LbvkuLgXnkpi1frf2Zw5h+iuAn+SuKGxX9fM1ndMH6AF7Np/mkmHsEjtOIN7DK5VKdWNCDmbKtjdehyLjU
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;6:PCEi4jl+EBU1+ouNXDJ7ee5+xOpmdi8WXxRSVzO8fgVplebqj7QyJG+UpzWQcelDjUqrk9Bl/zfmzFd1c1fHtpAvzA1A8uxp6brvPcU1hsL0AiMWpRLyR87ng1klvZ+0OjDP14o4Xhz1E/mKveykbP5WQcmjmXB+tsW46UahxNgSEDLrLK3r3ktLi3s4ZxlwXa5m9xG+KZLDmvhBQLLovwbPN5xdOIXI74y84E9kFOLATx3ZfoL21pE4InXdX/IJ+lCMwCTZyfb2FyppV09aSjiCiL80GaTuP3B20uPN8W6ZZEKmd8jjzLvz0R2SLIP9obp1FnkTxguCzgjwVuRLP3TjGKzxz6ieq/LFGKlAbqTbGskynOP946iR5Nu8+SJvc7PAINh9+K6RpnZleRZU9rk5AmeyfteCvE14BquPFNyXhAo+7wqY2mCjNZMy+du10j3CKgTprL1vSGrZrazvqA==;5:JD5lh+smwIys0kA8j/GiU8mRiMT6c8oMxo7ymKvL77v0azqAd8c2ockH81hhdfNd2M0pCGYxsoppNIvsBOIoClx/T7AwOzU/HPCEuC/080Gyier+RcbERDnPPAKjyivI9PbaEuoekhpcX3UDD3wWhXrjQ+ELH+KZUO1PYvju90I=;24:Q9DSrg+ZTgXTSPJ5jhtnTBo33fm9O+UIokD4Yay/5FO7OUCDr0+cqcQz8DYpE7DWlS9yrI5VFUTulMsXPAmLyzcV0O4bqw723mDXQgcO764=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;7:L++L6nRFkRKCoFRshqNrElguDwCRI9pzzL9rLDhkBAq4vsAHPdwBn2/hPfiXJoLxdU9UW0+kE5GCoGNcXwch2O2VM0ltQJRqJc1CZeRL2HY8+QKgsNezyNbW/MpIrjdMCBuv3306s5+UiS1lXDvOSI0swdmHZikYoIQErEoYiFxSXEHOBrgXmU+m9gcgj3Tya4e72VfZsTf45VaXbIEMz36RxT9qLhDsv6BeoHX4/KrWRAiDb2I+vLh6ihX95bqO
X-MS-Office365-Filtering-Correlation-Id: d3df2300-27da-49a8-9f3e-08d5bbc00da7
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 06:33:07.2965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3df2300-27da-49a8-9f3e-08d5bbc00da7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 09:26 AM, Takashi Iwai wrote:
> On Tue, 15 May 2018 08:02:08 +0200,
> Oleksandr Andrushchenko wrote:
>> On 05/15/2018 09:01 AM, Takashi Iwai wrote:
>>> On Tue, 15 May 2018 07:46:38 +0200,
>>> Oleksandr Andrushchenko wrote:
>>>> On 05/14/2018 11:28 PM, Takashi Iwai wrote:
>>>>> On Mon, 14 May 2018 08:27:40 +0200,
>>>>> Oleksandr Andrushchenko wrote:
>>>>>> --- /dev/null
>>>>>> +++ b/sound/xen/xen_snd_front_shbuf.c
>>>>>> @@ -0,0 +1,193 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>>>>> +
>>>>>> +/*
>>>>>> + * Xen para-virtual sound device
>>>>>> + *
>>>>>> + * Copyright (C) 2016-2018 EPAM Systems Inc.
>>>>>> + *
>>>>>> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>> + */
>>>>>> +
>>>>>> +#include <xen/xen.h>
>>>>>> +#include <xen/xenbus.h>
>>>>>> +
>>>>>> +#include "xen_snd_front_shbuf.h"
>>>>> Hm, with the local build test, I get the following error:
>>>>>
>>>>>      CC [M]  sound/xen/xen_snd_front_shbuf.o
>>>>>      In file included from sound/xen/xen_snd_front_shbuf.c:11:0:
>>>>>      ./include/xen/xen.h:18:8: error: unknown type name ‘bool’
>>>>>       extern bool xen_pvh;
>>>>>               ^~~~
>>>>>       In file included from ./include/xen/interface/xen.h:30:0,
>>>>>                        from ./include/xen/xen.h:29,
>>>>>                        from sound/xen/xen_snd_front_shbuf.c:11:
>>>>>      ./arch/x86/include/asm/xen/interface.h:92:21: error: unknown type name ‘uint64_t’
>>>>>       DEFINE_GUEST_HANDLE(uint64_t);
>>>>>                           ^
>>>>> 			
>>>>> Adding #include <linux/kernel.h> fixed the issue.
>>>>>
>>>>> Did you really test your patches with the latest Linus tree?
>>>> My bad, it does build for ARM (which is my target), but also does
>>>> need "#include <linux/kernel.h>" for x86 which I didn't build this time.
>>>> Sorry about that.
>>>>
>>>> Do you want me to resend this single patch or you can make the change
>>>> while applying?
>>> Yes, it's fine.
>> Thank you
> FWIW, the patches are in topic/xen branch in sound.git tree, and I'll
> keep boiling for a while to see if any issues are caught by 0day bot.
Thank you, hope everything goes well
>
> Takashi
Thank you,
Oleksandr

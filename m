Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965448AbeE2R3F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:29:05 -0400
Received: from mail-sn1nam02on0080.outbound.protection.outlook.com ([104.47.36.80]:14173
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965010AbeE2R3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:29:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH] iommu/amd - Optimize PPR log handling
To: Joerg Roedel <joro@8bytes.org>, Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
 <20180529145405.GN18595@8bytes.org>
From: Gary R Hook <ghook@amd.com>
Message-ID: <223930b9-3df9-813a-6676-68072e4e1bb6@amd.com>
Date: Tue, 29 May 2018 12:28:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529145405.GN18595@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0119.namprd05.prod.outlook.com
 (2603:10b6:803:42::36) To DM5PR12MB1450.namprd12.prod.outlook.com
 (2603:10b6:4:d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1450;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;3:3qGF12vbM8VPFsbPzfUGs2gcylYPAY4yC9Z4Bg07R4qPTmtbuVlTX7Ypa5AwPKpwnruOH/x3X7RIlSC04yfsnnXImdzJIafDW6h0LDMMEYSFJuomv4U9tRKbOKITJ362fISbw/LTsmwvFnCNd9FXOxAXSeQjkj7Ec6YXnYts/KAmcAM+TSDSJLvu2TVrUwu0iHDcqUdbIN7MgoitrT4oPFmZyJ5iXsobujwNDkbnJP5jlluCgjvTfPa17mjK9nUp;25:U8fT0MsDB80mIuvRAPkmev1lRMibWLPGuh4tsss7lBvG46Wdrad83Q2c3L9BVFFKPvdMEszg0OLfLOwCg0Q1jezQYERSc3EJqqMUW76ZOzMh/SXuYWOQGx5iL5/nS6o8XcgPEDPdGYSzOqIG2A2dEnUdi2GdeZdcuX9yxi9no+APL6Qsab2CrpckZ9WbbRIHwmSvv0ydRexRjix6yK3/T5n+yvUUALpOJ5hOMDApnfvujnJ6ZaWcnMsfCi2/xqjUZc+ApPyAKruxH8dbPL3UlJpmORZ712RIKeOObza7j5sUJfCRrICuPNEL+C/BSTw2UZtFanJw1N1mZP7sycLg9A==;31:dhO7oLyBtR48NKgbMQReAQKioE8RWS/9sSvEI9e/OLXrOR7LPi0DOMPB0vMNfXmQpvFmvgHn7+lQTownQuJT1wp7bqKhemJyhucpAvyxGNScCy8dNvE/bbAiurl66sXPqBbzSmMJj+bCF1R2IKXcmwp0mZmZNzWdudUHeyGva+c7XUKLh7OXvVE+UCAOeG4adloqC6jZd7lUlEHHQVd5hyv4qnMpFNDJPVCmPXdvAxg=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1450:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;20:WbT5w9leerkL2amVBGKIbl1CJyxas8HheMzwuI7hF5PoUoDXaMSUhvsI3QFspQ2niQjEChyEDpqIBSACT4PZbXxmNBNP++zuvfDJQVWuZ/l/2BXLaV9OjFZimCnqNXNzft0kyvEV7hgH52aSdMEyj+p8vug7FP71blQRlfm6xJ95dvTW92JgQTUvxOpvVrNB3/nwpKaMc6Ke9NPjikfWuc9/LvyLhlbnD5syQbzYWGjZ2V38iyb6QHdIBbG5hx1BI0INaXdkuI3ROQG3UWx6j8PiJmJV0ExFWu5uqhvFoTK9K53L9hIhhT7zAIxX6nOFQwSO4QhI7meLB+VNM1R+vF/bmS6dHLY/KntXnnGSxeHWc1tUDJMk3UJXFso43U8bpfErCiaUFS7Oj0Zv4m1xePI4e+WEwM5gJ7HkPoOyJNLWVXIUc6v8AwEnC3owr3kRZXk8WEmohdmNEH1ERLszMwgidZZ6GkdSRgyi2tlO5fOYBhVdEDWMdeW3VNyBkdru;4:9B/SlJNct1ijr1f9WY91xEBglRqzbhwRQ9/2jsaHivPjRGLy7BTAms3OuKYVWpxPCqlRbdPhLmZFloUDlTz5TT1EuiToQwl6yHY3Ao1qGbmPPBCvXvSPriAO690+9QZhESPAnt1srcNjGJ5gJoT6WuYY7XdiKcUm5u5jqPpOxXtSNItzFqyJCcFN7irJR1tyDaORnb7BP3sisXYQ091NcapIjXUTa8DJZ1bsYhwaGxTsqoNTofxu+ALgatXCSyASLYabFuIjFgLvf198NQ6pEODEy/Z6Kz0kSrfd2/Sy07q4ILLW1hbW8J1OmcoE3fyi
X-Microsoft-Antispam-PRVS: <DM5PR12MB145021CD7395D9A083E3A7F9FD6D0@DM5PR12MB1450.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1450;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1450;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(39380400002)(376002)(346002)(199004)(189003)(97736004)(65826007)(5660300001)(36756003)(6636002)(6666003)(6486002)(72206003)(65806001)(65956001)(66066001)(386003)(58126008)(305945005)(52146003)(76176011)(23676004)(16576012)(478600001)(2486003)(7736002)(67846002)(229853002)(47776003)(52116002)(110136005)(31686004)(105586002)(53936002)(81156014)(81166006)(8676002)(316002)(53546011)(11346002)(16526019)(186003)(446003)(26005)(77096007)(50466002)(4326008)(106356001)(956004)(2616005)(476003)(6116002)(3846002)(6246003)(64126003)(31696002)(486006)(25786009)(2906002)(68736007)(230700001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1450;H:[10.224.11.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUwOzIzOitoQ0cwZmFvbm84NVI3ZGh5SVJlaStXQVF1?=
 =?utf-8?B?UjV0aEtzbHNrcGpqYkpnU01VK3V5MWt3WkJGNXBKQzFTRWowOXdQQ2l2TnBO?=
 =?utf-8?B?cTBZdnA2TnhBWDZxWFQ2N25hVmcyL0pXL3QxajgxOHlPWDZFRVlMYkpGUFVZ?=
 =?utf-8?B?R0F1Mm9ITVNIWGRST1MyZjRxbWJjMDliTC9JaTE5MjB3Q3ZEdzMyeitsa1Nz?=
 =?utf-8?B?SlBxK3lYWUlDRjVQMXkvL2Z3b0tiZWpYNTVqd1NnWG9hSVBOQmFUdFRQSTZG?=
 =?utf-8?B?OWJialprOVVielg3SjV3YnpNSUlYRytOSkxLWGpIcjhNZUxDTkcxS0owTFB2?=
 =?utf-8?B?RHZ6S2NuTTI1Sm5qdU9JMkpaNXZNd21CRmZXZ3o2UlE1cEZaOVZzZG5lSER3?=
 =?utf-8?B?cktxQjJsSzFDZ1BkTmtzOTVlQ1NRc2cxSnNSQ1h3UUp6TDBhdXd6am8rbExx?=
 =?utf-8?B?RjFtem1NdG95UndOeHRtT1A5aHVtdUI3RklTbEVSVmlKYjd2TUtPWjZmcjRy?=
 =?utf-8?B?bGNlM0VKQXFNRGlBM2dYRUxzWEN3enVuOGV2YklwdE5nN3l3aHJFU0ZhYTJM?=
 =?utf-8?B?NXhJSWNhL2N1TlJ0bG83RUZmNm5OdjdBTU5lZDJFZFFpa1llTlM2WndBZ0dL?=
 =?utf-8?B?N0FtMmpZa08wUSt2dE5rc3hLL3B4QUIwMUJ2cUNiQWdZSWVNK1hHZjVaYU56?=
 =?utf-8?B?Ym1WdUFuVVlMZzBla25rNDBMU0F4UGpXYnF2NzYzU0Q5dldXdkF2OHRKZWV5?=
 =?utf-8?B?Y2plSXhQeE52bHBHSm1JQW9EdVQyWUo0NHJhc0RIMm5FR1VBNitWaEFTbzA5?=
 =?utf-8?B?Rkt6bjM4QjU5a3EzV1QyQTcreEg3RG5hd0txL0dDT3B5aTdnNlI0ODlMZXIz?=
 =?utf-8?B?WHliKzd4RFVnMUlVaFoxMDJ5bzlJbFNvUVVoTTJ5UFdHUHBKbDVsRVl6RnJs?=
 =?utf-8?B?aVh2eWk0ZXhQL2kxRUZlam0wSGtBQnIzZmRhdnBwMGlOZi9lOHJTelo3OUlM?=
 =?utf-8?B?ajVJNnp4MWEzYnBrWDBJdE5LZHNxQUhEeWhXT2N3UE9DY0pmMVRjelNHclNr?=
 =?utf-8?B?UGZNQkp6aDJhMndCVnZHa3NtcXlYemZFZUNQeUdmTkM1Z2lBbUx2S2RXSS9R?=
 =?utf-8?B?dkJBVE5yampiT3VrWFB0UmVzcnFObVNCNFUyTld5REZIMUZQYTk2cjZCUkhQ?=
 =?utf-8?B?dTRyYXhxQ1p5bUN4cXp0ZkZoMStCMWxGRVB3SnhoOTZyajEvSGpmN0xnYWtR?=
 =?utf-8?B?dm5MeFV2U3hob2VueVQ5Z3hiMHR2dktpcDE4bGU5SHBjOGQyQzlSeFB1eTBQ?=
 =?utf-8?B?ZW5ENFMxeUZMTG4ydXFBVExSdmwyRmx5Z2d5b1VXY2h3MTltSWZWRmFHNTFh?=
 =?utf-8?B?Wi95eFNBc2o0WlJVRFZxZC9DTFd1WU9ObWZWQXRWYi9YNjRrdVZWaHpjQ3ov?=
 =?utf-8?B?YmwrZWl4T3MrZnBFSGZ2MlI2aVgyNGZIRHFON2pVV1YyN00zSTlRNEg1OHVB?=
 =?utf-8?B?SHdES2s5aWo2eWlrZS9iSkFIc1p1eEYyMnhVTVhNNE1sWXBYb3dIQWlNUk5P?=
 =?utf-8?B?SU5jM3BxUVFVTWplYnQ2eG85eWJOSXdsZjhNZzI2Y1pzZWtYMThwZm5UL2Yx?=
 =?utf-8?B?NHp0bXFPN2lTQWhZMXhpNTY3YXlqQ0tYbE9IZ1VKUXJmQy9FM0l5VWtiZ0x2?=
 =?utf-8?B?VGdmOHFwdFVrYmwwbElzVTU4R0ZMUlNYcHkwbllmWnpNTmRhcTArcXVVb1dJ?=
 =?utf-8?B?M1hLSzQwSTlHZjF6ZUhSWEZEMGVSWEUvQk4zRHVjckV5OGlFMmovU0x4MTJ3?=
 =?utf-8?B?a1ZiRThaTHF6dlp5WkJqWGlyRzFyVzNHemhLa0w4c3NwM1RDa2dBNnBwbEJk?=
 =?utf-8?B?TzR6V1IyYjJtTVE5SE9COUllS28yaElqU2F3b0ZKMm9kblhLMnA0cy8xTVBB?=
 =?utf-8?B?blU2UllQTFRIRGpoZFMvWlQ4MWFvRWI2N0FYdXIzT3hFMHltUGJCZDl4TXNh?=
 =?utf-8?Q?HBN2tA?=
X-Microsoft-Antispam-Message-Info: FbL6lFTY5nolMgzsCSCuICKRjZ4vXx8SDE5U6YIc+IU0EyYQ9MQHD2yKdokUBiU9QUdfEy/iXm6ptJ75mzcYJzhQMxtbzMn8dYEMJ30kD0GIn53objpwey1g5yHwZJMk0RFJCP7pXlDZFnAR7HSlEM/NOr0H+8vuHmkEeu2FvQLkkTJg5+UyjLBKm70mPTWL
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;6:gKsr56dDviUaVi0xyj4rMZOpPYSMFYjfq9vHbFZBAp/b8kRAn398ggDbqBEm7olK5NR/gu3o2kV8hTAdhUNTtydXR/YoR0sYXN3l++YQPOjMFoxKHe6LD5GXUMlw8PlNm8ffu98FzhiSdHclahMaDMxY2K1wqpTqFQwLhIEM/4TTARtDMtB1rxIHkZnrR7JZRjhKsXOdyg39lShsaiEGC5Q4K2HlUC5Py/rjyMwW/gO0y/Fnl70BVjAszbmnTl5mXoxrIw4Owiyi0ZYFuTCtIsrpYvvWfhdRk3aJOGi0m0IRaU9Gk6+jut/Y8w5b8wpUbW4xa1P+2L36lIWPH0yvqmVcvxPeI34MdzCjgQHXfoHK4kXpPmdFekPBKYz84QH9/bw+nKWblkhVMM8hfC4NtYKfQNzMHL73T83VFev648NsRrJLEuiRiLcA7UZ1xAHV2YEoxLRVWpTTWJ3anszlNQ==;5:Y0e8z7mCTQ4teulkftR+3m1EqqlR9diX+hbXBsbHLPywrgcgGSQkc5AjajjVSotpcJ/uXWcmXn5I+4QOni6TFoNU79lAt2T/CtnW0KNc7TMzAcHVKrGKHoWq/iviG48mrxmcfMtG7C8EDOzj/KgwXRG2VJ1Ti2OK01WZIQMwBjc=;24:S/lYzbWzk2cjjMA/CkFv2N4rjqAu9tCheGu6hIfPv05TqG1JNpuBzxmBUHmFYJ1yjLhWEigIWK0SDnVtzaTcC11izkS+etkIk/3kveOZUV4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1450;7:0QpLZz1dfnaiSMhzV1IMDIO3KifTNgxnkvr3/aNaomK38kvYgGrkXD3TzsN5zVJs/Qbi6lbIK9UGor+BlJDjGH7ZdOHc2nRr2F/dkvJqkR19/l0p50XNmQUY21PJmZ4VLk+FUAebwOHhdRR0IcoOW2c1v/gp7XcoctuZlQ9IVw9GHsn8Zzr7OKba7gn2+9mFiKtJ2L0mkQMp2rUvGOP00Ryqfy31+MNxdx8RKlBNL63udIC27fbjVt74XI4Gziml;20:XAnRwA5GTIEkf3QggqdhUpwaq2fzc1lhhr9Cj7spgF8M9+v66rz4kZNR9mhlrBpk/CPRVc8Ra6SgPJwRgIF8slBZZblYtFkj9dxmVijQT5uXb/5gwoEV50vU41Zv4YErRh1Pg+h5wH/Soyq3asVwuTwFGXP0u2UuQwEpMDJSmp6/UK231enE9gq3oaCNwf0NbQUSjxtCKNscgBEK9Hn+iDUTgqb2XH+St2+WyW8RNYW05Ptde8aBVKmvDJFQd22J
X-MS-Office365-Filtering-Correlation-Id: 5b201fbb-5608-423b-306d-08d5c589a941
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 17:28:57.9075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b201fbb-5608-423b-306d-08d5c589a941
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 09:54 AM, Joerg Roedel wrote:
> Hey Gary,
> 
> On Fri, May 18, 2018 at 04:51:56PM -0500, Gary R Hook wrote:
>> Improve the performance of the PPR log polling function (i.e. the
>> task of emptying the log) by minimizing MMIO operations and more
>> efficiently processing groups of log entries. Cache the head
>> pointer, as there's never a reason to read it. Ensure the head
>> pointer register is updated every so often, to inform the IOMMU
>> that space is available in the log.
>>
>> Finally, since a single pass may leave logged events unread, use
>> an outer loop to repeat until head has caught up to tail.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> 
> Do you have numbers for the performance improvement? How did you test
> this patch?

No, no numbers. We're still working out how best to test this, and 
suggestions/strategies are welcome.

The change is modeled after the function iommu_poll_events(), which is 
much cleaner. The GA log handling should be changed, as well (there are 
superfluous writes in the loop), but I figured, "one thing at a time". 
This is admittedly a minor optimization, but discussions with Tom 
Lendacky have led us down this path.

Your feedback is appreciated.

Gary

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeEPHEu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:04:50 -0400
Received: from mail-eopbgr50070.outbound.protection.outlook.com ([40.107.5.70]:2781
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750995AbeEPHEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:04:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH V2] mlx4_core: allocate ICM memory in page size chunks
To: Qing Huang <qing.huang@oracle.com>, Tariq Toukan <tariqt@mellanox.com>,
        davem@davemloft.net, haakon.bugge@oracle.com, yanjun.zhu@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180511192318.22342-1-qing.huang@oracle.com>
 <2797ac27-022c-0818-388c-e4a6131ad1ca@gmail.com>
 <ff9c44ca-eaae-cb3e-4c69-e9e3cbb72ca1@oracle.com>
 <1ded7d49-0ba2-3594-f840-74d7cf37a0eb@mellanox.com>
 <f4c5d8d3-1eea-8566-9921-a9dc48435f66@oracle.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <465cf5c6-46be-2701-1c26-3e90f31f05e4@mellanox.com>
Date: Wed, 16 May 2018 10:04:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f4c5d8d3-1eea-8566-9921-a9dc48435f66@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::32) To DB6PR05MB3255.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3255;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;3:CvACajjAhPpNpn8Escxh3gwUF1Db1KM+etSiUa5M6N5jky7t/v9JvASkNUrL1u+FWEMP2QGDSm2DyApConVVje7bw/EJtWQhQtoKH5TNT/aF/smY9SNFOYh+xqqtwV/APL6pH1bZqcChcmVO4BIdvN7waZ+EnD2IVHZWm8C9LcmI5G0OYZjsBd+HdpIqO7+SASOkLuxEQSv72O9vQcWlcxTvdZ0O2Uoa/OlOGf6dJHg3uYQYT9P+Xe0DP50/qfUh;25:GKmuXlURm6IcdVjRZLZo//mCYf3Al2NUIB1ySkfnBvl613HxKVcIciJAbDuUQUIzQOiRQAMe4KWgTcIeX0K2BYsCmB6xZvJ1BCexSquS1zzQ2tONiEIWpuoRrL1EW3s+gPj2kPgqwXp4nzgM5vcufEZLpQ6vanrrzAcO0gIzPEd8EVYyvDC21LD2dwGOOA1g0+4KnN9r+gIL5YHVmDYa4XsnWoTiyUp6nmF4KNOLncNpH4OPNfsXFhHZqtH9ldQ0DUe+bYuwp4HyYyB1sP4KuDyfhhkNMKiJHMjlJHKXvWxr/anLf3IkZjqxifinJLC+JfLPHZD6ntkimsX+xHRfGA==;31:2+p8A84+lUwa0TvUe+HJ11zDUuRRb0omhCZKgmh0VohenRbOc4rzCmODMFsMbxYBT1MfV6Y0B82rg4DBE0fuQdW6cwEbshXgy/mLVUx2TH3CKuhmwvGSCn7VDTh4Q0bCtwSs6p4z9CTdyyfUtOM2MfvFydF/4Moy3aj0Cq7qaNAqvEa2liDHirk23Ode3tfH+QSZLKpCvCtJIUhbdJrtCi/lFZAxS6pX3UCJ1j5Keqw=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3255:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;20:L8TEb9g0BAtU6fVyJkI4TxmnU2YNUX1+38EszlKyewQR5UNOhrcGuJQp0C0NjAHYP4cbLm4lMp3Gm8Vz1Nq2IbYor3s1M34/HEJX2cxm1QQGwrBNAvgciCzmtqjSOVh85sOcacqNXVpJqlnwQ+brYYGomuS+OZrsVL3g/3MRtrzcp85/Oxa0QYSGQJh3cCqnAiZ+jHxDP3t+2zTSE79YGShYt/E/4jSMUzg94+Mkm8881xAo8MxSAZJlqeKyZfSftvAO8OSoUV8kVEE3YO/ri1D7XWEgtwlPoaXki1XHxp1M/+pto6dHMpndK9u4s2ptMNgMuUjhOBeG524jG6cLUsqWMou4TJ6AX55CBX3lS8EKLOk1nMxwN1Lu9lnIzVbkzA6lzCv0yzuTRhd45k0B/y5CvKnWdLedLNIgYiPODI8U9lKcnLaFy7coz9pBnOY+xsIzMUCIl3GxyLoJe0RZJ2+NQyo73Qs5tUbButaBNEzyy9itrBhRNt4NtXEIV/xw;4:e6Fv3mC8FNiCg4LLtQ6U9cxfA0o5NgvdxXYzOonARVnA10GiRDHA1po4npA9gerS7VLh1vTM96RCb0lbfyPzOw5aWsiJlP0StyF7c+yjkbPCjlpbs14eOCVjhHz33/QBfZludoUqJhU2dQGo69GEv97ishDQbZg0AKsfIfKKiwtb7CFd67Gd+8cv/OVHZ14JA2W5MlB0/4s29wpf/GBFrm3U4+Z2Pi2Mciwd5v2O4OK3yMr8d+/WbE+F7iTPO8JVoJiJfZoc3IbwLk2xeP/+xJsQ54pX4jIBYy+Ofy6qwVlcB3JLFPrGqA2Xs4QqtvgyA1gDZaVjOk60bVO6cMqBqRnjW96a73gBLTR6uH6wJ4hm2n8yXslINKGAkR6Ffm/m
X-Microsoft-Antispam-PRVS: <DB6PR05MB3255C02029254A2F4FE8C88BAE920@DB6PR05MB3255.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(788757137089)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR05MB3255;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3255;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(376002)(396003)(346002)(39380400002)(199004)(189003)(6246003)(86362001)(31696002)(81166006)(966005)(67846002)(486006)(316002)(16576012)(97736004)(7736002)(81156014)(110136005)(305945005)(8676002)(93886005)(58126008)(36756003)(53936002)(50466002)(8936002)(64126003)(31686004)(106356001)(3846002)(59450400001)(6116002)(6306002)(105586002)(446003)(5660300001)(229853002)(6486002)(25786009)(68736007)(2486003)(23676004)(52146003)(76176011)(77096007)(26005)(2906002)(52116002)(65806001)(47776003)(65956001)(66066001)(186003)(65826007)(16526019)(6666003)(53546011)(2870700001)(386003)(2616005)(956004)(476003)(478600001)(11346002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3255;H:[10.8.18.159];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjU1OzIzOlI5OGhpTEtaRXlWcEZvWHRLSW5Bc2Z5bjdw?=
 =?utf-8?B?c21MdVY5TUZtWGNKaGhRRjdoa2ZjQi9LclZONy9LZ24yTEQxRjFsM3Azd0x0?=
 =?utf-8?B?cGp1SitrM3JuaEN2UU9hdkprWjNMekQwdWJheGFnSS9SVjFmWjFGOU41aVZ0?=
 =?utf-8?B?Qmx0NjA3b1RBc0RtYnlwVndGeGFpV3BpM2d3LytRK1ZIdW5HTUZWcFFBUkFT?=
 =?utf-8?B?Z2xveGo2ZG1yTEdnMWZpSFhZeXR4UWNjbEZSaEFyTVFzTzRzTS93anM2M3o4?=
 =?utf-8?B?bkltN3lVNlBuNTFSUUt3TWdoTXNFVFlSb21oQXJadzU1Vnh6QlptLzhVblZF?=
 =?utf-8?B?K2RuOFI0dVdocEVtSk5NRTE5cHppYnF5d1I0V2VGOWVhY09vQnMvSk1Bd1ZU?=
 =?utf-8?B?NnBPeHZPL3h1TUhLNEJKakV0QU1SM0lzY1h0ZXpwUS9CR1l3cnhlQXdoT1BH?=
 =?utf-8?B?YUpHS3ZPTG9lWjBMemEvNlNESXRIZTBYUVJlRlV6WGFKRDllQW5pME1JMDhX?=
 =?utf-8?B?SXVxRk5xTXdrNllSRVREUnlWdllZbFVTNUljZUNEVjFWQjM0MnNHK3g2RUNh?=
 =?utf-8?B?dFFKa1RvL3YxY0tuT2E1ZkxKa0VlUDdrR3ZFbjRqdTUrb05KWnRJalpCRkJq?=
 =?utf-8?B?aDdDVjhnRWJHVFJCdjBMU3l0SkxyNVhsU2kvNTcvMDFFalNKaTlLM1owYzN6?=
 =?utf-8?B?OXZXWlRnQWNMM3FHT0pOU3BWN0lFdDNFcjkyRzFYRE5OZmNIcm9pSG1pSURT?=
 =?utf-8?B?aGRqZXI3Si92S2lib1RMVERoc0VXN050SjRWRVhEdmtDelhRTHpVYkNUL2Vx?=
 =?utf-8?B?dXphdkxrdXY3VVRUaDZFK1hwY29UMU5VWW5sQVpFUEJjRnFUVFRhU2VXM05a?=
 =?utf-8?B?YldjR1FwVFA1VWtvOVI3RDBGZVNLNlR6ck5meWJienpvaE9wQVhiWmVLSlZY?=
 =?utf-8?B?NnQzR3hualFhNC8yVE42TG41ems3clN6WUVIdDNGODZ4UXZFUzlUZVhuTjhj?=
 =?utf-8?B?WU10dXVlMDJaQ3B4QWFpRmRaT2NmL2VFQVRyNktiWlR2UUMrVlpqNkVzeUI0?=
 =?utf-8?B?Nkl1d014eDY4eUNNQTVjdXNXV01RVVFMUGhoWlJLS3NBOTY5L29qSHRwZlFu?=
 =?utf-8?B?N2MyVEl5cXRJK1I5V0dhSDAzZVcvbFJna2NaeXV1bVBKUlh6OUVPK3ozRUFw?=
 =?utf-8?B?eGFFeFVodklHbDVROWV0aGpzS3h0S1F3NnVmWStxbDQyemhZTDlNN1A2YzF2?=
 =?utf-8?B?SFJJb3pVVDVHRUkxZktPa3l4OFNsMmIxRXFlbDFVa3dUM0tJdXM3MWNhWW05?=
 =?utf-8?B?aUxwRklsNWNiaHFGMUFoTFh6UXFRRFlSZE9pWG5Dd0taUEMxcDkxdnFDcHh3?=
 =?utf-8?B?SFRLazlVYm9XWmxoY1hmRklEWDVTZjdJbUhwcGR5TFN6L0g0NU5jem42RUVT?=
 =?utf-8?B?Vjg5NkkrWEFxZlE4N0hKTTVjYllmWTArTFEvWWFuSFdGbjBKbHNRT2tmK0dk?=
 =?utf-8?B?V0RtdXIxaEl1dGU2ODJ4RERmYytYMUptR2FYQmRtT0VjWWcrU1R4OUxnbEZT?=
 =?utf-8?B?KzBMbStncm5zYlFtK3JIRGEyeVhJcjhKRGEvTmU1UTJHREhwZlFoWGFISDR2?=
 =?utf-8?B?Vk5janVBRTJCN29OQnpwL3UyaUFHSHBQTjRDMWtjcERxYklNbFozZTBFWFU4?=
 =?utf-8?B?Zmt6R2NCRnhaWUVUZ2xUbitNK2JmckZwTzlMcms1cUJobHg0WklrR2hsbkhJ?=
 =?utf-8?B?UE8vb3l3YzhxcVYycjVuWXhhNk96djc5RW9vSmxCNG1MVFRWbkhVeUNWcVRW?=
 =?utf-8?B?UE1CTi9mbTltYVNtU0d6VVlQaXh4cTFDM1pvR0RSaTU5N3FyS3E4aS9tc0pE?=
 =?utf-8?B?Z29LL2MwREo0aXQ0Yi8ydGFaaDVPeW84UmdXajF6YXZMejI2MDNUNXhXNXlH?=
 =?utf-8?B?aEFKNWxCVmpGMFVjUHBOVkgzL2svQUR5R1pyNmJ4MUhrdUlJbVdZanl5YXBK?=
 =?utf-8?B?WnNEdUpFUHlhWW83Um9WL0JUL0Vvenc4aDJBMTdSc0VIMXVQWjRZNU1vcTdU?=
 =?utf-8?Q?b+Sotpj4H/p5OimlUiLD609Jy?=
X-Microsoft-Antispam-Message-Info: jXZDCfm4mw8mzPfdBF5ouZNwXnP/91tix3yF64wfoXI+BpC+AUj32vd1LrMZlMuhAKZIczLf3GsCW5Y0zskGTotN4yyZMFog9YWdSsz/AXZOxuzeErtysE8t5FMnfmKEemM1ERl+k+MurSJZPxrt898YnI98vMLRHEBDoZtUCnBkVvS8+b811z+5/2ajUKwt
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;6:2HLohRRQ3buuSIwb37ioNKKQXf8AYCekYAK+bl/E68YMHOKN95q1dMVsYldpM1p69wMRp3GeWK9h+X3RbqQuh7exZEpQLd1nh6mJ3vr4TgEkDhqTCa5e0JfJhZoyPtbwJW5qA41qvhoT6Bi6FRpG5CCGHYQF154f/zeQ7XQGcQOlvWDc7QYm/UH1H/gKuLOvnfrBLsryQ2TyOabf7gJ1CmsbavKdt1vAcJ64CcN4/uYU6iiSZZt7ntKJiYLnpKULq/mfUXGXPVbWLXsxW75yTt+cVwKQ45GglP37GR5PbzR1jD2Si7XaqOuKerEj1HItw3YSPItHQGCoKcaNrXS9I3f/wwdYsgesaUqlcJ29HWNnDbtmsXZqHxZLT4P6luG5jlH/BOfBkC63JruF4llWHmnsoRVvLBD5vSlgsgyA4FeZbpBWj8u1vVCp1JLSQqby+mmPo+2kUGUwSmqJWtFhxg==;5:xygG7KmAeLEVUJsr+x58SntLj/ofaTQkpHuusDDcQzBxci1lYVg0jYHbcD3jQlMwjmUJ2v0LrrvvR1dewIiFLAzwOqVy8Sv+vHjcmEhdGnp0AfF9PAXM22ULc+M1/4rAjl6lD7oEiTy5fZRPuvM0LirM3iI7Xf40qwcASIA0Q34=;24:3Tn4Fx3XFumjk8fnXZY2w44z9FfXARmwVnICVgJ0j5nQpsnRT0qbv8s7t4m9Cb7kQ4nAP73+n8l+e6heKJfWcrlvSCyH2IhnvujHKjqBIeY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;7:JEndDvjscn3c0leYSrsBdsUko4jQzkhNjSNFLqvlKoPDnQ2Hy+8JgPoAHhT9KdcnhTOnBFngJllDgaJd8HIMw2hnHjTaB/gza7RTQbsuhnuvi/x6c7YfH2vVNP8cg81qpB6SRtAFStzpVIej5QslzrS/cYoUWaDgUn4oiJqTF3e26TKo1/axhoCUYkGlx9N9zr0E70PFmMqgx0oU2PVzTUqEtD3b42b921sGHeQXppc814/HYnwvd6P9LkPro91v
X-MS-Office365-Filtering-Correlation-Id: 19ecd5c1-254d-4454-67ec-08d5bafb4dbf
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:04:43.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ecd5c1-254d-4454-67ec-08d5bafb4dbf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/05/2018 9:53 PM, Qing Huang wrote:
> 
> 
> On 5/15/2018 2:19 AM, Tariq Toukan wrote:
>>
>>
>> On 14/05/2018 7:41 PM, Qing Huang wrote:
>>>
>>>
>>> On 5/13/2018 2:00 AM, Tariq Toukan wrote:
>>>>
>>>>
>>>> On 11/05/2018 10:23 PM, Qing Huang wrote:
>>>>> When a system is under memory presure (high usage with fragments),
>>>>> the original 256KB ICM chunk allocations will likely trigger kernel
>>>>> memory management to enter slow path doing memory compact/migration
>>>>> ops in order to complete high order memory allocations.
>>>>>
>>>>> When that happens, user processes calling uverb APIs may get stuck
>>>>> for more than 120s easily even though there are a lot of free pages
>>>>> in smaller chunks available in the system.
>>>>>
>>>>> Syslog:
>>>>> ...
>>>>> Dec 10 09:04:51 slcc03db02 kernel: [397078.572732] INFO: task
>>>>> oracle_205573_e:205573 blocked for more than 120 seconds.
>>>>> ...
>>>>>
>>>>> With 4KB ICM chunk size on x86_64 arch, the above issue is fixed.
>>>>>
>>>>> However in order to support smaller ICM chunk size, we need to fix
>>>>> another issue in large size kcalloc allocations.
>>>>>
>>>>> E.g.
>>>>> Setting log_num_mtt=30 requires 1G mtt entries. With the 4KB ICM chunk
>>>>> size, each ICM chunk can only hold 512 mtt entries (8 bytes for 
>>>>> each mtt
>>>>> entry). So we need a 16MB allocation for a table->icm pointer array to
>>>>> hold 2M pointers which can easily cause kcalloc to fail.
>>>>>
>>>>> The solution is to use vzalloc to replace kcalloc. There is no need
>>>>> for contiguous memory pages for a driver meta data structure (no need
>>>>> of DMA ops).
>>>>>
>>>>> Signed-off-by: Qing Huang <qing.huang@oracle.com>
>>>>> Acked-by: Daniel Jurgens <danielj@mellanox.com>
>>>>> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
>>>>> ---
>>>>> v2 -> v1: adjusted chunk size to reflect different architectures.
>>>>>
>>>>>   drivers/net/ethernet/mellanox/mlx4/icm.c | 14 +++++++-------
>>>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c 
>>>>> b/drivers/net/ethernet/mellanox/mlx4/icm.c
>>>>> index a822f7a..ccb62b8 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx4/icm.c
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
>>>>> @@ -43,12 +43,12 @@
>>>>>   #include "fw.h"
>>>>>     /*
>>>>> - * We allocate in as big chunks as we can, up to a maximum of 256 KB
>>>>> - * per chunk.
>>>>> + * We allocate in page size (default 4KB on many archs) chunks to 
>>>>> avoid high
>>>>> + * order memory allocations in fragmented/high usage memory 
>>>>> situation.
>>>>>    */
>>>>>   enum {
>>>>> -    MLX4_ICM_ALLOC_SIZE    = 1 << 18,
>>>>> -    MLX4_TABLE_CHUNK_SIZE    = 1 << 18
>>>>> +    MLX4_ICM_ALLOC_SIZE    = 1 << PAGE_SHIFT,
>>>>> +    MLX4_TABLE_CHUNK_SIZE    = 1 << PAGE_SHIFT
>>>>
>>>> Which is actually PAGE_SIZE.
>>>
>>> Yes, we wanted to avoid high order memory allocations.
>>>
>>
>> Then please use PAGE_SIZE instead.
> 
> PAGE_SIZE is usually defined as 1 << PAGE_SHIFT. So I think PAGE_SHIFT 
> is actually more appropriate here.
> 

Definition of PAGE_SIZE varies among different archs.
It is not always as simple as 1 << PAGE_SHIFT.
It might be:
PAGE_SIZE (1UL << PAGE_SHIFT)
PAGE_SIZE (_AC(1, UL) << PAGE_SHIFT)
etc...

Please replace 1 << PAGE_SHIFT with PAGE_SIZE.

> 
>>
>>>> Also, please add a comma at the end of the last entry.
>>>
>>> Hmm..., followed the existing code style and checkpatch.pl didn't 
>>> complain about the comma.
>>>
>>
>> I am in favor of having a comma also after the last element, so that 
>> when another enum element is added we do not modify this line again, 
>> which would falsely affect git blame.
>>
>> I know it didn't exist before your patch, but once we're here, let's 
>> do it.
> 
> I'm okay either way. If adding an extra comma is preferred by many 
> people, someone should update checkpatch.pl to enforce it. :)
> 
I agree.
Until then, please use an extra comma in this patch.

>>
>>>>
>>>>>   };
>>>>>     static void mlx4_free_icm_pages(struct mlx4_dev *dev, struct 
>>>>> mlx4_icm_chunk *chunk)
>>>>> @@ -400,7 +400,7 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, 
>>>>> struct mlx4_icm_table *table,
>>>>>       obj_per_chunk = MLX4_TABLE_CHUNK_SIZE / obj_size;
>>>>>       num_icm = (nobj + obj_per_chunk - 1) / obj_per_chunk;
>>>>>   -    table->icm      = kcalloc(num_icm, sizeof(*table->icm), 
>>>>> GFP_KERNEL);
>>>>> +    table->icm      = vzalloc(num_icm * sizeof(*table->icm));
>>>>
>>>> Why not kvzalloc ?
>>>
>>> I think table->icm pointer array doesn't really need physically 
>>> contiguous memory. Sometimes high order
>>> memory allocation by kmalloc variants may trigger slow path and cause 
>>> tasks to be blocked.
>>>
>>
>> This is control path so it is less latency-sensitive.
>> Let's not produce unnecessary degradation here, please call kvzalloc 
>> so we maintain a similar behavior when contiguous memory is available, 
>> and a fallback for resiliency.
> 
> No sure what exactly degradation is caused by vzalloc here. I think it's 
> better to keep physically contiguous pages
> to other requests which really need them. Besides slow path/mem 
> compacting can be really expensive.
> 

Degradation is expected when you replace a contig memory with non-contig 
memory, without any perf test.
We agree that when contig memory is not available, we should use 
non-contig instead of simply failing, and for this you can call kvzalloc.

>>
>>> Thanks,
>>> Qing
>>>
>>>>
>>>>>       if (!table->icm)
>>>>>           return -ENOMEM;
>>>>>       table->virt     = virt;
>>>>> @@ -446,7 +446,7 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, 
>>>>> struct mlx4_icm_table *table,
>>>>>               mlx4_free_icm(dev, table->icm[i], use_coherent);
>>>>>           }
>>>>>   -    kfree(table->icm);
>>>>> +    vfree(table->icm);
>>>>>         return -ENOMEM;
>>>>>   }
>>>>> @@ -462,5 +462,5 @@ void mlx4_cleanup_icm_table(struct mlx4_dev 
>>>>> *dev, struct mlx4_icm_table *table)
>>>>>               mlx4_free_icm(dev, table->icm[i], table->coherent);
>>>>>           }
>>>>>   -    kfree(table->icm);
>>>>> +    vfree(table->icm);
>>>>>   }
>>>>>
>>>>
>>>> Thanks for your patch.
>>>>
>>>> I need to verify there is no dramatic performance degradation here.
>>>> You can prepare and send a v3 in the meanwhile.
>>>>
>>>> Thanks,
>>>> Tariq
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-rdma" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

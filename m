Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeEVQZs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:25:48 -0400
Received: from mail-he1eur01on0127.outbound.protection.outlook.com ([104.47.0.127]:39712
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751613AbeEVQZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:25:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v2 2/2] kasan: fix memory hotplug during boot
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>
References: <20180522100756.18478-1-david@redhat.com>
 <20180522100756.18478-3-david@redhat.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <f4378c56-acc2-a5cf-724c-76cffee28235@virtuozzo.com>
Date: Tue, 22 May 2018 19:26:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522100756.18478-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0017.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::27) To AM0PR08MB3252.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:2rxb0rZNeDmamNhaJdRbHlTOxTAPw3OaWNboEIxmacv/YzZQZOMta4ulZWrxXp3Bw2qkJjVaU4J+647yLE6re53Ie6rX+8aenPnjwugWp4nZQfsYL6NTKgYUUSHsjUlDc3WS1JD1eOySfIUU+3EzPyPZPYLddkeXCP2lS+J8/ZpZANbkd6V8jX5oI4TI1G5GHiGft4XpA90MN/S6SKCNVnhVcJq1xIyBZC9vKCqgb7IdfRcezxxyBcbu2o7uWN0b;25:duDjRVb3nhmHgToGTPTNi9raCfEs6XM//7lY8A31KmSEZt+WbQLBuDv1l9mdhk/CpWlK+awfrnHPkdShHkD/wVrRhUlKb7oXgkaDtTvLrFAeVgOGNd7p6H2KeQTyG+UinAt/Kgctnkj8SoG+h9gKJKd91K3cnbHXsvFEJBxdk2WuxALQzaw0s0WHoEkE0dk2knOOQtB0/YDoRFIuXsXiKNDComK5pCGF2AUe2FudRHvPmZNH/kaVkDlJKSnaisZDfWF096vNjt7/7+BrzWcevdjjAkKqlpmIP9lkbzGm83DPWE/wRBzJ1UTz8QBWKXRQvtK1Kruy4C7LWpDa8Yx+OQ==;31:jKwxnNSkZyFwSO3B6S5heN/BjnJeFxx9tkYu3iZr9y6DsYEyjolNxH+W/bV/QuTgfHDTo1kd2rmgCGV5Sc6oJFBVXYQZ76lh2kpsavW9Ytg2M1lNgfG11l/ri+3biSg0zVdavlozzUXI6jrOUR3Z/UtryM+E1t30GmchSqtCLnuSsEGnbXNf0TozCzrDZ1DuR2BlytNtV5w7FRLdWaF8Ls5uWxfb9x7EwTsUMW/+TRs=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:gzx5GdUmUFHT4k7+pk1GD4s0TPadTD54DL5SUdzi/9miM23T6UbVud5mlsZlIhKKf97DjDUZWqcB6xGrQuaQtzs50pjleNy20nRSXvm0Xm0KQyrNg/oSbKud8LTlL/BRLwEt+W/qbmTX9ScMYOBay5LPdyAkDwQBxb/J4jWp+BmamhMQHlGsuITyMYJOZA53BNouAWHKM0/3WmG+mTCRpBE52o21mOVgmurs4BAi8CoNEhbrsyU4umbuFTBzFyijuBpV5LR5LCPY9QAk5dS+VZckbEpWjDryDscAER14RsP8xylFKMCgl3djGofvQ+OCuvMKVOuS8vijAnkhwV1tmZXuSkGWjYT2HC1i1ujo86wKYvuiXYIQJnHwfccVzdsdbdmW4ViNkROPoXHARs+C37bu84CcqGAlwdmFGDiqImYEcfXhsS2gYyxeh0l0WL/HRu7ZYe9YVJKNKqiKdgezck9xwta7AsMkLq/7WYZK+qJhdBKE0PPgFpwQkgpqemzI;4:mRho9sNdQLGWY+6qAnxf/4Kv5+YsI0DMyyb1m7EDIuR+BdcnIsSfyfA6JyoLhFlZiqZd3pp/P8eUDksurtZz2iNMJvDWo5i7nqaNpd0CdP8fwEXgY5S7DbZaxTqEl7mQuLzxAjVmsNQhuUmjk4YFsiuK6E7FzYmMFV7Ev52FmMZ+5BuBHlNiw/cWuaO6adoaKgTx+EOzeUzuS4PMKBRK1nj9jbXIIavBXZGzYRbKyFjnR2Mq8oeiw0/2QEMppLY6rYzmaBHrWvKod8S1LDrxbGNxa7wLJ0VXas8OyVQRMeiYPPz329sJA90XfqFOF/eZ
X-Microsoft-Antispam-PRVS: <AM0PR08MB32529ABE9C2F076B1AFD8546B0940@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(346002)(39850400004)(366004)(396003)(199004)(189003)(65806001)(65956001)(66066001)(478600001)(386003)(4326008)(36756003)(53546011)(25786009)(52146003)(2486003)(23676004)(47776003)(59450400001)(76176011)(55236004)(446003)(486006)(52116002)(2616005)(86362001)(305945005)(476003)(956004)(31696002)(7736002)(11346002)(53936002)(8936002)(8676002)(50466002)(81156014)(81166006)(97736004)(68736007)(110136005)(58126008)(6116002)(3846002)(16576012)(54906003)(26005)(106356001)(6486002)(31686004)(5660300001)(77096007)(230700001)(16526019)(2906002)(6666003)(186003)(65826007)(6246003)(64126003)(229853002)(105586002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUyOzIzOndDVDVzZm5ndnU1bzFZSVpPUVAwOFQwM25H?=
 =?utf-8?B?aGgxVENzM3pCMkFEV0psV25GY1luZnJVUUlmd1h3M3U0MU5hSXV2UGozYm5W?=
 =?utf-8?B?SVlKandyVTVDN0dZRG5idkI3bUtoa1E4RGh6bFVUQm1KSHlxSDRJaVFnYm14?=
 =?utf-8?B?RVY5dkV0bk5xSzgyOW1kTFl5bU1zZDV3cGh5S0duN0pEYjhwSzRWbjU4eGlQ?=
 =?utf-8?B?WlRnTjlxMExZeVVISUU2NUQzL0g1U3BCUG9vSWZFVlJyaWRvUjl1U3k0dWY4?=
 =?utf-8?B?UTl6WXdYOE9jQWFJT1JRaGZ5K1FLRWFrKzQ2ZDIwY0hiTmwvUU81WTJRaklj?=
 =?utf-8?B?MU9CVUxWZjVKSXBnUmFiZWxMSGp5NnNoY0xlVXhET2I4R3lFNEZzZ1l3TVcv?=
 =?utf-8?B?K0o0YzFiZ1hsdVlzMWF4OXhFdWdOVldWWEw0SlNPcmxPVUJqa3BqeHNWS0hO?=
 =?utf-8?B?NHZqNjNGQk90cnpXbE5taFJVbllwNzZGd2N4NTlESnY1RlVrZm9ybXNoaWZo?=
 =?utf-8?B?NmYxb3U2QmJ0VkN0QWxkNFhrMHpaSmJNTXFNcGh3dVVkcDhtRXhuK2FNbEYx?=
 =?utf-8?B?YW84aHdGWGltaWJCS0NhZWJiNW9tQWNZSXFHV243eDc4M3c2czlVcjJ2VHpE?=
 =?utf-8?B?WWtVcldkZTB6SXlyZUs3d3FCcWcySVNCTlJjWERpSzVsbUNoa0YzNUs2QVJz?=
 =?utf-8?B?WUdNbFBIaTg3NkJFUU10ODBtdC84NVFSQVdtMUdCNVBZL1A5QTFHWitxNE5Q?=
 =?utf-8?B?ci81aFdKeWpRMTdud0FkU0gyTDIya0VpeDBhR0lXY1gvcENUYytDVTJEdEFC?=
 =?utf-8?B?R2NFRFZXQk1LUVkydVROcWNCNUNrK0RUSzdYNGQ4NFUyWVZFNUtrWnlyRFo1?=
 =?utf-8?B?c250YnpUeitWTkxQK0VsdlNhRHBlZ1IzK1ZxdHdDbm84ekdlUzVGQlNNYW15?=
 =?utf-8?B?VVUvQ0pTak90eXN5REdveWtOcGFkbVoxOFdOTzBjNXZOd3JtckQyV2NZMG5X?=
 =?utf-8?B?MG9ZakZqYWp2a2R6WThRVjR6USt4K2I2eWMwV2pmWDhpbkVyR01yM1ZOOGlB?=
 =?utf-8?B?TkxSZlNRQVRUbTVxL2Zxa1lIcCtBc1BUVHBGUGZuakVQczZzK0QyQTBpYm0r?=
 =?utf-8?B?SVhzaWgwUlk3cHV5Y1czQUtIMXNBM3VPU3A3VnhrU2p5alNOTFNNVEZHWVA1?=
 =?utf-8?B?S0pBZnFTa3NZaUV3S1Nsc2srQUIvdWJLYWEvOE5GZ01Ed215RDh5aXFUT0Vz?=
 =?utf-8?B?TDRxS3llNlFmK3dzVTRad3pCRHpWSnB1dzlaRUFpb0lReDhENGNJRnNxbTJk?=
 =?utf-8?B?M3pmOVRhcEc0YUMzZ0J6WGpZcmp4QnFhZDliWVgvdDlvQktwdzhMVVhRYm9W?=
 =?utf-8?B?OXpDZWcrRURzYisvcUt2TEFKb1VUWG5rV1BmbnhOcjJrS2N2TytKSVZTS05V?=
 =?utf-8?B?amo5cjlPb1Awdm5ndEw1T3dONERid2dWZ3YveC8xUm41a1RYNm5ub1NvVUtJ?=
 =?utf-8?B?ZEs1Y2JPVXovVVc5UUhqM3RRMkVDUlhsOE8vWFlvMXBqUnhUVmp5Z2pNUmxh?=
 =?utf-8?B?b1pTQ29DS1JDYzZaSkhSbFB3TEF2R2piMzI0NG92aGROMTNVRGI5aVpJcDhG?=
 =?utf-8?B?SnNhZks4UGlmWXNSM0hCZ1B6MCt3TXVXRExlVXpiYThKSUtlREgyWkJ1WENi?=
 =?utf-8?B?ak41K2tMdTlWRDBSeWdpSG1lNUdzRFYyenpOV3BpUUYxeW5CakVlZTcyc2Uw?=
 =?utf-8?B?R0FDNGMxMmllZlQ2c0Q4Tm9jWTdwcHYzUTRQYmF2OFRFZFgvejlPcnJGWXh0?=
 =?utf-8?B?eHFraURRYjdaK1p4SEFjbEFGWWNXQ2lxZzNNOG94ZDZlV1hta3dlOENVa2o2?=
 =?utf-8?B?WTVJVXlTTGh1aWh2eGNFV1l0K0RCc2pESWZXVDNLalVrWTF6dFhuSzVKamly?=
 =?utf-8?B?djFuMVl1NmFwdlpyTnBWeTA4S0VPYmlvTmdlZFhWblRzaHo1aEdZNzZrVEFy?=
 =?utf-8?B?RWx5RVIwMm1jQmVGeDRpREdpWloyWVBPM1VBdz09?=
X-Microsoft-Antispam-Message-Info: lNovZa+NiRlOV4+ko8jScsIwfnS6Bld7urPSxB7ynIjy5q9822LGi7jNRayhXZyfReHffs31q4RbDOSLTeW+zIWONypDl1Thpefh5iap+vbOgYlIjDSNsep8+cEyaKzBfUX6UNP3+N2zHIpWfThVDP4Zn5HiM2LrUXA48fWWtTwESTSZLfjJ3B/6SqEqUzj3
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:tnxtHXMvwKR8Zl92oCloWhhMwrm+lBLcENMD0PwvjZGQwEgZcp4N1pXeqkE4rxgJyEtx4weGBrA1JhuatKmDgJ2MsSpgzZhR1S21oLBDLmDe0kTA/63mmA+I/L2Df7lTbUuvXTbolyurUwPwCI/+gEGSsDbR4tUEBLcAcH+n9hmgoFIAd0lzeVbRlY2+gNm4tzjJPj/dq6enVBbE6s59Zl8HNna6b+tVWo1Cqj/ffFRRzSZALv79NqOHgdH/hVd7z2STEb7l5xTKfs4ADgYL+qpkAi/b+uP+3SLOrggMdMrTA8xYBlYPaS/oHvxqKbvbhh14upboFpvQfNIlGeKv2kCcNx4ZQoFSO1+YJn9bvvzxz/oHODNFghyQOZjZa7geIkYfjByV11nxH7tNfKAkq7+76iAsktr435kpc25LljwZjvbt8h28VYN/QABlnBOqH4Wv0uLFFHrrsPx2IxvLiw==;5:oppXY1Wixvg2XmVokcbn6P8k/Uif2EP9NjIllN78UBq6EN9r+CcJg4pfov/Gs/ycaqYJKx+PfcajdopuxOGsXcJhKOgWKJNHX4F1MrOG28HwlN7/KBkKUPCiyYhpxZ1EegsD/cDpcofLU1IoJfbjZU/lbA1mGrMCk+FXUgc2Ess=;24:03xxkbhWctHVzC+4EVZeXsCUVdi+kxOnhSIi1oA/OhDlrzK4HJhRj0mrZgNK1K72/ZGZ2EkB7IxLo8EpSEqJZo9IQAZMx6LmLoU86hpMmTc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:pjrq6sctD6h8Y7xYgrKVENI+EralGfYovyPcjeqaYT9Ji85Bw76gypSDOW3qTCa9fR//gUd0lM1Q6Sy3KDJa3s1/DA8rTN58BHWwcUDNh9MT6jy4DEMoW94vpZe7kYyoa/qeFEdfZaaBL9ossDjptdNNZSJrjnd53C1/n4dcCqH/2e/kaITHO/8m9SXu8BcfNJU9Ygn7nCFyiMFT6Lx2AbcqU5QrvxLprpnmXsOUr5KGI2SHQlMsZMVL0kSZxWsH;20:sFm1AHmrKtuuipGvoDHIOUBMRc7T2OYbcriyUZYumhseSQdIT29eQsistI3WhdR2gy0UoSnXexMZLjayf73LVSG41VwmmqVOsXDcLyA9pDMBLH0YJagNl35L+Icjucl5Ou8EtQfHPV41treJM7Ljdl33H1OUVAvn3U4hZifO7lM=
X-MS-Office365-Filtering-Correlation-Id: 9f7e3c8d-da7d-4f66-19b5-08d5c000a7e2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 16:25:38.6470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7e3c8d-da7d-4f66-19b5-08d5c000a7e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/22/2018 01:07 PM, David Hildenbrand wrote:
> Using module_init() is wrong. E.g. ACPI adds and onlines memory before
> our memory notifier gets registered.
> 
> This makes sure that ACPI memory detected during boot up will not
> result in a kernel crash.
> 
> Easily reproducable with QEMU, just specify a DIMM when starting up.

         reproducible
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>

>  mm/kasan/kasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 53564229674b..a8b85706e2d6 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -892,5 +892,5 @@ static int __init kasan_memhotplug_init(void)
>  	return 0;
>  }
>  
> -module_init(kasan_memhotplug_init);
> +core_initcall(kasan_memhotplug_init);
>  #endif
> 

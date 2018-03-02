Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427342AbeCBMKx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:10:53 -0500
Received: from mail-eopbgr00109.outbound.protection.outlook.com ([40.107.0.109]:18656
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1423004AbeCBMKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:10:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 1/2] kasan: fix invalid-free test crashing the kernel
To: Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc: Kostya Serebryany <kcc@google.com>
References: <cover.1519924383.git.andreyknvl@google.com>
 <286eaefc0a6c3fa9b83b87e7d6dc0fbb5b5c9926.1519924383.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <818fe418-01cd-4664-9844-46455b06842d@virtuozzo.com>
Date: Fri, 2 Mar 2018 15:11:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <286eaefc0a6c3fa9b83b87e7d6dc0fbb5b5c9926.1519924383.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM4PR08CA0050.eurprd08.prod.outlook.com
 (2603:10a6:205:2::21) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 128aace1-e811-4f3b-7616-08d58036a0a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:NWEkJe2IOa2AXf8b+XVtJF+0lDMWkROjZ6lIZU7BFzmqu8aMBsL7I7cMjzzvKU9dw0t1UJMKF79KTsErfzEAW/R4WG4zZkqTetcTe6InkDIYs+ggQQwmXkrdCiNvEzzW+tsB7eXUHEEBMMmr6YDd7iNA3KgfCblRoW3kfnx3ldJQsoNP6snTM7gFeCX1z7F0TnNj0Z0waTg4znvQoH8Wa3EdgsS6GjK8vVLWzETwo0l83p6Z1i/2teT8tYT0RTaY;25:cJXwFNa37/fRBpq+v0meklkwzYluodq95/EukBuCVKm9LgTSo/EHhRT0x5oZ3DJeiKrzRqWTwSZGpbmQeQ+8DrFC0liDVXRP+ZmM6ahE5cEJn8c3+XbFO0kjTrnBlRoDH/t0RD3GQxiBglQ072k6dIhdkhnbdX1h0AuSv9KTWpEG8BxDjm71aoMNCEUn4xF2aslyhChWgldyh3+F39ZFFRrH67AokKeasNB8H8oK01DTCe8e5bzGLlsiqmyiWDMkd442Do7BFzkwTWKYPdeXpcbnXswQ8Er3bVgnRmt9BV94OJt0U49oBhI2At5itciZO4pewrRK4mm5w9n4VOhLQA==;31:pNMG6FZk/Sw5m3QatvM/+UKdYjZdaMGylK+/qGQtrSjFsAfNN4AuLqLI4yljJtXYYe/pnrpnBdSCpgF0HeuJQblZKoEGKFXPt612xBtteiLlUj9Po1CPqiKWXT7C4ZL8dAHbWM4AaV6Rlz1LETDs1lINCdVKuYXol6P2+lIinWbUbHDBDw24Po6NSqyqwZAgPf2OXjFZepY3X9IdJL3rwet1N97pbNHGtIO3gew0+Cw=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:jMX0hRCYRreVMy+GFSQEEqdWtBiBlSl350Z4R7BatBSnP3u2l0TJs2Q6jAY7Bl9KBuK2NokjUnDvrGndQmXe04OIp7Fc9QQKzorhrVN/65J6/Z5nHnLR0eazBGxrqyoPPCi/3e+TTsL9GVHwaxtkwSDaiCecobPCRCLlOVFpbz9bZWtxEWySQhB6nlnNw9AmmjLp/4THE6VKrTcYVFBRWfXxR8DjR9JVd/+51zhxvNJZB5bKsEqvijQlzJJ8qUnHUX/qXGCjcsT+7R5zoBUFXzLXnvH0OFm8soyOwVv6IlzTpSvdw9PVbECn1q605s7tkpKfHUiel99p1RiEGKuBB9P35PMdf9GhX1nFcUaBGmQsjUDifL8nu/yDJiDPwBibzbxjwpRRkvZ+1GiQvSWtb/823gWli9giWG77DRKsL1rIRHxkg4Z+lC6pCmW63kT5zc1JH0hiyeWAN6O4ZDb7NmBsl3ibNNORRR853hG3f7bRC+HALoB41/peAXLjP0C3;4:2sbbKychy33m79lc70xCscrdGj6z+ewC2+XM0FvegP5DVdrcEkyADXMZUt61ixY5lE09UtgRLVFDo0VI2GqW7oTFESpX1pw/f5ZCALVKmSTs9pZYF+kOasvB4Ucq+zGZ6rm+xHf/sTTNc5tlpX5BFiT/oieWs1272VPKrN3N5Ac9tmxQ/eUwCPM+SNLoyD3d0T7pvjdfVXoQqEMlzp/0PAfAFxLfquh4mBEF0ipFbW3GoF5Hy9Dz/JyoW/mm7ek/WnaJjkzZwkzXa1HCOviQzOQnQix2W7tFEkivizUJlzt3NhFZ0s/GCkIckZwFhP5YlcCLQSH1muI5dZKq6MK61riccOogppBVGVUGaOFbAZY=
X-Microsoft-Antispam-PRVS: <DB7PR08MB32580994B8586D76947576C9B0C50@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501239)(52105095)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(39380400002)(346002)(366004)(376002)(396003)(189003)(199004)(230700001)(478600001)(7736002)(81166006)(68736007)(76176011)(23676004)(106356001)(55236004)(5660300001)(97736004)(6486002)(6246003)(53936002)(52116002)(81156014)(305945005)(8936002)(86362001)(8676002)(31696002)(52146003)(53546011)(7416002)(186003)(59450400001)(16526019)(316002)(66066001)(64126003)(65826007)(105586002)(47776003)(31686004)(58126008)(65956001)(25786009)(4326008)(386003)(16576012)(2486003)(36756003)(229853002)(3846002)(6666003)(6116002)(65806001)(110136005)(77096007)(50466002)(2906002)(26005)(2950100002)(20703003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOnRFR3VNVVVRNFVsaTZ5V1JvT3hCOWQrbWFP?=
 =?utf-8?B?VThBOWNDRnNNN3U2RkpTRGoxRWpCK2l4b0FCWXQwWjdjN2NYN0QybHFwTnkz?=
 =?utf-8?B?dnd6ZVQ5c2Y2SmZ5QlVVS0M3R1BXeFcvai9FRzFDN25XbCtpQ2xpMEc5MTl4?=
 =?utf-8?B?TEJLVS9lckNBV0d3Ulkvd0paQlgySFhoMHBVNWd0NzMrbGd0NXRCZW5iQlh5?=
 =?utf-8?B?U3ZaQnNMR3dPVFJPYm1qU1kxZE15cUZnMG03YmNFRVVKNko5WS9uQmRpNU1p?=
 =?utf-8?B?b3RVSWZYTVFRRnE1OFlSWjlKQlNWY0pnNlVWMEYrdUFDOWFlUTBWQlp0azBs?=
 =?utf-8?B?cTZ5MjMxcTdrM2UwS0VmYksrajlHcksrKzdoc0RGMzJ3ZllaWHhua0VieDh3?=
 =?utf-8?B?amtVUWhZbllyS25UaVFTcnJqa21TcUIxSGNsN2I2RnJCOFVQaWdEc2RwWkZY?=
 =?utf-8?B?eVk5aER0U2N6RUZLRWV6QmNSZHgwTWdOZFpMeDVBZGQ3Ujc4T2dCMHJtM1I3?=
 =?utf-8?B?QkVESGhMOFJ6WWl2MjF5YnpuUEF0bzMyK0d3UU5EaVlRbnlmYUd4SjJudVJh?=
 =?utf-8?B?ckJwNzIvWEJvbkVsU0tZMElDdFhUZG12c0hlcW9JTXdDRWsrM0s1eDFXdnVH?=
 =?utf-8?B?V1Z4cm55a04vdjZ0cWVaZVNKRXU5dlJZcHk2WEEwclpJYWt2bkZSRGlyZmdu?=
 =?utf-8?B?YmFzeWtTVGVRR1BkbzBnWDc5RXBDMlhJQ0FNbzYxZW1hejYwQmx0ZE5FRTlM?=
 =?utf-8?B?UUlDTEtMbStDeEJ2RnQxK3hWU2Z4VlNmbTd0dGt6Y0VITjAzMEdRT1pHeW9Y?=
 =?utf-8?B?TWxHZkdQQVRMU2dVbjJMUG1OOWs3VW8xU2JLOXRPam44UUVDRjZEeXlYRjNN?=
 =?utf-8?B?aFpqWXF0TW9oSDhHOW1QYWo1TUd4NWJKeVcrM3BVQ0JTZ0djRlNZVVU3Qkpm?=
 =?utf-8?B?NFNWZlhDTGhUY2VaM25SNGhFR0hnb1VvckRDMzRlOFg5dUxUQlYyU1BmWWFW?=
 =?utf-8?B?STRmQ0EvamEwSTlTVVp1YWlHbUFudW5aQThlWkdBYVdmQkp0aFdTTnJPcUQ5?=
 =?utf-8?B?ejZHYjVmMWlHcThuNm1UdmhHc2NES3IrelRrVTJPSzdVRXJCQU16UTF6UFNs?=
 =?utf-8?B?dGFVWFZ3UUNBRmVpWWxxL2FYSkc3QnlpTzJOaFZHS3RXQmUzdk0xcjJuN0pw?=
 =?utf-8?B?Y0drWDFzQnUrQWdBY2NRRVhZVUkwbEEzS0ZPeHROdEY1K2pjMTBsOXF2L0J4?=
 =?utf-8?B?QlY4OXJ1UlRzZlZwZGVRWk9TRDlSN0dRaHBQQ3B6d1lEZVNtMnhFQnladHdT?=
 =?utf-8?B?N1E0WCtwWm1VdzVzbkJDUnROaG90aUg1VXV2cDhNN3FFT0hzcGZvUG40bDIy?=
 =?utf-8?B?MEQ1RXJxOFpQSGhVcFd1bE9sem4vRXBsV0hGNFoxNDZGSjVSaDFiaDVjNWFB?=
 =?utf-8?B?eXVRSEhsNlQ0SkJlM2ord0xEd1M4SFcyUUZObnRYWUNXMmRWcmxiaEN5NUVS?=
 =?utf-8?B?NGRhcjFlQkhUWDgwd2ZHVEhZMWU5U0ltUEVMNEI0YTMvbnRWSDZkaWc3ZEJl?=
 =?utf-8?B?YTVlRWFkWTBrV0xSZlZwQmJaVFBZRmNpeEkrK3pLM1JQc0QyOFI4ZzBjSWNE?=
 =?utf-8?B?ZTRBVnFkaCtUeXU1Q1pkYmxrTEx2ekxobEdrSGFLOEgyb1YwV1gxZFZ3OFkr?=
 =?utf-8?B?MjlXS3JCMG1SRzJLTzJKeHBVQXI5NFFoQ1YyWWY3MkE3U2ZxWnU4R0kzcjBH?=
 =?utf-8?B?WkFaSnhqYWJxNW42cEtPT1JtN3BTZ1RJUkdQZ0hvNnF3T214dkc2Uk5MM2Vz?=
 =?utf-8?B?OXVWSUlCQmc1MDgyeWgyby9MMnhqenVDSHgzeHdvUksxR1ZUWkpjeThCRmx5?=
 =?utf-8?B?R1BrTzJEZWxvVC84c0JVU0R3REpiSEh0UHBUSFljdWtXcU1hYmZqcUp0Sjlj?=
 =?utf-8?B?OHhTam5OcktXdFFUWnMrVWJXMHl5TmV5dCtPR0tkT29XRFZZMmVsaEFOeE1z?=
 =?utf-8?Q?FLGQIy?=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:Hqmx42oKFLremJjaGyfy/NapVsB/b+SUnUBsxadYbqzBO7oV4+EIsLfZneYD/ghkdl0mnOsCwy/iL1P5N5S+nCbdJdywfhA+p4QNh2rVkIksHbZHpc1BVqmCQZ4Bt+dH+k/g/Y0EjsYlYFEAl8O1yHrODg9rEI+eyFClVKbxHHsJURNsoA9vMsdL5N2lO6o1AR2nBA8/sG3H3DsyNQj4AnMAp2779NDroNSM39Z/XRYPwH9gCkleomqqFc1JzCBvxL6N7LOUa5NYOX7TZHsYcxKkRqQ2QHpcD7H+YS3RjiMqT2a5GuPHI1qYs/2IuoNvS4hdt/rjTrWXGRV4zEyQltdLW6THilXlTXnNAKVOaJ0=;5:Isk22wZ//sVFlmRKeAZGb1lIoG8f/LqCLHQN4AlOJ/+hKQoEBv8Mc/HUOgsy17m2Bg18lEnnLA2JEWckoavFtRwbt+/gNHwPNefLsgSmfQ1vAunrMfVsmhzNxdopZTPQsmjcVYAFq6GLpYGPZaLhXw9zOMZSsOtdKWZczk7Ww5Q=;24:w5iWgGi7ugsl72Kj/pq3q4rk3iuiVn0a7ml/uOWSmjcIMys3ppOTbHNGHuJsT0V+AmzXaIG7Jf1DWK9itbssQwFJSV6p70okjHemPCDQAEo=;7:R7TbG2lEhJanv6pCFOT5dVzNaHWmAnAVNQvhOoizp/NKcDViQFQwsMufv3GVzGy5B2cxIdGGc3a+n4gI47Lr3qNbxCfgmhwPLPZR+Ymj3HVvbU/CA9cPa2dizgzafxtCFm4cvc/DXW+8Fx4JuETAsbL1Fcn8K8Qh7mcvI0rcXBYA1NTpFPcKbfWlwc/TzA3KtcHGIRZ8ard3xhCWT2e1csEPr2bp4vTAw196zGaJ2eyfCZt13130gGVTsShc2Is9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:r/nRmr+YbLaSI82/3mj2gXxKmc+CpyFNJbSKkjWTQ5v11N/mUETfoNlRnuHnAWwwKeU/IS69OJipHScTTReNsXMwbHf2zWQlT+SRtTyEw6ZTDVaVgMbZSUEC1SeghnWu4ttqlIdaCl7IFFwdfffH9QjqO0ScVN+2GpQxpj5UTr4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 12:10:44.0009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128aace1-e811-4f3b-7616-08d58036a0a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 08:15 PM, Andrey Konovalov wrote:
> When an invalid-free is triggered by one of the KASAN tests, the object
> doesn't actually get freed. This later leads to a BUG failure in
> kmem_cache_destroy that checks that there are no allocated objects in the
> cache that is being destroyed. Fix this by calling kmem_cache_free with
> the proper object address after the call that triggers invalid-free.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

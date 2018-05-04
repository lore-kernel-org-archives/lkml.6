Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeEDOb0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:31:26 -0400
Received: from mail-eopbgr10116.outbound.protection.outlook.com ([40.107.1.116]:23574
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751792AbeEDObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:31:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 3/3] sched/core / kcov: avoid kcov_area during task switch
To: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org
References: <20180504135535.53744-1-mark.rutland@arm.com>
 <20180504135535.53744-4-mark.rutland@arm.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <9dbd4703-5d79-0f3c-306c-5d50a757c11b@virtuozzo.com>
Date: Fri, 4 May 2018 17:32:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504135535.53744-4-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::11) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:7wqKppDeDL/f7zOS2AZXgYGTdZdWYo8B90+OFjxOxG6V0lgaHiU/OvELN5vZMFmcb+Frw6b8syY2K223YHFa83G8lZmYeP1+iYr+R7mCohhOaN/EtaVyUaQ9NrQsV5o6Dk6i7U9XRwSGtPNJBSj1YU8T1yQHc9e4sD4jYJ89QAJK7wGR20v7N11AtTgNndRGO63PQE173x0NiPzsexSHbPUsoSOtfcbHxLfj7RZufAb0pvM769cMMcNFasxusjwM;25:CTdxIhHcILXCVRSi8DSNqCpn0bqxtqgeLzQ++n17PFLJzXd3Fox2KBLF/7Ztg6ItlGqA12/5NtS7FeIMLlww6ZClgJOFqs8ebSuCn3+I3+h2Ddv985/nQjrvHjgjnoF9byTWGiPvIQS03cIg1A853oNHJuXu4Fr4MGMTtla1QPiGsx/Ca4RAv0Da4iUD7Uqck3ct0Nu9NSzIDBBVHOxGaskoRpF1A6DA8w6PVkASJbHEPirH+UDfKGMOMVJO9nt1kMZ1tHW7ZoQ/PnCgOQgn7li6jltek1W3831KgCp6OgbKEYFoStoi2cAwoWSu6cwP2Zs4JxodKHTXvbo83MPypw==;31:S3m0Oc/UJCA4iESz3KeEtwfSRx+HAA9N5Aj1fpM6D59yIjkJQwtnykjMWKvO12rJlNkwFmKjwlMfcejTEVidE5EBd/C8NEkxKQ6LWKFX45tejlCJ61PbYcZBw5VdVToNYqvQ7g8fW8GYC8oknf9ID5Y680gU4ZHSDoNlxQmQzufcuoBFo0PA9av5Dc9SEcZ4bJh6DSbS7KTnTdh3bIeCieMzEJEuMWp27kGIDfVQlEY=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:0aP2j63YT6I3U0sZLq6LbgFU8ez7xI0R+14sHUKzTfBCV2QlO8Dn1A00NIsSNb5KwTRnoDoWeWQphbv1AvSUy8cBsXytk/RjdwCPJuRxOF/bFfeeFMbRxW7L2zbH/hl6OOF7llg2X/psynVnaASOjjhZMH2rzC7l4qwC1dhNu04E5OV+KJhKJsB+29aBuzGzu/DyAv40rFMuUGAdzqvQHBSkoQDXy1GIh5h2Drkp8iwaEFewzCE26zSjBVSTYMwLN44IzsrDlbAQcvaezF+qNUAFZW+BhMmIT7n0jzL+UpRyEpS/y9iINHE/tLZPoMRqn/iszxBeV99Kj8lmWPXXY232WuyPq60iYMAcSMNEy7/YWgi16CE72vsu/GeKNqXXtOx+vhOvUYd9KHE/fSHbLmLZJPHPiMJgEnQ0odzw8zSViRKq0dKJXqQX+Td2ebiRCLtSDkXz0Y+kGvbPoFZ5s5YucV4X2q4qnPmJbdMN/Bzkq21NQ8qJ7gMWvqHpADcR;4:7uANjZkMx+0lJnLCkrW9qiy3HXMnqn5xQYYJ3yBX8deWFmLxuW5TFLlCdhe81Oiy0lG48Xn+G4jAsnlVjAlLUBo9nnRj5Z8/KYpAyNIQ1A1F370Q8R1E0DGzwTK/59CjOASwPCQ/GaMD7ML3BpN6Nur6WVw8UCSoSnPp3pvhEUDWZguTp71D+lztEZHBk62VV6GjURr52TSFHtlY0uxswDTQ2XEe0g8Q69ECArKrxyA2kcEw3iKVDQykaxriDbC+izoPk8NQHY7I0rPoCze8YA==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253193F6006624D57FE4DA5B0860@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(376002)(39380400002)(396003)(39850400004)(199004)(189003)(478600001)(106356001)(31696002)(68736007)(6666003)(50466002)(25786009)(476003)(2616005)(229853002)(6246003)(956004)(16576012)(316002)(6486002)(446003)(486006)(58126008)(86362001)(11346002)(26005)(53936002)(64126003)(6116002)(2906002)(558084003)(3846002)(81156014)(305945005)(81166006)(16526019)(77096007)(36756003)(8936002)(76176011)(31686004)(53546011)(7736002)(230700001)(105586002)(47776003)(386003)(186003)(5660300001)(8676002)(65806001)(2486003)(66066001)(52146003)(55236004)(65956001)(4326008)(23676004)(52116002)(97736004)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjUzOzIzOnNYdWxOLzJreDhlUW5zd0prQlBXTmlDZDNG?=
 =?utf-8?B?ZDZ1NnVrMG9PajJOeHk3RGVCQlN0S2h2d0I5SGxzOFpEMXhSa2h6cnZROEUw?=
 =?utf-8?B?UUdhTVJuYTlVL0hzZDVtRkw3VlQzRjZIWTEvQmJ1MmZBQjNOZlUvekFBc0RI?=
 =?utf-8?B?L25pdklBWUcwT0ZjUVk5bWpLSjlUVG5jQy8xbHhNN3k3N25XeVNvamJoMzNz?=
 =?utf-8?B?NEhIRWc1SXh3REdUNUl3WlRxODl6YUN4TjU0QWx1V1U5SzVZY3ZVYW9iZlM0?=
 =?utf-8?B?ZXp6YjhXWmNSajJKUVFIT2EwOFUrZUlYOXBGSlZjZ0FhWkkzS0dJMWN5VjRz?=
 =?utf-8?B?TTNQWWxqMnBhTENiVmlTMEoxdVFjWFNsZ3VBVzZlc2pUYXgvU1lrbVRmSzJX?=
 =?utf-8?B?eklrSGJOQkdnNUwwRURHTGw1Q2h4UjdPWEtVTXRFQWFMNCs3T29jOVBwSDZG?=
 =?utf-8?B?YWR0Vy9RTFNHNU1kOW9EZHFoTlcrczBVeTFuQ0k1TlVqRFpuV3hnUVdtZHR5?=
 =?utf-8?B?L2hKOFBhb1I0bldtSlJ2OXhrRFBQUW9wSmlYQmtHZlhrUEZwVU1zRFZUczN3?=
 =?utf-8?B?d3A3ZFhJTW9BOTRoU293NUl3L0hkTlA4N1ZtSGJsaXNPMkE0K21GbkkvVUI4?=
 =?utf-8?B?bVpaa081ZnQ3R2VueE91TG9GaDdJYWVibkpaVFpFcmZjbEdJcnhkczlOWjZ0?=
 =?utf-8?B?cC9takFQYnBYWVhiZUV0NVl4YXRiNmFBd0Z4bG9JaFVNeDFYODNQTnNWRjh2?=
 =?utf-8?B?MFREaVV0ci9MQkVheFBJN3pZRytTc2htZlBvNHFQUlo0d1Jxa2pyT3poaitO?=
 =?utf-8?B?SVhrZlp0cExJOXZOczZqMnpFTjMvRFQ0Zmhidkdxclc0UEFUTE9UaUlZeTRE?=
 =?utf-8?B?My9MZzZQQ3RERmtUbGM4L01Qbm9veDU2SlE2Y0c1V0htRDlMOXE4TEFXZm4z?=
 =?utf-8?B?TGw3emU2eE5ncHhaUVVId2RHL2tMVE5oV0poNEdONFRScG1IVWNTWWFZZFFM?=
 =?utf-8?B?MTRjUGJPa1JMMnptVWJ6bnZUNjc0N254RWppUXd2TVUzRitRendTOCtvWE5I?=
 =?utf-8?B?MlZBR1p6TGpueW5oRjhPb0cyemNkTFp0ZDB2MU9YbTBsWUptd1pnU0hFWGZl?=
 =?utf-8?B?NkxLaUNib0tLNVVtc3FsR3Jnb2dYYnREWUZ1eGxYcUN2dDBmaDd1bnRFNTAz?=
 =?utf-8?B?TncxZmhWSXV1dkY1TElRRFozRCtla0dvWk5zazJhZVhVUzJ5ZmZNNytrZElv?=
 =?utf-8?B?MlpiNzVDa0Z4NWtTNUVDNWN0SlA1MjhPRzgveWlnWGR4ajhWR3Ezb0pYRlhl?=
 =?utf-8?B?UUYxQkFPRURYQ1lLZE9kTEYzQkhRUVg2U1hPeGp5K0JCYXdXUjJ3anBoekRw?=
 =?utf-8?B?bDEwUGdJUi9aUzcwOEVVbDBFWDRBcjd1TXRBWjAwQmU0UWl1ZkJGOUo5NHdk?=
 =?utf-8?B?YngybXhTRHJ2bEU2a3JnbGNKMHp2Rm1vSW00My9FTkxzUWVPSXRyb0xHQ3Z5?=
 =?utf-8?B?dlFZck9FNzVwY2dFRWkrc1RSS3RGYzZwblZNS1QyNS84QzIzYytXbk1zbSs4?=
 =?utf-8?B?OUZWL3IwMm1wa2NKQlRvY05YakZJcDZUUThvejNKOTNFbmNBbDhOTUpPdmRY?=
 =?utf-8?B?Q1ZWKzhGcCtxUisyNVhta0dPWDh5dG51UEFmMngzTm9nY3plU1VhejA3bFFq?=
 =?utf-8?B?RmlyeS85cEtBR0FvbTJkRGQ3U05nUTltWllDSlhnZmVGTE96ZVBoM1VkYThl?=
 =?utf-8?B?V3ZzZTZ0VTFPMmxoa2k0OGpyZjdZdXB6UThGMHJ3bU1BWnQ1b2lLWlJuNVE1?=
 =?utf-8?B?VmMvbG5yNzR2eFFJREZGK3pBRU1KQTZLYldHNk10WFcrZVUvNkJDOWlOUXAx?=
 =?utf-8?B?WU05THlGc3pRMVlCVEx0ZStnbitaWE1kK3kwaTNaV3VDc3JnUHlFeVFwTDI5?=
 =?utf-8?Q?Yr1dUMK4eidEvclZH7reGpbuH4d2Eo=3D?=
X-Microsoft-Antispam-Message-Info: 3bQZP/WuqxDdddS5d/LM4DY7yv8jhFqMKidCzkf8heemGs6yZzFmGMQe2Oej988m9j+KGuajC/90dgyG7Cliix1PZlIOlNprLTaMO/Mk4QqMZZO8mvQnD1E9lJlH++9W0KsJuxjCb7NmhkLr9wjNKNDuAw3LiMlze2o2OZQM01g0Z2J2rCLHjrfEpxYpuJRy
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:snAdF5l3qR3/W9ofwQnmIouxRP/coimHGmAeGItSqNSRwjC/UCa9+5hiP0kylntmgeYUX0e0ar2FViQ2I3fNR3S2zWIpS9rijpaHz+qseCsjBaOwYHJn+g0x6kjcdsOse4CjxqNFuJdE5SHEXE+0+AjXpUuIMigpXHc1bngeHykirx+lw3mOrhhW8TcCQlsLlggCqPhk9DIelHMNhHxmm6PvD0WVvtJTcPK3DKnF7FBntvvIslj9e6uguIWk0jkxE59KeTr8ALsR8NRoTZdaN0+OA6W2Tvmn4Gj7ph2kCLxn4W57DKU5iFiJtX/vJvBozrbyENZBH6pzpC2zy0Yc4iWNZGC1RvIrY0hXmsCdF+FXeoPAvIG54eqKx6fKHnSKiz0zJ6+Ly7XxMxCUDjmMD8sas4WyB4Z5Ptmp14gx194Lwrsda33IZC40wpbnkTv70TbCekgyGHr3NNbmuRmyuQ==;5:PYvQw5XKS8PYUcqsJ9PPCReUu/K+BcVEoYBJ4hABJUPIlXaQ14nwd66K5obxPqy9YjJCOxFpW1Wp/7s8Cq5CQ4RtKBmDyt/acsVZn3K63lekFLS0xkVDcD15jPa8taAWMPkB2Wl3HEw41XjV81XybodC6vvi3eb7pJ3ZqufAHgo=;24:PlT2RfLWZLKdxvZy27m0i/LY+LA74yA9NjhmUfQp+pgAsYPz5mq5ro9DEcR9QIPQWg830nZtKXohhiDhlc5xDicTbWx8cEx/naTsmIOThrg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:JFuO3V/a3bcHSBWBuRMjf6gChuuNVYXwNufS8Z8LsXWJwq84tiRSiIPEvs1IoRcFkZvDX2IcTG8nyetuCqKoLtxa2aWtt75w2jXgVgJP5wOQQE6XkeLyZrdFNkMqzR1sQt2a0sY0E7KZv0aoLODMVg0Gn8GxwtUrtC7MEqUNEceN5Npz1yytpIloXwhOsKFjfFt2epQcE36VhQ+Bg8I6mTocZWUa+vCejAw7lcgYq4LL/vVMD/jyFJjRzPduIMUt;20:vptdfe3A96GPYiXFcPxXqHKhIuzwPD/KjNBXvslxMND4ISK35HgNfuYZr6KfW9CMRsU83c0eqYcYOUWUUUbW5L20jEZQVviZtDb1co+nxxmHgvHpbjuHnSAEgPEboY3kkoKdNfQ40dO1oJOMX6QFzPJD9k43md1VyfsPx2bVP9U=
X-MS-Office365-Filtering-Correlation-Id: aad1c932-0ef4-42f4-2da0-08d5b1cbb3cd
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 14:31:19.0213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad1c932-0ef4-42f4-2da0-08d5b1cbb3cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 04:55 PM, Mark Rutland wrote:

> +#define kcov_prepare_switch(t)			\
> +do {						\
> +	(t)->kcov_mode |= KCOV_IN_CTXSW;	\
> +} while (0)
> +
> +#define kcov_finish_switch(t)			\
> +do {						\
> +	(t)->kcov_mode &= ~KCOV_IN_CTXSW;	\
> +} while (0)
> +

Why macros?

>  #else
>  

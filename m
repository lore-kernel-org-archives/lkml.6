Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDRW72 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 18:59:28 -0400
Received: from mail-eopbgr20111.outbound.protection.outlook.com ([40.107.2.111]:26432
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751520AbeDRW70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 18:59:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [v4 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        mhocko@kernel.org, willy@infradead.org, mguzik@redhat.com,
        gorcunov@gmail.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1523730291-109696-1-git-send-email-yang.shi@linux.alibaba.com>
 <2697a481-b4ea-9d24-5df8-a30cd7dbdb8c@virtuozzo.com>
 <79741293-22de-2f77-ab6b-9ea8f5cd43c5@linux.alibaba.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <fec524e9-4299-bd0f-8a21-a7bb6b5d4acc@virtuozzo.com>
Date: Thu, 19 Apr 2018 01:59:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <79741293-22de-2f77-ab6b-9ea8f5cd43c5@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.178.229.144]
X-ClientProxiedBy: HE1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::15) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:1HmpMXgOaKAh89iHKFZSYZPzpt4E4NtUuNAOF2uM1R4g0fY0s8ZniB+USWkmFM8j+r61NQ2jL+5L3AnxSMnoxX0uQszLHyXYTZn/YVw3d1el4xqSb2EXn+udbO9RxOWzFtT0J/DMnc/m/yw6kAJtEXxid0uXmSiH9RO6ns+aVtxim1QlXO/llqhrETd4sW3O7tAhf88I4ccmCLU2jdswGYit5GulVhnPd8RgbXTk/UI+hP3c7Hl8KHntf0JtK5VJ;25:fVGeKb/05iA5WjMcFe/CrA676ijbIsDO4B8lP31bunD70fOThyJXrYgEVeCCNb70Z18mVHGkrjkIwG1LrHujBmiXCXhjfCTTLRBMxhXQGWe8J66z8bQ3XG29plt7YO8M4Au1TiMkigOdjTJ6WvWvkAWMmVAV/ZCnPyWcv/EBbFfUk1OjUQDvNdpGDXvwv8f4Jm/7f/aAf1B/DTU+NRk3oPVlACeLVDV0J6/+dL3ZcHgxqKDjLTHR/16mIMYQNceIe+ouACcLl4UQ8K+LUBQuOUTehJHRuUIMKVN31z2jz0xHpbcemvW3DSFrqPz7DZMtKnquu6MzM90coGbAEI41Eg==;31:LFQhNoqClMdys/5/cgalUw4AVHCJJG2IIaNMvudbIRb181tez+g+mVD6Nuvwc7OicwVs1P0q/HkjtK/fjaTeqLGE0g95dmDDUdAPkEs/s01vqSzKpJMdA6P7iipPSr2JOjWboh/VQqLqlhJhLd5yEWrV9OvYapAn3dZqPVfyL2SVeqfNAJrPZtkj94e9PKOVD0sqlWtdJk+3PugTFjwIrpK5f5bMIKvVXTiHjxReDjs=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:WpU9xwv3ih6G4EfOcVFIF295S9yVuL3zwKJEpWssKyOIg0U0rdFy9RG7sDg6fhOwz0eHGx7J2SuTvSWZg8pQ0ISn88TUoxzUd42ZE/8RKD8W42EwYy2zNtL8zeOG+rMfch/BcyRZFVA9XC1yphgwo/9ri+SngmKVsdUj09ePnCyEQ2VBI5hDxRBJbCPvS8X7wWDkvziKjyh7PeY3ufN5r06ec5W0BMdovlYO/pcgjPkRyRt1IrlstGsHCiWLx6AsQhwPWCzdOGfIfDP+x3+7s2XQmaSLuJY1qVoX7pKVoUpYTg3zDEs0KtM4TYuJLVslhNHVZ9QsYI/PfcffWm90NRe5gs4AgfNkoAY0IJxAasXHwY/wdC6pvlTv2e8cbDLRATaO+AeqMirpHncw143Zff3TeCNEn4lT5lLwE7d2AZpB9ErUu96PUJo+Dw0N2vjbIO8c4XqOEwpupIN6o81roMy7t3fTKXUkCBvBwqujUAmMPlt6+uskeD8sUaBNUK5Z;4:leM4lhfVlsgDJV+HNG5C+vUIYZTao4q5iW/C3n927J+J1zNbXFcKwj3Ji/iB0+Xu4ohgKh1al0xYLjRoNA3CV0aX11SY+5/jbS6JPIQyXnh4sFOXcR8IoknBhFxFSbiP4jv0IwoLfqzGdIonTPLC91pY4bXp0rXeeKmnsUu2hgYn03YDWzY8f3jYCPjwjL9hQsB8deZeRASJjNzyt1E6u1It2nUD+k1mEQDOLEDHiWqIqh1Pr2DkZlCWrQO8Ka12EB6giLs2vJHjEipOuDfcmG526ENUD87U3uBaGzKeF+/yFw8Tc94KcadFC9nPvwMxhDIxqZmvFap1fPSizLpW4VISX7PwfKPe6ROcR//KbiYy7WuXTF6S/uVa/MIRH4yjH3YcWNRWVkuJc2v6De8TfOtmVkIouHEBOZdyomYutGs=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134158A19B6CC0D946B9BC61CDB60@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(85827821059158)(788757137089)(168385556255192);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(376002)(39850400004)(346002)(39380400002)(59450400001)(446003)(53546011)(2616005)(386003)(476003)(956004)(6506007)(65806001)(66066001)(65956001)(47776003)(16526019)(6666003)(186003)(2870700001)(52146003)(58126008)(4326008)(316002)(2906002)(2486003)(31696002)(52116002)(64126003)(76176011)(23676004)(31686004)(11346002)(50466002)(25786009)(5660300001)(3846002)(6116002)(53936002)(6486002)(6512007)(6306002)(65826007)(305945005)(36756003)(86362001)(8676002)(478600001)(229853002)(26005)(81166006)(39060400002)(6246003)(7736002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6OXRXdkovOW5nZ3JvWDAzaXJqVzJjODlx?=
 =?utf-8?B?aGxJWGxBaGVrNFpidFJxZ1hVZnZpamFKalQrVnBaNFRrdTJFeHlWTzl0ekxW?=
 =?utf-8?B?cVJaeDhkd2lPbWh1T3ZrWGt6VWZlTm80NUhXQXAxclNZbW5ORFoxdDZWaUdB?=
 =?utf-8?B?N1huVXh6eGhQUVR4eDcwQks3dU53VnhNem5aTmRHdC9Rbk1ibjRaZ0JHczZC?=
 =?utf-8?B?K2lMWUxuOGxsMUVTOHdVcHJjWGVleHZnSHVuUkVyZURwTzB4dHc1WjZKcWlY?=
 =?utf-8?B?NGFNUjdzQWFEeitoS0xFYUlEZFphNW9la0JJanhOaU8xTEdSVXRkTjhSUDh6?=
 =?utf-8?B?dVp0WlZEYU1maWwvSlJlc3NhVkJWcTdzRUpnM0Nsb3JZTlFqTlFqc1RZUHBF?=
 =?utf-8?B?aDNpRUgwSFlyN2V6d2lWUFhXdXRPVTkzWTEyeUdqQkYxVFNDZk1yQnZ4ZEti?=
 =?utf-8?B?ZEpneUtITGpwblpWdmZpVzFLYW5Jd2NqdVQ4Z3VnVGlQZUZmVkxGV0tLZ2ZF?=
 =?utf-8?B?RXgycTY3c2xqNjRnRWoxRzFjbmFsd2hZWXFjakpFSE5JTnBUanlJRDF2Yk5v?=
 =?utf-8?B?WFovbXpOZXI2V0lySEEyZUoyYjByaHYzTGtsbm1ENWhNZDQvdStwN0hCMkw5?=
 =?utf-8?B?MHJ4cDRwN09UTXR1cU0zNnRkZVRBU1NrOGJ1OHA1ZDBlSWZTMjVLTzZCK1Zw?=
 =?utf-8?B?WGJ4QVYyTmF4RjkvaUEwYzVQNE5YYUlnWVBOOHRtNGVta0tXY1JiaE9LQ3hx?=
 =?utf-8?B?UEJUNnU4bFpYZ2Q2aGVIamFTWE5pWjdiUjJBZWU2ZXhURzNzRXVzSnBYUXhs?=
 =?utf-8?B?MnE5Z3pBQmV6WkV2UmpCc2JaNXFxVEVwNU1MTEJScXVPRzFXcWVvOEZoZXlj?=
 =?utf-8?B?a3Vra0FHc0lTaTk1S3lBOXdhK3YzRzhHa0FBdm53SWNRSlVQdXVGWGRrVHZz?=
 =?utf-8?B?M2FQSnV5UW5qOVU0VWdrcDdQaE5tbFk4dklhVXlBRDlUV2RvZGN1Umxkelhx?=
 =?utf-8?B?NlNzck53TnZYWjNXZVNqb3ZYdFhEUCtuNUR0RHhmMzk5Qmw5NUZJanR4L2li?=
 =?utf-8?B?Y0JsUUFuQndYSk4zR2Y0VFRKcGl0ZzRENFRoa1BaS3JVcWpuM2hIajN3ZTc5?=
 =?utf-8?B?eDNIc0c0MytBUFQ2Y010cEc1WWE2NE9IV05nLzA4MEdzN29SQkF6R0x2UEZH?=
 =?utf-8?B?M3UxSGEzOFoyMFIwWk1EZkN2cFV0VnVmUDBGak4rTkx3OVc5M25kRzNlQTJj?=
 =?utf-8?B?Y1hCeU11cGE3L3BKMDRqODBRbHdBTXA3Q2RwVGpzeVF0VEloL0M5RUI1Unhv?=
 =?utf-8?B?TXFjY25pTUUwa1hiNVBhdVJVUnllODlocHgyMXNoOTBQbEc3Qmx4K2dGZkI3?=
 =?utf-8?B?N0RYYzNsWFBpZytqckZEM2U4WU1kV29HVUljTmc2ak8rZU9aU0pGTVBNZW5u?=
 =?utf-8?B?aEwzNU44cTM1SUszY01FVVlmdnl2R1JtOXJwRkZKU3V0Z0xKNGlabis5NEdu?=
 =?utf-8?B?Ry9rcnU3Qm1ZR3VyWUVia0RiRkNzdDcwY0xHYnlwcGI3MGo2L0xIRnFhdml3?=
 =?utf-8?B?ZGdFSE90NDEwOEJVVTNTOVhBT2h2emMwRzB6aVo0c214T24yOXpjK2t6V1V4?=
 =?utf-8?B?bEVFdVFxU2JDSm1pOTB6TDgwajV5bGxUUnlVeDVHVG1YMVQvT3QvUk4yWlE5?=
 =?utf-8?B?YXJBcHFucDhabHM3emMwaEdhNytlcFB3cUV0L2ErMEZUd2gyM3RYcXVGUU9I?=
 =?utf-8?Q?dWgzV0N3fF0ewFkJxZaxc8AOAeQZiKmBsoWezdA=3D?=
X-Microsoft-Antispam-Message-Info: j/28qijB66oVFJEr7UOfa8Zx+Stq7FrZRr1gkXmf7Wrz/WiH/fF6My+W2HIOW8gax36Do5djC387C4esVo6phjBWAkBEKl+ggwBbkfMMt3VNSkRXrBZRunbrGrHrAzKnsKXADuqLzlMzS0PwbDjlsjsqbp8gAM4TPe2tQS7sd2l3lJcZL8KQchtuqLrwJo67
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:87YetVA+hh84P3X+aTCJb7qX4iic9JG1PJPkemc1cVq9yK1RM54KlpY8NcUEZtIkobvn6xXVBRJfGM8amlH3FbSjLcHWDLMdQq01xfbLPAqtFYM4Uor4yWKdojeXFCSESTLk6k1XfziHbfFlz01vlUYjlIx0v+beZgtqqsPrtZlhgx8MrKQ5A8ffVsYU5gzWSMoWsAS2s+J7viZ5JDRsFKrKEW1ep/Ww4OROPzqlwY9wyKKLse9CZ4WCMWtaq4ft3bCgW27g0jS6Oz9EQiUvFRx2x3fo4Nup/U8ZKsD4dkvozPx8dEbZPwRq6A6TcgzdBF6icEQqyptE5t+E17d+XucCysNqA5aotixTaSzvfBRg7kCjP472CYJth8AwTACvhStqGn1Ka9OftQqcTUvvKtNs0MEnDc50j+9HgfnluEZSBvaR+V7qrHSbLDPbB8lAoSewfXa9KB7jdzxKCoSASA==;5:dD6jj2UrkP8FfcjKDbA3JU8bhI71rSpOcxvKyiN7GgFh16luzTpTGPAwSnnPdbuSGpQ8kNsFuNHdF8LW8urUr+NbUeZhKpXzLlGJgi+Hn9OVNBOrhieAeebhOo/g5MtStf17pek3W1pMwOdyjNJvfn4r8qOE/gdRsSr073DNuN8=;24:RjMNnfWzbCNUVwSbqEgAsVrbR28U+V0WQZUEmBgAOkleSrGh6gOfRqYPTd49ZJKikha8NH//WKBQUQtA4xJLYjvBi9+hECQtEhVd6lZx0f0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:lPNUDTpjgfRb3duXvj2QnAOgqYz7B4EcroB/8+zVheBH/NNClYLfwTC/n2We5HEqm85UCrrLDronVbrpGz0i8BuOT8KWRKpPCz/NH9LEYcoiYVSOoUtuVZyohUDtsH+WobifH2CYDnJchCtKbGZp+A9kGChxvB+NtSd60dgYtypEOoJh8OkLlbV8zrlzRB06vrbVfMO11MnCtd2CUHN6M3AP9c9sw3uxcU1ylGJkHodx9FOyYR/c5UPQO1DPJO7l;20:Q49sle/jbi/pjabFs8nThQI3aSE67POChPGKCP8NyNcqFk/aUGRyqnPDeD6bZKZE6JWSvwi6D2CJoj+/3JH5q63YzE0ev0+yiyXuI8xl1JpyiW0nUCpu4tRC327TBJqqj6J0HheuOvsg/G3NWQfyvUmPcEoOFBo6bL3/tbuY35g=
X-MS-Office365-Filtering-Correlation-Id: 50fd92c2-143e-4943-50d0-08d5a58005a6
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 22:59:20.4475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fd92c2-143e-4943-50d0-08d5a58005a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.2018 21:48, Yang Shi wrote:
> 
> 
> On 4/18/18 3:11 AM, Kirill Tkhai wrote:
>> On 14.04.2018 21:24, Yang Shi wrote:
>>> mmap_sem is on the hot path of kernel, and it very contended, but it is
>>> abused too. It is used to protect arg_start|end and evn_start|end when
>>> reading /proc/$PID/cmdline and /proc/$PID/environ, but it doesn't make
>>> sense since those proc files just expect to read 4 values atomically and
>>> not related to VM, they could be set to arbitrary values by C/R.
>>>
>>> And, the mmap_sem contention may cause unexpected issue like below:
>>>
>>> INFO: task ps:14018 blocked for more than 120 seconds.
>>>         Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
>>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>>> message.
>>>   ps              D    0 14018      1 0x00000004
>>>    ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
>>>    ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
>>>    00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
>>>   Call Trace:
>>>    [<ffffffff817154d0>] ? __schedule+0x250/0x730
>>>    [<ffffffff817159e6>] schedule+0x36/0x80
>>>    [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
>>>    [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
>>>    [<ffffffff81717db0>] down_read+0x20/0x40
>>>    [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
>>>    [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
>>>    [<ffffffff81241d87>] __vfs_read+0x37/0x150
>>>    [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
>>>    [<ffffffff81242266>] vfs_read+0x96/0x130
>>>    [<ffffffff812437b5>] SyS_read+0x55/0xc0
>>>    [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
>>>
>>> Both Alexey Dobriyan and Michal Hocko suggested to use dedicated lock
>>> for them to mitigate the abuse of mmap_sem.
>>>
>>> So, introduce a new spinlock in mm_struct to protect the concurrent
>>> access to arg_start|end, env_start|end and others, as well as replace
>>> write map_sem to read to protect the race condition between prctl and
>>> sys_brk which might break check_data_rlimit(), and makes prctl more
>>> friendly to other VM operations.
>>>
>>> This patch just eliminates the abuse of mmap_sem, but it can't resolve the
>>> above hung task warning completely since the later access_remote_vm() call
>>> needs acquire mmap_sem. The mmap_sem scalability issue will be solved in the
>>> future.
>>>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Mateusz Guzik <mguzik@redhat.com>
>>> Cc: Cyrill Gorcunov <gorcunov@gmail.com>
>>> ---
>>> v3 --> v4:
>>> * Protected values update with down_read + spin_lock to prevent from race
>>>    condition between prctl and sys_brk and made prctl more friendly to VM
>>>    operations per Michal's suggestion
>>>
>>> v2 --> v3:
>>> * Restored down_write in prctl syscall
>>> * Elaborate the limitation of this patch suggested by Michal
>>> * Protect those fields by the new lock except brk and start_brk per Michal's
>>>    suggestion
>>> * Based off Cyrill's non PR_SET_MM_MAP oprations deprecation patch
>>>    (https://lkml.org/lkml/2018/4/5/541)
>>>
>>> v1 --> v2:
>>> * Use spinlock instead of rwlock per Mattew's suggestion
>>> * Replace down_write to down_read in prctl_set_mm (see commit log for details)
>>>   fs/proc/base.c           | 8 ++++----
>>>   include/linux/mm_types.h | 2 ++
>>>   kernel/fork.c            | 1 +
>>>   kernel/sys.c             | 6 ++++--
>>>   mm/init-mm.c             | 1 +
>>>   5 files changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index eafa39a..3551757 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -239,12 +239,12 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
>>>           goto out_mmput;
>>>       }
>>>   -    down_read(&mm->mmap_sem);
>>> +    spin_lock(&mm->arg_lock);
>>>       arg_start = mm->arg_start;
>>>       arg_end = mm->arg_end;
>>>       env_start = mm->env_start;
>>>       env_end = mm->env_end;
>>> -    up_read(&mm->mmap_sem);
>>> +    spin_unlock(&mm->arg_lock);
>>>         BUG_ON(arg_start > arg_end);
>>>       BUG_ON(env_start > env_end);
>>> @@ -929,10 +929,10 @@ static ssize_t environ_read(struct file *file, char __user *buf,
>>>       if (!mmget_not_zero(mm))
>>>           goto free;
>>>   -    down_read(&mm->mmap_sem);
>>> +    spin_lock(&mm->arg_lock);
>>>       env_start = mm->env_start;
>>>       env_end = mm->env_end;
>>> -    up_read(&mm->mmap_sem);
>>> +    spin_unlock(&mm->arg_lock);
>>>         while (count > 0) {
>>>           size_t this_len, max_len;
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 2161234..49dd59e 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -413,6 +413,8 @@ struct mm_struct {
>>>       unsigned long exec_vm;        /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
>>>       unsigned long stack_vm;        /* VM_STACK */
>>>       unsigned long def_flags;
>>> +
>>> +    spinlock_t arg_lock; /* protect the below fields */
>> What the reason is spinlock is used to protect this fields?
>> There may be several readers, say, doing "ps axf" and it's
>> OK for them to access these fields in parallel. Why should
>> we delay them by each other?
>>
>> rw_lock seems be more suitable for here.
> 
> Thanks a lot for the suggestion. We did think about using rwlock, but it sounds the benefit might be not worth the overhead. If it turns out rwlock is worth, we definitely can change it to rwlock later.

I missed your discussion, and failed to find the overhead details.
Could you please to point that or shortly describe, what is the overhead
of rwlock in comparison to plain spinlock?

>>
>>>       unsigned long start_code, end_code, start_data, end_data;
>>>       unsigned long start_brk, brk, start_stack;
>>>       unsigned long arg_start, arg_end, env_start, env_end;
>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>> index 242c8c9..295f903 100644
>>> --- a/kernel/fork.c
>>> +++ b/kernel/fork.c
>>> @@ -900,6 +900,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>>       mm->pinned_vm = 0;
>>>       memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
>>>       spin_lock_init(&mm->page_table_lock);
>>> +    spin_lock_init(&mm->arg_lock);
>>>       mm_init_cpumask(mm);
>>>       mm_init_aio(mm);
>>>       mm_init_owner(mm, p);
>>> diff --git a/kernel/sys.c b/kernel/sys.c
>>> index f16725e..0cc5a1c 100644
>>> --- a/kernel/sys.c
>>> +++ b/kernel/sys.c
>>> @@ -2011,7 +2011,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>>>               return error;
>>>       }
>>>   -    down_write(&mm->mmap_sem);
>>> +    down_read(&mm->mmap_sem);
>> This down_read() looks confusing for a reader. Comment to spinlock says it protects the fields:
>>
>>     +    spinlock_t arg_lock; /* protect the below fields */
>>
>> but in real life there is not obvious dependence with sys_brk(), which is nowhere described.
>> This hunk protects us from "execution of sys_brk()" and this looks very confusing.
>>
>> The generic locking theory says, we should protect data and not a function execution.
>> Protection of function execution prevents their modification in the future, makes it
>> more difficult.
> 
> Yes, it is used to protect data. As I mentioned in the commit log, check_data_rlimit() use brk, start_brk, start_data and end_data to check if the address space is beyond the limit. But, prctl may modify them at the same time.

But sys_brk() does not take the new lock. Prctl protects against sys_brk() via
down_read(), so it's impossible to say a single lock, which protects brk/etc.
This will be a problem if someone decides to implement something on top of this.
Which lock should he/she use to get consistent brk? Both of them.

> 
>>
>> Can we take write_lock() (after we introduce it instead of spinlock) in sys_brk()
>> and make the locking scheme more visible and intuitive?
> 
> Take a lock for what? Do you mean replace mmap_sem to the lock?

No, we should take both of the locks there. mmap_sem will protect
more variables, of course, while the new lock will protect only
brk/etc fields the comment in structure says. Then we'll have the
clear synchronization scheme, and all the locks will protect data,
but not one function against the function execution.

What problems we have to insert the new lock into sys_brk()? Is this
because it's sleepable?

> 
> Thanks,
> Yang
> 
>>
>>>         /*
>>>        * We don't validate if these members are pointing to
>>> @@ -2025,6 +2025,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>>>        *    to any problem in kernel itself
>>>        */
>>>   +    spin_lock(&mm->arg_lock);
>>>       mm->start_code    = prctl_map.start_code;
>>>       mm->end_code    = prctl_map.end_code;
>>>       mm->start_data    = prctl_map.start_data;
>>> @@ -2036,6 +2037,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>>>       mm->arg_end    = prctl_map.arg_end;
>>>       mm->env_start    = prctl_map.env_start;
>>>       mm->env_end    = prctl_map.env_end;
>>> +    spin_unlock(&mm->arg_lock);
>>>         /*
>>>        * Note this update of @saved_auxv is lockless thus
>>> @@ -2048,7 +2050,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>>>       if (prctl_map.auxv_size)
>>>           memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
>>>   -    up_write(&mm->mmap_sem);
>>> +    up_read(&mm->mmap_sem);
>>>       return 0;
>>>   }
>>>   #endif /* CONFIG_CHECKPOINT_RESTORE */
>>> diff --git a/mm/init-mm.c b/mm/init-mm.c
>>> index f94d5d1..f0179c9 100644
>>> --- a/mm/init-mm.c
>>> +++ b/mm/init-mm.c
>>> @@ -22,6 +22,7 @@ struct mm_struct init_mm = {
>>>       .mm_count    = ATOMIC_INIT(1),
>>>       .mmap_sem    = __RWSEM_INITIALIZER(init_mm.mmap_sem),
>>>       .page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>>> +    .arg_lock    =  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>>>       .mmlist        = LIST_HEAD_INIT(init_mm.mmlist),
>>>       .user_ns    = &init_user_ns,
>>>       INIT_MM_CONTEXT(init_mm)
>> Kirill

Kirill

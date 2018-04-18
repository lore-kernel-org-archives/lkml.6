Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDRKMA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:12:00 -0400
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:30350
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750861AbeDRKL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:11:58 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Subject: Re: [v4 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        mhocko@kernel.org, willy@infradead.org, mguzik@redhat.com,
        gorcunov@gmail.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1523730291-109696-1-git-send-email-yang.shi@linux.alibaba.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2697a481-b4ea-9d24-5df8-a30cd7dbdb8c@virtuozzo.com>
Date: Wed, 18 Apr 2018 13:11:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523730291-109696-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::31) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:9V2gZCJxU38jvj5z2NUaNkXI9HXeyfgC90b2KbfJ4TqHPvUiSX8ZHAMrXMKiDiO4aSVS94CNOQOOefuzA4togv/yXPxGatbNc7prfZqRM/Gu5hDWW53tpwhklF9PcP0t1Sek7viH/y9uvy2xkrcFC986D6Gx1nh1ObtztalbdTRRlwMUoRY55tIwvoaq/Z3EViEsT3InkQZm0yHvwrWpyEhFlqnrOEmFjgNByUNs8z8sTCSUietrCGrRS2gE4gdR;25:Cf8fHRZAhql77gj9pz6XCJ86UJCiZJiE+HM4wqZq2kADDobbnnEx5+83Upqu3neToSxRswxxCKtA+u4jXbeZdMynccsm1Jc6qRdSAnJQ7AAsGGJoRKO0bZaOR2nP1sg4EZJGi5TGCNT6tmZHUGEBsTwq/ZMkLz2N/IGLgXVzisiwPw79tzoibLebT3F8fIOk9HSu1h2zdpLcvNVEPMq/SW8vcj3MkvUWIMmPLZuJWL3JKPmiIoy1/+/0JA+TFJMKL5IJ5BZN1m7BE0dhUygqwBKRSMjPM3NV13xN7so7/lWH0ghcsv8PWY/s1yuyEyqz1ai+98EOZ4qaKNlD3h++Rw==;31:XSrZnn2KaPgzw/D+L6e6BD34LqBK9GM+WgvfmzfmwwglKE7dD8O0oyQ6nUanSI+0tSaIFZ0TCSIXCIraR/zrx2O3nw4LdknnNDw+hZSrzme3btX2Ao/4+Mj/NNtvFIkJbdBFOY1fQcdvxX/yM5oLU+X5QN8TL2NJJc45la4AjJgLRVAXUnEfKF7HR0zS2jk3PKd7IeDqUnolvW8KqBAIp1JdJqy6or5bjIJQRb9AAZM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:pu5kWIleN8eNoyh8SCK9SqZ1GO/fZncFblkxW3iMX3xl5/dhrDEhCsbVLjaNG7Kc1rlXZUe305iEeWayo6c97ZZ6W9zlSL4iwJZ9kgjLsc1BM7S81lp7RmChoMt19rEabQuHqcbS3X9lrnqKHxYUgdHRKu1oHMYsmomoBeXXlkCJgl9GDd8wpjz/PZgn82/s8cMtgOiuShPvegLBLw1bTfeNTQuVCqCrIhFgQuZWoLtCWCuo/SW2nWqfVcYubPaXblq39FzD5KNYhcIjllY3T3antVbFreCrEP0HWi0gRrMWL8pHOhgpICWg4THxwNOzb58eGPC0JPKTM7kbCq4elfTYvI5ZDM+BH1W0IUjC7Mlu+bTuZLxZjnMf8/OJYcoyZBDWQI4p8Broy5gnaz7oRQciUAruwcramxWHNdjWyttUPd+kh+in99wgu5JcJDabjTIN7M4mhYmyIYqkgbELQN7o/jjlegXjhzKvdosY5H09gdsgpH+VHIvyCa3pXgmg;4:gZD7JHBtGMCi9cBETAerMmsL7OlGZ+bukvvjq3eY2UXFgebNiLoGo+KnvFnwsfIoIkJ9U/9zjkkqFW6uxi5O0ckTmF1uRxKHSu8AICBXIK46L7jEptsv/2cfIZhH81zgg4NYVBvT9Y+UqLOEYCueTh7Tc5IUD49mDRr3RznmNHMxfODxutO2eviPB8NrtJq138ti7FhrSFvr5HBSkxSeDu9LF+TDT/SZt7vodw3v/xZL37pGHhEhi9gtrtNoDr53pXguq4RXxIK+wNXtBwdc3ewILFHxzoHiyirmPInpYuFD+jlBru+dUl++ij4XQEWxsnem6pTFkDDGdCrgnaGDaPIE2nk3dQvwTIjoMGuYsI5VPPvPiCzmeFH6iKZMEUIX8GUCp0UeW2Z9VsnfkCVogJi80RyehjuV/pZmS0kxmR4=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13432E8D78232BE4602066FFCDB60@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(85827821059158)(788757137089)(168385556255192);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(376002)(366004)(39850400004)(346002)(2906002)(26005)(4326008)(386003)(53936002)(956004)(446003)(2616005)(11346002)(305945005)(5660300001)(25786009)(229853002)(36756003)(478600001)(55236004)(52146003)(186003)(8936002)(59450400001)(65826007)(52116002)(31696002)(86362001)(97736004)(16526019)(476003)(77096007)(6486002)(23676004)(81166006)(2486003)(53546011)(31686004)(58126008)(66066001)(16576012)(316002)(47776003)(64126003)(3846002)(65806001)(6666003)(65956001)(7736002)(39060400002)(230700001)(8676002)(50466002)(6306002)(6246003)(76176011)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovr;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6TGNKcS9qMFJhdmc4SW03bW5JdGdzSDNx?=
 =?utf-8?B?MWlmREQwT2YwaE4zRm1xS3ZRbnh1eTRmNHVhaU05MFpGeDgrYzNzYldaQVUr?=
 =?utf-8?B?YXpmN2I3QTNsNW9MblFnakVkSWYzZHhPTU5TTlBrNWFLNlRNT0xiQ2pTSXY1?=
 =?utf-8?B?b3FtWnhJNDc5WVNpRm5weTZCQkl1YkU0T21CWUM3MGxpTlNYcmM4ZXhqM0Fz?=
 =?utf-8?B?cnJsRlg1UVZTNXN5UERWb3k0dmtMcGo2NUZSQjF1N3Z1ck9MSUVtSm1CVWQy?=
 =?utf-8?B?QjRQZGdRZGpJY2tOUkg4a0VpMDRUelN0MXJFSXB1NGMxT2liVGE3NG9FVmd3?=
 =?utf-8?B?S1k5V3AwK2lvQXh5NEdZS3puNmpkYUd5bFlrSU1yaWJVTXJxSC9qWjFnWkxU?=
 =?utf-8?B?SzBVTmdvYmdiSE5ZbVRlRVJza3JWVHpNV1ptVDRjMG9XMUh0b0ZCSnNXb2Vl?=
 =?utf-8?B?WUtrMENSTzhGUDNsdE5FYlN1cFBXNEtMOG50TFpPbTF5TkNjcEg0WGhpS3Vt?=
 =?utf-8?B?Ty8ybndsd290VkZOQUtpK2NTVnlVdjRSWW9NRExkKzVnV3pucURlSEVaSXk1?=
 =?utf-8?B?d0lJZGlidXpaaVI4WkVIdk9jT1R2MlpqcGQ4VTNRd09DQ0N5SlFpV05UUnMr?=
 =?utf-8?B?SExwZjJxY2I1eVhaUzc2Z0kvejNiV21Ic0g5cUt5Yy8zQXVWdkd3cWpFTmhr?=
 =?utf-8?B?cjNvOWFIRkN6bXAyNEg4SzVtYkg1UHV3Z29XOWdBanR1ZHFvTDh6ZHVvSkdG?=
 =?utf-8?B?Sjc1Y2MwZFNCZUYrV0pwbzl0a0g0T1Vwazl2OGtRLzIvRk5TTHVONU9XVWtY?=
 =?utf-8?B?VW9nMXBZb0VkSkMvdVFDN28xd1Bla04wT3JyN1lScy94ZDBhbi94NzRUZXZa?=
 =?utf-8?B?c240UGU2a053c0RIU3dQWXRQNkpIR0JVLzZpTXljOFBjN3FIRVV6cWpFOCts?=
 =?utf-8?B?T0YwcUVmSmdiOFZkME9OZjg4cWNwUy9Pc0E1cWw1WmFJekFiRTNXRWFaT3VX?=
 =?utf-8?B?VExTMUNHc3l1dng0MnloRXExZkZEazVOUGFPSkxnZzR4QVlTY1NqbW5tVzdP?=
 =?utf-8?B?eVY1cGxMMWNCTjlUMnd6VkxVT2k0TExDMnRVeWxTZitwRVVzakdSQkI1M2Zi?=
 =?utf-8?B?bnZYdXRrbVFLQi9PWUFueXBUc0JDekJaVzB6YUErM083a2hvOTVaNUhIQVFR?=
 =?utf-8?B?MmpCUHp0a0hiQkh0bEZmdkdjbkJsamRscTRiRnN0b2NnL2lsZm9WQWhkSkts?=
 =?utf-8?B?dTNnZ3dVNEV0TGQ0VWhWelEvT1RRYjAzelV2c0dyRUNIUlAycnFhNnFoOVhI?=
 =?utf-8?B?bTNKWHBobGhUeStuTXBzU0VlWGsyNDEyR0RKaW1GL1g2S1dwaE9UUXdmUXJj?=
 =?utf-8?B?L2VBWWtpU3FqUFV2bFNwWHJsNjNXSmZKQk1qQlpGTkp3ZUZSL1dvS1NsRFR6?=
 =?utf-8?B?WXB2dDZTZUJmTmZNcEhaS0JVTHlsTU4xVnV5WEloeVBEbThEbHROVSs5YXpj?=
 =?utf-8?B?QkRaWHBsRy9mbUpERkVxb3dwOUpaRmFPc1gxVC9EL0xxaCt3dkRZdjRKZGpk?=
 =?utf-8?B?aGhEZ2RMUTJjcVpZL2dxSVhHbzV6eFFBR3Izb2JpWHFBeU9WQU5VUkFNU1hk?=
 =?utf-8?B?eW5xanRiQVV1TG93bEVrNkt6Vk9JWk1HRGY3cDg5U256K3FDM1hicklsWTVp?=
 =?utf-8?B?TmFkaVZ6QlZKdjlOK2NhaG9nN1Q2cThCS2RkajV4L21nTlJteDdCcURYckxx?=
 =?utf-8?B?bzJ2VFR1cTUrQ2drMkozMzlmWUpwUGl4MSs4LzZQVWtDV1FzWUtqQXBLRkRQ?=
 =?utf-8?B?RHhvMDF0QlIwM25QaFM0cDJ0MytnamtxRit2MmVEQys5VjZEZz09?=
X-Microsoft-Antispam-Message-Info: vuJiNo7eeLKYvvJ3TURD/SnN74j5XuQeEPgsMkthwrJscqyQ9F6/6cgimFwIjck28IkdGZrpYeM71ET0QMFePaL15HZtsajIG7s5t/wXKDJ5ZtxvV6LwJGC6+jITB03B9FoHnnpSRifVhGDTLcnpNiyazJldKZ9G2fgVEtuBQ+hQh1CCuneNJJZFavFwxfdr
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:d3wC1kg/X0PKXzwyMRH7x46+Bi+O3/GYpQ6Mq4DY5Unj7GiiG8TJCrjaDRS1Nt34JD9FfsGCVTEwDAUgRF5vHF64+zD8fbKN68TM69c7pfQF5Ny28HsCy3WIWWciNCDcDkJZHVhOWkNntScOXpIAewmE+uWDp11QPYw1R0rqO9CdZ0QxhKFvcTUDYTjL9i20gqVNkNqzq3isRgNM9MNvoHZzdG1wKyWZ6zhtiEdx5ef2h/jb+89kDzmoA1vKb0NHNiONQ06GlqfQdiP8TxH/vuM24LR5/r607bmuaRDEu6Raqb9F/U7tGZMoQD/ns+YHJmZSnOEr8kBJfs2Jzcpl8QWRjIBtKe54ylBU+SRYJ7E1KSubUpSQw4nw97ois8iAAEO61fcwuXm9V1iUvdf+0ITqotgh8bhyRUowEnCDvfByyQWww3GU+HFyYLqQdawu4RGrs5Y41MsF/XT77IFhwQ==;5:RXtxSe8yJ4Xe+hXB+s94z7B3TZB4iKO/oVNIzB3i3JqigPLS6LBwunf67fjcgHF0kdbTkoOnko1WVMz/PMG4Z+SitmxCgvPjaLQsdujfk5d2rVN6J1XKWvJgu12rkD9xGuDzDwE0CGMp6xqz5bXqcAtUNlQjXdcjH4msjRdVLE4=;24:iu0Lh7oIc/FPMRijDQzfXizStBGN6kdWeVIlN2iqJiASPSz5JHVE4yjiPOtlY7qBNVifwJolXnD38ClpaRrwOEAUmPMNe76mZNwuoJhcWyM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:YvvX9JnCLeQW5pRp2eWq/K5+5y4syV7ftKz5RoOxfi31OcyXsiWezRkuouOnrXDqen88C5bSZ94NnTLXi57kn+pKxDFCXwiYuCkUG/K8KdBhgTIFhqhi22NbxbRt5hw7Fr10hBZmlpEcQSidVYIyIbsJIILGRnSpGGTYDXsTe0Y6oUgVj1R/cMKxXG4My69DK3vJ/xQWh74k0PbnClO7tMorSSGB1VTKn7NELhNzamc8oei2HDDiy12CmfaHayiU;20:Xks9wj+jLZefdFSLMyKKjmNDDIWFLfTnMSKcsYqrRIVXIU8A1Bipp6hhaQWwLU2vmiN5D2SPB3HoQdOu2scmk0BIGFVJwO/glnOFtJKG9LGOOYdA4RGh+efBB63kbgNcEPjhsUhN3Kzb8fnclCdZytgxplHJnTeg2vsRuWUhSbU=
X-MS-Office365-Filtering-Correlation-Id: 890953b4-d318-4f53-a4f0-08d5a514d010
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 10:11:54.4129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 890953b4-d318-4f53-a4f0-08d5a514d010
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.2018 21:24, Yang Shi wrote:
> mmap_sem is on the hot path of kernel, and it very contended, but it is
> abused too. It is used to protect arg_start|end and evn_start|end when
> reading /proc/$PID/cmdline and /proc/$PID/environ, but it doesn't make
> sense since those proc files just expect to read 4 values atomically and
> not related to VM, they could be set to arbitrary values by C/R.
> 
> And, the mmap_sem contention may cause unexpected issue like below:
> 
> INFO: task ps:14018 blocked for more than 120 seconds.
>        Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
>  ps              D    0 14018      1 0x00000004
>   ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
>   ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
>   00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
>  Call Trace:
>   [<ffffffff817154d0>] ? __schedule+0x250/0x730
>   [<ffffffff817159e6>] schedule+0x36/0x80
>   [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
>   [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
>   [<ffffffff81717db0>] down_read+0x20/0x40
>   [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
>   [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
>   [<ffffffff81241d87>] __vfs_read+0x37/0x150
>   [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
>   [<ffffffff81242266>] vfs_read+0x96/0x130
>   [<ffffffff812437b5>] SyS_read+0x55/0xc0
>   [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
> 
> Both Alexey Dobriyan and Michal Hocko suggested to use dedicated lock
> for them to mitigate the abuse of mmap_sem.
> 
> So, introduce a new spinlock in mm_struct to protect the concurrent
> access to arg_start|end, env_start|end and others, as well as replace
> write map_sem to read to protect the race condition between prctl and
> sys_brk which might break check_data_rlimit(), and makes prctl more
> friendly to other VM operations.
> 
> This patch just eliminates the abuse of mmap_sem, but it can't resolve the
> above hung task warning completely since the later access_remote_vm() call
> needs acquire mmap_sem. The mmap_sem scalability issue will be solved in the
> future.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mateusz Guzik <mguzik@redhat.com>
> Cc: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
> v3 --> v4:
> * Protected values update with down_read + spin_lock to prevent from race
>   condition between prctl and sys_brk and made prctl more friendly to VM
>   operations per Michal's suggestion
> 
> v2 --> v3:
> * Restored down_write in prctl syscall
> * Elaborate the limitation of this patch suggested by Michal
> * Protect those fields by the new lock except brk and start_brk per Michal's
>   suggestion
> * Based off Cyrill's non PR_SET_MM_MAP oprations deprecation patch
>   (https://lkml.org/lkml/2018/4/5/541)
> 
> v1 --> v2:
> * Use spinlock instead of rwlock per Mattew's suggestion
> * Replace down_write to down_read in prctl_set_mm (see commit log for details)
>  fs/proc/base.c           | 8 ++++----
>  include/linux/mm_types.h | 2 ++
>  kernel/fork.c            | 1 +
>  kernel/sys.c             | 6 ++++--
>  mm/init-mm.c             | 1 +
>  5 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index eafa39a..3551757 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -239,12 +239,12 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
>  		goto out_mmput;
>  	}
>  
> -	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
>  
>  	BUG_ON(arg_start > arg_end);
>  	BUG_ON(env_start > env_end);
> @@ -929,10 +929,10 @@ static ssize_t environ_read(struct file *file, char __user *buf,
>  	if (!mmget_not_zero(mm))
>  		goto free;
>  
> -	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
>  
>  	while (count > 0) {
>  		size_t this_len, max_len;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 2161234..49dd59e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -413,6 +413,8 @@ struct mm_struct {
>  	unsigned long exec_vm;		/* VM_EXEC & ~VM_WRITE & ~VM_STACK */
>  	unsigned long stack_vm;		/* VM_STACK */
>  	unsigned long def_flags;
> +
> +	spinlock_t arg_lock; /* protect the below fields */

What the reason is spinlock is used to protect this fields?
There may be several readers, say, doing "ps axf" and it's
OK for them to access these fields in parallel. Why should
we delay them by each other?

rw_lock seems be more suitable for here.

>  	unsigned long start_code, end_code, start_data, end_data;
>  	unsigned long start_brk, brk, start_stack;
>  	unsigned long arg_start, arg_end, env_start, env_end;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 242c8c9..295f903 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -900,6 +900,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm->pinned_vm = 0;
>  	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
>  	spin_lock_init(&mm->page_table_lock);
> +	spin_lock_init(&mm->arg_lock);
>  	mm_init_cpumask(mm);
>  	mm_init_aio(mm);
>  	mm_init_owner(mm, p);
> diff --git a/kernel/sys.c b/kernel/sys.c
> index f16725e..0cc5a1c 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2011,7 +2011,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  			return error;
>  	}
>  
> -	down_write(&mm->mmap_sem);
> +	down_read(&mm->mmap_sem);

This down_read() looks confusing for a reader. Comment to spinlock says it protects the fields:

	+	spinlock_t arg_lock; /* protect the below fields */

but in real life there is not obvious dependence with sys_brk(), which is nowhere described.
This hunk protects us from "execution of sys_brk()" and this looks very confusing.

The generic locking theory says, we should protect data and not a function execution.
Protection of function execution prevents their modification in the future, makes it
more difficult.

Can we take write_lock() (after we introduce it instead of spinlock) in sys_brk()
and make the locking scheme more visible and intuitive?

>  
>  	/*
>  	 * We don't validate if these members are pointing to
> @@ -2025,6 +2025,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  	 *    to any problem in kernel itself
>  	 */
>  
> +	spin_lock(&mm->arg_lock);
>  	mm->start_code	= prctl_map.start_code;
>  	mm->end_code	= prctl_map.end_code;
>  	mm->start_data	= prctl_map.start_data;
> @@ -2036,6 +2037,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  	mm->arg_end	= prctl_map.arg_end;
>  	mm->env_start	= prctl_map.env_start;
>  	mm->env_end	= prctl_map.env_end;
> +	spin_unlock(&mm->arg_lock);
>  
>  	/*
>  	 * Note this update of @saved_auxv is lockless thus
> @@ -2048,7 +2050,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  	if (prctl_map.auxv_size)
>  		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
>  
> -	up_write(&mm->mmap_sem);
> +	up_read(&mm->mmap_sem);
>  	return 0;
>  }
>  #endif /* CONFIG_CHECKPOINT_RESTORE */
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index f94d5d1..f0179c9 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -22,6 +22,7 @@ struct mm_struct init_mm = {
>  	.mm_count	= ATOMIC_INIT(1),
>  	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
>  	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
> +	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>  	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
>  	.user_ns	= &init_user_ns,
>  	INIT_MM_CONTEXT(init_mm)

Kirill

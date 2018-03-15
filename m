Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeCOI60 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:58:26 -0400
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:46560
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeCOI6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:58:22 -0400
Subject: Re: [PATCH] percpu: Allow to kill tasks doing pcpu_alloc() and
 waiting for pcpu_balance_workfn()
To: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>
Cc: cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180314220909.GE2943022@devbig577.frc2.facebook.com>
 <20180314152203.c06fce436d221d34d3e4cf4a@linux-foundation.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c5c1c98b-9e0c-ec09-36c6-4266ad239ef1@virtuozzo.com>
Date: Thu, 15 Mar 2018 11:58:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314152203.c06fce436d221d34d3e4cf4a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0056.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::45) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb4dcc5-13a2-4add-e27f-08d58a52e5c1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:pjDLbiVMI4sdThSdbCBwpVQ3nn1bF+rPbpO20DinOYKswZPtWja7Gbw3jWHxe+tc+V2MpPPBpbpLoP9D7ED8Ey8QUskG65X9wu1Xvf7aEFYZtb+ZOAQ3IAWQQQyn8XQWTs9/L/ZlpjdsFhoVZB8zB6Qb5eQimr1IRqMqBXpywHQqXY1PVBDFy/86GyC4DRruOEUS3AHBbYnaBLbdVpfYDdVLr+zcy/RjpC3vAHgQICPw6B1cvb8/e8yTNuWb632C;25:ffEvmFiEL5d7fvjo1IxluLZ8LYK2nvFI5nK/crPaBz00Fhrw5wvu8D5aWcmTGnCzMq93yd2D1+9yJ9o2FdItt1sbDKVmDtAc6cmxOXG42zJfIuVNWcSUaoPR6Dhd0HDbt7dBKvpvgfWJAZYdrKPQPNpSof5URSSfzo7WlqcFXfh9JRbilPQybLGGT8LDPZu5mlqKN+gxbPfzPG66sn2wvkBKmNcpVu0b7myPZyKKFxTp5tA4iHRzofiY9Ogek31c5iwvlNkga1kZGhJwMF5qOV/oLVMo6yXLttArD54na6IBUCzbbMGK8zShZGVTCN9rTTDpRAo/UftmFZDObIIGIA==;31:zs3qQl1YMYzRSsUu1j0vCsuSaTxj9dCUdTM5CA8jdhBFHa/DGHjOzkVQ8HelF/eM3Xfn2ymBTkogWkybUWao6RtE+NpL3BZ2hrRnL3WZ5VmiG/jJdJQ4gZyNgm6OQ7ResR7NjxGlL16iFwzb0cJ8ErFC9ILfF/atnQ07oidqkqyxCy0UC1mlxN5MyFsLiXm78MHEyXx3FliS8j69NPvy/HrNZFxY447A0VaaK0ouk0s=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:N5PYpnQWRRGdvxHDHhvyZUkT9e2PVixD1E++am6dks6ddFXJR+A1ODf6nX3SvzajKeTjpTN8YEUl2Hl2tEQC1MQlp0f2EqOXAl50XeGfU3VV5WH6Xu3yTrjskx+kLQFfuU9bE272+TYDjk6wcSS2Sa9aA0myqu6NkzsN0EFFMd8y5zCPDA8SpxeGUM3591HgeLtAVk77iZMuZ/YwL7YKx/h07EAxkLxajeWFLnWyqr6Q2Rt9jnueg2Jfv1YlvWyHUFOLsf8du66/h4Ssx0vPDU8TxpXWy0CNzojM+tSuzbbKz7DiuSK5OXwlt4RLMytQ6VV3JRkFIr5MAzyHZErGVONcjsznj+S00t/meV9K0UMCvE2ZWdt11EdwrLwDdy8caOGy0xV6IgxsKV9m+CORWEaApn1rbbnFWED6KgySCaf+mfvAUA3w22d6Ms8piwTFg0Ax2xwvMKww3li4rArIvUd2gDwChf5f2bjj8JaCgYc2EPrfJpeRl0EqwtUjAOGl;4:JxJgLHvsrnQ/7SLXIitmpExv0gTlFNo1RLJZj6ZdDS2dFTVl/TMtoRlQ2KeNH58d8RBxiktQEM4cnALF53IeKJInSnxaZEr7L6iiWSBLRq7DwepRTtiuAMjLB8Ir6VgqRyoyhwlO2XsXDLdBNCfeerv4mOaK1lDFWkgUpKsZ3AezeMlb5ydV7Wib2TA2l48N7vSStgrpOhB6HqK1lZ5yQHAHDtSD3VNMOAdmMCdCiv3iIRXxm01ZIfSsqgkKiKJzQwc0R2muyg2oSsOdUpQduA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332B014B0A1F786E54BCF8BCDD00@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(376002)(396003)(39380400002)(39850400004)(51234002)(199004)(189003)(2486003)(106356001)(25786009)(31686004)(23676004)(2906002)(186003)(8936002)(81166006)(229853002)(110136005)(53936002)(26005)(58126008)(77096007)(52146003)(8676002)(16526019)(230700001)(59450400001)(4326008)(6116002)(55236004)(386003)(81156014)(16576012)(6346003)(53546011)(3846002)(52116002)(65806001)(97736004)(105586002)(316002)(6246003)(36756003)(65826007)(65956001)(76176011)(5660300001)(478600001)(66066001)(305945005)(47776003)(2950100002)(7736002)(64126003)(68736007)(31696002)(86362001)(93886005)(50466002)(6486002)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6bWNKSVV5dXZoTG1NUDVGMmxxbjNsTUMx?=
 =?utf-8?B?MkwzVE9EcUFmNmNMY1owOHIrSjcvM0N3WE1pbG9yU05UQ0RKTHROQzdTS1BW?=
 =?utf-8?B?Mm94Q2ZEU01INkx4cXBHblZDak5SMlB1WTNrOGszYlZUdFpWVzM4REMxNEkr?=
 =?utf-8?B?enlzNE5va1ZHQm5FYnlpc3dsakYxMUFiWC8rOWxRNVgwVzNOV0FQQ25xd0hC?=
 =?utf-8?B?REdRc0hqeHJubzlodDNyODIzT09xVXZiK3RzWkQrbjQrWTFCVWR1UHhabDhO?=
 =?utf-8?B?MkJ1YlBmZHAvdlMrMGUzSURzUjJ6a0ZuWXcwM21zVmdFZ3lYcm84NkFrZzdu?=
 =?utf-8?B?TjJFcXloY2g5ZzI4eXVwNmg5aklsS1ZmeHZRemZFUmJKbk5KRE1LS0RhMHR4?=
 =?utf-8?B?VWIzd3ZkMy9PQXBmWmtsSGM5Q3JUSlN4akUxbzJ6Mk9nQmI0cUM1UU43N2dr?=
 =?utf-8?B?NlBIZkFGREp2dFl0d0NlcitVZGhDVlR3SERDcnNOV2hDVUhubERoYXlNYkpo?=
 =?utf-8?B?V1laNGVXSVlQa1JXL0JBUlF6ZkVJMDRtcWEzdUhyVkYrWTk2VGM3TDc1dllr?=
 =?utf-8?B?OXFTeUlCbmoybjAxdFFxd0Y0TkhXUVJNOFF2VnQ2K1Y3clUzMHpQMDQ5Skg1?=
 =?utf-8?B?a2k4WlM1UTR5SEJmU1hodmF6MlhveEsvblJXUXVITDhnKytvU1hpcGVMNkI2?=
 =?utf-8?B?VUNxanlNMm1yWE9Rcmw0UHhPOVlXVGpmSy8vTS85Vi9uaDNDUGUwYXY5QUJx?=
 =?utf-8?B?V3dQUW42dW1Ib0JJZk9ObEJZV1Q1N1pLZ1Fqa2o4YmNIZTJqK05CWXBLSS84?=
 =?utf-8?B?RWJzMkpralZQbFNMNkVSRXZDejIvS0JSYWNOMHpFR3BFbWxFNjZZOWZkcnRu?=
 =?utf-8?B?c2hhdzZNUGlRTzE0YWxaS2l4ejdmN1ljSmluZlVvbFpWSDNiOHZBR3lQb25S?=
 =?utf-8?B?R1pmbWR5UU1BdUZGclU2NXFBTVpZSitBR3JDODEzY0VTd1kxMEY4NzVMRmps?=
 =?utf-8?B?Ym1INEEycW5QL1lyWUwzamtEc05ta3pzc2YvM0RvWTRtNllUYlZ3eEFrR3ZG?=
 =?utf-8?B?dmV0U2dHcm0zM2hCSUptMWFWbVdaL0dOaitnL29jQThhRGZ5Y3NUZFlienE3?=
 =?utf-8?B?Vmk4dW1CM09BWFpKUXoxUlM1N3pxZHd5M3VDbG1MVTVsNmluQlpoZGQ2QkVp?=
 =?utf-8?B?QlBlRUROS0xlU1dzSWpOS2JucmdOeU5JV0lsZnQya0hkOE51YTBSWUhnKysz?=
 =?utf-8?B?bi9ZRXh0OFhoaTBYZUNDemgzeFBQVTJ0REVLY3MyNUd5Rnp0ZkF1cnNpY3V0?=
 =?utf-8?B?RVVBV0FqMHcyMURDNmxHbkxnTUdaUXVOVFFpYzJ6NlkwUE4vT3V0TWxBOE84?=
 =?utf-8?B?R2ZlVjlZd2hYenJVQ2l2Y2hwU0cxeHFSMXorZXFJZmJBTytUQktwelV1My9B?=
 =?utf-8?B?bU1FaDNiVlZ4U3ZyRzkzV1BWZHdmeklpUCtUUWhGNTFLUjZQOUFqV000L0wy?=
 =?utf-8?B?UDRyNW5NbXVMa3lnL3dSSDZTQlgvT3Juc0FyM1htZHFpQWlpU0ZXUURKc0NO?=
 =?utf-8?B?clFPdlBpdUJubGswZ1NrWXhJclRZemttcjlMQU1LT2NBd1FETDdaZ0E1blEz?=
 =?utf-8?B?QU8xOWIyVlNGNy8rU0V3YXp1eHIvQVFhd2JNOHJIa2I0cW96RnVHTy8xMGpL?=
 =?utf-8?B?cmFST3MyOVdncUw3cGQwV3ZQbnZpWkduR2ljQmthUTc3U0w5T2RkQ2d2bHJu?=
 =?utf-8?B?S0sxMzRiTnlSSkFJWnEwdzV3ME9McDdMMkN6Yi81RTBzTDRTNjYxL3AvN0VH?=
 =?utf-8?B?RkhxUzF1SGtzVjZxbGxjTnNBOGZQcExjYjVYNE4wSkRJeC9BWnpDNFZ3YmdF?=
 =?utf-8?B?OThNWWhNT3ozRWxUWGdOckZwbXY0MThvbHhJQ0lvSnJHQzIyYnlKekF0TG1R?=
 =?utf-8?Q?gCvsiWy0gIDqOjiFh3mEngU1Hq3TBbhQ=3D?=
X-Microsoft-Antispam-Message-Info: nJ+n7ZcCVWuYvJ6VdzydYpb47hTjKHrNMxUY1WJs5HAHxyZuxyW1PPTkjCo4pdWYkRsrE6P20xZdLAfzkUo+jMUkxYOH0x20+zqasnBh4kc+1ZMrByX6rejNlqwJBn6nRztyFUe6p6O9eoy8CohFmlSCpeeWYwMvPjz7XzjAWVcBs/kjd5SL/8dDfOMyIwekfJFnMbwFgLY0nCq+VK2FHQ==
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:ni6cDyDijh1e7dgXB3OEzB13a7fwv74G+7pQulzYCpVB8E1ihMTI16vRFRQmpEBji8RGq4K8AwMAZ4g76ZENykBnTdqbFJiybuDt7qjP0NAre6BXGhoJzq6UTGCUuqLbEZRcNPxMeo5/LSBUklYFmZSG4dCikiZBwSIR0ptkiD2P7CmRLQqyl96WCmnnvyQ2r4H7q00cPjj6R4Jax5R+Y+U8fbeySrI0E0dRQ5kuzoxGuxCc5ORnfejsS7lzhC9dLIK1JxF0NmKzt4PKkfk7msGg8K5qfhtI5O91ABe4xdMD5JggBKDdZDwjLih1O/mwbxWQ/3OnjEnldr3yrHH0RKqzdYIZhMaukcZVHIb6jn0=;5:U6XexzbldrYsGV3BYS24ojnFtwrrLyIqFj4QaUdxUdsEi3Aap+IWxTG5w7VoqOhulUsAjGGn+9ukiDF4gvRPaEQ+Tsw86Nb3vZT/21X1Orze9EfeDbcXNEN5SXba31i8iPhuJwBwNUwEfWZKpzNBnugV7/RU4MrFysoZq/kEtK8=;24:2RCvZkzyHDk9sMzRGZkYGcHMpgL6xmXesZbEau4TTJ6rULxWYsAL2xtXDtSZEdcHlzkEvQL6489jfFNLjwdqTTniQM5KT3vgpMNf5PkuMdw=;7:UGercFMcNQctafivZOhOL6LC9HabbQQSpVbzQhNm4SihnlP0805VJRpHFOcxqO2aIqIcBHbS67bbkv6RepCGp/P6ef0QWs4OB5KuAlehnkHJLKj+JPLXG23kV/SD5Jy3fqXUU2hQxflNjCGQWmSWhpmocOSA2KqoJmDqksYZua3bgeT6AGl5RT3vnve9uzNEyYqekOdHqL5ra15/siRjl5XvsElBx1Pv1DfZ5kvpWiYFAheC0b8O5poW/wCQphPx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:8yTWGWcnDl3BBh508QLPTuH7vcA/pgmllL7/EYShRZ14w2bpcoZtse0et6tOxRCc4hrGWntBTlnkov72sddIZbElDwN1el2qfoSiaSwmP4xQWs1AwlFcdUEpSPgV13DBsGCluTJe/D3YRN5pBbcyVbEhugODBWdTyrbEQk8QHx4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 08:58:18.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb4dcc5-13a2-4add-e27f-08d58a52e5c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 01:22, Andrew Morton wrote:
> On Wed, 14 Mar 2018 15:09:09 -0700 Tejun Heo <tj@kernel.org> wrote:
> 
>> Hello, Andrew.
>>
>> On Wed, Mar 14, 2018 at 01:56:31PM -0700, Andrew Morton wrote:
>>> It would benefit from a comment explaining why we're doing this (it's
>>> for the oom-killer).
>>
>> Will add.
>>
>>> My memory is weak and our documentation is awful.  What does
>>> mutex_lock_killable() actually do and how does it differ from
>>> mutex_lock_interruptible()?  Userspace tasks can run pcpu_alloc() and I
>>
>> IIRC, killable listens only to SIGKILL.
>>
>>> wonder if there's any way in which a userspace-delivered signal can
>>> disrupt another userspace task's memory allocation attempt?
>>
>> Hmm... maybe.  Just honoring SIGKILL *should* be fine but the alloc
>> failure paths might be broken, so there are some risks.  Given that
>> the cases where userspace tasks end up allocation percpu memory is
>> pretty limited and/or priviledged (like mount, bpf), I don't think the
>> risks are high tho.
> 
> hm.  spose so.  Maybe.  Are there other ways?  I assume the time is
> being spent in pcpu_create_chunk()?  We could drop the mutex while
> running that stuff and take the appropriate did-we-race-with-someone
> testing after retaking it.  Or similar.

The balance work spends its time in pcpu_populate_chunk(). There are
two stacks of this problem:

[  106.313267] kworker/2:2     D13832   936      2 0x80000000
[  106.313740] Workqueue: events pcpu_balance_workfn
[  106.314109] Call Trace:
[  106.314293]  ? __schedule+0x267/0x750
[  106.314570]  schedule+0x2d/0x90
[  106.314803]  schedule_timeout+0x17f/0x390
[  106.315106]  ? __next_timer_interrupt+0xc0/0xc0
[  106.315429]  __alloc_pages_slowpath+0xb73/0xd90
[  106.315792]  __alloc_pages_nodemask+0x16a/0x210
[  106.316148]  pcpu_populate_chunk+0xce/0x300
[  106.316479]  pcpu_balance_workfn+0x3f3/0x580
[  106.316853]  ? _raw_spin_unlock_irq+0xe/0x30
[  106.317227]  ? finish_task_switch+0x8d/0x250
[  106.317632]  process_one_work+0x1b7/0x410
[  106.317970]  worker_thread+0x26/0x3d0
[  106.318304]  ? process_one_work+0x410/0x410
[  106.318649]  kthread+0x10e/0x130
[  106.318916]  ? __kthread_create_worker+0x120/0x120
[  106.319360]  ret_from_fork+0x35/0x40

[  106.453375] a.out           D13400  3670      1 0x00100004
[  106.453880] Call Trace:
[  106.454114]  ? __schedule+0x267/0x750
[  106.454427]  schedule+0x2d/0x90
[  106.454829]  schedule_preempt_disabled+0xf/0x20
[  106.455422]  __mutex_lock.isra.2+0x181/0x4d0
[  106.455988]  ? pcpu_alloc+0x3c4/0x670
[  106.456465]  pcpu_alloc+0x3c4/0x670
[  106.456973]  ? preempt_count_add+0x63/0x90
[  106.457401]  ? __local_bh_enable_ip+0x2e/0x60
[  106.457882]  ipv6_add_dev+0x121/0x490
[  106.458330]  addrconf_notify+0x27b/0x9a0
[  106.458823]  ? inetdev_init+0xd7/0x150
[  106.459270]  ? inetdev_event+0x339/0x4b0
[  106.459738]  ? preempt_count_add+0x63/0x90
[  106.460243]  ? _raw_spin_lock_irq+0xf/0x30
[  106.460747]  ? notifier_call_chain+0x42/0x60
[  106.461271]  notifier_call_chain+0x42/0x60
[  106.461819]  register_netdevice+0x415/0x530
[  106.462364]  register_netdev+0x11/0x20
[  106.462849]  loopback_net_init+0x43/0x90
[  106.463216]  ops_init+0x3b/0x100
[  106.463516]  setup_net+0x7d/0x150
[  106.463831]  copy_net_ns+0x14b/0x180
[  106.464134]  create_new_namespaces+0x117/0x1b0
[  106.464481]  unshare_nsproxy_namespaces+0x5b/0x90
[  106.464864]  SyS_unshare+0x1b0/0x300

[  106.536845] Kernel panic - not syncing: Out of memory and no killable processes...

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeCOMJr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:09:47 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:29344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeCOMJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:09:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] percpu: Allow to kill tasks doing pcpu_alloc() and
 waiting for pcpu_balance_workfn()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>
Cc: cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180314220909.GE2943022@devbig577.frc2.facebook.com>
 <20180314152203.c06fce436d221d34d3e4cf4a@linux-foundation.org>
 <c5c1c98b-9e0c-ec09-36c6-4266ad239ef1@virtuozzo.com>
 <5a4a1aae-8c61-de28-d3cd-2f8f4355f050@i-love.sakura.ne.jp>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <77e9be93-3c94-269e-3100-463b39ed9776@virtuozzo.com>
Date: Thu, 15 Mar 2018 15:09:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5a4a1aae-8c61-de28-d3cd-2f8f4355f050@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::27) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf64395-3671-4e83-128c-08d58a6da172
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:MfEfVkhF/f7j+QOAf/yOCkN04QPLi10YzTp1+r10HEXP4QDiMAJdjsDTEaTKY+heIaww3karTrkO0rRDq0h/lI/fZnc2CZpImGlhz6x5VxTkv7q/wX3H82Eh/gO0Y9Et6XjRG5ljYyulWLqEbxAd7QfA2fJgPotmtT2IB8TH+zuChphHW4A62W8Y094fLecWHj0ON8aejlcdXRcORbwwCDcb1OAQMKLPMrlc92bBWHIUyfQkjrNmqfBdgmgSeXhr;25:9ZYlenrp2cqxZJW5jTiFOce5gCdwEizIBjA9LhGX69sNPiIg3QzVnL3gDlGbI9X/QT+aofJWtyU+EpxIvWoS64i7NCQHwdu3Rgo6kG8Fp1TcCWYdiEG9ldUlbmLaSZ3ZYIj69fDaZPLDLVTAPs5zbyM95KabbK3xwss09ko+Ty3IjWeNRhBBg2ImceBOv6pj0S9e2qYdbRLn15RIifXiz2Z8161pHQ0IpQSejRKpbt0VFn8tlP/z9AG3Fh1v4FY7oRHLb9kQfNAFfhEADsL4Kz/1aJq4W+MrG+OJ1KsxV0mZpHlEakkaNyXNeXtQ8JrMhHFW7DSFXvUkg7dOgjNvOQ==;31:F/nytqP0/yhDIg7JrXGRmB79i66xN6EaddlhHUvfAczSAMI9/NpGjaercXcP7nVGr8zLPonp3er3v77alAgznUFOlHoSf8IREEXLJVj2lm6IyQKTMuQliypRDZV3Yqoq5CmtoPng6zulebZDYa77PB/a0uxpV5xXbADKIchGl1z8RdgYX1R1QJI+m1ZqzYCkySvt/3iGfLy8+BPOsJ0YVMzihDaQrHlCQElqxkbf/io=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:4qc8X8/7hjiCpsIeqK/TZEH/+LpbXHz/l6j8uNj5Oowwu+Gw7eQ3sGy6LXcSdI63nbViTnUqHk545ecVgXj8xb+2jQNUrwYh/TJs9W03aGBvRYmMygsq892d8cgCCS0FZi5uiUAVPZ8g3I1Iyg37l2MDihnJOfnhu0TwyRlbGbI7/Ri9h3afcyiQHVlTZpeVWWfIKOaXrGWAArH3+yRfHDlAhC/+gtkzDMIvb1QgJaIMSw9JvgkbcSXpM46HiGRLtAGyWFEJVQBM3Z1HO8KV5roD9StqylSCtJrFXH2E1LaAkNq2nATQ+0BObGvNVDWh3j+d9dBv33lB8wDQ6ISJrsWDfU3fodoGnsTiFoa5uIguYyNOL6RyWKnzC0u9eRF8JoQmq75ZiKwMOq9WkB9EyoFogcQe14K1yhNwgV2jU5wx2q6hBHGuy5kF18vjXEqE5dVvd207G/eAjwHmREYHlXuVZu8Q+628u5JcZeBuBnWKYfWO97K326gy1b2MpkxF;4:BiHrMTi6b9fW7C0OtXYTbqhESlZgHXMVQp4ACe4xIX97tEfCfXGfmdNvfFYosIp0P4smRAYKvuenHrSrfsw4UID4iu/MaPOpHSGXa4aTNSDGaSkF13mb9ZKh6LO4U0jxCcYcLy4n7Kv+/EIsbUNFMYiK4orMxjtuTjVnJ2czVCtkmhhwegEMchQc9VtRo/eVG0vixrBzbfE9gZuTx2+eBuuPJmHz0z2MLDAoeUl0C0tb7/FuX4N5i/FZytj1oQF9JEi+IaIUAUQksOvxvJGu5Q==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13372FB674C9BFB4AC48DEFDCDD00@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39380400002)(366004)(396003)(39850400004)(51234002)(189003)(199004)(51444003)(7736002)(8936002)(229853002)(64126003)(106356001)(81166006)(81156014)(305945005)(65826007)(50466002)(105586002)(110136005)(3846002)(31686004)(52146003)(52116002)(36756003)(58126008)(316002)(6116002)(23676004)(55236004)(59450400001)(76176011)(31696002)(2486003)(16576012)(6246003)(53936002)(97736004)(478600001)(53546011)(86362001)(93886005)(16526019)(2870700001)(386003)(6666003)(68736007)(25786009)(4326008)(8676002)(6486002)(47776003)(26005)(65956001)(2906002)(77096007)(66066001)(186003)(5660300001)(65806001)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6dVlBa3g2OFVybEYzSGdGSk8wVm5La1U2?=
 =?utf-8?B?Z29SSTFRY2JmM3cwdnFQUXo5ME9zVzdodm5ObkdqcUFuMUx0bC9lU0JKT3kx?=
 =?utf-8?B?aUtqeEZEL1k0TXp6QXAwelpTQTFqWnVtdnBGc2ZVM3hoeGphRVhtUjFtUGdG?=
 =?utf-8?B?cDUyR1plQklRVUMxZUxHSjhMdnljaDFSZ2lxMWlHWnNGL1lKdTQ4RVZwUTVB?=
 =?utf-8?B?U0daOTJQbCtZTmNrVkVIREdQTDBTZmZPSVViQ1dDTXBpSGdzN1RYZ2JTM2c3?=
 =?utf-8?B?c1lSVEo4eUNXam5vS0diT2ErSGIrV3hWMDE1R0oweU5rWlpxODRqbjhTZE9J?=
 =?utf-8?B?VEJCclA2TjExcnFUV2ZHbCtuMnNBNDAvSmNNUkhLMUloSTliMFc2cnhxcXEr?=
 =?utf-8?B?TmRIbFI5dWdJeTliZXl6ZlRuNW1hR0RqLzhDTk5qaE5oSlNMcXgxTVlCNk9r?=
 =?utf-8?B?YUZYWlZhYXhldHFQdnNuZ2NqOFY0OFNxMkY5NnhUdXl0VG4vVGx0WFNlQUl6?=
 =?utf-8?B?MFJhYlVEQkp1UzVLWVBxbmdMeFliZVhtY0NONm5XREZtSTRVRTRwZCs0WnRv?=
 =?utf-8?B?dnJQWmdWV1NwNERUaElRYkRPakY5bnBqNmdCQ1VhQWpqY3hxQk5nN21pb2Jp?=
 =?utf-8?B?U1dZbUU2bWRES29zMXZSK1hyNktNWDlXRXlBQU9DQnB2NUJJaVNscUVDNm1u?=
 =?utf-8?B?UU9lZFhYSFdkOGNNUi9vTnR3MldOQVZUUXo3QWg0YWlROHFDZUxXZGtmN3E3?=
 =?utf-8?B?MldVeGNucTROU1lMMm5qdHVROFZYZzgzcXVYVVZUVytwYXZ1TUE3cVBwanJ1?=
 =?utf-8?B?TjJRaEVuWTNxMTd0Sy9CbW4vWG0zWElocktxUGVOSkNYaEFpTWRqSWJDWFZq?=
 =?utf-8?B?OUViSHJYMW1RcVBaOCtaY1dSaktJUXQ4UjgzYVFBc25TWVlDZnlZMjEveDR1?=
 =?utf-8?B?Sm03SWwwcG5NNmsyaHB1RXJZVzNFOHZWT0VhM3h3QTZlY1Jydk9TYVZaN3pR?=
 =?utf-8?B?UFhMeisrWXFkb2VCdWVsdHVyWVpDSGVxMlZ4WmNHdlhTcXBZOWpaM09JN0Y4?=
 =?utf-8?B?bEUwWlA5dEowdDNEWVRoQkZzMnVWMjFWSXp2MDB1eDJQNzQvY1IyZ3R6WDk3?=
 =?utf-8?B?akxncWV1blowUDEzdllVRG16cHFEY0Nad0djZGl1N2NvQVk5YlFlcEpqaUti?=
 =?utf-8?B?bUNKTStJVFErUXhWVG53SVVXTWE0NEwzaXNMd1c1Qy9SS20wN0ZYcldxS09i?=
 =?utf-8?B?OVUxNEpoRFhIU3dDTGwvOHVQd2pwemNjbmpGbjNuVVVEcUNyc2lLR2w0cWFu?=
 =?utf-8?B?NTFUWjF3R2xUQjVSQkZTdlRpbkFxUnVTV3FkQldENFBpR01xT1JYSDhNdXF1?=
 =?utf-8?B?R3BGWWVXcVF3ZHBhcnhUR0ZuakZEeDJSR2JiZjZPTVo3djAyc0hYNUpxQXhn?=
 =?utf-8?B?RUJUa0dpNVpwY20ySU4yYmZRVjZNRFhWWDdJSVBHVkVvR21UVUt1SGtSMmZM?=
 =?utf-8?B?MkNZQTJsOWZQK2cxQ3JqM3JrOXRRY1E3NUxSZVgrdGZSVUVWYmRjL3VsRkpM?=
 =?utf-8?B?eEdSREwxODFGa3ZTbVJEMkIyaTh5Y241Zk13aGZ1VXRFMFAxTlhpWjh4UDNa?=
 =?utf-8?B?Mi9SVld4Z0Fjd0NSSHBpSDNvSXBxTFJXc0ltNDFEcyt3dDVBcFVpNGdTaUZj?=
 =?utf-8?B?TmVwbVR0Y3dFQXc4OERNcVl6ek5teGppNVlaZE9MU0RuY1FxL1poUGpXUFRS?=
 =?utf-8?B?bllBMnlNN3BSM3ladlVVV1BsNDFaMFByYytoMWlTVGRFdUJITkxKQ2tVZCtD?=
 =?utf-8?B?YllhZnpWZWFhVVZSOUZWY3JTaU9qbVhTU24zcXVLQmZ4eTdpQzJMU2ViRTVa?=
 =?utf-8?B?bkdabUc1SWhodTgxWStZVTZuVkQ1d1pzR3N5SWJMd2dSU2Q5aks5VDVMTnRI?=
 =?utf-8?B?cGFnRDI1Q2JGREduTWF0WDdCMzJxRWtkVmFXd1pjMUlIa29ueXovaWhSdmRp?=
 =?utf-8?Q?iZbG9vGi?=
X-Microsoft-Antispam-Message-Info: an+uU4j0UmzCXBWV1eVcvjtNcIpxPQo8CybEPq5PBWXtihRInPj822tCW/cq7eEb0yCnOioiV3WLkgRgdgPMWJR3vCt/TLo6y05D6eHqLmt1c4DGiH7BgSpKdy59UyL5ojn0x5tGrApcboWnav7Hcl9H7KLgszmsavs/0bPYdlh6IP3eXmQm9cFRQwHAKbs79C/Pom0kAeVgkNQU87CgNA==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:bSaebS0k+0Gnt/9vEsg4rc1cuPI3qhV0wZX9WDrUyDmlqIOovejjFQ1/l2wN3+U/nHw8MbQtwZ/Y6cZTMBPc4FHAMxC66WbNUAMiDy3B3Z+MdYvHmlZDOEdqsw+u/Ci5BpG3OFlxlzSGMI9i8Nh7GyUGdtM/H9zkkwMYFIDla6tmxlDPXKOOg8C45NFqolHhbJ4xLURLisYB7uk8UF2X0mi1HHqxZXVUNtH29NG23vq+6phlEmX6q8s1vYZxSi5FqkRSVW27SSFDGGA9WJRZX5wcOD3xHHN/c+2u5APGxTeNslyrud3gz0hqpsSvDQdTRUyAvoPrStjLZ26iSk7MysRZy6GiCpkVAGbxI/qoO54=;5:p9lD0iFTnNeZGAFs/7+3MRIMIONHUSwMuwRhETNbTsnpHOpCQQ4el109zsSVOki0SFTrmboU/84tcf8QuXwrRNU2WcnezftptQGbtcGppC9TpmBnC3TTZiJqi71mCi6MfLuTBbhdv4zHSlTWyvq1b8kVOUpyu/E0BdhETQMEAME=;24:nat8/KYw5c1HzZUMjVxIJWPJPIJQ+JBH4SRtJAWINOUSZ6+tAHCi5gnR1JCFqz4vX0qQQeZeWhmgZD2HkCPEodcGZ36ROgoEnbJNUhRW4Cc=;7:0wLVAkFM2lKG0EwK1UbuICREF10WQ1azA+s+ee8WaSZwn6bePz3wwM8bynCC5JZD54THq7QpUYwh2H/6HHKytNNfw2OEg7EXmjzGUsw45FSCg7kcRe23Agcq/XbJrYRFBib39/KkrCaNHyCY5/quQ3PvU+cNFKvLoBmyCllWYNl9TVbTWQHL3DAKZ1F9gbK1khAKOAX/yluqvShLsL6JhBmJPodmNj8sRxsgpzjhQ7IME3xYT2gOxX+wPJLcDkgK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:BWf8dJ1la75r5+gLQwxnwgv+ASmOcKMGwrxlAq9L2mNEbO8MqCGSjjT2GfOiTxvI71h5GWah0Y/iPYAJlzzcbcerqcPoHuLh4S647TL5ZQxu19rMuQTGGF0Iq9OpHAxONum89tXp+qN6ktkLRVAAUrpPlN3ocjaiNgrIKYUBIuQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 12:09:40.4969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf64395-3671-4e83-128c-08d58a6da172
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 13:48, Tetsuo Handa wrote:
> On 2018/03/15 17:58, Kirill Tkhai wrote:
>> On 15.03.2018 01:22, Andrew Morton wrote:
>>> On Wed, 14 Mar 2018 15:09:09 -0700 Tejun Heo <tj@kernel.org> wrote:
>>>
>>>> Hello, Andrew.
>>>>
>>>> On Wed, Mar 14, 2018 at 01:56:31PM -0700, Andrew Morton wrote:
>>>>> It would benefit from a comment explaining why we're doing this (it's
>>>>> for the oom-killer).
>>>>
>>>> Will add.
>>>>
>>>>> My memory is weak and our documentation is awful.  What does
>>>>> mutex_lock_killable() actually do and how does it differ from
>>>>> mutex_lock_interruptible()?  Userspace tasks can run pcpu_alloc() and I
>>>>
>>>> IIRC, killable listens only to SIGKILL.
> 
> I think that killable listens to any signal which results in termination of
> that process. For example, if a process is configured to terminate upon SIGINT,
> fatal_signal_pending() becomes true upon SIGINT.

It shouldn't act on SIGINT:

static inline int __fatal_signal_pending(struct task_struct *p)
{
        return unlikely(sigismember(&p->pending.signal, SIGKILL));
}

static inline int fatal_signal_pending(struct task_struct *p)
{
        return signal_pending(p) && __fatal_signal_pending(p);
}

>>>>
>>>>> wonder if there's any way in which a userspace-delivered signal can
>>>>> disrupt another userspace task's memory allocation attempt?
>>>>
>>>> Hmm... maybe.  Just honoring SIGKILL *should* be fine but the alloc
>>>> failure paths might be broken, so there are some risks.  Given that
>>>> the cases where userspace tasks end up allocation percpu memory is
>>>> pretty limited and/or priviledged (like mount, bpf), I don't think the
>>>> risks are high tho.
>>>
>>> hm.  spose so.  Maybe.  Are there other ways?  I assume the time is
>>> being spent in pcpu_create_chunk()?  We could drop the mutex while
>>> running that stuff and take the appropriate did-we-race-with-someone
>>> testing after retaking it.  Or similar.
>>
>> The balance work spends its time in pcpu_populate_chunk(). There are
>> two stacks of this problem:
> 
> Will you show me more contexts? Unless CONFIG_MMU=n kernels, the OOM reaper
> reclaims memory from the OOM victim. Therefore, "If tasks doing pcpu_alloc()
> are choosen by OOM killer, they can't exit, because they are waiting for the
> mutex." should not cause problems. Of course, giving up upon SIGKILL is nice
> regardless.

There is a test case, which leads my 4 cpus VM to the OOM:

#define _GNU_SOURCE
#include <sched.h>

main()
{
	int i;
	for (i = 0; i < 8; i++)
		fork();
	daemon(1,1);

	while (1)
		unshare(CLONE_NEWNET);
}

The problem is that net namespace init/exit methods are not made to be executed in parallel,
and exclusive mutex is used there. I'm working on solution at the moment, and you may find
that I've done in net-next.git, if you are interested.

pcpu_alloc()-related OOM happens on stable kernel, and it's easy to trigger it by the test.
pcpu is not the only problem there, but it's one of them, and since there is logically seen
OOM deadlock in pcpu code like it's written in patch description, and the patch fixes it.

Going away from this problem to general, I think all allocating/registering actions in kernel
should be made with killable primitives, if they can fail. And the generic policy should be
using mutex_lock_killable() instead of mutex_lock(). Otherwise, OOM victims can't died,
if they waiting for a mutex, which is held by a process making a reclaim. This makes circular
dependencies and just makes OOM badness counting useless, while it must not be so.

>>
>> [  106.313267] kworker/2:2     D13832   936      2 0x80000000
>> [  106.313740] Workqueue: events pcpu_balance_workfn
>> [  106.314109] Call Trace:
>> [  106.314293]  ? __schedule+0x267/0x750
>> [  106.314570]  schedule+0x2d/0x90
>> [  106.314803]  schedule_timeout+0x17f/0x390
>> [  106.315106]  ? __next_timer_interrupt+0xc0/0xc0
>> [  106.315429]  __alloc_pages_slowpath+0xb73/0xd90
>> [  106.315792]  __alloc_pages_nodemask+0x16a/0x210
>> [  106.316148]  pcpu_populate_chunk+0xce/0x300
>> [  106.316479]  pcpu_balance_workfn+0x3f3/0x580
>> [  106.316853]  ? _raw_spin_unlock_irq+0xe/0x30
>> [  106.317227]  ? finish_task_switch+0x8d/0x250
>> [  106.317632]  process_one_work+0x1b7/0x410
>> [  106.317970]  worker_thread+0x26/0x3d0
>> [  106.318304]  ? process_one_work+0x410/0x410
>> [  106.318649]  kthread+0x10e/0x130
>> [  106.318916]  ? __kthread_create_worker+0x120/0x120
>> [  106.319360]  ret_from_fork+0x35/0x40
>>
>> [  106.453375] a.out           D13400  3670      1 0x00100004
>> [  106.453880] Call Trace:
>> [  106.454114]  ? __schedule+0x267/0x750
>> [  106.454427]  schedule+0x2d/0x90
>> [  106.454829]  schedule_preempt_disabled+0xf/0x20
>> [  106.455422]  __mutex_lock.isra.2+0x181/0x4d0
>> [  106.455988]  ? pcpu_alloc+0x3c4/0x670
>> [  106.456465]  pcpu_alloc+0x3c4/0x670
>> [  106.456973]  ? preempt_count_add+0x63/0x90
>> [  106.457401]  ? __local_bh_enable_ip+0x2e/0x60
>> [  106.457882]  ipv6_add_dev+0x121/0x490
>> [  106.458330]  addrconf_notify+0x27b/0x9a0
>> [  106.458823]  ? inetdev_init+0xd7/0x150
>> [  106.459270]  ? inetdev_event+0x339/0x4b0
>> [  106.459738]  ? preempt_count_add+0x63/0x90
>> [  106.460243]  ? _raw_spin_lock_irq+0xf/0x30
>> [  106.460747]  ? notifier_call_chain+0x42/0x60
>> [  106.461271]  notifier_call_chain+0x42/0x60
>> [  106.461819]  register_netdevice+0x415/0x530
>> [  106.462364]  register_netdev+0x11/0x20
>> [  106.462849]  loopback_net_init+0x43/0x90
>> [  106.463216]  ops_init+0x3b/0x100
>> [  106.463516]  setup_net+0x7d/0x150
>> [  106.463831]  copy_net_ns+0x14b/0x180
>> [  106.464134]  create_new_namespaces+0x117/0x1b0
>> [  106.464481]  unshare_nsproxy_namespaces+0x5b/0x90
>> [  106.464864]  SyS_unshare+0x1b0/0x300
>>
>> [  106.536845] Kernel panic - not syncing: Out of memory and no killable processes...
> 
> These two stacks of this problem are not blocked at mutex_lock().
> 
> Why all OOM-killable threads were killed? There were only few?
> Does pcpu_alloc() allocate so much enough to deplete memory reserves?

The test eats all kmem, so OOM kills everything. It's because of slow net namespace
destruction. But this patch is about "half"-deadlock between pcpu_alloc() and worker,
which slows down OOM reaping. There is potential possibility, and it's good to fix it.
I've seen a crash with waiting on the mutex, but I have not saved it. It seems the test
may reproduce it after some time. With the patch applied I don't see pcpu-related crashes
in pcpu_alloc() at all.

Kirill

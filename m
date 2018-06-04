Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeFDMp2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:45:28 -0400
Received: from mail-eopbgr50094.outbound.protection.outlook.com ([40.107.5.94]:60332
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752120AbeFDMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:45:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v7 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0e725889-c42f-0557-ef41-76e4c87a3c9b@virtuozzo.com>
Date: Mon, 4 Jun 2018 15:45:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:209:1::31) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:h1e1xJhIk9ofZHTubswrrMTelzifM8LJe7QftJPeMM+rtg+tUQeaYqd9sHfsza/Nte9jO71Jzqzj0FYLaVsHg9jRwKyMhtkibc9kuO9vAYm+8Gle8iS3jIHfvliy5FztvATNafOdPplM0x3v+O3RwY+URh/mEZ5UnHe1ywk5PulUFmztPEPNB0ziH/ObHV4yQqxt0g3uJYrlgQydYCxaB1Qev92wjPo+EI0SQ+xO1TTlfxIjGryZcvb0xHJr2Ckk;25:DtrufW+YDv6pSXuiuu+Gp0WvaxJJJB6J7ZPh/h+nLnV5oi95b3pjZW7AyEcWxTch8gSR8RqvYyVcnj4FxrbJYDLj2t+Nm1fTTgl4Tw6OOH9K4NJJMFO1o/Pl+4WAPYJ79aALgPMEve7nT5fKjlJPwcckQZ5xmWkjS7XXcccIPqcepTnIx3Ik8WqchMFoRoHsZ4YCYRpzNjbFxXeahHJ0jnju/hiT+3SwesGos7Ml6q5Abs6sHTKaYupvmjx0f15a+M4G8JKUiyDbinFUUXmcy0MUEXX/XMMhQsT5F+dQqaDJRJCdeDpY33KC4sJvF4g71ItB56Rd88d9DWKqXK1boQ==;31:oC+oAqYUIL3iFytGZoR8zt+nmHx0Dl4aX1ftQBghPVbTWVdK9M+iyzbP4Dc4cvjjGl2ydOBg3EtrmBdTDaw6Y+t5fIe8lcAYba1bb5zeV3XiOBc6tILYnDcOouQRYG5Diq3uoMax4OOYWebRfxuH7h60to056haMYP8Mr8+rBIKvmo/jtU8r4x31B/mogRXIwYPVYF1hNEHamduR3+b4lG27uJ0IZf9hp+xvLjWc3F8=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:yXHCYHKbWAaK903ktH5m49wJ7G3uSfmo6haLBHqxUFI9+6aCPBsk+pNEnGGjfAXNum1TfzpcT8mmTQKRAUOzkV+YBUi44ohd1ynyPHhg8Jzex+VJXXU/Hb/6OohCinynUlnG6+IrFtuyL7mJr5dEaEw/rJ+wyZxi3nxwsr+BKlReSdNSrSuEF4dFTD7kMC9v47ats3+33Sz3IEZ8p8f3PXy1bSuqd87cs6nsiDIowDbtmBS+LKfnIhlQADABQUvO7LbHfabJKoWDEFnpeOhR9tpYtvymt5AeQQ+ExPBiHWIDygb6B4neWDMXFvPC+BlVSJ8qbTKg3ygt6t26VcAlgy2aKgfMq6RIb/+DgVAZXqQ8xJUdluIgvMaDxyj9eMA4PpXbs+enQeeZmYgzksIoZOinwq3YR4fvHRZ+vCFjrWddiuMk8i3uXLLwcdj76MHvDKHj1yp6DnzPKznXhRlvCJzX4BnC2FrdKVd94kiqaygnBRPzp074ZLJh4oLaGj8H;4:TEt5jooxXDBd6X6c+IXx3OgGPut7J8HSW5g4vZv4dHWQqlz1DfFBVPyV9jr3fhER6cb3kVPiLKhYoM/q1z8NRzCvuIqiaKaDsgTw5jOnTl2uiovu4D9v3FDOdd8i7MhKe//QvGOtSzReWBALadfT2ds+vHXf8abcA09Oe80oKSSXKqVWM9PCCDeMkmunCtU4v88AKDWsF3+rkJ5Hsf+VvmZo9wEX/qEqN2xRcSqzdB3pa9PiJQal6Xl1FM/71wdLeg5UyWJAf1zU/UqTpJvK67IBAc7IU/WvixwCx2ueaMm2UtEk4tJpp3biMWESl70H
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344F781050595F7A8D3C715CD670@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39850400004)(39380400002)(376002)(346002)(396003)(189003)(199004)(11346002)(53936002)(6666003)(31696002)(81166006)(8936002)(81156014)(6486002)(6636002)(7736002)(26005)(64126003)(86362001)(50466002)(229853002)(8676002)(5660300001)(65826007)(36756003)(305945005)(58126008)(316002)(6116002)(59450400001)(230700001)(23676004)(2486003)(3846002)(16576012)(52146003)(52116002)(478600001)(76176011)(7416002)(6246003)(39060400002)(2906002)(386003)(53546011)(486006)(446003)(68736007)(47776003)(2616005)(31686004)(106356001)(16526019)(25786009)(97736004)(77096007)(956004)(476003)(105586002)(66066001)(65956001)(65806001)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6cm84em1HVVFXSEIxZzkrV2RCTFVkcHpZ?=
 =?utf-8?B?eGpCZWJoQlZxaENHNmZDdFV2YkNIcERUYWIxSzNQSE5zWTRvRkxsQmFnTG8v?=
 =?utf-8?B?SjgxVGxKVVZaSW9aZ2JJNVF0Z0FCVkdTbnNqMzNUOURuY1d1V3hqajhCRUJM?=
 =?utf-8?B?MUdZUVl3NjM0RTl4K2xhVXMrb1FRL2ppTlpjY2kvMjN1UG5TYklxZ2IyVGpF?=
 =?utf-8?B?bi94N1J5aDkzZzN3TWFETDBGMWY0aXNHa0tKY0RUWWhIeDVwK1pLaXdjTVFY?=
 =?utf-8?B?SFNkNUsrVHhkdzV1cjFjV3RGVllyOFNmTGV5MjdaK1huN3g4elU0VldNMVMr?=
 =?utf-8?B?dkd3ZEMzTDFRNnZTTnY4QTV6OVNySEhTZ3FvTDBzdVBSbXNTNHpXSDdFaU9z?=
 =?utf-8?B?dTY1M05lalFtdUNVb0pNMk1GS21uRkUzRG5MOS9Ga1Q1YkpDRHQwbmdlQW9t?=
 =?utf-8?B?dXAybllhYWNTL1phL05iRG8xRDd4RVdHbTk5aXdsTkVGaTZZVXFHeTYyRkYv?=
 =?utf-8?B?UUh0SS96TjYyMVBWeEJRRFQzSGZaTjMwS1lTY0xyamNaNXJRZTJVcTAvNWU2?=
 =?utf-8?B?eTN6ZU1yUVdKZG1KamRaR0RkY0duT0RkVXlpaE1mT3hmeFVSYjI4NFRjTDVu?=
 =?utf-8?B?Z1dtZEFvV25EOE9FZU8xUUhLYWNYWC9BNDFvblFWZHZiaGlKdEZWOTJZR3JT?=
 =?utf-8?B?a1lCT3h6cE9NbS93eVVLQnZYcUQ2RURucmNodUl5M21RN2E5VnB5eFJab3hp?=
 =?utf-8?B?Nmhpdm82Qm1EL0pwd05YRDhZaXJuYUNFN1UvVCtVakJLMnJjTUk3K2NZTzRs?=
 =?utf-8?B?THFlTnRvNHo4ZVRBbVorQzAwRDF4ZGtvK1VKT1ZVNkF1ZDF5YnFWUEEzQjVk?=
 =?utf-8?B?VTlOV29YQnRWdzVoSllGK0s4UGhTSDFOYUNWakhkTkZyNjFHcTRCSDlzOGFr?=
 =?utf-8?B?Q3U5ZWZacmt6VlZVZmE3WFppZmg1KzRTV0lCVkp3eWNhR0xydWdqM2lmdG5l?=
 =?utf-8?B?OVVEeXJ4dlgrTFpWZ3ZJNkJmS2Y4QSsrUnNCZHhOb3FHYzhwdnh4K25mZjA0?=
 =?utf-8?B?RzN5OWtJQ2VGcDVnQkpvRU1mWXphOUtUVHY0QUtSMFg1aEt3M0h2ZWhva1RJ?=
 =?utf-8?B?a3Q2ZmF4V2JXVXRDa0VFQ3lPc3lVVElLSHFoSmp3am5FSUhaZXlvZ0NGUFcv?=
 =?utf-8?B?YVNlL0NvQ1dBSnppOTV3QW1xSXRGVkdZakxZS0lrcXhGbXUzZ2NUeEpwNy9Z?=
 =?utf-8?B?SWJMWWF1UG96b0VxcFZueEtWVnRvU09UWFlsejgzcklaQWlUNGNFcGpFSEhH?=
 =?utf-8?B?bFVTNGJ5dFIxUE1ySXNNVVRnYUFFRXlncDlxcG52TmhIdGdaaGlyMUJXOGtj?=
 =?utf-8?B?aHB2SGhVajJnQ2ZERU4rTGRQbEo5djRTbDdvRUo1OERQRWtldjA3WmZiR09Q?=
 =?utf-8?B?Smhra3F6KzFWS2ZzVncvMG5uMlRxWEJNbS9udTUraGpXRlpyR3YxZGVYTGJP?=
 =?utf-8?B?dTVocXBvWDJIWDJXQ3BzTnhzRS9HYTVxdHhEMmQ2R0RPZDM3ZVJ5OTNad1cv?=
 =?utf-8?B?Nm5Bb2hUS3o2bUNqT29QK1JjMlEycDAra1hDL1d1NDhISkpYSVZLMUoyanpl?=
 =?utf-8?B?Wk9YdHlOWE5iWDVjOFJ2RUVIOFpzZGF5TlljdnBFbUVlbFU2NmV0K2FtL1JM?=
 =?utf-8?B?OUxCT2lXYi8vQXBvblM0ampXdUxyTGJaUXp2UXJQVVQ3N3lmSXUyTjVuWVh0?=
 =?utf-8?B?M3RZZGxJM3J5RFlJeXhjK1pzRTJYNTlwNTEweFVaczcrS2pOSE9XVlRaZ2ZY?=
 =?utf-8?B?QnlrQVdmYUhOQVNuTVEyWDExUTYyd2ZVTXRxMDdqMFJsTHZnd2VOa1g0UmRP?=
 =?utf-8?B?MXFna0ZjcnlUcU8rNHdSdVV2S2gzODFHcXVLYzZvcTloeGdKMlZvRUJVRVhL?=
 =?utf-8?B?U05xZkpkTmdDazdXWXVaaGUyM2NkUHJsZFhDY2d5blRZMHpERGtCUUFrRzE5?=
 =?utf-8?B?dEU3Znd5dEJkQnlXRVB6TFF1em0rUklQUXpjQnRLcE5QZ01xUksraUVTdXhN?=
 =?utf-8?Q?joPk8s=3D?=
X-Microsoft-Antispam-Message-Info: G76aIu3+lnPUWZ0xCc+9rh4shlfE+qNMvK+t1zzSjVaekKUCTZlP0F5hgyYcVCpudRxFlSrTsv6nx5eTLTtei1EoeAIKq15W8HLxDEL6p1HEQlnBW7atsSKwqKovkUCYtPD0Wcamp7N9/TkpAA3MpdvXSgqw7lqUVuRYbuGmk7jCbXRBkvcXSAsDROC11i5Z
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:dozyeD91Zie1ML89R5GxU8WXluXcFbdQ/8E1bBFhLL66wzXAtpvHT5wF6j97qNo7nta6AuSPtnaFPFmg3GD9WQvUoFXy2ZT63lHWGiY7MHdWWobas6xZmPq98SXI0Cy62FvSC21+eECLhAqdFidxjx8NVYN1ejWNDfYusNUdxQFtOTVVXCXXstuRJp8AAJcRfEnn7vT477TYgUwsW8aHpR9ZGSsoO6b6I4JqDp/6hjFl0nEFVyvTS2GRqCpfG428lGvSCTcK/ZXZSjwyXEWAUJMhT2WHWx3fiaCa3f5UK2m6gnipT3auHbolHDykNc0vN5y6wfSND1sLzzsKrwXbEIJJ2CC9T14/dRUX2H8R8t8CXzAKLmeSL+8atCNBxlPaJHYfW+MxCLMrUsQiR3PlZIqs2D3mVxbfMeKuVfsSWsiLcfD8FBG0HVAHh/WJhXdcexvIRQ2YjZVraIXcRLOD5Q==;5:6Eez1pKjGQqTsg229Ptr8c38xKy7Iz5uyJg0lBUGKpUBvozhXyEShsLEJ3NT8BS8T3Dt7czD1CgSwsRQ8KC2LR8HCJPvVM/LoM3JgTJ5/agiakSYU4mDA7+L7Tankg7QhPWpRxSEmg0SPIugEdF43CgxSa/z78T24hz8hANTQcs=;24:ucR7dsVUmkSVOKzKffeD1YPxYNKldwpRx8UtzVCY2QNpiJUFw5BGO/75u+fyvpqGxLCWQbDXkjHzFTsOFxv9ZfgmnIUV3Z7UMPAol2AaoYI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:PuYFsjtdeveR0qiY7WsfVPMYPSAGxa7N8t6jdpCid9Tj+jO08NKefpZxCL+QbJmRrOSZu0oFJHnqYohtN+vNIP1jmJNBuqqzzQ5LBXgUoePpY6Q1F4cxgRzu7hw+1Mn1E6xP7BFwFVDyBC5vWKPO+cEMMWgy6KyXnrBFUlq0UswMA7TC8VR64w/cVulVP2tQHTq9+7mPDBIlaYLtN7bXBqIltUbafJLf32VzHkZWEHhIdl+b1MbyUH8L3K1Nut7C;20:4bzAIlTiQlWE9v9HrJTPWC5pIe0iXxCyUmEgnYMWMWUTBd7s4UuZRiXc/FK3oYL9C6ww1StKo5PJ50BXVekRt6XCcC+2UuzAwGUMawd4DLnmfPluOJYMm87FRTd1+6fAodyNLrSO3u5HgXu7kEayvAL649zoT4NIIckMv+0wX6A=
X-MS-Office365-Filtering-Correlation-Id: 6765ed84-2dbe-4e06-77f8-08d5ca1909e1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 12:45:21.2181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6765ed84-2dbe-4e06-77f8-08d5ca1909e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew!

This patchset is reviewed by Vladimir Davydov. I see, there is
minor change in current linux-next.git, which makes the second
patch to apply not completely clean.

Could you tell what should I do with this? Is this OK or should
I rebase it on top of linux.next or do something else?

Thanks,
Kirill

On 22.05.2018 13:07, Kirill Tkhai wrote:
> Hi,
> 
> this patches solves the problem with slow shrink_slab() occuring
> on the machines having many shrinkers and memory cgroups (i.e.,
> with many containers). The problem is complexity of shrink_slab()
> is O(n^2) and it grows too fast with the growth of containers
> numbers.
> 
> Let we have 200 containers, and every container has 10 mounts
> and 10 cgroups. All container tasks are isolated, and they don't
> touch foreign containers mounts.
> 
> In case of global reclaim, a task has to iterate all over the memcgs
> and to call all the memcg-aware shrinkers for all of them. This means,
> the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
> and since there are 2000 memcgs, the total calls of do_shrink_slab()
> are 2000 * 2000 = 4000000.
> 
> 4 million calls are not a number operations, which can takes 1 cpu cycle.
> E.g., super_cache_count() accesses at least two lists, and makes arifmetical
> calculations. Even, if there are no charged objects, we do these calculations,
> and replaces cpu caches by read memory. I observed nodes spending almost 100%
> time in kernel, in case of intensive writing and global reclaim. The writer
> consumes pages fast, but it's need to shrink_slab() before the reclaimer
> reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
> there is no writing, the iterations just waste the time, and slows reclaim down.
> 
> Let's see the small test below:
> 
> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
> $mkdir /sys/fs/cgroup/memory/ct
> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
> $for i in `seq 0 4000`;
> 	do mkdir /sys/fs/cgroup/memory/ct/$i;
> 	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
> 	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
> done
> 
> Then, let's see drop caches time (5 sequential calls):
> $time echo 3 > /proc/sys/vm/drop_caches
> 
> 0.00user 13.78system 0:13.78elapsed 99%CPU
> 0.00user 5.59system 0:05.60elapsed 99%CPU
> 0.00user 5.48system 0:05.48elapsed 99%CPU
> 0.00user 8.35system 0:08.35elapsed 99%CPU
> 0.00user 8.34system 0:08.35elapsed 99%CPU
> 
> 
> Last four calls don't actually shrink something. So, the iterations
> over slab shrinkers take 5.48 seconds. Not so good for scalability.
> 
> The patchset solves the problem by making shrink_slab() of O(n)
> complexity. There are following functional actions:
> 
> 1)Assign id to every registered memcg-aware shrinker.
> 2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
>   and set a shrinker-related bit after the first element
>   is added to lru list (also, when removed child memcg
>   elements are reparanted).
> 3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
>   and call a shrinker if its bit is set in memcg's shrinker
>   bitmap.
>   (Also, there is a functionality to clear the bit, after
>   last element is shrinked).
> 
> This gives signify performance increase. The result after patchset is applied:
> 
> $time echo 3 > /proc/sys/vm/drop_caches
> 
> 0.00user 1.10system 0:01.10elapsed 99%CPU
> 0.00user 0.00system 0:00.01elapsed 64%CPU
> 0.00user 0.01system 0:00.01elapsed 82%CPU
> 0.00user 0.00system 0:00.01elapsed 64%CPU
> 0.00user 0.01system 0:00.01elapsed 82%CPU
> 
> The results show the performance increases at least in 548 times.
> 
> So, the patchset makes shrink_slab() of less complexity and improves
> the performance in such types of load I pointed. This will give a profit
> in case of !global reclaim case, since there also will be less
> do_shrink_slab() calls.
> 
> This patchset is made against linux-next.git tree.
> 
> v7: Refactorings and readability improvements.
> 
> v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
>     Use different functions for allocation and expanding map.
>     Use new memcg_shrinker_map_size variable in memcontrol.c.
>     Refactorings.
> 
> v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB
> 
> v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups
> 
> v3: Many changes requested in commentaries to v2:
> 
> 1)rebase on prealloc_shrinker() code base
> 2)root_mem_cgroup is made out of memcg maps
> 3)rwsem replaced with shrinkers_nr_max_mutex
> 4)changes around assignment of shrinker id to list lru
> 5)everything renamed
> 
> v2: Many changes requested in commentaries to v1:
> 
> 1)the code mostly moved to mm/memcontrol.c;
> 2)using IDR instead of array of shrinkers;
> 3)added a possibility to assign list_lru shrinker id
>   at the time of shrinker registering;
> 4)reorginized locking and renamed functions and variables.
> 
> ---
> 
> Kirill Tkhai (16):
>       list_lru: Combine code under the same define
>       mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
>       mm: Assign id to every memcg-aware shrinker
>       memcg: Move up for_each_mem_cgroup{,_tree} defines
>       mm: Assign memcg-aware shrinkers bitmap to memcg
>       mm: Refactoring in workingset_init()
>       fs: Refactoring in alloc_super()
>       fs: Propagate shrinker::id to list_lru
>       list_lru: Add memcg argument to list_lru_from_kmem()
>       list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
>       list_lru: Pass lru argument to memcg_drain_list_lru_node()
>       mm: Export mem_cgroup_is_root()
>       mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
>       mm: Iterate only over charged shrinkers during memcg shrink_slab()
>       mm: Add SHRINK_EMPTY shrinker methods return value
>       mm: Clear shrinker bit if there are no objects related to memcg
> 
> Vladimir Davydov (1):
>       mm: Generalize shrink_slab() calls in shrink_node()
> 
> 
>  fs/super.c                 |   11 ++
>  include/linux/list_lru.h   |   18 ++--
>  include/linux/memcontrol.h |   46 +++++++++-
>  include/linux/sched.h      |    2 
>  include/linux/shrinker.h   |   11 ++
>  include/linux/slab.h       |    2 
>  init/Kconfig               |    5 +
>  mm/list_lru.c              |   90 ++++++++++++++-----
>  mm/memcontrol.c            |  173 +++++++++++++++++++++++++++++++------
>  mm/slab.h                  |    6 +
>  mm/slab_common.c           |    8 +-
>  mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
>  mm/workingset.c            |   11 ++
>  13 files changed, 478 insertions(+), 109 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 

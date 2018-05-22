Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeEVKH2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:07:28 -0400
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:35367
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751394AbeEVKHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:07:22 -0400
Subject: [PATCH v7 00/17] Improve shrink_slab() scalability (old complexity
 was O(n^2), new is O(n))
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 22 May 2018 13:07:10 +0300
Message-ID: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0352.eurprd05.prod.outlook.com
 (2603:10a6:7:92::47) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:OBBD9sPKx30L4Bd27k9QCULIrHge3p9ul/fv4k3BbTTJbnKkdypvK5g1bdh8KJGxSVLWGWHEC1frM91lqaLxOFjlNFAY0Hi5HND9lshRZq6qA68hKZbOnZ1b4+jpeYiWl2mhfdpD7k/h6Ch8kmc7OnCVNzxPcf9DRw89WHhZZwo11wrG8useUEOpzG0P50SC50OTnTFa9MsgZbjqta9Ybjrdem8LFcPZiIbKgaKU5efvebbP5PyX3VrKWfJGlKFS;25:Kx60KdvQgW/n+IEjNnG/VEQABtYux2HkqTuRaQJk2hGe2GRtJJsK+bESGdeNl90+RJwj0fE4aw07cFP97pVrPMvqivxvlDVzfpO8dUrTq+zA3V6fZcUoOxcuJfKXXsOpmcjrssu9G4ZnMaj+c225Hd9VT10vsSe99+EqSULQPq/mbrR+lSKFEGE29sUR0+1MJPZesJ0TSsBI4ScFv+d2w04UuyvxcK1Ekw5qaMZ2u7aivQlBdYmYyhFm+JdTS5b6LIRwdOsRCcaA3pAgA2ppaLf0F2bZAq2wTKrOfKOd3K0beG6epWm2QGOx4EwPDEwAKo5C4n9bf7Fx5jge+JwBMA==;31:UbJRrr9t40+pcyTskIl/BVaR4s6jwG8sv2gLMZx/mwlw0Q8NAY/FfTRg6InA97Np9lTkbwstOKyxV8a6QqUBAxSlM4PcJyN2/yTOxiqKHOgrcgk+rEbqrXudtMTXnNhuYcMqCkFZtD303KR3z1ZNq88cLGwkRIo9V8/NPLksq3Y1P++Jrg1ULxO/yPzs6lmYbVgnTRndrxG8Y6RMLR9pyzd4Uw0ewYFsaL31yAfoD5o=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:PoXKoa/bsgPGKMLBjoVS5PwX88hyQfeWOYKg16o5GWKzhk7miMDYY5Ik8zadxkXX9EaDL7MQ4m7EO/yyW07JIG0KcQ+6b81czaB+oAxgocNxmQh5YRID9iuz6afvv4LapuOvXYHyL+pn4qXuJosj+WyJJ+4Ln1LsPuYhD94fMXDHZZ+V2ql6cCWxHHGKH5XZg4uw2chbxInDtqxM4uhALG9YhNbXDo49CQgnoiAfWMPRw7GSXaAEUOdTpzZXLzEFTZAvw5lP3YRrpj4c3HI0NuIVdHGbR2VbGy6S5OazfCkX0kJzMYUDbopJCUvuj785lEqy29c5uNIXY9uj4vkUGcNiheJYzv1W3QCytGDYa7sgA6RP04ZqqahEXLyMGzLL5qX9vPHvTWIrAsBl1RmBWdJP0yjsKbgeZxfWf7ILInZu2QU8ylOgEU0pGSN1ZOqgNH79Vbiqdn4zTt37exgWPyUqO8FUZLf55YIUigpz1tMBLuNM+wCB/Pzh8yRvf8uX;4:tKRn+AvZUJ/2gPA/WyEFZUNbjNL/oqfETFNfB7hxUeiupKx/PmFJQ/UCwfKlEvZRC/Y42gfCiR1GnPaNtK/lWcyhSuZ/wBS/Van1Jx56jUqYjojDe0WOhgxeNlStFJvRv6hT+vW+ilEHjKfM05J4CMfcJzB+y0npyUiS5+0H3P/Ae3R7MaKX0o+s42hVgvSI7LLFq2xX+sz8EEzPxMvmz7rwarAkVmLkNfvv6hFWX4M0Ay12X60JExN/xne6fTWRiC7sM4XTvkRt2/TrohzjQOA3u7SKE1x7KmeLsWuqpg3gUJnZYYv+uni7i0yvj4w4
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13409F2C8E1BC00C45E8E454CD940@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(39380400002)(396003)(366004)(376002)(346002)(189003)(199004)(58126008)(68736007)(7416002)(66066001)(8676002)(5660300001)(9686003)(106356001)(6116002)(81166006)(2906002)(105586002)(103116003)(55016002)(478600001)(53936002)(81156014)(61506002)(6666003)(25786009)(6636002)(47776003)(230700001)(3846002)(50466002)(97736004)(305945005)(386003)(86362001)(7696005)(6506007)(186003)(23676004)(52116002)(2486003)(26005)(39060400002)(956004)(59450400001)(316002)(7736002)(55236004)(33896004)(486006)(8936002)(476003)(16526019)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6UHhGT2ZJY1UrMmRzRkxNQUhtT1NvY1Vw?=
 =?utf-8?B?SWZzVHBsVlU0RkJud0VuVkhqY3NtbE12NWhlcW1ycGhHaTRNSkhFME1VL24v?=
 =?utf-8?B?SGl6V0d4LzlaZ2tkQmV4OS9JcE9OZlFCdnQ0elJyaEtzOStqZDRwWitRc292?=
 =?utf-8?B?TzhScStZZ2x0WkRtY0VGMTdFWnZYVnM2ZTNld1l3SHBpS29ZeVdoYzNpcTM4?=
 =?utf-8?B?aEkrekhyZHFYNVhkVzgwSllCVEpWOHB0VS81Y3gvQTlGemlOaDUyU01NUWRs?=
 =?utf-8?B?ZytCSHFkV1h2SHZmR0VDYkNoU0JBMm9hSUsrQ2VQdXBKN05RclVUbTZ4b3ZU?=
 =?utf-8?B?QTkxM2tIclVkWVFnVlZ3Z2d5WkpsUjJtSlNpUUNKTUVCSFpDN1VKVzg2ZTE0?=
 =?utf-8?B?VGp1cm1Kelo0bVZTam0rcTAwbEhRdXJ2dmJVQnRUeDRpbFlLcXRkRSs2eXRO?=
 =?utf-8?B?aS92QjZZYVRRR0FCZ1JOQWdZV2VuSW8yZGppZlFWZE9tSGpkcHd3WnV4QmFs?=
 =?utf-8?B?d3dobXhGNEg0MGZUUjFwNUFOR2hZRURPcnBlZmxEM1l0MDQ4VG1FN2F5L3kz?=
 =?utf-8?B?WEtWM21GUUVLK3J5amlUUGl5aXA2SDJLYWFXd01VeG45VFVxWEpTWTNBRFJu?=
 =?utf-8?B?ZFN2NlUwQkRKVFhJVUNvM0hLd0dKVDFBVU5mckJ5a3doMHBRK0ptSEJLV0J0?=
 =?utf-8?B?QUt1SVF4VGtmSnFmRE1zamY2WXo5RGxvaG8yNlhLWTNnd2Z3MVg0SXRpd3Aw?=
 =?utf-8?B?eFQ1R2VacVRTQjBqZGF5T1JwdXZxeWlJeXJlVEV4azVWK0VYemR5MnRMeG4r?=
 =?utf-8?B?c2xoQnh2M2dJTFZtZGdkUkd3cS95RVVWaURRaVZnQTRZM0p0cDRXR3ZCSEUz?=
 =?utf-8?B?NHU5WUNIUlhYblZTNC9mOGFQdzZVU1NRNlIwQXRzTEFnZ2Rab01HdmFzWlkw?=
 =?utf-8?B?bG9EdElvWWVkTVh0Z3dtbS85OXBMSVFsc2IrMG5JeEtqak9ubHBCV2laOGZE?=
 =?utf-8?B?eDlNWC9BL0VzTmZhaWRwNVZaNVhKQnpxVHBwYUJzRVRpcTd2Rm14c0JmS0M3?=
 =?utf-8?B?VXBTQTZ5MU9LcHEzSzk2SWJ3elRVZ1lHandkc0RwL1V2cGN5VExVdndMMS8z?=
 =?utf-8?B?WVloWE8xdlpmdzVkZk5qSDVTVUhhb2YwYzFLbEFFaFMzU3d1eVM3Y0Uxbk1D?=
 =?utf-8?B?NXhHKzBYamhyblRRU1g3d0JzWXd4QjZaMytPZHEyZ2YzME1Ia08rWDQzYjdi?=
 =?utf-8?B?bXFRajJFeEdmdERmNHMzVi9BelNiWDAvY2RadktTTW53NjFpeStTWU5mMFFH?=
 =?utf-8?B?MGgxN01NMWs1bTkvVXArWEdqNGw5TGkveDM2MmVLd21ZbHU5MWRsc280OGVa?=
 =?utf-8?B?RUVOVE51N3B1dzZnd0gyekZkWXlBMVQrSFRGb1oxcWtXdlk0dXF6MVVuYkJl?=
 =?utf-8?B?QmNVc0duL3dFYTA5RnJKYUlRL0ozR2NhcmV6bkRUZWtIK3VhWng1dWowSHFz?=
 =?utf-8?B?VXk4Y1AwQjlXNHhRSFE3MEIxSTZzMk1IZVRINnRYNms3YVR6UCtuTkJIT0pU?=
 =?utf-8?B?L1JVdEg4dkwyZGROVTl1N01oQ0RxNzVEZmZhVmpSN2hnMTRLNGFtYjZZaTUr?=
 =?utf-8?B?UXQ4M20rTUVLSTUrOWc4eXlNWStxa2NyVUxzM3BQWHF4Y1JZa2pIUC96eXJ4?=
 =?utf-8?B?aWN3T2piaERTaTNITjVHd3VhRHVCSjQyZ3RtVkZEZnF5blF2VFczSUV3dysr?=
 =?utf-8?Q?B8PExQbF27hbXjoVrQfnw7VlfKl6h3MMDiuANNg=3D?=
X-Microsoft-Antispam-Message-Info: Mxo9LsiBaLdTLLxwdgonGlnbLKVs+ldsWaQGKDs/ZrV8HSMCWuXina341SAW1Ph/3slgFm9DGGazcqgeu35CUlC/H9K9jbt+8j//GWc5vOjrNdVENbxX4ogtKMwyAyy+GnSVpTbV18Sjc9HwzKYa6KqbiORpqvEzw3hd/Tmpv1ojVY+KN/TSiIYMWii8JHM8
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:akIGdKlERGxsx1egMtO1dlppICm/U5SDUralMfsEdKtfKPX7YkU74zC/+NvXeJyqL4FuQkJwSZGGb3L+N9wH6gkDZjq2pP1KIaFBtZ2ib/dkG9Q8kuVKz143jbmchcRlMiamC0LAxkbBKyKJx9LLH0XAoiyBSDBlrJ5YIz2TX8M8+VcX6gPCYVbPbH6JEp1V9ZIGgUZCPX8mMJBC3CqmHzTUsF/th5dWEVnTpz4fs83GVD1Sz58A/dTABqu2yhujRh4NdNlGC6DCluyNYx3MIifkYGcMMuLiPdHDht7wGjZOVVr8Wy9lyMMAlgNbpk42wsrD5kv/ZThUGsd4Byv7iMbeSMw0gIg+CgG72idsopwgHtPMr3s/TURVCHsQQkfwE/YXHCAj/BAMwbQLF8aB/JCYX5G5pDZCruQWEDS2SaePLuyEyd+UO4P+vJeUdn+/AsebNm5ooSGHmHhGx1v4HA==;5:qjqs0KUDOsnj8lLgmifOZjYMOjRreah1IeTEWZbWNccO9qMUp32MxMtw9MgbH0ntBfAYhx5tLHiC3NYDK8fJTHSD8vPDUVPiXO32KgtayCyjqIQNCwcK0brnr+ZZ52h1OGEs3PXAFtdmYJEjaqtUz2+u+A4xfJhDGj0B0mdIhdw=;24:DGIzZVTMEoqVFAXkfc1OL3IOwnI1JDZ5+c/oQ/VtsJoF6Wjq1hS9rzjwUMG9BLfVKBjLlCa/EjxMMzn87rsvSwFt18tjPra+ycoYzHub/Uo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:4q9vf+zvfNm95Nwfi1gePRyH/8fGCyJ1XDF9P21xctH9yK+NrUonm2PwJTsIGBORKl1VXdlNuVwtPPjJZsn24IVDp/mUYE4KNWd5l9G0lsWpdxZEytj3I7FtrgYKRsQfmshJAUMaJLn3QkSePFYQI0dXVYAc6ZiCu7f0K7dL2O87lejROGxw4bURMOAaQ1FJgUylObDQzD32QWWxVaD3CD3wf0xROCRwXIRAZ7Cbxglp7VS0Kb47LAdXlzfNoxUE;20:U+GcvxlQU6qUeaN/MTmploWbIiaCP6gfUdfaKvkoYblaVUZ/DPbrRYvfFxEUH35NZpeUO4IXPTk/kibdLoCyZ1//GY+17GOI1yVTytgQQO4BKhj+O6F7FOMZ4oPnbujq941nLpkY9k9ELz01hmkAHnlS0num++YIeZw5Zkg+R34=
X-MS-Office365-Filtering-Correlation-Id: af13db75-32c6-4a6b-95eb-08d5bfcbcc86
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:07:16.4681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af13db75-32c6-4a6b-95eb-08d5bfcbcc86
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patches solves the problem with slow shrink_slab() occuring
on the machines having many shrinkers and memory cgroups (i.e.,
with many containers). The problem is complexity of shrink_slab()
is O(n^2) and it grows too fast with the growth of containers
numbers.

Let we have 200 containers, and every container has 10 mounts
and 10 cgroups. All container tasks are isolated, and they don't
touch foreign containers mounts.

In case of global reclaim, a task has to iterate all over the memcgs
and to call all the memcg-aware shrinkers for all of them. This means,
the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
and since there are 2000 memcgs, the total calls of do_shrink_slab()
are 2000 * 2000 = 4000000.

4 million calls are not a number operations, which can takes 1 cpu cycle.
E.g., super_cache_count() accesses at least two lists, and makes arifmetical
calculations. Even, if there are no charged objects, we do these calculations,
and replaces cpu caches by read memory. I observed nodes spending almost 100%
time in kernel, in case of intensive writing and global reclaim. The writer
consumes pages fast, but it's need to shrink_slab() before the reclaimer
reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
there is no writing, the iterations just waste the time, and slows reclaim down.

Let's see the small test below:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
$for i in `seq 0 4000`;
	do mkdir /sys/fs/cgroup/memory/ct/$i;
	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
done

Then, let's see drop caches time (5 sequential calls):
$time echo 3 > /proc/sys/vm/drop_caches

0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU


Last four calls don't actually shrink something. So, the iterations
over slab shrinkers take 5.48 seconds. Not so good for scalability.

The patchset solves the problem by making shrink_slab() of O(n)
complexity. There are following functional actions:

1)Assign id to every registered memcg-aware shrinker.
2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
  and set a shrinker-related bit after the first element
  is added to lru list (also, when removed child memcg
  elements are reparanted).
3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
  and call a shrinker if its bit is set in memcg's shrinker
  bitmap.
  (Also, there is a functionality to clear the bit, after
  last element is shrinked).

This gives signify performance increase. The result after patchset is applied:

$time echo 3 > /proc/sys/vm/drop_caches

0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

So, the patchset makes shrink_slab() of less complexity and improves
the performance in such types of load I pointed. This will give a profit
in case of !global reclaim case, since there also will be less
do_shrink_slab() calls.

This patchset is made against linux-next.git tree.

v7: Refactorings and readability improvements.

v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
    Use different functions for allocation and expanding map.
    Use new memcg_shrinker_map_size variable in memcontrol.c.
    Refactorings.

v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB

v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups

v3: Many changes requested in commentaries to v2:

1)rebase on prealloc_shrinker() code base
2)root_mem_cgroup is made out of memcg maps
3)rwsem replaced with shrinkers_nr_max_mutex
4)changes around assignment of shrinker id to list lru
5)everything renamed

v2: Many changes requested in commentaries to v1:

1)the code mostly moved to mm/memcontrol.c;
2)using IDR instead of array of shrinkers;
3)added a possibility to assign list_lru shrinker id
  at the time of shrinker registering;
4)reorginized locking and renamed functions and variables.

---

Kirill Tkhai (16):
      list_lru: Combine code under the same define
      mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
      mm: Assign id to every memcg-aware shrinker
      memcg: Move up for_each_mem_cgroup{,_tree} defines
      mm: Assign memcg-aware shrinkers bitmap to memcg
      mm: Refactoring in workingset_init()
      fs: Refactoring in alloc_super()
      fs: Propagate shrinker::id to list_lru
      list_lru: Add memcg argument to list_lru_from_kmem()
      list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
      list_lru: Pass lru argument to memcg_drain_list_lru_node()
      mm: Export mem_cgroup_is_root()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Add SHRINK_EMPTY shrinker methods return value
      mm: Clear shrinker bit if there are no objects related to memcg

Vladimir Davydov (1):
      mm: Generalize shrink_slab() calls in shrink_node()


 fs/super.c                 |   11 ++
 include/linux/list_lru.h   |   18 ++--
 include/linux/memcontrol.h |   46 +++++++++-
 include/linux/sched.h      |    2 
 include/linux/shrinker.h   |   11 ++
 include/linux/slab.h       |    2 
 init/Kconfig               |    5 +
 mm/list_lru.c              |   90 ++++++++++++++-----
 mm/memcontrol.c            |  173 +++++++++++++++++++++++++++++++------
 mm/slab.h                  |    6 +
 mm/slab_common.c           |    8 +-
 mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
 mm/workingset.c            |   11 ++
 13 files changed, 478 insertions(+), 109 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDSR3K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:29:10 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com ([104.47.2.101]:59077
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbeDSR3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:29:08 -0400
Subject: [PATCH] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date: Thu, 19 Apr 2018 20:29:01 +0300
Message-ID: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33)
 To HE1PR0801MB1339.eurprd08.prod.outlook.com (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:a0M8jIToikQYQnIflwnAsqoAv3FdRs9zPLtkchBmSIfOicn0D3YnvQi035sGj3gVoT2Ca3ZFk42BDQLhbJe+qN9FFcSoG4GiK+jUAFgQDZaLE12zHX/eBG10odHtI2y9pBKC/DSI7bSIK1v/wiieVa0uP/LhQdXL5y9sXJkCqLbgcZ4I9OgQvibZ5NrewzSdaxEWKVyDUD6NdEjLwjQqmJlpSlciFiCmWIQNDWgf5gpKNHRJItuJ9mloXDAOKAbo;25:pK5kd1YW7Ch0DiwXqAlboJrQSejAoSoUgZ57dUakc2b6rd4VvU03pOeTnFy0loVg1qDQiwga9xSjlR5DuwAw0qIAdJVjb3yYolohd7+wIvju7lNlKdBlhzS/W28yOeSJT/7CSChd1TwWmX59ayXwsNioP1ij3OIP/kl+lzxWbpbJaFS5PnB1gNFdft9QAq5DDiCsEscs57+OiHICaVdXFs/ibt5pjSi+r8P2Drnb3Grb+MJvcfYXUHITLYX21VLynPPODgpRQ8DE6hpCTjwP1IV/H5DwkOxHtl3zJ3mCT3Szjxl3OzUwqTrIqwd4z3LRXasLLG4zDtve3K0jgNJrlQ==;31:Wd76jGErVIfCLdntYdhZHFe2G2j0FuS3u1K9hihiRI8wCt5miOeMAdLbqaRC4Z13lI4ddorxrUwOUqqfaKDUWUmklcqB7/ix96UuMAdccIQJb7xzQMmi4iB5UXlAWavJ6mLrbfbQUEFAr6HWdXhy0noU8OcPY+8tZ8lNNsvpoOVUHq0gXz27PbXh7T9ZsHYiTjEWjzT+G47p3pK0tN/wx//PYMUjnVls8hv9pBkqMus=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:vtCpJOMQuvLrzKZC5HI98RTG9E5cyoaT+tjHlfjrIvxgnDiPrny0UV4rqzHeI5k5JqxuBRmwqRjXIzKEFwWfrVgBjXlXvHZeMitJwU7H1DgG9iRS6+j7aaFU39gro4198YVcBSUNnbLAF5JgnNeP8j2N8YahrL1uCy6eoZ09mmBXn03HD5F5b4qu6tm78feHkK64n7QFATzgzwa3JVQ9XbUouuJ+VCHjyCe2OwDBC9lNGixttrbutEE4K6pqshGSJH/UrIEMNpiQE9rtnXnUm0b6IPJ3eX3A/jkzn1TjgojgntzJ0J1ne1Apz1I+Qm9Dlw0Etrsgt4PjHHIQgN73MhK8LZi+1CB2eU6gd34M3Y0rLH+QAK/SLgT4a4/Udx+q+P84cGKiSqYLoV4D8E9Egzf5rZSFIcRq/Ob0pJh1y2J5uMwpaBew2blsQYZlrBzkVo7Fb/kbva7wdaarh879f4xCc8dDmxTc0FC6h4N27brYDm2rPqGZSRy6qkb6En66;4:90yxf8M+Kepio6at5ckbnZYaWTIEe0Da7XOXjFn6LrvwXpMjGbOe5BJHaYzlnGoLz1GbLHvI78CQzqCJ3eHgH5KqAKQFHbEi63ivEPXSmP7kYZ0he+sDyD00t4SutMzDikXQZFqyJWHwnvrzsloHL8v1L56/q7WYdLNMz3LMedzUh6tZrZQ4qJ4AkpyKn4IAXKfVAhoKnyDTd0i+G0hRa/vWTDmfMVZxNb0kuY5ggaM+/Y3bXw42plSK5tDsHW8rLt4zuWGeQCka4dTNLfVCvg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133970F2D5D99F3AF7B02E2ACDB50@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501383)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(39380400002)(39850400004)(366004)(376002)(346002)(396003)(5660300001)(230700001)(61506002)(81166006)(58126008)(386003)(86362001)(6506007)(59450400001)(2486003)(23676004)(7696005)(25786009)(55236004)(8676002)(2906002)(52116002)(47776003)(8936002)(66066001)(33896004)(186003)(956004)(26005)(55016002)(6666003)(575784001)(6116002)(476003)(3846002)(478600001)(103116003)(53936002)(1857600001)(9686003)(7736002)(316002)(16526019)(305945005)(50466002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6bnBJZlZINnFFaWFSSzVCVFNnanFUd0Uv?=
 =?utf-8?B?eEZ3ZlVjYVVNdmxqVUs1TUQ2a3VYQmRDYjVBOWhhc3VvS2kvVGtLejIzOElM?=
 =?utf-8?B?aXhJY1JQMDU5NXRpdmtYRk8xNXlVeHRUQmlKbFV4d0pNazE3ZjB5M3hoOVFS?=
 =?utf-8?B?c29uYkhsTDcyazlvR3dJMThXTWFubkovd0dOcTFma2hUNUZMQ0lPcGhIK3Ev?=
 =?utf-8?B?OExIYzhCNnF1Rm8ybkIrcUlrSXBjbXgxWVlSVGFZQVRFMUFFaXBxMS94bUNo?=
 =?utf-8?B?TUY3Mm10TkZvUkxXMWtJSlU3U0hFenJraGcrb052aXZVM1UvSFJJZTJpVzkw?=
 =?utf-8?B?bXdXY0JXRFkyZm5vWnoyYTdmSUZWZmRkZkJCMXpWVm0zQ09oRks3TStPUDg4?=
 =?utf-8?B?RngyaHBVbkoyT1Q2UkNIdGk4dFltbWlkY2JEdzRaZEpiRUx4T01vM2o3Tjgr?=
 =?utf-8?B?U3p1NG5wUFUxYzhoMWRwZmZWcDAzNElidmNGNE51VHMwS2ZKMnd2aVNhT3Vk?=
 =?utf-8?B?RjFCRTVBeUJDOWgray9KajhJNlFiMzFWUkRIYldSSGticllnQzZKRkJlVEpv?=
 =?utf-8?B?R3BWU2RERVVOK05PcCtLYzRPU1NDSHgrR3BOMEtjUEt6dXNXNzFBcjFVTis2?=
 =?utf-8?B?MWJiWmpzM1hHMDRpRWMwZEpLbHIySVFuZjc1a2txQjBXM1R2dGIydWVyc0lO?=
 =?utf-8?B?SnRGcFJPN0ErVThZMVNRd3VwQkdDMm9qQ1JDbHU5eWMxV2F3ZVdxZ0NoUzdG?=
 =?utf-8?B?bFo4VVJ2eE16MGNZNzZ0Yko5QWJ6bkt4V2EwUFlSTm41Sm55Znc5NHJkYllD?=
 =?utf-8?B?bWhkSWFLOFB2Um1BSFZjM3JYclIzd3ZuN2ZGYVA0cmdCU2FGcGl4bU0vT1Jh?=
 =?utf-8?B?L3RXZkJPL1BvT3F3dE56dEFJZkdJOTJacWNPLytpYmhLK1c3UFpJNVAzc055?=
 =?utf-8?B?K1M1N2dvQk5wY080eUhNaSt3ZXZid1NZSnh5UThGMjFWdFhuNzlEZnJpZ25I?=
 =?utf-8?B?UU5kNElVeEN2Y1JEMHdrd01LcVhOc2I1N0ZsWmI0aktqb0szK2FMM2czako3?=
 =?utf-8?B?NzJWTWlZWVRTdzQ0anAwRGJlSUd2SS9XQmxYUzZWR01DeWZJQTVKcHgrcmcr?=
 =?utf-8?B?dmNLU2JCckU4YkJqRGQwcWZWaXBsVkUzR3ltS24zbmJUcUV1V2xLUnEyM2p4?=
 =?utf-8?B?eml5S2pQaXRwYjlGL0tPMFhyN0NVcGR6R25Yc2N1OUdrNkJtbkR2bmQ3TzUr?=
 =?utf-8?B?ZWlFZmYxaEw5bE44eWNVS05Xa2lISGl2YzZ3aHBnSllGQy9kbVAwSHVnM1Nu?=
 =?utf-8?B?bEMrMkZ0UnZ4OHJVZmZnTGFNZTJOL3hvSG54NDhuUWdZMkt5b2FNN08rakI4?=
 =?utf-8?B?aWIxZnBwNjgwQUtQVW5hSXo5bEhnK1RaK3pvQ1R6UXF5VE8wVGFOVEVGbkZl?=
 =?utf-8?B?d0I1bldrMDlLVWgxVERuMnFvV0w3MmNPbmJQNHNsVFY5OU9DM3lmUDJTSzdj?=
 =?utf-8?B?TW9SejQ5SU40OVU4akRpRTRrRkR6UUZ3dUFDVm5ocVhDdVVKV0pSRFEyZit3?=
 =?utf-8?B?TCtBYVJqZW1XRWt6TjJRRFRNdnEvNkpqQS9qMlR5cGdTekhCN2hCK3A3OTkz?=
 =?utf-8?Q?k=3D?=
X-Microsoft-Antispam-Message-Info: DyRwJ7fJyNZzDjyEZRw0Xd/OIGXnCB5wZHEL+JzV0EuKL26pTzoOcOq0UvfZV33iuj4Vnx8aez7s3X6fQOwtUV92qnIzB4CR6s3trlTbEiCdCefnSnbeNgEGZYPTUJtb4cwGDXXYh4vG/U3f/znqwpuGeH+eUuf8ObUUQfiwD9el9dbUdeKOsrtTv8UED6aM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:QAUHApJNIFEZOT0BTrgYBQMAiUKG8WW6urEsVfNiOT0oDwBIp6g0ZbkAnoFsLwYxMOK3PvDq94wRKUsyv4Jp0D0eeAonrAgQJwM2uyRz/yNJpFmq5ssT8ytkliqhNImPjne3AwaGyLfWs/0XVuBl6LaGJL8chnBzOtdgIO3LBczA4gjjzTa//j9b40ZfLzvzFNEUqChyGknxa3JI1/QoE2zUXCWdIjteDgq8t2edPZAoz41Fmg0brT7L2QGvPI3qCVCb1fggj3RCSUwz/O021+ucio304YOW/Nad5IQntOydfrDqBvbRCpoPPGceJ2b1f+cD0LGdQfDtxVPTbnKGKNxUtvqqLKKuv3bezbHi+zJ66e4/YCJQ54QF43GtdEOf2ypHF8znXUjclCfekkoJVzWgqfnutNNPf/NaBGmsKo4/7obJ1Ip6P5TYT42xSH0GLUqdkoUrYx2vxokVS64rrg==;5:IN0hQH7ca4/Y6hzd9QZqnG5h9yibWkp/oReBN8H8sEScEMRT6t9aYH26mKgpnJTrmD4M3P3M32l1Y/YEtGBRdcssN3hZZZJidQQRmMhUtimONubGCfAAOlglbvlWEje6WJt2Lb9f5rO5lQZeczxSRdfrKc81LAUYtSOQGkuh3go=;24:dhjQYqs3hVus+8RntPFDIC5UFFeTSD8LWgf8HyNrf4DpM2nIzNgGkZVfKz/g+tSum0h+SSBnLlpNSz2jAghR2GDLosFeki0bgGc8PYA15XE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:YVokmu4q0szagn4bTKVQBLMA9fH++cJee32nKRgNjCdRJG+6SbELUZNygY+0sPBhhad+fC9MMcA/WhbC/XEMHLxmR/rzCCOBMMQ04Eyiv0lVuKFhyZupliCWVLxgtICziMnydYSGutAdMasZYpI8l3BtBohRRE0hMFVPIQBCQy2WseqC9w6QRGaNMw8XworLWQdU8EEZs1d7nCPF3uCdfe9xADdDQpsAexio7XALcF/dQ1Nptf0IeQpHo/EHOX32;20:0GVlhTuHD0Dig96rBLX9SjEfijv5R09XVXN7xqh4Z/MkftoIxTe4X2qkJttXeEjbBVK3JtuTMbylwuggA2lwo9jSX1dvBSBP5Wuyp0hx0hWQ2heC1G06B25z+IytRRBP4um1K/sG0wu8TAz4Wp7pq9LNLoRssxxYIjit2VIEtTY=
X-MS-Office365-Filtering-Correlation-Id: 929dad79-4e86-4bc0-49e1-08d5a61b0c48
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 17:29:04.1466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929dad79-4e86-4bc0-49e1-08d5a61b0c48
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tg_rt_schedulable() iterates over all child task groups,
while tg_has_rt_tasks() iterates over all linked tasks.
In case of systems with big number of tasks, this may
take a lot of time.

I observed hard LOCKUP on machine with 20000+ processes
after write to "cpu.rt_period_us" of cpu cgroup with
39 children. The problem occurred because of tasklist_lock
is held for a long time and other processes can't do fork().

PID: 1036268  TASK: ffff88766c310000  CPU: 36  COMMAND: "criu"
 #0 [ffff887f7f408e48] crash_nmi_callback at ffffffff81050601
 #1 [ffff887f7f408e58] nmi_handle at ffffffff816e0cc7
 #2 [ffff887f7f408eb0] do_nmi at ffffffff816e0fb0
 #3 [ffff887f7f408ef0] end_repeat_nmi at ffffffff816e00b9
    [exception RIP: tg_rt_schedulable+463]
    RIP: ffffffff810bf49f  RSP: ffff886537ad7d50  RFLAGS: 00000202
    RAX: 0000000000000000  RBX: 000000003b9aca00  RCX: ffff883e9cb4b1b0
    RDX: ffff887d0be43608  RSI: ffff886537ad7dd8  RDI: ffff8840a6ad0000
    RBP: ffff886537ad7d68   R8: ffff887d0be431b0   R9: 00000000000e7ef0
    R10: ffff88164fc39400  R11: 0000000000023380  R12: ffffffff81ef8d00
    R13: ffffffff810bea40  R14: 0000000000000000  R15: ffff8840a6ad0000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #4 [ffff886537ad7d50] tg_rt_schedulable at ffffffff810bf49f
 #5 [ffff886537ad7d70] walk_tg_tree_from at ffffffff810c6c91
 #6 [ffff886537ad7dc0] tg_set_rt_bandwidth at ffffffff810c6dd0
 #7 [ffff886537ad7e28] cpu_rt_period_write_uint at ffffffff810c6eea
 #8 [ffff886537ad7e38] cgroup_file_write at ffffffff8111cfd3
 #9 [ffff886537ad7ec8] vfs_write at ffffffff8121eced
#10 [ffff886537ad7f08] sys_write at ffffffff8121faff
#11 [ffff886537ad7f50] system_call_fastpath at ffffffff816e8a7d

The patch reworks tg_has_rt_tasks() and makes it to check
for rt_rq::rt_nr_running instead of iteration over task list.
This makes the function to scale well, and its execution time
does not depend on number of processes in the system.

Note, that since tasklist_lock doesn't protect a task against
sched_class changing, we don't introduce new races in comparison
to that we had before. Also, rt_rq::rt_nr_running contains queued
child cfs_rq in additional to queued task. Since tg_has_rt_tasks()
is used in case of !runtime case:

	if (rt_bandwidth_enabled() && !runtime && tg_has_rt_tasks(tg))
		return -EBUSY;

the behaviour won't change. The only change is that walk_tg_tree()
calling tg_rt_schedulable() will break its iteration on parent cfs_rq,
i.e. earlier.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/sched/rt.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4e885a..601151bb9322 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2395,10 +2395,10 @@ const struct sched_class rt_sched_class = {
  */
 static DEFINE_MUTEX(rt_constraints_mutex);
 
-/* Must be called with tasklist_lock held */
 static inline int tg_has_rt_tasks(struct task_group *tg)
 {
-	struct task_struct *g, *p;
+	struct rt_rq *rt_rq;
+	int cpu, ret = 0;
 
 	/*
 	 * Autogroups do not have RT tasks; see autogroup_create().
@@ -2406,12 +2406,18 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
 	if (task_group_is_autogroup(tg))
 		return 0;
 
-	for_each_process_thread(g, p) {
-		if (rt_task(p) && task_group(p) == tg)
-			return 1;
+	preempt_disable();
+
+	for_each_online_cpu(cpu) {
+		rt_rq = tg->rt_rq[cpu];
+		if (READ_ONCE(rt_rq->rt_nr_running)) {
+			ret = 1;
+			break;
+		}
 	}
 
-	return 0;
+	preempt_enable();
+	return ret;
 }
 
 struct rt_schedulable_data {
@@ -2510,7 +2516,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		return -EINVAL;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	err = __rt_schedulable(tg, rt_period, rt_runtime);
 	if (err)
 		goto unlock;
@@ -2528,7 +2533,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	}
 	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
 unlock:
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return err;
@@ -2582,9 +2586,7 @@ static int sched_rt_global_constraints(void)
 	int ret = 0;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	ret = __rt_schedulable(NULL, 0, 0);
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return ret;

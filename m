Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeDTKGk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:06:40 -0400
Received: from mail-he1eur01on0097.outbound.protection.outlook.com ([104.47.0.97]:40959
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754290AbeDTKGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:06:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc: linux-kernel@vger.kernel.org
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
Message-ID: <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
Date: Fri, 20 Apr 2018 13:06:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::25)
 To AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:ZZOLBj4zmTX7UhpmqI5WhbcAg4iNVJLUDKfnf/AEY9BxiAvlcT2FNC13fNN0/UUmkJAjuw242/mwGbE4ykq43J1Jg+aJKM4cEAaeNx0/m23PZwOx8ewm6Ae/BEUP2xeMwQE2eaV/jhozSAnRWXIKAhf12Mxu9sctvKCAoU3/M4cm31g/c0SomR9sE4N/NOlm8AXUo4sMGmXI7FBE1Z/r/YmN6SLhIhaunr/gS4XEe0yOxwli81DaUeDiM4Dsr6wm;25:oZHhPgypb0wRZFCsuFKUYuTU5OGJg+PtxiDsSljjdmXy5hXBEZAT2uivm0nh33vPBd12hzLPVtkxLDmv1yCEmoBG5UdCi917EQhg7v8U7CdC9gWdecZG0Z8iY7Nu0bcmQyiYy9wPYqM1YBesT875LLGp/4I6rD/m+UWl83ATstxkKQEE+pqHddILkZuaTS4y/B9FcOaAZvuPG4TSJzsr1hVj1in7inrfFCsk2V9CdhC5SycUUQttol/sqa8MbuIEE9795mh1/E8UInP0uetH8wQ+sCVafbciuGWHsi7SMLf+P0MOJ8S7b8kzF/CGSQzTxZHldawiaN9/5gNlV0lZYg==;31:ohBiW8UA3MUZC3ZGUd0SsYoc6rKwXNj7fsh+g3CpQQc9pywwJVRw8mFIm32uM/ei9yZBG4T/oAk1sws6UoUTDcK2K/844JvODbAu4yH2NN4prhmLrJZIy1lauQGccLpk2n9VaVcf5u7DOcoImeWNXvtM1so6iSuTLCVGgJZ0C1KHiiAGUZBMc6P9Ppv5eZWTn2+9qXBYmjeW1SZT6HRzaV1ST/9shf4IVtXGWLE78fo=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:db1foIYyg7EEeTadsA0KS1cYYEU9UeCJk3gmnrF3YdyTpOSEmDikjK4/gtMmjfDROwmALv+uVN5l8CHmJBKANJPACxXmUNLL7Ne6JjR8I64yCPPt8vI6kO7i12yCTKyinIXw3hNB1CQS3HGEpLmMqRGZ2kAccZVO6tcCyQupswepWGSH79WSjCRRAJIwA7mekCjhjG+ppIgel4sw2HwPNrgZ7ecRUMrw4q0RZnp0CBa/bIDfAqafAsovUBpPeFm/K+hRCZb8Uh0o1NkxVunp7AarfU3ilmHH04IGHb4FygfruKM7P0PTN7m14kFxp/OyJ2OHPiWl0Mi00UMhKuRnwrgRIWDT4QrLwqFrjUBrVToCvD89JZ2sy0yuDcse9dzF5h6+dHi7xgi42jwQGZKWHKgpga8y10oWRFC9MW2EAx5lLGhFeEa/i+VFNzV3Uk1lIj2uDChH76T+WacFZ+kz9US2AhYEkszEt31Cxjf+6hyqLEFItPYzDe82D1O65lPo;4:UCFfR+cFV7I5lwC98M2OM1tIo/GHGOlMDqXjqzdHxcUN2Eu6q6l86WDq3FlYqUe1qsKski8bC0u76F+xVn6uQo/m+NGmPmHDkunJvu5M5gwLQHL8mNgVncj9mKVhLGDljBSyfgCuRiwG+H5n87ThQyyFPTAnJSLJEYusWD43C0guTqYlXA1/Qh5XO7l8WiVY4Em1DWmm4MjklUGP2tyrw7QKDBqibmwlk4DQ0ETKsZR7CA1Up+Nuv+cYP5EeVQ1iA6B9AUH02Z4EWyNbIyk2fw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331A4DB9C9ADB29D06B07DBCDB40@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(39840400004)(396003)(39380400002)(376002)(346002)(366004)(386003)(8936002)(16576012)(446003)(58126008)(65826007)(26005)(65956001)(230700001)(476003)(36756003)(956004)(186003)(2486003)(65806001)(11346002)(64126003)(52146003)(66066001)(47776003)(23676004)(76176011)(81166006)(7736002)(316002)(305945005)(575784001)(8676002)(31696002)(2616005)(2906002)(52116002)(39060400002)(86362001)(4326008)(16526019)(53936002)(478600001)(31686004)(59450400001)(6666003)(55236004)(50466002)(77096007)(3846002)(6486002)(5660300001)(6116002)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6eHk3VWd0MnBGMFpoSHFrVUpRYklOcEpa?=
 =?utf-8?B?VWwyTVAzV0JUK3RrTW5odGZ2S1BRRnhnTnI3ZW54WEdYWEt5TWNtdEp4cDVk?=
 =?utf-8?B?TmVOQlJJM3RWUFNJTnhhMElucG9ZNTBXS1JiMXlRUlluK2s5TjJSNUxabUpS?=
 =?utf-8?B?aSsrL3ZKaCs1UmlmR2ZpQWlEcGRxTjNwZ1F4VFlHanBFMTV6bnJHMlRSVmY5?=
 =?utf-8?B?NmljZU9CWE9BVy9qMHd5SThhZlZId1ZFZG5sWXlhQnR1NUFBRjRnTUtZYisr?=
 =?utf-8?B?bWhNZDlDOXVGWncxODNEZnBEeGttNjZqc0RNaTYzb1dUZklKRlUydE5IUTZ6?=
 =?utf-8?B?M3p6V1RpK1FhS3BISm1Qd3FEaFNQVkZEbzN0bjhIMXYyNHpPbVVXdU8yWVlG?=
 =?utf-8?B?cXljY3B4YTJtSEFyZExlLzQ2QnhFdzU2cnRpb2Y5Q3lLTVo5S3ZJOFpLa3ZN?=
 =?utf-8?B?ZTVwNW45UkVzU0l3UXk0M3RhaVNTUytNcmZIU1ZaeXlVMUQxc1BYYUQ1WjF3?=
 =?utf-8?B?TFdJK0FIaExCVTg1OFhGNytzbU9XRTZjOGN3ZHpLTXBiS284c3krZUVxSm9j?=
 =?utf-8?B?c3NqYTgwRU1UdVJHNzJRUHZLdWhDRC92WDVHWU5DcVhzWXpiSVBKbGp6amJG?=
 =?utf-8?B?aEN0NkgvdHZ5NzBJbEdTeHJtV0E5K05SY3B3R1FQTXVGU1JDT3pxRzgzcXRy?=
 =?utf-8?B?RTBXdWZzTW1lQWVaM1duc0FuMkM0ZGhUdHMvcklzRUxGemR1UHl5VXlhV2NZ?=
 =?utf-8?B?UlRwZThHTG9JNDZGbjV2RHJrQ2xOTWJWMzJRdFhIb3RrRUdNcTV3VFZ6T0pM?=
 =?utf-8?B?TzhyQ0huSml5ZlVrcHVLYlJ3eFZBNUMvVi9Fd1JZdXl3allWR2N0M3ZXcmkw?=
 =?utf-8?B?OEMyODRqcENIdDNvbHJMS2xUZU9FYk80WTEveXBsVlZjUDJLKzI5dEp1cElu?=
 =?utf-8?B?UVpxRnVXOU1ScFFGRFYzcThDTTFxcFRORkl0TDhuTzh0M0JBYllyRjA2SFFj?=
 =?utf-8?B?NEQ5V0w3VXIyWmRzTzJiMGlrNGNOQzRTRWlxcHQ5MGlOblYvYWM4RGd4MmhF?=
 =?utf-8?B?WjFJK2dUM0JBWkpyM0tlUHRYWURvSko2QzJDVFd6bkV5dTRrbVJaZWwrZDlS?=
 =?utf-8?B?K2VzZVJRK20xYlZ0cVptb0tsZmxaaEc2aWtmNmJpSFRnMzMvQmJLbnk2WUpG?=
 =?utf-8?B?dVduajRRS3NPMHMvdzNWY2Y5bGVXSUx4SVZjTnZaSzl1OTZXMVFDcmZlcXNo?=
 =?utf-8?B?MVMza01jVUpjd2l2MmFzVkpFek5YZUFPQjZGdlJEcGRoSVZBK2U4Y3Qwbm5w?=
 =?utf-8?B?Z0ZBWjJoWElaM0FJb0xJbHUreTJnanRhSWwwOUlBRTZnOWNBZnBQT2s4cmhZ?=
 =?utf-8?B?MjZ3MTREZnBsSm9Xby9vbDJsQ2p6NkJVclIxQTZ4TmFkVXNGZEM4eEdhT0VR?=
 =?utf-8?B?MTUzM05sbTA3RFRUN2Q4QUNIVHkxcktQUEk5a0QwTkxqVXJRMDZWVnh4U3cy?=
 =?utf-8?B?WnVOVm5LbmpnYUUwM1d5MFZmckJmUTlVcFlwSzBaMEZVSXFNdjBDdlJtaTh2?=
 =?utf-8?B?T0dMUVZISWF6dzhWNWx2OHBhSU1nb0hlS3JLQXhmbzFSaEsxRDlmNUFLZkJO?=
 =?utf-8?B?TGhUclJvZUxjQTlJc3dDVmpuMCswelVpVmJPd3RWWVE4cmcvVDVHcDdodGlU?=
 =?utf-8?B?UW1ZazNmQWxwTEU4VjJUTUZaU25UYUQ5cS9udkZPaHBhV1FFWXB3RjRqUEpv?=
 =?utf-8?B?ZGhmZnUzM3FOdG9nVFRTb0h6aGV4Z3JINWdldThySmZTUHlJUytXVXVLR01G?=
 =?utf-8?B?M3p3Qy9jNW8vY094MFFIamMwYVV0WTRqRHJRdVgwZTg5Qkd1VFpIdUs2VURQ?=
 =?utf-8?Q?3qkpiE1W2IWYU=3D?=
X-Microsoft-Antispam-Message-Info: QUZjj4mosnCnyqTwvhn5GoXhoOBN6JEmLnuTernsJgv9YLH7r5/tyH2WSt1zs/Wu1sftwdbcXpv7fXnDwcHPNcfbYr/z9BDsBj5cUYng28s1bfsoXKeMhQmBKDncJVm4NqzFsFsbPCVo+wjfn+x10WOlNwLf1mDzsMo2g6XmRbPV7KQoKfqgublL8Wl0Pps1
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:tyHySq6ASUryxRTXK1FkbHuDDmCc2cYcAWBxSSqA5fJrcHZMGQjHQW2dQLFrX+VssWS1rfUbXU8gGnvljKzE/UxNmRt9G7V9EwJx+dVZ3N5IfkobP7mgIaH6pO0D0/XREANutgd8vGOpJsnO6MH0+io/AxbqIttadj7pp+qPeSMg9M8pdeyGtp45J1c4ieWlBxMjQOGMGyPMcQWBtl1vu09GY+nosODKoaX7ob2I2r9oSdTRbAuXu6cmIyyGOu7KV5N5ZevPJzpIRRg2ACdjzNGfK1FfmgmAxYIyDMTfGP7wBDDfvmno973/clq0JhtUzeskM/8IkmWtDNhjxjBReDKxFp+3bubNxV3rzw3Wf8V6JX5MH/NOyL3WHdKw1+1AeE6qOTbtttaeAkjcFZGJ0jkKT/OBrl686ynQAzG1EJ0DMYDadLiKbyt7L2kIlAbNZqrrttAuZMzdI6/ty5wVZA==;5:KjJcgcgQQxwhCz2LNOzzdu19yzlYZtywgb7p+rYyl6Ic9fHwKI3O80b4M9jteHuA9ngbLtN1+VABrxYiudk67B/2250YyvajmH9+UKRm7enixuZ5XqM0ZFgS31iZn5L4ERy6F7eds3YXxqQxiXWTAk28pXbsIqrIm0jMDw8uCAU=;24:iuse+F5l6QGlKj/Q7G7PRBNvZ+XPV+kPgbxcTbioMRsQKobPDJQ6LTHsRZF5DgUqodc6nwED2sKYIBOs4N5ut8xs042nTwXiNjTIwCCOgYk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:dSrVLxWErW6/J6KJBzqTHY+HPHoJtJuk1DD9GQVOohdzxJnzlw1P0CzG8dQu8tTxeUKxgkBkBxaF82OBgEiDozPWes9+BTv/3o7CMZV5xZZImRs3cQVIfCnbnF3B8JcmGxdQ7es5gcS6X4V4xVtpGZ/EnTamMHSQ73pATVs8wpNSyCeHzEbpwpuIt+LD2RBaToStqrEOSMj5mqu/A11GIlqPEh7G+0QEQwbTesDfr8sxOTCiphLCFpdH/FQ2Hy2p;20:qOw8lLHeUIhlb8CsO+2XHlIuJKy1jWKsTU8floITRWL1u201Cef138nE9ZJ0JiE3mHQr0+khbMPB0iFYKI3Ayfr+Z+HM3Xs1R3RQBKqrtCDTXo8o1+7FlbFZOIK3FIQYq89OILry+cfAupNosV08VOpAnEUHbOpvVQQ5bi3+0lk=
X-MS-Office365-Filtering-Correlation-Id: 717a2ca1-8864-4d70-7616-08d5a6a66617
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 10:06:34.6905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717a2ca1-8864-4d70-7616-08d5a6a66617
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

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

The patch reworks tg_has_rt_tasks() and makes it to iterate over
task group process list instead of iteration over all tasks list.
This makes the function to scale well, and reduces its execution
time.

Note, that since tasklist_lock doesn't protect a task against
sched_class changing, we don't introduce new races in comparison
to that we had before.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/sched/rt.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4e885a..20be796d4e63 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2395,10 +2395,11 @@ const struct sched_class rt_sched_class = {
  */
 static DEFINE_MUTEX(rt_constraints_mutex);
 
-/* Must be called with tasklist_lock held */
 static inline int tg_has_rt_tasks(struct task_group *tg)
 {
-	struct task_struct *g, *p;
+	struct css_task_iter it;
+	struct task_struct *task;
+	int ret = 0;
 
 	/*
 	 * Autogroups do not have RT tasks; see autogroup_create().
@@ -2406,12 +2407,15 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
 	if (task_group_is_autogroup(tg))
 		return 0;
 
-	for_each_process_thread(g, p) {
-		if (rt_task(p) && task_group(p) == tg)
-			return 1;
-	}
+	css_task_iter_start(&tg->css, 0, &it);
+	while ((task = css_task_iter_next(&it)))
+		if (rt_task(task)) {
+			ret = 1;
+			break;
+		}
+	css_task_iter_end(&it);
 
-	return 0;
+	return ret;
 }
 
 struct rt_schedulable_data {
@@ -2510,7 +2514,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		return -EINVAL;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	err = __rt_schedulable(tg, rt_period, rt_runtime);
 	if (err)
 		goto unlock;
@@ -2528,7 +2531,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	}
 	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
 unlock:
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return err;
@@ -2582,9 +2584,7 @@ static int sched_rt_global_constraints(void)
 	int ret = 0;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	ret = __rt_schedulable(NULL, 0, 0);
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return ret;

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbeDZLBl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:01:41 -0400
Received: from mail-db5eur01on0105.outbound.protection.outlook.com ([104.47.2.105]:46080
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755118AbeDZLBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:01:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 4/4] exit: Lockless iteration over task list in
 mm_update_next_owner()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date: Thu, 26 Apr 2018 14:01:07 +0300
Message-ID: <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
In-Reply-To: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:7:29::21) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:nU6e2k4yUI2vlAMzjxyk+eveVnlmEsHSElflypsk4pxGIQwkeXDo0pwzRe4fedC1j9BksgvgMX7CndsuA12xYMGA0Xkn+wajm3ti99615UY9CaaImp94ZJWMxFF/LzE0LsQdoAWeQ32jT+hmjhcQw5SA/fdMoCFonlxeVWAzkJIREJMHdQEvg6SSQNPLwEBkoMr1kQJIYixJb5obKxdGjU6fdm+hgx/FEu3wPPfavj5enf1oSGAKEBv2aGg8QICu;25:ama9jnCnq86wKbkKxGi1OOaETN3skkhSOjqrbnCLtNzC9Jx55EcTDp+PPHfMFp22AAttc48bqla/2271nHssXi6gYMVrLD2KgGDfpD1PlkaqhXHD+agN85kSRYPMfwK9UXOX5jWK9dFtCSt7nxxzp9bT4BzfnAjsFZRDu5y24gl9r0Hj30XY02oSTOxC7Sgg2Tjks2Y7FEHoTbXb744QbGClSuuDP/OVtQN8zCZJNPOECHp1TwiCKhDbtIeG3waQqFRSFmZU/JH5qEM6fK5ld6AuCKNiAU3YJIxS+RoCwGBsUIjh8cU1Jv06eZfmSWBrzyQFYTTHkZkZM4MlynMX+Q==;31:Wt3nQQAjO0Ki6wud5ZXgqyI0xcE2jL60UlSgQ79oUg87dB9zSKpjxdtT4p2YZ0zINUXGB+Q9+EwtJ56RnsS0n4E/2Nwks0kyiompqZ7eIG3RsxOOtjgVcrvL1p5KEUCtdf0hxqsAqZRLK6zZ/+xdgHtKJnH/gD/kht/NRMk/9LVbAGqMYu4o+EO5vNguPSZvYxAwCM24AjxDWJyZav5WJ/dWj/I8MoWyl4VE9k7aCaM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:jh37Vg3zbTMm7KtldmQcbftJPMoSig3wEBfxkuJG9JgZNkywSKcyUrLLqcFl02t6GNTAUX9Yrz2/18Id3KEGEFX/I58xApWYoCrgNVdla0pSTpbzeFU+ocGZKZGjrIHfPtNnYSvryQ478RaiFl9flSqeQJBpYRd9jWMTAkHjA2+yXYhDbObiB0RVMXSb5e6ny6t5nkqad4LO+2CL5iVoxFPhxGYnvb0k4C1Yh4NgOp0BrlYxH1CcKmX+imeUPdHO3KCLnj1FY4F8gMElrEbOaKhQMus7TofPkw/p4WGwmgDPEbdufdGpbzSFN+7L0N7lPQFq/d/8n5p/aOF1eAaHNO/JI2R5TLa11SceZEv7cm5EP9jz1benKzKSaasYZGX3xw+os7+hT1baFCPk92RoSKzGW6Q0mpQMUsg9pvm32qHI0/oUgGthvat4C9cBXJMhQhAd5WY2BhJZdtiKx1XynPU+jkG5kogbgUcEPWfv/5D24vg5b7FX4Zenlss4tOuu;4:0iih1LKqzijEKUKcK9qME5KAhL/0ZBCASk96naEHlWLxe6vrQOtIRXYjP1J+LuoiYk76mUYc/qdOtT/S40GnnsFH5Jb1WX/vrdzOyLpIxj9a2tFXBQw/lfhq8agZvGNqwhPI2tscjdwqfn5u3b8OIgJnI27RS5zpj8nrdtp1UwfAqLZePCvx22kgqb6nIpS8d9TYyGakgy9RW0bVe/jLWN0T4Abyr7Jd1FRWuWebrPcr1600GqIuwMWSTlTtdThWP2GVE1+As5GyAnO/2wpW/iTMTAJ6FXZkMLXA+/kOZ6wkrxeN8qG5tq5Nb9RbtR42
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13440FE3F49B201142F8812ECD8E0@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(396003)(346002)(366004)(39380400002)(39850400004)(189003)(199004)(2906002)(478600001)(305945005)(81156014)(81166006)(7736002)(86362001)(956004)(8936002)(11346002)(106356001)(55236004)(476003)(68736007)(6506007)(386003)(58126008)(105586002)(59450400001)(47776003)(50466002)(446003)(486006)(316002)(33896004)(25786009)(7696005)(52116002)(230700001)(5660300001)(23676004)(103116003)(2486003)(26005)(39060400002)(8676002)(186003)(76176011)(16526019)(61506002)(66066001)(3846002)(6666003)(6116002)(9686003)(97736004)(55016002)(7416002)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6OVZXcVBsZk9EeEQ3aHZEQ1RTZXdoaERV?=
 =?utf-8?B?ZnAwbStkOG5aSFh4b25VYjhia2pma242WTRwY0YvR0RZQzVERHQ2YVNSTXRI?=
 =?utf-8?B?V1VrQklFSHlYWUdGTnpYaUxRako3c0Q3bUtkdHpwckZEWUE4RjZMNy9zOGFC?=
 =?utf-8?B?SC85dkhFb2JGamdwdW9DNXhKSlNsUlZkQ2hacmZXbjBHa0ltbWQxejhtMDZn?=
 =?utf-8?B?Ri9TdllobldpT3BKSElMMFN4Q2ZXYzdDcTZBSlBKaWFGUk1TaWxLNnJYRDgr?=
 =?utf-8?B?S1V3N3IwK2U0OXNMT0lWaVlBOHhDOS8wQUsweWZoa2hHWld6WUlBZlAyZnNV?=
 =?utf-8?B?QnpiV0x5YitnTFBUVFJ0YzZvelNBUHBySWVqenRKellvOHBmRFBIaVV5czRo?=
 =?utf-8?B?dWRxb2VVR1BSS1pkQUR2dTU1ekJLUWd6S0NXdHV2c0NLRGdnK0NpdjhZZGNJ?=
 =?utf-8?B?SS8wZ3orblJXSDVpcytFN2Y2Sk9KQVhwdzJwbHMzRXQwdzhXOUJUWTRBZXpC?=
 =?utf-8?B?M1hobEh2MVh3cEVOd0lyR2dKeTI5c1MwbER4RE83dG1rYkxGSnRrUjh4WE16?=
 =?utf-8?B?bkROK3VoYVhPd0w0Q281cVNVYTZ5emtvcDJXVW9ML2xMWlg0L3RqS200NVZL?=
 =?utf-8?B?Mk9FVzZuQUN3eU5ONDlvMGE2MGxsZmtaTjFDaGNMSzVla3NqUmIxNHRBd2cy?=
 =?utf-8?B?OGR0SmVOajBmZW9uNUVkbC83NWN1SHhUUDJSRXZFa3lyWU5ad01xZy9uc1c0?=
 =?utf-8?B?YUpXUXNFOTlUM1BIZkwvbFBvMkdpUGNTbHpKKzlObnN4MUE2em5WQmgvc2gv?=
 =?utf-8?B?cllTbzY2S1lXc1hqUnhFa2J2LzBkcWhiUUUzZ1I5aEJ0TVo0eFdVaGxGaE9q?=
 =?utf-8?B?RjdSTk1Jak5GMDlKMnBiZzZQc1ZKVXk2NkVmZm9Hc0tvaUE0elZ5QzhnUGps?=
 =?utf-8?B?WGlCRkszSXBpUEdMTDg1em9jeWJISVZpVjcxOGp4cUJQMVArbURkZlpFREdh?=
 =?utf-8?B?SFloRVB2YWxyZTc2N21OVWh0RTNwUUVseXdRdGFMUFJialZsSUprVVlCOVpY?=
 =?utf-8?B?emYwRlpJVm5HQUVWYUZEUk9kSzc0dmswS3Y3L3VPY3Rya3BvZlh2NnVEbmdJ?=
 =?utf-8?B?bEtKRktMWFV6cGd1R0tUZDhGWTJRN3dRQ0tnNUgvblFCTUpKQWZ3UExPbDV3?=
 =?utf-8?B?bm9DNlI3aHRMa0JqUGd2RkZDbzV4NDR3M28xcVloOWFUMGlZbjMwZktxeVhS?=
 =?utf-8?B?TkV6T3lHbUZacjVTYjA3WWRnN2t3WWUrNzRYdkZiWmZSZ3NIUTY2eDM0ZFZv?=
 =?utf-8?B?RzBnOXNXNzVvRHJGMzdSdkxaZityNnhCUDhFMkczT2hxOEIxcGN5VFVBOGdn?=
 =?utf-8?B?NHgzSk0wODBBYk40U2wya1RMUHUyWjZQMmJtQVdzL1pjNTd1T2tiV0djcTc1?=
 =?utf-8?B?MldHcmgyMTBEUFBwRkN4aHpvRHhxQzZYdmNmUGpJNFJvTHphekMrZUlacWdV?=
 =?utf-8?B?SHZqanlkSkZoZ3RlTm5mRGFya2ZtYnpxbHkybkMwMG9UZGFzUUE3Y1RndGpk?=
 =?utf-8?B?KzhOdDBUckpET0RsZG1xYlc1ZVZQdFFoTyt5UjdKbmhmSzZnbWlkV29tQ2lz?=
 =?utf-8?B?eE1aWDlkd1hra1dMUnlWNjFITHFVOFFia2c3SmM2a2lWcGJTdEd0UXRZd1Z4?=
 =?utf-8?B?eWdoeFpNVFVGaGZHbU5mNDkrdVozRVFxQTRQMlk1NXF0Mm5YaFdYTkplcDJz?=
 =?utf-8?B?NlZ3Q21TcGhocjIzbmk5bEVwaDVmcmpKcGszWnVvMXZEalBEcUZhejBZRENy?=
 =?utf-8?Q?fHHMtneFlEApFrX?=
X-Microsoft-Antispam-Message-Info: AjYFiLOcsOS44JFmx5BIrOGB44Djbmlw9jfm9PvCLMbcEI9+8G6xzwek1aA5YoQ+rzw5/8d2NtehDGilbNKpYbda+AcPtbGPHUzeQad6aAlbzKzVgV8/vJb6e8XMdQwtQj9wseW/R7I8/bQhu37AZnKIQf+SdFH7778dKczUwkWgJ19vkiRR8lQ94gM1du6b
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:OSimAGGB+5GUf0h6oDVRpmfl3USBgH3loXUPEnR8Z/YMe9JPJHeEFaWqoFP/T4V5UShhs6pb1yIz88TUQ3Qt2Wvyz/KLauBnrkE/tReZG8w1qojzKsv8xqGYoRQIL7cYpSf0rDPK1vaZXqEPJ7H9Yi9G51NFzYMCBRlzLZIQEeDpra42Qc9RRX0Mg1ZUH/cdCLQ330J75wvxF2gwJOj4Dgk/d0wh4UkYyJfpGsVve2ziQc8js7IgNN5neznn0iZyv2S1VXq4py7ol+9XR9Rc17w8nFNxZRISSEJx/16nOuH5nCYEaOJuPTbiVQaOQr+4eFCgKKzEwyJg+jxLuQYm/xYrW0/qcDjtqDj6w45bD2ebfQ8W+H1XXM2FXE0yRWBxs4SIfyyr9wUwzFldStFdz1dbaokRw+1NbRNaz4zDharyVCw15ef6FK4AlRRZ7/NiJYQBnKHQM70XTYaysRMpyw==;5:pinmYTfhTKertKzM8AGkSpyj3dOPGBoAQ8FJ4JXMgho4gjxKqhzfIhmv6jgcVifbyl+m/njSM2K/HAfG00MAkRmSMJEkE3KR5ZXVywbTUPxDLWa7fpLaGGHB3kjIAnl2ISBXrwKA5LmRSBuv9ub25hXU4vdJGMPVN91gAgLD8nQ=;24:Bzu2eh1hhX9Lc5kSLaBchluLOGLaOgK/dQLJ3ic4i/5tMcS2Q1TnJ8HUYzXULsDjv9tyrfzV+zgAddwQ0P0kPa5lnlkmODl1MCaiZXIkDdw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:kB1SCOpzdsMU0NlmM0F+B5mXwCyZtmmlUQVR7VcgU2UbgC/MylgGdCgUKK0aCtdKFRhwKA56KQJotvcKX9zcQ17mf4BCdmLA4/UsYVZ6DzLH6UYiIyXe1S7+t4dtq4CXquCwgJXJxJ/Cythsz8BOhJEC8mrRvoO2QRmhGWj2q7gLy46QQPDZoFMh3E85RGLgGRtPWFuhFV3opj6YflwTJMFMnNSctOBpECW4XsQe5D+Ofk4a6r4/ep28IxtTy1+W;20:nbU4AyJ/DGhyBW6w0JwyJ/fcy7oiICKFG9zMaMN5S5BaXlFrwCjufJ0nlaMfPIqbmwGoTltF5qNrOqTnPqCFHxvMz7U2BOD+2ID5F7YZUu5d/YQfWO1fsE/nj0ARh7nd/6wMBIwWkp0mSX+P4UKM0ffEfNepyUbftcGVNDQwNYc=
X-MS-Office365-Filtering-Correlation-Id: c3dbe000-f644-4b7d-160c-08d5ab6505b6
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:01:10.4127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dbe000-f644-4b7d-160c-08d5ab6505b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch finalizes the series and makes mm_update_next_owner()
to iterate over task list using RCU instead of tasklist_lock.
This is possible because of rules of inheritance of mm: it may be
propagated to a child only, while only kernel thread can obtain
someone else's mm via use_mm().

Also, all new tasks are added to tail of tasks list or threads list.
The only exception is transfer_pid() in de_thread(), when group
leader is replaced by another thread. But transfer_pid() is called
in case of successful exec only, where new mm is allocated, so it
can't be interesting for mm_update_next_owner().

This patch uses alloc_pid() as a memory barrier, and it's possible
since it contains two or more spin_lock()/spin_unlock() pairs.
Single pair does not imply a barrier, while two pairs do imply that.

There are three barriers:

1)for_each_process(g)            copy_process()
                                   p->mm = mm
    smp_rmb();                     smp_wmb() implied by alloc_pid()
    if (g->flags & PF_KTHREAD)     list_add_tail_rcu(&p->tasks, &init_task.tasks)

2)for_each_thread(g, c)          copy_process()
                                   p->mm = mm
    smp_rmb();                     smp_wmb() implied by alloc_pid()
    tmp = READ_ONCE(c->mm)         list_add_tail_rcu(&p->thread_node, ...)

3)for_each_thread(g, c)          copy_process()
                                   list_add_tail_rcu(&p->thread_node, ...)
    p->mm != NULL check          do_exit()
    smp_rmb()                      smp_mb();
    get next thread in loop      p->mm = NULL


This patch may be useful for machines with many processes executing.
I regulary observe mm_update_next_owner() executing on one of the cpus
in crash dumps (not related to this function) on big machines. Even
if iteration over task list looks as unlikely situation, it regularity
grows with the growth of containers/processes numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/exit.c |   39 +++++++++++++++++++++++++++++++++++----
 kernel/fork.c |    1 +
 kernel/pid.c  |    5 ++++-
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 40f734ed1193..7ce4cdf96a64 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -406,6 +406,8 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 void mm_update_next_owner(struct mm_struct *mm)
 {
 	struct task_struct *c, *g, *p = current;
+	struct mm_struct *tmp;
+	struct list_head *n;
 
 retry:
 	/*
@@ -440,21 +442,49 @@ void mm_update_next_owner(struct mm_struct *mm)
 		if (c->mm == mm)
 			goto new_owner;
 	}
+	read_unlock(&tasklist_lock);
 
 	/*
 	 * Search through everything else, we should not get here often.
 	 */
+	rcu_read_lock();
 	for_each_process(g) {
+		/*
+		 * g->signal, g->mm and g->flags initialization of a just
+		 * created task must not reorder with linking the task to
+		 * tasks list. Pairs with smp_mb() implied by alloc_pid().
+		 */
+		smp_rmb();
 		if (g->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(g, c) {
-			if (c->mm == mm)
-				goto new_owner;
-			if (c->mm)
+			/*
+			 * Make visible mm of iterated thread.
+			 * Pairs with smp_mb() implied by alloc_pid().
+			 */
+			if (c != g)
+				smp_rmb();
+			tmp = READ_ONCE(c->mm);
+			if (tmp == mm)
+				goto new_owner_nolock;
+			if (likely(tmp))
 				break;
+			n = READ_ONCE(c->thread_node.next);
+			/*
+			 * All mm are NULL, so iterated threads already exited.
+			 * Make sure we see their children.
+			 * Pairs with smp_mb() in do_exit().
+			 */
+			if (n == &g->signal->thread_head)
+				smp_rmb();
 		}
+		/*
+		 * Children of exited thread group are visible due to the above
+		 * smp_rmb(). Threads with mm != NULL can't create a child with
+		 * the mm we're looking for. So, no additional smp_rmb() needed.
+		 */
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	/*
 	 * We found no owner yet mm_users > 1: this implies that we are
 	 * most likely racing with swapoff (try_to_unuse()) or /proc or
@@ -466,6 +496,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 new_owner:
 	rcu_read_lock();
 	read_unlock(&tasklist_lock);
+new_owner_nolock:
 	BUG_ON(c == p);
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index a5d21c42acfc..2032d4657546 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1805,6 +1805,7 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_io;
 
 	if (pid != &init_struct_pid) {
+		/* Successfuly returned, this function imply smp_mb() */
 		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
 		if (IS_ERR(pid)) {
 			retval = PTR_ERR(pid);
diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b19971..cb96473aa058 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -155,7 +155,10 @@ void free_pid(struct pid *pid)
 
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
-
+/*
+ * This function contains at least two sequential spin_lock()/spin_unlock(),
+ * and together they imply full memory barrier.
+ */
 struct pid *alloc_pid(struct pid_namespace *ns)
 {
 	struct pid *pid;

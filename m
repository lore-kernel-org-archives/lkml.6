Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeCTWhs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:37:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbeCTWhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:37:43 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Shaohua Li <shli@fb.com>, Rik van Riel <riel@surriel.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [RFC] mm: allow to decrease swap.max below actual swap usage
Date: Tue, 20 Mar 2018 22:35:43 +0000
Message-ID: <20180320223543.6188-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:180::1:8fe7]
X-ClientProxiedBy: DB6PR07CA0161.eurprd07.prod.outlook.com
 (2603:10a6:6:43::15) To SN2PR15MB1087.namprd15.prod.outlook.com
 (2603:10b6:804:22::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 680c77c8-b0ba-4927-3609-08d58eb2f8ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1087;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;3:Lo63tBL8ScydolNeOCB7/1Im/1gngSpUyQsxv80WSKgxZzaaXdlpaIcv2QBT1jqya0zXGdYQCnfYJoezat7TY+7uwZ9PeCMrYo9X4FObYaQNKYjZ+yv79pxjmy2m16wA2YDuOavgGTEz/IDRW4IAQaVjlnjtV0sJpv94cSNwKowxlqWVJNHkZXzaoCUhCQ5W8lhTU05MjwJitAx+ZgjzvijMpGnom+VXooL5KGz76GdlM+rr2ZKP8UiuLf2dFOVh;25:atXDMbU3G7JNvNPxqIHKNc8V8mH45URHTybEKAfSTGKf4YhzK48w2s3BQm8WM3UPtxnLSvvfEGBxx1S0qdwVCpA0UmTu+F1LztP/lRDKrTymfpYXODfawONwNuq+jel1YR1w7TCm5UAnNhPNxksb2c5U6QQLIzL6wNb8V9l94MCEsui1ik80af/t/jfCH9CvSwaOZx817vOUdaTN9WAYVVs6xk6FH38Q6h67obKoLMkproKIElkfCE48OAqtB5LORYMozymK9pqCmOR+XQXzQZEh2b+VIEEf550eopCNEyPKFvwEGWKVyhzSRheoWjoAcgxdWx2SXip476uwHTJ8mw==;31:uNiwFgVN7356wL8iIZX8xgCGC0VP8axVSund1FB7ONAy0yElPZ8RZKo9w6wRoaAiKwrZxjs1KYBjFCjRKcqYFCU+NRNGzkYaDDmg1Q1HCyddmBq06BvcA9fFUu4YJ8mfeX31Bb3EUK9QNScqyHKheBkTD12vxpx0tGgbXKNLkupbknXosvqXgWHENukNRr3SYKAxbhDVQEQqfFsDVolCwThELPHZMOuUF6lKR/kH2/Y=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1087:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:oocTIps6C0AxIyebWdTxcObXH7TSza2lQgMTsFdUL/YSZ2+3Re1WNAG9e8ADdc/sUsBEN9K5fZKwiOnR9AKtFv81mYndUnKat+JVLLNOietf5ze+gAFxJF9Kw0DkizpN/ygDzXbYfmXnq58zYuFeIY9KQMO0HNZfdevuLy1nZZepqKNaLDVi2hS9qVDBfbCC6WMVWr3ydDcb1JCH404Uk7Z4ngcrpB3g1Rgh02m/98Rt2r18S/maCsRjXWlsOcA7rRG760P5UGrU++JjvlagDUZCV7KVKa2hqqRiWr9H8JaGIdDZSJ8qJIg3qho2r83J9EU2vhzEQEyJxOdFDwurNApcv+mDkbXHox+6e+/9Gt4pdsucrUKkuGy3wnXMmn3fJjQkWOc4om+wU7gKhiTShXp+NaEdWDZaK2ZlOyoxZP8R2+JUyBL8GzfOz2xQMU/uxz4JKBD1tCElvQXy1UbGtNeNMG4mhwHrHhDHtDZ/SsfQiRm2f1J3zs501ixONco/;4:NGYgaKYJCUurVrhPZ0YDq/YaAB/NAWRkfP5HPnKbBu9cqLSPIw68UnaQPchb/PZkLN6shcmn1+rb1QJ2JlUOd5ZF+hjSNZF1m3eZZQ0XtJJh1SpAIESeyfqH+d8kMqJ0jkM/goTmQ+DDxX6kbuLN7wmRI+hK1BrRKSLb7ad0Uix3oa5yNdMldB1P7PTpIGc7F8u5zSNXWmlqoGpL13cZdtcZQCjmTOG2AWlbAOMvEQ3/NtpoQnSpwktnpENamppdu2Zb3lLd6s+dcJLXCpDumewm1wDy4m1y1Xd+GyvfjjXdk8HmMlNf/1uZEoWXaDbsWdTb9AKKlV1g0FCM7q5c9xABtRfYdRezoiaXsECMmNs=
X-Microsoft-Antispam-PRVS: <SN2PR15MB1087BA4853F1A1861B7E7C71BEAB0@SN2PR15MB1087.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(11241501184)(944501316)(52105095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR15MB1087;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1087;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(346002)(39380400002)(199004)(189003)(47776003)(68736007)(46003)(105586002)(4326008)(386003)(6506007)(36756003)(305945005)(59450400001)(86362001)(52396003)(316002)(25786009)(54906003)(6916009)(6666003)(51416003)(16586007)(7736002)(6486002)(16526019)(97736004)(52116002)(186003)(53416004)(8676002)(2906002)(6512007)(81166006)(2361001)(2351001)(69596002)(81156014)(106356001)(5660300001)(53936002)(50466002)(1076002)(478600001)(6116002)(48376002)(8936002)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1087;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1087;23:xD6dJ8ntcIDrV8goIofI6p+hF4SZtBXcEFknUdz8i?=
 =?us-ascii?Q?oq0fncGoTtfKKN6RqcDzcKOwgytjH1tEaPaZWYzvKeXhhVAlhniDQiJI1NUq?=
 =?us-ascii?Q?0FjCdu4bXszkfs/RNUGQ/+OEDtxVHWCHiPHGhSXJRBmIEUnG62ws6e4H8P8u?=
 =?us-ascii?Q?6VqNY23XbCbUTkmcPteCcC0fv9BIfw5zQGzoUv8Cylp+ilEqT9+AlFqffc5n?=
 =?us-ascii?Q?voY9x18EVltn9j4q3LLyBsjLQGGgHCGBOxzvm6b4QFg2CURyjcYdqvCAgC3+?=
 =?us-ascii?Q?1VY/e8GpD0X1r01yaBHiw9YNi419Q1L6KrJAlWf++LsKa3RE483xK/aBfLyA?=
 =?us-ascii?Q?9x4nD6oyvactDgs5lfJ3CLgykgFLxAyx4RWVVP8tCv03DJHiVYiklyHueeXc?=
 =?us-ascii?Q?bVKNsJPU+IcVchGbqQDzBnfbvc/VOUqsbcI/3ULO0ZG0FSLyMAkSNws0+RmH?=
 =?us-ascii?Q?FxSKhEsYyUAgbm+4YM12QbMmbY6NZaFCe11A74ZN9Y85/vUa0Chlwj1GE0ek?=
 =?us-ascii?Q?Eub3mVM93KrhvJSzxn7KCroCLY6WgymTwtw3kpQtVR579KmjjF39AlCe19bQ?=
 =?us-ascii?Q?3zhsm5cirwiWLGaHmcpS0UjWK7Z6XnjjZc8TuhKYXT+FWHBTPvtid5pJNbSS?=
 =?us-ascii?Q?ot9TcWw5Y5db6pqIlAdqE454DG8cEIshskTsqsn/DWjmaHLLcrXuFMBZePKo?=
 =?us-ascii?Q?YdNwsd/XKb0z6dBYsX7nnAGYwvjT4aNToySihgp81bw5ZbFnFHfynQ6hgazF?=
 =?us-ascii?Q?M+pHsgbs62YLbkywCPHkFNodqMgnORrmITRAdRZvF3HRsbqJxwlE+Rn1H1yg?=
 =?us-ascii?Q?k9mgAMU8mOXyQ0Q7iPXxatdgbhfQtyqDHV5QJSntAeS9VkgvyymnvAMCzmc1?=
 =?us-ascii?Q?wmsmgk+lDw2jiV+dJh/cpy02gPzohla1WflaDOe2Nn6Q2q8ps0zRZzplGPA0?=
 =?us-ascii?Q?wRj/hNc52U7bm0Glq4H8OQhIvKp4dsa343jtu/3PyRJ/+rBSGbEMKKZuCHaJ?=
 =?us-ascii?Q?ZDCQd/hzTF/eQ4iMUQP55jQe/YzBZtNCITs3z/8RaIV/9dO9Zf/D+/5fysPa?=
 =?us-ascii?Q?Sa2X2k3iQTGQCAii240JnARZmuEDKrtRsTgRtezPTMvFGeA3yXBnsP9QidLO?=
 =?us-ascii?Q?GJVSu9y5Wg5IN20gFCSTfaC9nUzVCSEs9tFDmVzyJCmW6VZZEW619M2Ny7eH?=
 =?us-ascii?Q?WLkn1X+i54tqgaEQP/3fK+UnqzNGWNNrJBp?=
X-Microsoft-Antispam-Message-Info: UTzBkCX1dk3UnimmkoCk00PzsF4sb9HRs7WEmlUF7pAZxdZYtp+68RUmbnIiFQz2QuQhp1uQJUoAx+rIF6n07B6vW48z5gwUd8q1PFvivRnuz6iwRsXd5vSaXELTDeqI2xxrAdUFOrnBQDDEgIm/x4/qCVJBBdR/6gFEiRhbjqp+8n5CAFWPWJJ9AZzG587g
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;6:YRe5xa9pcToxm2qxdzupGpldjvn/mrxkGB++bSjQQB4NfvrLgi9pJZ6NIJb8XAee7FbQ93BNeFUV4U9Rsc/JR4AeGvF7PHkwk/U0V1ovcRV2FEvE9lZcOlhSP2PXNCZbrN1eO0QRRb4UO4i/NXvs+awcm5pSmp3/j3Nr6J/8kObps76oRbyVmpTOMxuLGY4Id0NpZIND2tMviTl6DnvBXgkc0jb9rVnccAs+k6uaAie3KPrGd/XCBMiw1vVKJ5AZgyyMSPfM7448g0JCklVTnT8mUJ5wjWKCKPbneAA29YH+K82sWvghJsQDjTQ1UBzjTHPOy6U/TflpZAtxkn5Oay0q6zuuj4R3ZDmfmcHCeuI=;5:4uYUevJE9V2euuSqzPhfatd45QFLaQreqsmmfmZAV39z1qw0ReLP47bIjz2W1it4mVAzEXOMQoC36GTn7BfryjW5l+REky/lzYeZVgETgYHOFQSwv1oe+yct3m3zbC3tm11Sr+PUrLCSTfthOrmIlIid8fO5ajDkqubMlhRSUmI=;24:nktk8LW7pqmAjj9+sGicwIvm035g/prMTkyQY0IzAJ6BesIWSp6AGC0TRCqwp/aieNIuu7XfaP3X+59lM/2zRONOOcIDK9FEE/8Tyt4JTb8=;7:cFFq/0Kl8VTirFh2vLWR8GROM1FitJ/fr50EPiHWc2vCQU64t06NtHbgbNlrAAQhxwyxBHdQzn016+h9PT/w1GFF5RtZnIGqwgqRgSv08fUoMSOGaLwakqoKyXUPszyzmYDtwoKdpEWA7xPuMP+b4mZWFJ4WhUCLYpI0cEHp5hzEQLvfTubeEOfKN2bGX2t86qvQa8U8SL3/QF4EfP8RyMaypJ3h9ANS6c9C2E1f/Vs6Z5xnAiYH5w/YTsKeRhOG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:1E48ld5xAjU8PtA6RrPX9rks5WG6nhsLAMRgQ7+O/sRgWsoJQdTkIyySW8WfvvVljFP7qK/fXNBRkntV1YfAn+ZAAoXkmKgooOnuviVxuUeMFGcOuX38QqvGUnP2p0DcK6fITavp9xSszh1Z1EU+83ToUPO2+ozV2jZo1uqmuC0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 22:36:05.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680c77c8-b0ba-4927-3609-08d58eb2f8ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently an attempt to set swap.max into a value lower
than the actual swap usage fails. And a user can't do much
with it, except turning off swap globally (using swapoff).

This patch aims to fix this issue by allowing setting swap.max
into any value (which corresponds to cgroup v2 API design),
and schedule a background job to fit swap size into the new limit.

The following script can be used to test the memory.swap behavior:
  #!/bin/bash

  mkdir -p /sys/fs/cgroup/test_swap
  echo 100M > /sys/fs/cgroup/test_swap/memory.max
  echo max > /sys/fs/cgroup/test_swap/memory.swap.max

  mkdir -p /sys/fs/cgroup/test_swap_2
  echo 100M > /sys/fs/cgroup/test_swap_2/memory.max
  echo max > /sys/fs/cgroup/test_swap_2/memory.swap.max

  echo $$ > /sys/fs/cgroup/test_swap/cgroup.procs
  allocate 200M &

  echo $$ > /sys/fs/cgroup/test_swap_2/cgroup.procs
  allocate 200M &

  sleep 2

  cat /sys/fs/cgroup/test_swap/memory.swap.current
  cat /sys/fs/cgroup/test_swap_2/memory.swap.current

  echo max > /sys/fs/cgroup/test_swap/memory.max
  echo 50M > /sys/fs/cgroup/test_swap/memory.swap.max

  sleep 10

  cat /sys/fs/cgroup/test_swap/memory.swap.current
  cat /sys/fs/cgroup/test_swap_2/memory.swap.current

  pkill allocate

Original test results:
  106024960
  106348544
  ./swap.sh: line 23: echo: write error: Device or resource busy
  106024960
  106348544

With this patch applied:
  106045440
  106352640
  52428800
  106201088

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shaohua Li <shli@fb.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
---
 include/linux/memcontrol.h |  1 +
 include/linux/swap.h       |  9 +++++++
 include/linux/swapfile.h   |  3 ++-
 mm/frontswap.c             |  2 +-
 mm/memcontrol.c            | 27 +++++++++++++++----
 mm/swapfile.c              | 64 ++++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4525b4404a9e..0c1508503422 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -184,6 +184,7 @@ struct mem_cgroup {
 
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
+	struct work_struct swap_work;
 
 	unsigned long soft_limit;
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1985940af479..878f111d0603 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -650,6 +650,8 @@ extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
 extern void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct page *page);
+extern int mem_cgroup_shrink_swap(struct mem_cgroup *memcg,
+				  unsigned long nr_pages);
 #else
 static inline void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 {
@@ -675,6 +677,13 @@ static inline bool mem_cgroup_swap_full(struct page *page)
 {
 	return vm_swap_full();
 }
+
+static inline int mem_cgroup_shrink_swap(struct mem_cgroup *memcg,
+					 unsigned long nr_pages)
+{
+	return 0;
+}
+
 #endif
 
 #endif /* __KERNEL__*/
diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 06bd7b096167..16844259e802 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,6 +9,7 @@
 extern spinlock_t swap_lock;
 extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
-extern int try_to_unuse(unsigned int, bool, unsigned long);
+extern int try_to_unuse(unsigned int type, bool fronstswap,
+			unsigned long pages_to_unuse, struct mem_cgroup *memcg);
 
 #endif /* _LINUX_SWAPFILE_H */
diff --git a/mm/frontswap.c b/mm/frontswap.c
index fec8b5044040..f7cb2e802fce 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -458,7 +458,7 @@ void frontswap_shrink(unsigned long target_pages)
 	ret = __frontswap_shrink(target_pages, &pages_to_unuse, &type);
 	spin_unlock(&swap_lock);
 	if (ret == 0)
-		try_to_unuse(type, true, pages_to_unuse);
+		try_to_unuse(type, true, pages_to_unuse, NULL);
 	return;
 }
 EXPORT_SYMBOL(frontswap_shrink);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1a917b5b7b7..2150f15a7345 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -60,6 +60,7 @@
 #include <linux/vmpressure.h>
 #include <linux/mm_inline.h>
 #include <linux/swap_cgroup.h>
+#include <linux/swapfile.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
 #include <linux/lockdep.h>
@@ -1879,6 +1880,23 @@ static void high_work_func(struct work_struct *work)
 	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
 }
 
+static void swap_work_func(struct work_struct *work)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = container_of(work, struct mem_cgroup, swap_work);
+
+	for (;;) {
+		unsigned long usage = page_counter_read(&memcg->swap);
+
+		if (usage <= memcg->swap.limit)
+			break;
+
+		if (mem_cgroup_shrink_swap(memcg, usage - memcg->swap.limit))
+			break;
+	}
+}
+
 /*
  * Scheduled by try_charge() to be executed from the userland return path
  * and reclaims memory over the high limit.
@@ -4391,6 +4409,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		goto fail;
 
 	INIT_WORK(&memcg->high_work, high_work_func);
+	INIT_WORK(&memcg->swap_work, swap_work_func);
 	memcg->last_scanned_node = MAX_NUMNODES;
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
@@ -4526,6 +4545,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
+	cancel_work_sync(&memcg->swap_work);
 	mem_cgroup_remove_from_trees(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
@@ -6394,11 +6414,8 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	mutex_lock(&memcg_limit_mutex);
-	err = page_counter_limit(&memcg->swap, max);
-	mutex_unlock(&memcg_limit_mutex);
-	if (err)
-		return err;
+	xchg(&memcg->swap.limit, max);
+	schedule_work(&memcg->swap_work);
 
 	return nbytes;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 44101a14e3f5..e7551ca9bed5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2093,11 +2093,11 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
  * and then search for the process using it.  All the necessary
  * page table adjustments can then be made atomically.
  *
- * if the boolean frontswap is true, only unuse pages_to_unuse pages;
- * pages_to_unuse==0 means all pages; ignored if frontswap is false
+ * Only unuse pages_to_unuse pages; pages_to_unuse==0 means all pages.
  */
 int try_to_unuse(unsigned int type, bool frontswap,
-		 unsigned long pages_to_unuse)
+		 unsigned long pages_to_unuse,
+		 struct mem_cgroup *memcg)
 {
 	struct swap_info_struct *si = swap_info[type];
 	struct mm_struct *start_mm;
@@ -2192,6 +2192,17 @@ int try_to_unuse(unsigned int type, bool frontswap,
 		lock_page(page);
 		wait_on_page_writeback(page);
 
+		if (memcg && do_swap_account) {
+			swp_entry_t ent = { .val = page_private(page), };
+			unsigned short id = lookup_swap_cgroup_id(ent);
+
+			if (memcg != mem_cgroup_from_id(id)) {
+				unlock_page(page);
+				put_page(page);
+				continue;
+			}
+		}
+
 		/*
 		 * Remove all references to entry.
 		 */
@@ -2310,7 +2321,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 		 * interactive performance.
 		 */
 		cond_resched();
-		if (frontswap && pages_to_unuse > 0) {
+		if (pages_to_unuse > 0) {
 			if (!--pages_to_unuse)
 				break;
 		}
@@ -2618,6 +2629,49 @@ bool has_usable_swap(void)
 	return ret;
 }
 
+int mem_cgroup_shrink_swap(struct mem_cgroup *memcg, unsigned long nr_pages)
+{
+	struct swap_info_struct *p = NULL;
+	unsigned long to_shrink;
+	int err;
+
+	spin_lock(&swap_lock);
+	plist_for_each_entry(p, &swap_active_head, list) {
+		if (!(p->flags & SWP_WRITEOK))
+			continue;
+
+		to_shrink = min(512UL, nr_pages);
+
+		del_from_avail_list(p);
+		spin_lock(&p->lock);
+		plist_del(&p->list, &swap_active_head);
+		p->flags &= ~SWP_WRITEOK;
+		spin_unlock(&p->lock);
+		spin_unlock(&swap_lock);
+
+		disable_swap_slots_cache_lock();
+
+		set_current_oom_origin();
+		err = try_to_unuse(p->type, false, to_shrink, memcg);
+		clear_current_oom_origin();
+
+		reinsert_swap_info(p);
+		reenable_swap_slots_cache_unlock();
+
+		if (err)
+			return err;
+
+		nr_pages -= to_shrink;
+		if (!nr_pages)
+			return err;
+
+		spin_lock(&swap_lock);
+	}
+	spin_unlock(&swap_lock);
+
+	return 0;
+}
+
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -2693,7 +2747,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	disable_swap_slots_cache_lock();
 
 	set_current_oom_origin();
-	err = try_to_unuse(p->type, false, 0); /* force unuse all pages */
+	err = try_to_unuse(p->type, false, 0, NULL); /* force unuse all pages */
 	clear_current_oom_origin();
 
 	if (err) {
-- 
2.14.3

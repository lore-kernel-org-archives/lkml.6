Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEBPsT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:48:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52064 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751574AbeEBPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:48:01 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 RESEND 1/2] mm: introduce memory.min
Date: Wed, 2 May 2018 16:47:09 +0100
Message-ID: <20180502154710.18737-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:767e]
X-ClientProxiedBy: HE1PR0101CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::23) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:u6lrlYTcoCmHcgUTidWY2FTHMFB9tjw3cKwEJ4aYJI72Es6iG8oDLjCC5fl2SMSq7BMgMUU8ftrT3z3rVnftR/ZTbNym1V9KyIEHJACYKKnepSlIrdpkGKa+Ww0vXtQlfNivXuQ5J661uQgJhE3oKkHpa1nlenSrksb68cPyXXNUExGjOQoC558CIjldbusvWQShZ6uS84F/IYjMAB61HRbWVKlT3uajqaLF/V37ml+YxNJ6cvXjSJCIlTEx234Z;25:sFJS3wP626fFQ2rvBUJ5c3UVDenkwdro0t85K4E39bIvBC6wB4twKDtpYyapNSyVk0jY4F2xuiTkmIXDCUab5nci1vKKN/D9Db2/VSG9djq4aw9+3J8fr/K6/FRf8oU9fn0RhdyB1WcOQrpyCvWhvJxh15YNSInuzA5VbUOSTVKrFijPFwPKIvg6gCcQjApUL6Gg51rfF4CM3QQoEMnGotcdjSaSmQENaa/hM7Ea0+AhIzFWE+4YdS/IKiNej8LAPQckkEx3sYFN6AJmec+nNBEQcsBzrIYEQTA0UQc2iK2ysCs3hqvofYO0aWNT3lgJQA4wjYRpqUpiTsDEk0nkTA==;31:n7/38CgZ/r/gHGIE/K67IFd+CkNMgG4gWoHmMdOYXyu/98uqRDkv8aBB4x6ZEv0aPclzz0NtehLsK6HmzESSVH+NgaX7LhP57IMk1OAAvxN3K37dsKCXtDuSOCJ/B715YZSuFGXvhre3IOafv8Q4BS/CzS0R1q8ejdgweDhFNBeXIxcfMApbrzQVBXVwAEnRxkwMpHRb7n8C9atAybTUWknuvFWwPFTmhJOjtmrZACw=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:QdNDfENaALrdNGlUNrkEnjUCFjl304G2dQX0AcWDQ0epiQ05hljHIyJGVS9Vf3XqJ51ZgSRLypeUyxZuZfH4FsP8Az3pM1xI4NS0TVK+p8CUhuSSEAgIb4WqRmIT7eOgKsnJ3iLeoQL/5g1ZZlYoIX/7OOMsMgQNNpD/9iJZ62UT/gkP2ogv2p168Zqqa1qFCBOs45E3CJGU/UEl/WRHGV8tEQBDEAzxqKEBX0QB+0XXKRD+nLAdpnaWXrA3aN1axSu9jR0yqeO2OuRC8aHLYoUhWBTn1/fsloEJ8zLbmnTBaeJSBOBv3PeN2WF23eQIiwCpcoEyjKQVsOVB/fkDfC7ZcHIbxH1MPkVS2yjy1k9OT5dSik5Xy7XiW0LObeEhetcY71oDQntZeVdCxgZfSkw81thqRHuxeIecMxaKlXRxkfbgKLjXGa0y18YS83/2KxvaAdqVEWB2VD0aF2LbRR2HBlZ/KJ9PNU6FMdS76Z9jSVJ6QMnGmSRzv5f7s/ke;4:j32UwQx/GHKyH4ma2st3ryRSIq52xjzMxPyhMlzvHit6kGxvzHQSAlWQ0FQnHpmTpyuGEynpjx8beSK9yPzH4y/Ea4d2ty9N+WhFgCn7KCIJsBS8xL8/smjmBbcmO9NWjDvGA6FfAuxr90wOPbbbP428kLwKD8XjL2AMjTiwaSgDV2EKnfGZ3QYg44mwNNU4e3Swwk4vz+yYsvEzvGLn5M2FIRM3rwZsdVsZg2qIFKi2g2c9PJhxGm7WY+byCwTs6AcWGNlenWwoWXU98gzQYIsHYHFAaju7ndVy7MRlSs0TxRcn1LxtmhJGflmWaGIjqqrk9S03DO9GDSS1i7CalqyZsKHbZmBl4bGM7Epptj0=
X-Microsoft-Antispam-PRVS: <CO1PR15MB107776929E4E45227186F242BE800@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(486006)(2361001)(7736002)(305945005)(47776003)(106356001)(6486002)(5660300001)(53416004)(8676002)(2906002)(2351001)(1076002)(6916009)(6666003)(81156014)(50226002)(6116002)(68736007)(81166006)(8936002)(386003)(6506007)(476003)(46003)(50466002)(54906003)(48376002)(2616005)(59450400001)(316002)(16586007)(105586002)(97736004)(6512007)(39060400002)(16526019)(4326008)(25786009)(36756003)(69596002)(51416003)(478600001)(53936002)(52396003)(52116002)(86362001)(186003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:hwxeC8aBVxUdxFSL71B2UEcg0DHoqRPTQroB49llA?=
 =?us-ascii?Q?yjQiKHuE5/PwfglhLn4p5bsq9x53dNTAfdIjT4qR+vyp0elkSgaoq0Z42HNR?=
 =?us-ascii?Q?qyDMKjoeuNXXGJjWTpCb33loDofn3wXE/uyYEuv3KY0OUNnwXfIa6clfKfHP?=
 =?us-ascii?Q?nHK5vd5I/OYZAlKPCUWJreQywynCZYBV0rkaZCJFCnM7SNGzRIqfdeIgJ201?=
 =?us-ascii?Q?C+ICpa7siqtZ60waER5AfH1S2uosGtZNYWtZ80qi72ZoYq/jzwQ8AtqaJ8oq?=
 =?us-ascii?Q?jJP+VMyLHWr4EaOoew3tI1+gDMVw4/WlW2l/rwyptZy49/QLZDwR3If2xVt2?=
 =?us-ascii?Q?lBRGB9/umsU/Adev4h5syNAu6odVQe8KNgGPLA7W0/iGYIWsY+6pFgozyyTj?=
 =?us-ascii?Q?BYzdYXiP5D6NtK8pBBIHOGQ2jQyfhujCegxuY7ZD0/l8+e0uR/zswAzUDRJa?=
 =?us-ascii?Q?mVSq3o8b77dcRS5V/dCv+BFVqtlsRjvrXpgsBO4TWVJ8qCrnsqYIwrwZCy8k?=
 =?us-ascii?Q?vrWdNcvUXVtoKa6oLvl4gaxHUxria7Uz9Rqrsi+0E7J3q/MUZwouC+gXgXwf?=
 =?us-ascii?Q?OEVxBSlld4ljrmEgfUDRDbbNz6485UfeIXagbG2nEUHQtL9bE545hEw/b3Cl?=
 =?us-ascii?Q?XxqmwxTjJ2qgw/wO+9n4NPvvk7v/tFOKddJztSVqdGlfwVPN+h9mthJBBRQ2?=
 =?us-ascii?Q?LITA9phYbZzi0oaoKRs/mGOf3SsRLbOdTWHJNrQUFN5joa+jYIoxnExwZF3c?=
 =?us-ascii?Q?80syg9enDRNPUOFTb/WD5MWjZ0tv9TBeJnU18Fu5s15DGs3zXewfbjmJrm7P?=
 =?us-ascii?Q?5kcdCPB4y4sdAUKb6Hof1itS9okki0c96q8uaTHYsD3vFyiu+00heKQtswiF?=
 =?us-ascii?Q?amPVAGMhFPPkg813YjvBvmJT+egm+EWDHAvXDyTQ+FP/UF9VbZwOwzVRsjM2?=
 =?us-ascii?Q?RClJJ8U79YpfEpwtzYx2bJAAmQ7yBGeWzjQW1Ycq+38aKX4mHykzVdehwR3X?=
 =?us-ascii?Q?jFRCrxvSmXedw2qXbN1D8M2Zxxq1NtkFw+QIh9vBk2y76mXwqNx8r4QoEJiB?=
 =?us-ascii?Q?RwdbqsGUSxq0eKW6XDCi8VGyPNc45fFPGt9StEiT+0nGP1CS0xoM6w05oEvz?=
 =?us-ascii?Q?uf70eJaVi1t97j03IFkCSGBkTEA19XMX7FUViZNjrC/T1BfJG8MVkT2+X7Di?=
 =?us-ascii?Q?pqyHaSmodKjlFszfaMoKrJ1vz7Av6+upTwqcY/PZOeh/QcbSMvITE4Srk77u?=
 =?us-ascii?Q?okVeIgAFnw1NlogQ+kfFwooYK7hM954Rkjq6kQsY+Bz0eHtjEzJ7/xv9Kb0m?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: gddxg/W9LmC9UsIg9vYDI8rTf+A0de5H86mhOvTb557W58NB+2uGro31XT9XAULauOLqQKNpLolACfOj/JmbBC0TquZIeG0BmZovUirzIO+eEnYJKMNkBsYMKHqo6sZv5sOUPx9fFkobIy0Q8sYn8TmEz9Qs8plq0BzzpSimnYWW5SarlvjD1H8X8Qi7dlv4
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:+NXQFGpXkRSggOIU3PVGDlfHzngi71EgA3JSkTyq5wsDUQK6JWehi9t7YgcRnHFNJgjYu5HGIaI+S2onLz5wE2KykgSDN3wdi68BNAXWJdwangugS58UKpLALWSI8W+QkZbe1LAM1CW+bI6StZcouoUKjEMvh9fGyRA31M/Bsm2ZJOVPsmWdxKADkHTUWKJOQxD40Ev3yEmrQadVm5+1cBrNPGEBRSFedgu+fYiuf3vMi1d2bk/NhaD+YfGtBkT3ydyTwAJXYh4mzti9MoANpaCaHuLdaT9UUnqf0jIf7zDfoPI13UELTSqECkWKAu+rikPiMtwdvbcwR3JObRF8EqzpD6mDsfkMekgeDkyWgQeV/7+KBY94mRe8brOqTcsSiS6JIplPbqDa9VYZO4lOXWguF5mLZ1pz2plMveKOUpP4pvSsqHz3VavGXMM+JnAqZM8L9JLQE1AfY0VjLVKoTQ==;5:ayPVSpWcDgea2GnZHkEVvfOoUhBF1kqo5kCdwxxyO/f9YoqtalcjUwRpChfw5c47l2rkhgjdywIUCgTTgy6K79BVOEj3A+BeCPaT5YsrdNlJP8Rt8PaesYfoAzddRm+iZMJoPL/kf4WQWpQ4pMoMnfl44uVxvbcrcym8th4Yq2A=;24:UrHn1/Ep5mOaRqyWWQIc7f4Us582qIVnqpd8SNX4X6HMsOb1LvDnyDw+DS9kiz7hrH05oVF6rUBsGfAQrNFL5WSfW4YezASvzTbwB4LlxRc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:uj9VvBdYCsY9lAKh5tyev3KMGV45lQxxTbQdgeAzWJsbo0+cXCp6Ujisd6Jb/wUkg2UZ5rL91mxVS6/fccovNYWIBWRvHeB/xol8zUsrHSuXwamLSl5fzdzXavHFUfqF/BBsat6dnm0dgmq+UfBBOeJEY7U0KtSZZOPNbQ976LqcMZf1PT3T1JKGXgu4MPfAhiG10wkNtV7bk+ItFojDDzj0OYa/CAU21VTMyyYtnTv+dLzVMYoGcEjbvEpmBjLR;20:0qEYf8kxHqaKn6DpmBeRySxyW9yGmiCDazb7293OOGVY/xxsRrGI6u5jg0y0WAsek0YUia5abMf6MadDbg036DpRsrohbL8GiOVt6e4u4R0YIjAIh4y3X2S7ZQEMedBC0SAy/F2VhYWK1xicn/bvTtTTkJKT5ZSm0wNb/4hw9E0=
X-MS-Office365-Filtering-Correlation-Id: 2a6cbcb3-ad94-4790-8346-08d5b0440a54
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 15:47:39.6304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6cbcb3-ad94-4790-8346-08d5b0440a54
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory controller implements the memory.low best-effort memory
protection mechanism, which works perfectly in many cases and
allows protecting working sets of important workloads from
sudden reclaim.

But its semantics has a significant limitation: it works
only as long as there is a supply of reclaimable memory.
This makes it pretty useless against any sort of slow memory
leaks or memory usage increases. This is especially true
for swapless systems. If swap is enabled, memory soft protection
effectively postpones problems, allowing a leaking application
to fill all swap area, which makes no sense.
The only effective way to guarantee the memory protection
in this case is to invoke the OOM killer.

It's possible to handle this case in userspace by reacting
on MEMCG_LOW events; but there is still a place for a fail-safe
in-kernel mechanism to provide stronger guarantees.

This patch introduces the memory.min interface for cgroup v2
memory controller. It works very similarly to memory.low
(sharing the same hierarchical behavior), except that it's
not disabled if there is no more reclaimable memory in the system.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/cgroup-v2.txt  |  24 ++++++++-
 include/linux/memcontrol.h   |  15 ++++--
 include/linux/page_counter.h |  11 +++-
 mm/memcontrol.c              | 118 ++++++++++++++++++++++++++++++++++---------
 mm/page_counter.c            |  63 ++++++++++++++++-------
 mm/vmscan.c                  |  18 ++++++-
 6 files changed, 199 insertions(+), 50 deletions(-)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 657fe1769c75..a413118b9c29 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -1002,6 +1002,26 @@ PAGE_SIZE multiple when read back.
 	The total amount of memory currently being used by the cgroup
 	and its descendants.
 
+  memory.min
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	Hard memory protection.  If the memory usage of a cgroup
+	is within its effective min boundary, the cgroup's memory
+	won't be reclaimed under any conditions. If there is no
+	unprotected reclaimable memory available, OOM killer
+	is invoked.
+
+	Effective low boundary is limited by memory.min values of
+	all ancestor cgroups. If there is memory.min overcommitment
+	(child cgroup or cgroups are requiring more protected memory
+	than parent will allow), then each child cgroup will get
+	the part of parent's protection proportional to its
+	actual memory usage below memory.min.
+
+	Putting more memory than generally available under this
+	protection is discouraged and may lead to constant OOMs.
+
   memory.low
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
@@ -1013,9 +1033,9 @@ PAGE_SIZE multiple when read back.
 
 	Effective low boundary is limited by memory.low values of
 	all ancestor cgroups. If there is memory.low overcommitment
-	(child cgroup or cgroups are requiring more protected memory,
+	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
-	the part of parent's protection proportional to the its
+	the part of parent's protection proportional to its
 	actual memory usage below memory.low.
 
 	Putting more memory than generally available under this
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a2dfb1872dca..3b65d092614f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -59,6 +59,12 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
+enum mem_cgroup_protection {
+	MEMCG_PROT_NONE,
+	MEMCG_PROT_LOW,
+	MEMCG_PROT_MIN,
+};
+
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
 	int priority;
@@ -297,7 +303,8 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
-bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg);
+enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
+						struct mem_cgroup *memcg);
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
@@ -756,10 +763,10 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
 {
 }
 
-static inline bool mem_cgroup_low(struct mem_cgroup *root,
-				  struct mem_cgroup *memcg)
+static inline enum mem_cgroup_protection mem_cgroup_protected(
+	struct mem_cgroup *root, struct mem_cgroup *memcg)
 {
-	return false;
+	return MEMCG_PROT_NONE;
 }
 
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 7902a727d3b6..bab7e57f659b 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -8,10 +8,16 @@
 
 struct page_counter {
 	atomic_long_t usage;
-	unsigned long max;
+	unsigned long min;
 	unsigned long low;
+	unsigned long max;
 	struct page_counter *parent;
 
+	/* effective memory.min and memory.min usage tracking */
+	unsigned long emin;
+	atomic_long_t min_usage;
+	atomic_long_t children_min_usage;
+
 	/* effective memory.low and memory.low usage tracking */
 	unsigned long elow;
 	atomic_long_t low_usage;
@@ -47,8 +53,9 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     unsigned long nr_pages,
 			     struct page_counter **fail);
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
-int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index db89468c231c..d298b06a7fad 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4503,6 +4503,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	}
 	spin_unlock(&memcg->event_list_lock);
 
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
@@ -4557,6 +4558,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
@@ -5294,6 +5296,36 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
+static int memory_min_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+	unsigned long min = READ_ONCE(memcg->memory.min);
+
+	if (min == PAGE_COUNTER_MAX)
+		seq_puts(m, "max\n");
+	else
+		seq_printf(m, "%llu\n", (u64)min * PAGE_SIZE);
+
+	return 0;
+}
+
+static ssize_t memory_min_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long min;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &min);
+	if (err)
+		return err;
+
+	page_counter_set_min(&memcg->memory, min);
+
+	return nbytes;
+}
+
 static int memory_low_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
@@ -5561,6 +5593,12 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_min_show,
+		.write = memory_min_write,
+	},
 	{
 		.name = "low",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -5616,19 +5654,24 @@ struct cgroup_subsys memory_cgrp_subsys = {
 };
 
 /**
- * mem_cgroup_low - check if memory consumption is in the normal range
+ * mem_cgroup_protected - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
  *
- * Returns %true if memory consumption of @memcg is in the normal range.
+ * Returns one of the following:
+ *   MEMCG_PROT_NONE: cgroup memory is not protected
+ *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
+ *     an unprotected supply of reclaimable memory from other cgroups.
+ *   MEMCG_PROT_MIN: cgroup memory is protected
  *
- * @root is exclusive; it is never low when looked at directly
+ * @root is exclusive; it is never protected when looked at directly
  *
- * To provide a proper hierarchical behavior, effective memory.low value
- * is used.
+ * To provide a proper hierarchical behavior, effective memory.min/low values
+ * are used. Below is the description of how effective memory.low is calculated.
+ * Effective memory.min values is calculated in the same way.
  *
  * Effective memory.low is always equal or less than the original memory.low.
  * If there is no memory.low overcommittment (which is always true for
@@ -5673,51 +5716,78 @@ struct cgroup_subsys memory_cgrp_subsys = {
  *     E/memory.current = 0
  *
  * These calculations require constant tracking of the actual low usages
- * (see propagate_low_usage()), as well as recursive calculation of
- * effective memory.low values. But as we do call mem_cgroup_low()
+ * (see propagate_protected_usage()), as well as recursive calculation of
+ * effective memory.low values. But as we do call mem_cgroup_protected()
  * path for each memory cgroup top-down from the reclaim,
  * it's possible to optimize this part, and save calculated elow
  * for next usage. This part is intentionally racy, but it's ok,
  * as memory.low is a best-effort mechanism.
  */
-bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
+enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
+						struct mem_cgroup *memcg)
 {
-	unsigned long usage, low_usage, siblings_low_usage;
-	unsigned long elow, parent_elow;
 	struct mem_cgroup *parent;
+	unsigned long emin, parent_emin;
+	unsigned long elow, parent_elow;
+	unsigned long usage;
 
 	if (mem_cgroup_disabled())
-		return false;
+		return MEMCG_PROT_NONE;
 
 	if (!root)
 		root = root_mem_cgroup;
 	if (memcg == root)
-		return false;
+		return MEMCG_PROT_NONE;
 
-	elow = memcg->memory.low;
 	usage = page_counter_read(&memcg->memory);
-	parent = parent_mem_cgroup(memcg);
+	if (!usage)
+		return MEMCG_PROT_NONE;
+
+	emin = memcg->memory.min;
+	elow = memcg->memory.low;
 
+	parent = parent_mem_cgroup(memcg);
 	if (parent == root)
 		goto exit;
 
+	parent_emin = READ_ONCE(parent->memory.emin);
+	emin = min(emin, parent_emin);
+	if (emin && parent_emin) {
+		unsigned long min_usage, siblings_min_usage;
+
+		min_usage = min(usage, memcg->memory.min);
+		siblings_min_usage = atomic_long_read(
+			&parent->memory.children_min_usage);
+
+		if (min_usage && siblings_min_usage)
+			emin = min(emin, parent_emin * min_usage /
+				   siblings_min_usage);
+	}
+
 	parent_elow = READ_ONCE(parent->memory.elow);
 	elow = min(elow, parent_elow);
+	if (elow && parent_elow) {
+		unsigned long low_usage, siblings_low_usage;
 
-	if (!elow || !parent_elow)
-		goto exit;
+		low_usage = min(usage, memcg->memory.low);
+		siblings_low_usage = atomic_long_read(
+			&parent->memory.children_low_usage);
 
-	low_usage = min(usage, memcg->memory.low);
-	siblings_low_usage = atomic_long_read(
-		&parent->memory.children_low_usage);
-
-	if (!low_usage || !siblings_low_usage)
-		goto exit;
+		if (low_usage && siblings_low_usage)
+			elow = min(elow, parent_elow * low_usage /
+				   siblings_low_usage);
+	}
 
-	elow = min(elow, parent_elow * low_usage / siblings_low_usage);
 exit:
+	memcg->memory.emin = emin;
 	memcg->memory.elow = elow;
-	return usage && usage <= elow;
+
+	if (usage <= emin)
+		return MEMCG_PROT_MIN;
+	else if (usage <= elow)
+		return MEMCG_PROT_LOW;
+	else
+		return MEMCG_PROT_NONE;
 }
 
 /**
diff --git a/mm/page_counter.c b/mm/page_counter.c
index a5ff4cbc355a..de31470655f6 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -13,26 +13,38 @@
 #include <linux/bug.h>
 #include <asm/page.h>
 
-static void propagate_low_usage(struct page_counter *c, unsigned long usage)
+static void propagate_protected_usage(struct page_counter *c,
+				      unsigned long usage)
 {
-	unsigned long low_usage, old;
+	unsigned long protected, old_protected;
 	long delta;
 
 	if (!c->parent)
 		return;
 
-	if (!c->low && !atomic_long_read(&c->low_usage))
-		return;
+	if (c->min || atomic_long_read(&c->min_usage)) {
+		if (usage <= c->min)
+			protected = usage;
+		else
+			protected = 0;
+
+		old_protected = atomic_long_xchg(&c->min_usage, protected);
+		delta = protected - old_protected;
+		if (delta)
+			atomic_long_add(delta, &c->parent->children_min_usage);
+	}
 
-	if (usage <= c->low)
-		low_usage = usage;
-	else
-		low_usage = 0;
+	if (c->low || atomic_long_read(&c->low_usage)) {
+		if (usage <= c->low)
+			protected = usage;
+		else
+			protected = 0;
 
-	old = atomic_long_xchg(&c->low_usage, low_usage);
-	delta = low_usage - old;
-	if (delta)
-		atomic_long_add(delta, &c->parent->children_low_usage);
+		old_protected = atomic_long_xchg(&c->low_usage, protected);
+		delta = protected - old_protected;
+		if (delta)
+			atomic_long_add(delta, &c->parent->children_low_usage);
+	}
 }
 
 /**
@@ -45,7 +57,7 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 	long new;
 
 	new = atomic_long_sub_return(nr_pages, &counter->usage);
-	propagate_low_usage(counter, new);
+	propagate_protected_usage(counter, new);
 	/* More uncharges than charges? */
 	WARN_ON_ONCE(new < 0);
 }
@@ -65,7 +77,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		long new;
 
 		new = atomic_long_add_return(nr_pages, &c->usage);
-		propagate_low_usage(counter, new);
+		propagate_protected_usage(counter, new);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -109,7 +121,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 		new = atomic_long_add_return(nr_pages, &c->usage);
 		if (new > c->max) {
 			atomic_long_sub(nr_pages, &c->usage);
-			propagate_low_usage(counter, new);
+			propagate_protected_usage(counter, new);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt.
@@ -118,7 +130,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			*fail = c;
 			goto failed;
 		}
-		propagate_low_usage(counter, new);
+		propagate_protected_usage(counter, new);
 		/*
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
@@ -190,6 +202,23 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 	}
 }
 
+/**
+ * page_counter_set_min - set the amount of protected memory
+ * @counter: counter
+ * @nr_pages: value to set
+ *
+ * The caller must serialize invocations on the same counter.
+ */
+void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
+{
+	struct page_counter *c;
+
+	counter->min = nr_pages;
+
+	for (c = counter; c; c = c->parent)
+		propagate_protected_usage(c, atomic_long_read(&c->usage));
+}
+
 /**
  * page_counter_set_low - set the amount of protected memory
  * @counter: counter
@@ -204,7 +233,7 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
 	counter->low = nr_pages;
 
 	for (c = counter; c; c = c->parent)
-		propagate_low_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage));
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 10c8a38c5eef..50055d72f294 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2544,12 +2544,28 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			unsigned long reclaimed;
 			unsigned long scanned;
 
-			if (mem_cgroup_low(root, memcg)) {
+			switch (mem_cgroup_protected(root, memcg)) {
+			case MEMCG_PROT_MIN:
+				/*
+				 * Hard protection.
+				 * If there is no reclaimable memory, OOM.
+				 */
+				continue;
+			case MEMCG_PROT_LOW:
+				/*
+				 * Soft protection.
+				 * Respect the protection only as long as
+				 * there is an unprotected supply
+				 * of reclaimable memory from other cgroups.
+				 */
 				if (!sc->memcg_low_reclaim) {
 					sc->memcg_low_skipped = 1;
 					continue;
 				}
 				memcg_memory_event(memcg, MEMCG_LOW);
+				break;
+			case MEMCG_PROT_NONE:
+				break;
 			}
 
 			reclaimed = sc->nr_reclaimed;
-- 
2.14.3

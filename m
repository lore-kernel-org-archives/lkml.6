Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754999AbeEHMrZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:47:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751705AbeEHMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:47:22 -0400
From: Roman Gushchin <guro@fb.com>
To: <kernel-team@fb.com>
CC: Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v2] mm: fix oom_kill event handling
Date: Tue, 8 May 2018 13:46:37 +0100
Message-ID: <20180508124637.29984-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:60b4]
X-ClientProxiedBy: HE1PR05CA0165.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::13) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:Lxgkrz450Vxjzj41Ihn13RCZDFSBtPWO+stP3xVgsyEO92X4Ls5kD0xkIBQYnWf0tMSOtXYZRI2KBWG14UHOuyoR36OvB2+gkXZMDYdFct5H0ZAKPKoA7wrt1ixKA1W9KaSScdgvURnnq5MlewJu2R/imJvLiiYTufUqjn/67grd+iNw7EUanfa3LiHNwQIX/R5pwwl3mnYm5O1FTQfYsAdEfUYNzkAhUcRE3XK0glLUBWU2JPsTuvEm+rerGDkJ;25:hYV6Rcv+MzVW2JYMTXHsJoTixas1gWxfseQZvW7JQvRAUQvR5qRVHV+QlSaVIGsIRLxzR2sr2UhLAwsC22aHMeYapP2eKqewx/IwWJdI5HPdOIChB2f+g10B1Cj+5tFsUGo8do3LQO8L6spPE8oBKn3EoV+KdV2+cySAkQeMaDGvNVuWkQCUPziIQlev4vbma2BaNiIp1u43BU3zWRo6svsDT+Ef+o307U1YTWJzELxO3L2NpPogQsz4mIICE8AZisKxi6UsM3PpQxLvU0C+w+lu2wD4iK0XP6mt/Au+CgWliDdECb9B3a2RIEjAjQW53+vhX73JUDlIj74dhvRRhg==;31:k5l/6/IE9ME62OP2XUzIE1/T6LRBQnGd8EfeQBBsbMbmbjZMlu/bmneNn5UVugxSkdeS3wJYL+QOaG37QEtBW79LsCZtCVbR50y23PXFLhfqUEmh9P9xxiTGqgwI+/qZJgfVpi4dPHJ1ksnrvglWCqpSy+NfSw+NV+uRIhiYlxcE9SzMkA91l716he3zBVO7ytOkySAVSANuA03I5yUOy00KR4qxVp1FTL5y9x9BM8A=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:zT50rM2wyaKVCVSTNl0HPpG9EuwxRhmsCwmSiTA9l/IJ80qcaUU/R/8CA5xVU8Op7azh2kdvsl2fuQyZ445lyRu9is/vLlthH4pxet8zZPk4mW32T7OgtP1Wpq1GNrWp0KLoULv8moF3kjltxwTQQgQKHRfIdYm8l9v+6UBadgzscIeRNyWfo4DHsQZ/PimRFifNb7Se0xVOofLRwidle0ORrFvSEaEzaC3AXTDeTtZQAzckeVr2hKbnTuqq/R+jCthAtu9uAbLZtitHnFhxsiU0C3ilvxor9EpucDaM7oNaz9bEYZrSrRtqEh0+mmnZuOEqxXY/GAPhC5H7N3WUiOGlDYSpoOUPG9VISzPs4IsjqT9vNNhkZhu0qmJrBJWOo2YrA4QTYKblGMj1KiCRf4g4ohPvhtANHvWrYTp8W2NUgKiw8DPI1DwBf15h7qpb7TrV/oLUWDkkEreOM9ilEiWH9eaYSI4d6mj4taIMcRIcCgriPWzFXLAaeaNUses3;4:rVfsMIj+x4ncnqO8eBf9f+zeJIpSkzaoGvn0Vh7FQCSa2BmklJAB3vWWhqsAkZQtTV2NLraQzMVaOBGCwFcY7aovslqiW4WZDKeJ14Zb8gjQcuvmHqrsbUXxatSmFdBc+QckPnzTiYg5f2t/KrDj87dQHP1AD2V98DLF0CfQFzp81MNK+Yu5K7J4mrr5GgXeTZ+Sov5aKylqCoM0BcK3/vTTe0K1IWHItMVCKFWAWCreGsiuI8ouAweWXltGhkgEM3AI+NAIcoPvS75OM/35s4bO+LmoejDD2oRbvePg6wMb5aU4RFgEiB9pfssNyGlGviYZ6v6D8x1zIsiWMm5baJzkJ3BFZKKZ43zdxQyd+H4SILxDKobtK7+/frnwyZ34
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077E47663A5E55FAE8F5FD3BE9A0@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(396003)(39380400002)(199004)(189003)(2906002)(1076002)(6666003)(386003)(59450400001)(86362001)(6506007)(7736002)(54906003)(37006003)(52116002)(69596002)(51416003)(50226002)(53416004)(316002)(52396003)(305945005)(5660300001)(8676002)(106356001)(8936002)(16586007)(81156014)(81166006)(105586002)(53936002)(6116002)(50466002)(486006)(25786009)(6636002)(478600001)(48376002)(6486002)(36756003)(16526019)(47776003)(6512007)(97736004)(46003)(2361001)(4477795004)(39060400002)(2616005)(2351001)(476003)(34206002)(4326008)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:FX19wmVYqe+9sB8f6e7SJJtJ9OTCBi05ah2RribNt?=
 =?us-ascii?Q?tLicfY59JQeTszc9pCRXA0rNjcx9dMVo9X4vYqOQO9mqOYzRoToK47k1lpiZ?=
 =?us-ascii?Q?R7nYE54Hktdhg4t7q8G8yLeXTsZBOiHlNKKWKp4SIhk7virATzHH9yoBL/x5?=
 =?us-ascii?Q?yie2/BWUcXCbGsTdZFxweIOslQM6YZwCIFNbShCo3mWkHoXQWR2J/Wiqszh9?=
 =?us-ascii?Q?HNT0rVFZTm9srwU1NZ0INiO5r9ukIhWv0O3E7nONUR0bQ2nJi1bbEQISF1in?=
 =?us-ascii?Q?H0bF03nRK+LnKphjvE8WtWbxT2A37TogEDJb5tYtAkBbsx2nm7X+H53evwNh?=
 =?us-ascii?Q?8X22iG2J4I+oWz28BDA8sggmLY19CSRv5Mim4eBfyUEmoCs7Iree7ikkd5ku?=
 =?us-ascii?Q?BPODuBki/o8+Vxcd4pxNwNZYwtNgq2pRr5OfutJ7JIC2TPSwWkh2kJ1BIOcc?=
 =?us-ascii?Q?BPQdZs3uZvbBKLhG0SRDLIzBWXEwTZYFliJonG4Z6D6EninpipL23reqE/qt?=
 =?us-ascii?Q?t1jau8uWJ26WGld0HU3sTlnYQgPijzQpLvj9ZM0vD9SeMF/wKqf+jLSaP001?=
 =?us-ascii?Q?QbSMTSfanB453NDJuqBure4MZp8CU/sIeXHzb4b3vxvy2oX1/1MWy7bYuwEl?=
 =?us-ascii?Q?y9H1YOljsyLX6oAqapUruTdu3l5dkeEfyCVaTtlvPu+dhwSUc06Q61fix3/E?=
 =?us-ascii?Q?QYdj0D2VRzxo8sYnwR40VsRJLYJ+wEaszgkxwakFutu6/fZz5ANt7H/wuaei?=
 =?us-ascii?Q?Z3zvT3nwA3ps3OZ0rQ+Va09RblPr0pEHUekEMKbOyHOIC8DpvFh+Jk9htYMN?=
 =?us-ascii?Q?AR7CLyVw9PCPsHet8Pgt7hgJiG8/dDxqebUJ/ehtp8ubqi6JXHzEIZjA4h60?=
 =?us-ascii?Q?oonegX57CADxIdhzl2VW7F8AGukLxX1L3XTA+dAYBxspA0PiZsNizqrS+ZGo?=
 =?us-ascii?Q?6SZgf8LeUfYTCLoxE3viIMO8LwoqYBHOym/dkd4KeVIjItl929jeafOvFmrr?=
 =?us-ascii?Q?fKcFoLVajupnGohX+VQVCX4PcG7sI07lZKEb3t2KXaM9cNHdNbOwAneXcgF7?=
 =?us-ascii?Q?sTdW/wbjw2vS4dYab0VvQ00u5TmMprzlZc1xQWawXvrvlneSeceNgVidHrt+?=
 =?us-ascii?Q?mZti6EtstklpGyZuy8tvETgA0+H8crr90cOjcDsFPqZrqZiQO2VJLfMf9+qg?=
 =?us-ascii?Q?NpWKnVtOysvasnJVv52wOEgWp/krIHlMujkX3HOnbdoBm2Ks7EnNXnb7CIP9?=
 =?us-ascii?Q?H6UCiD8EaN+oiTH8q424CBjoC9jq744okrTzTa7FHrdP6r1BazedonDRaz93?=
 =?us-ascii?Q?L84eXgGegfCULrFm9b1hsTwktRRxsfo8tYJLibm8k0M?=
X-Microsoft-Antispam-Message-Info: GsWCGpptu1cjvtioJ/mFrRUBbc8HTyWTw78+6vLpBNlYmrk/4oeOFYkvzqTUtWwjDXWp3PAuOALAUKHAGHyyTKPHnHQmknY/R2ZNLsDhDCFNJ6ZZqnPI1yqDHj6+y4wb3aA48Q5Sj+8xrOHX2851iCiy1Yc3A0M8trExV6RJOlnp9Ea1PWPA0Nm0InJzJu7m
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:XkMprzeK/9WRPAULeKLcsoz/ZHFGExrNGdv2WoHYiBNaDthAMRUcHfsFFbX2oOXZduZO08/qBvm/IoEdNGYsELR6MTR3caZklzmjFeqhKuYy39DlXYChgSGs0a8hMAXz1+hPQnbKIX+X1+xC1uu71URfWLQpJE8JWlMj98023IoM4Cz9iMXPKkjerzK0Pmh3fms2TzFvMPu8VMlokKdDzhBUukAql/uttUnyPsztseDDFlUc8+BLP8jFDzrsvdToZYvbXJ9O6c0s3jsuvn5o4UI09qs0x5Iulu7ai/pslaZK+TTiIhdv5WQLajLi1p2ebdKSCGdFcsgTzdlgGgK7xn5hOY06g6xGfaDa3IIfcunxbPtLhTVZWBwDMLWpQFDWljsgRe1T6DKXEStM7gF6NCeCN+/BPmyTyqD79ktWr4z+Ti8mnxNj7CK3OEKmc+hseBz65RXFSDQAMtFB4ePnlw==;5:i2D0bo7FFTUyg2iLO43ROfEtW5dqHzO5ejNFFedNv+43zJCP0j/+Ze+7doQ8fAYtcfnE13lcK62uqCApF70cQ1I0pd7NoN+cV809iEt5T3Y0T657j+qny1rxg2NtxQGcqfCCrYn21qVb5/TqCK/RmddhI2eiuUclE5A/IjhZaig=;24:3CCb+B8b0/9HF/MlfQCUlM8lJr1FFYhi0oxWRT4ncQsRTqNhLPxviHQ96VV/pba7bTDZg3KR0KA44B5DDL9qOPGCPXzP4IjWCmS5UEsn3ew=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:wcuW3qth9J006kT3JWAD86RlIMn5qoDAWZytEOb3qKUi7gfPYI5Z8UlUg0/eRcnNS37wWbSVPIIbaMpqMKcxYRA1djQQjT4kzUK3Hx8HKoxmtp0ZyDeQDC7tFugFZuIUwwbeSKIGbMq8RRJPnESE6D5iYc++lJeq29ToGeusme3GqfJfVbjCwnX4endY2/plLLuf8TZe35pjGZKPZOm3SuzIl3dirXECDpzIclv0fADFo3Z5J4G1epoAnc7OsKY8;20:GKra5nDlki4Jgs654QV+eboe1NDO/KzrwzZSmxzWBEUeSfSlFi1TrkwGrzXFv54STbU92XTe0/bu54UyZQGNBy+q+MHqz5eE/GfpZGYY/Sn1PksgC1A9mHeIplY5YbUmDnF4SuJwAToMbQKocM+e/zf5CEkEx8uFzZ5QVXoXl8w=
X-MS-Office365-Filtering-Correlation-Id: 5bf5f519-4e66-4381-2048-08d5b4e1ccf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 12:47:01.4846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf5f519-4e66-4381-2048-08d5b4e1ccf0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e27be240df53 ("mm: memcg: make sure memory.events is
uptodate when waking pollers") converted most of memcg event
counters to per-memcg atomics, which made them less confusing
for a user. The "oom_kill" counter remained untouched, so now
it behaves differently than other counters (including "oom").
This adds nothing but confusion.

Let's fix this by adding the MEMCG_OOM_KILL event, and follow
the MEMCG_OOM approach. This also removes a hack from
count_memcg_event_mm(), introduced earlier specially for the
OOM_KILL counter.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/memcontrol.h | 26 ++++++++++++++++++++++----
 mm/memcontrol.c            |  6 ++++--
 mm/oom_kill.c              |  2 +-
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6cbea2f25a87..794475db7368 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -54,6 +54,7 @@ enum memcg_memory_event {
 	MEMCG_HIGH,
 	MEMCG_MAX,
 	MEMCG_OOM,
+	MEMCG_OOM_KILL,
 	MEMCG_SWAP_MAX,
 	MEMCG_SWAP_FAIL,
 	MEMCG_NR_MEMORY_EVENTS,
@@ -721,11 +722,8 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 
 	rcu_read_lock();
 	memcg = rcu_dereference(mm->memcg);
-	if (likely(memcg)) {
+	if (likely(memcg))
 		count_memcg_events(memcg, idx, 1);
-		if (idx == OOM_KILL)
-			cgroup_file_notify(&memcg->events_file);
-	}
 	rcu_read_unlock();
 }
 
@@ -736,6 +734,21 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
 	cgroup_file_notify(&memcg->events_file);
 }
 
+static inline void memcg_memory_event_mm(struct mm_struct *mm,
+					 enum memcg_memory_event event)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	rcu_read_lock();
+	memcg = rcu_dereference(mm->memcg);
+	if (likely(memcg))
+		memcg_memory_event(memcg, event);
+	rcu_read_unlock();
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void mem_cgroup_split_huge_fixup(struct page *head);
 #endif
@@ -757,6 +770,11 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
 {
 }
 
+static inline void memcg_memory_event_mm(struct mm_struct *mm,
+					 enum memcg_memory_event event)
+{
+}
+
 static inline bool mem_cgroup_low(struct mem_cgroup *root,
 				  struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 10973671e562..38717630305d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3772,7 +3772,8 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 
 	seq_printf(sf, "oom_kill_disable %d\n", memcg->oom_kill_disable);
 	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
-	seq_printf(sf, "oom_kill %lu\n", memcg_sum_events(memcg, OOM_KILL));
+	seq_printf(sf, "oom_kill %lu\n",
+		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
 	return 0;
 }
 
@@ -5529,7 +5530,8 @@ static int memory_events_show(struct seq_file *m, void *v)
 		   atomic_long_read(&memcg->memory_events[MEMCG_MAX]));
 	seq_printf(m, "oom %lu\n",
 		   atomic_long_read(&memcg->memory_events[MEMCG_OOM]));
-	seq_printf(m, "oom_kill %lu\n", memcg_sum_events(memcg, OOM_KILL));
+	seq_printf(m, "oom_kill %lu\n",
+		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
 
 	return 0;
 }
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8f7d8dd99e5d..6b74142a1259 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -868,7 +868,7 @@ static void __oom_kill_process(struct task_struct *victim)
 
 	/* Raise event before sending signal: task reaper must see this */
 	count_vm_event(OOM_KILL);
-	count_memcg_event_mm(mm, OOM_KILL);
+	memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
 
 	/*
 	 * We should send SIGKILL before granting access to memory reserves
-- 
2.14.3

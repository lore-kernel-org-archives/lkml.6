Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754782AbeEHMF6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:05:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54608 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751747AbeEHMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:05:54 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [PATCH] mm: fix oom_kill event handling
Date: Tue, 8 May 2018 13:04:02 +0100
Message-ID: <20180508120402.3159-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:bddb]
X-ClientProxiedBy: HE1PR0901CA0048.eurprd09.prod.outlook.com
 (2603:10a6:3:45::16) To SN2PR15MB1088.namprd15.prod.outlook.com
 (2603:10b6:804:22::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1088;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;3:edgO7TeFcLj1OBBKBwJqL0r75qog/8MSVDS/DQAH1n4CCRGkOlGl6ev7M7XuHNrm5Aw/6jWhdaqBJZD/YTtyPHvuFkHTIui4ZdNa2VfVmjBZG628TPmQfFLZI6egmoxrPox1YISsNFSeGhbSctfqioSEwPV7NOLUo6lEeZQLTOoBpx2z+3GSq7UCgK6F6Ko9sjlGzvGkbHbzTa4tbb9YVK+bNMgK0zgsBua1nvWj95QlP7Il6PkljLQfgeCOddMd;25:RJ9swcjzVz1o14I2+3bevx+PpjXKbU9ZpsrTDXhRBX5Yq5bHTOzjImFZ+bGSg3RrTe7fm/1IUnDrDARH6CDnCQ98C3SDS5GJ5xjJTL8o/NJXTAfhWqpOmhEClBBlnGTy5y258/K/8ZbrEFzWwMU7mXVzXahHAJbfsS9g4MHT1gFyg3qHhJfkRF09bUjZfBNhKmtJ/I5HfcbIH/TSIVod4Li22ov7//LmFYQpPFXpFbxQaqZyZ3oVYNOYXqA0h+fMP3cOTHEW5ms20L0k1jJfo5LIGegfcxfpNpcKuz7MjKqQ/zp2O5PH1Ndks961uXdQH17gKvjfKdw389JCvr+Pfw==;31:nVspd0FEMk5r1SnzLdTqKqSbBd4grqt/AN0cPYr39ti46xpU5C353pMZH4k2VLyETPniK+2SrsRLy55oYnCofM57VwYST3/9in8T4RFrfrbANGhPlVnzLnk2lVIwaE6UsV8Llc+QOlIwp9hxJ5LbeBabIA12cWYAXkseKBh/hutoYz8d2tkR/kQdjzZHRbqjwSLMgM0DW3ueDCb/deVRIIfKEGy/RLSDmncZ3/TJPcE=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1088:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:IFHGN6YaJae5BgIg2djp1jZjzgG45eNrS5H0+HZkF5rvSef41aw/tNep8XXRg2xezqshLZXcKy9zw3+3baD4kj+/6s0R4RyKWoHWnoENShJjXoDwzcjEzzQ4uAR2gzU7UdHSQA1PiQq+qftDeqIe02x4aj0dKkAvdYlgeGFB2vJrtxqhcnfUe5zrmBXFhBk+tVvaO6Uqorc5MYv9IWviNkZSrJ6DQaFmRrM6hRiN5yURQXPTwa6l8Pajt2qeOiEZhRzPxgHTtNJX/6hBupViwXDo7A8MdX7nRSNtMybo5P+rBQt+U2Zj4kSp+Aj1fo4YJ8mBtBhj2Wt2cjUWEayeHex6uaSsBxin1BWrpyk3SEbZ0uGz/9vLxIbrJIxgE6e6M6s83Alw9Uu9JIm/2UqpmhOlQD4OLl71PsGVx/qE+Zkd0Obq/moOWgtta9RUJfrgIPV8+OvmaLMbWhnv/FypcUGZxnpyqjT+EXdQGdohvTfsrGikKOqM7/JNSRcTURTO;4:ZMIYtcoCdrLydxTQpDVYlv25l5bObYTYqV1VMm/GVwTxd/6tMDGdvcAExsQbmLooLppoy5LaFDg0Zj04FLq5EwPTnB04nPDwv30iaA3F0NMbO8GfRRVgCAnI3uPKRKBN5s2XZqkMbEGXNwTymVg2Pc1FHyosc5roCmscxfyiK+SRku2H1mQy4+nb7rERfOuqIcxN8dSRQ9dFmZ/67LUQMKaHSSRVeAC3BwiuRZCcC9vzVqngSW24uVhAl6M4bexLPJEyhMokSodiuzgxyZj7Zc+Fil/lHB916xF1wClzXPqhH18y1TCHvaVciLPSAL+xqvpNK9r2Bqvz2hf6UQ7fmOLQW0qWcfIGYWCOKHklA2v4uHV5d+zzhe4IEyf//VnT
X-Microsoft-Antispam-PRVS: <SN2PR15MB108825F9B84356D40AC4A2CEBE9A0@SN2PR15MB1088.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN2PR15MB1088;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1088;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(346002)(376002)(189003)(199004)(69596002)(81166006)(186003)(81156014)(48376002)(1857600001)(4326008)(46003)(52396003)(2361001)(316002)(6486002)(1076002)(50466002)(8676002)(6666003)(8936002)(54906003)(305945005)(47776003)(6916009)(16586007)(2351001)(6116002)(25786009)(68736007)(50226002)(2906002)(478600001)(59450400001)(53936002)(36756003)(105586002)(86362001)(5660300001)(6512007)(39060400002)(4477795004)(486006)(52116002)(476003)(106356001)(51416003)(7736002)(6506007)(386003)(53416004)(2616005)(97736004)(16526019)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1088;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1088;23:iWoLvcRYdTyRJWedMIOGse346TJBToVHog56sKl36?=
 =?us-ascii?Q?IYYLOn+xcCDwID4d0eake0J+7qbCvdRfXLiN8tI/Vj/mpbThJti/7nz+8ak5?=
 =?us-ascii?Q?NonPK64ywejG7yMpklNERZbhaTF2lS5557OeftzbtwJHv8MxG8EY09eKe2Rz?=
 =?us-ascii?Q?Qe+C7Gw3F++FAymlBkv4paiVP0hTEwf4loODL/VSYb8J+L+m7fHHeEb2uALn?=
 =?us-ascii?Q?H/LJ00W/E9nLsSQQb0b9UbramWd92OJUvkY5fQ2zAJLDq9KrvlB0Ux9BB8q2?=
 =?us-ascii?Q?SNnM2I0f+Xh0IzQ7s19K7XAEz28HFgwvhblcHgyG7vjjG+rBc9v0wOU+5Vx2?=
 =?us-ascii?Q?1W8OfzuqL/2zI07UlqlyAlGvGFh0RUDz3aVRyHbu4ynxvyTEEuyJZR5k+EIh?=
 =?us-ascii?Q?mI5CTzLDhjkdssUvrusMQeKENb4lJAHsp7FtHGCrVRwDcMeUEBqmsZ9p/fN7?=
 =?us-ascii?Q?U2BIW/Lv0+AeYjMaekUHqf7/UVPka9ddHVyQkVAChVEGfPprrxgtUO9aFdWG?=
 =?us-ascii?Q?exDfaDGADv0SMVlY/n2hTlNd27Fk/2wzEaNrkKKxwCqZ7GwJze4nqN8D9LSd?=
 =?us-ascii?Q?j5BAdGIJRmr/4t7sC39EfjixtAOghxhBgdNlTJdOhv0PS0D+OGYO9MXJ2DAR?=
 =?us-ascii?Q?EmetKKALpSWTVCLoQNcWVyek1fDxxFsxwmNMajP64Viexu4P7TS+hiJ7JcsJ?=
 =?us-ascii?Q?mXO8xsyAyobcLjnAxGNpcJ0VX0BsTh5S9n2s5MkuWg6Sr9AKt+2AhO0K2TX8?=
 =?us-ascii?Q?vFNwIlSwNxPaiDmY20q1xDRcbw8F5VFgrBUjxMYzXm3XZHUlk/LQ02BMr0JG?=
 =?us-ascii?Q?4BUXN22OCoQaCtDIhDhe5kANn0XQznpCeDECoxrXp2oqqGx5+GCEkrQPzdlL?=
 =?us-ascii?Q?qz5/TbxMFnTR+rkTZwmRKZ4o4ZktphaxpRF7bAVcpVpjfpra8J/lUVM1lPjr?=
 =?us-ascii?Q?i4eoHiRiAav6i6Fcv4yEFyU5wNwmqx7dkHF2c6hhPQvwGHQ6TiReM0gIfGYB?=
 =?us-ascii?Q?KIHgQwJAdweNpHC2RfP+wlznwurE9ojgzrcvEHzyxwfd4VTGlD3zB3nuObw7?=
 =?us-ascii?Q?Xpi59lmEI+eifK3oNIVQGwMSo2reGjZY59iKet9IjQlHZ8XIOJhIDlsCnI1k?=
 =?us-ascii?Q?VN23idyY+0BGduaij11/Q+6Xl+TrPWmHkqQgc965vOEYDq2vaMh+H6K90Iug?=
 =?us-ascii?Q?6j3f1PX8dwsA/mJsAYTm+X7G5r/dr14oSSRkDcrpv5TazJhtKweLDJjeR45U?=
 =?us-ascii?Q?KC+/27NQa8GB+axuTv+Kqt8Q3XO9xmJXu6lYx3+t1CFj4AMzTxCv0fTQnpXV?=
 =?us-ascii?Q?i0n2097K108FzSosuNozoQRmBvC7kiST//ceYM45HZi?=
X-Microsoft-Antispam-Message-Info: uF5fzC2hYTu8bj26KXq8lsDK32v/lClN5FNxWbAKce7iQy5vr+lVR63uFZimuFHpgU/PsfsSG9wVcCFNSMn6ZSot8cHONFDvNUZ0vPOUQT9lWKCBWEslnV4kPhb6X3FhN8X8/ev4RCszhPQCjH1OWIWSUraFj3LZ2Czbrd7/0KoNQ+t9YbYbZKJfAqHDkMaw
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;6:ELOmeffI20xZVuDE0oO9ORogd1mQey9zE/eUwC1+VMROuKRojbiC2rP6+pQUaBFZGUqGrExXFLZWHDPqlqFs9sknQmsBIAXsyDaGMu1nD+EEWoOIXCmD9CBNaB2pEH72zV36pf9mNj24PwVwB3NLttOsDCKWJwZhCedsCMZvhHmwdEZCh2e3J5uO7eGVyKWZOcXwMnFsytpCTm3Xj6MS1gS7fp8yd2hPAwZ/Zkkoi1vAk4vzbX9LjGy7W/Z5rWyFD8VExAx7k8IfKEkKzT3wGDzV4TR8er/J0aQ6cy90sgfI8yRmM2OwAgUka2P8Ikv16+ioRj9HgaSfyt3L9/Sj4xYGTdlWWCRtUP1HQSdx5qnAho+iCzP3vjt9uzVaWni2q2WVJRL1bxj1DbJdTZvZu44sI5kFwP+Wdb9a7iBmJRh+eNwiBiCZmE0020CC+8S6IMaKSHV0isIElfCiLuEkSA==;5:wyRqlu0z2hkYMU9Mc+fwe9jE7kPUuyef192qFMLlxfcMd0Cby1FgRjMp/HICHrdGCLqbSf8nyr91m0ZgZNbPmhxsyGGmMYMRifALFh0pF78hNbsJKKxdLaAUq19MsA3HDxAKlzyno0y9+YBpZnFC+x6t7p1LrW+hplloei/csBo=;24:jjHwJVBeXjwhSDpJsygmjEpolyW2IS6DEzxZbIU8jEZE7oedHHa1HzJ2LiKT/n2OZcOYvfzexFNdRDKAMqoHc6S6L4/Y6Qja49eI+TQek70=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;7:Caf3Lh1acWZ52QMkk9gbtxmF0KSw8PndVgRXwrgW3RhLnTXQ27Ms0O3hc0HrAi2Ed/LQPqme/plqYoERWw+D+cwTRnnSrISuFJ1+5QR4j/OTLm/Q0wcpbvkGfcCBji8DwIWj9ELoi3LPa4eyRX1O6oG9GmZ8PFcY2xd2CklXBK6LjJhytrdcUPRL0mO588FswwASleIK9yVI4W2g/+q9nMeYOOj4vCnuNQK8Fon/Sej2WRjPt/nyYStb7oH4DPNZ;20:m1aSACAYhTg1ZqzuQ+XfAH2OXWCPXOHQsZb+QrzITiNW+cPPmHa4IeFS1H8RUzZylwjQ5CitgN6xSX4pkJNElphZRnKhMQTRd3OOWjogDKNoKFkEBn4qzr7aLhgcSs61foS6q3qp8t7DiCaUMYHaZiuWmaHB3uU4MKPsbsl4gp0=
X-MS-Office365-Filtering-Correlation-Id: 74dac825-86ad-4333-aed8-08d5b4dbffc1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 12:05:30.2638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dac825-86ad-4333-aed8-08d5b4dbffc1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1088
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
index 6cbea2f25a87..caa8b70a85f6 100644
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
+	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
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

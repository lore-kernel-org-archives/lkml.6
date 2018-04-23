Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeDWMhI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:37:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754729AbeDWMhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:37:02 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2] mm: introduce memory.min
Date: Mon, 23 Apr 2018 13:36:10 +0100
Message-ID: <20180423123610.27988-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:b3a9]
X-ClientProxiedBy: DB6PR0301CA0007.eurprd03.prod.outlook.com
 (2603:10a6:4:3e::17) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:xCsoS4IfLkdmP+SSOvd8czaLZOvdglHCKVkTp5TG9bAgKe0PCmhAx2liUuUfK8OO/matEBcyrErkkt+NpC7ALcC78h60sGTrlYKIC8bd1aFU+J92V8uCKk5vsjX2xkYIqLn5IVfLl1Y6CFec5zHDY5zstcyAN0ydI3qZe7Gzcz7FhJyunAdLRttlJ8p3NOdENqBCdS7sj9rE70+M2J6bYCOGkUoT/YAy0HXaXxJw6zcRri8tOQ7PDXI6gDBU2RuX;25:gV6ik3HRzn3iaP91HBRJ/QzNa9so/JOel84lnqsLnL04cQKwUa7iKCJqlYcHwcS8RMwjqe+JI70Z19/zAJmBU6u0M148MdMUJKBFHgBNfKHoIAS/Mw/jADn7mPlLRGE+H5qSn7DLFIaz93c1MKjqB9tqsmg3+NbZ92o3nukohOIzy5+YcnoBJyXwWfAOVvZzGhW6OWzQDap1WwGVl1p2d2JgGZ11qSGdv+mpcripbeJ9kDshk3CkzKntx+hUyVAX00rt28GWh5SA9a16O+RYzSpk+0ZSnlObV/8TbPvSM4d86IvVpc/+nmwcyFSZF5i8/zuxV3PRO5w6nyx5fRmOMg==;31:o1ALg6rMTf+RL15BSZ8ZRVhbS+K/UeqwuaPkV2VmZ0ZUx1OGTPGmOOnVdguqFB+f9pURXRL+0CtAARuzNQKQOo2i/lJ9Bpx+DlzYWcRLK9dbZDYjuSNWu7zLqyVonYcuKhL2XPEBs6/4dDZNqxMRged2uLGqIbCGRMp3HTgeQkzbKQasbavpo3QmBCIOheJF03LeZHhkZ1Gcn1g+BwLDPhzNUx0ctjfR5HT/22S1W4Y=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:uJ0x1+AX1Gz4P1Et9ESgfbwxqs7O2AJKVsjlsAnF2wbPTghZuVilZNl0/cVGC9Utgt77W+AR6pRQBhPti85IEtaQvYB84WYnt0oson9WCWEDII2G17Da5TGLqWELQQ585gLvRMsF6SeuYLRVj6Ji0eTIaqrsBaFWfXUqcmSO0DKa885S2c1t/+suiel3LYe6iyqWQup+VIvP3nNnBGoXpmJP7O+3jW5b4NK1Lnlg+lXMpOr8PU+8PqHymMNPDagdrBbtwd/gxtqkzBF6zqKGVDCwjz4zRyIB4hpo2A2z3vuWBTIOOTbkBHGmDJuOU3MAHPjM1OJuK5ivvEXD5uiwK2PSmfQ55ILoO+Tok3tujylJOYhutABDKFwivNy735+UqnPe/Mf2wVth21VQbBunig6I9oGRfs/p+0QvBVzt9z9hyvHYW+8m9wbW8XRf/N0jESqcFnoc+Qf9LcNgb39YRuE9pUtIZ1mgpHavAn7O7f+axLizsWKdzoDD4OD3hzaj;4:w3wOQj1Oy8mzLenn6IfmvHu6LZ/mXZ+o+S3exduE+NvgJPojNFTYRg466e/yMPu+D9t/EHyBndibEpChSftFi5QJ/GjWMIaPozvtRQLva1v1W+DYDcaYaIubBjG9PQaCWPAA1QYr6DsXYR7kic5UnM2OaYkgU+3bLeI5LGb3dwGRYJo3aEeY1g14jPrxr6BwK6lfKbCw31kpWJF2L8sBdOhQX3KGH45+EluHCt199WMLC43NFlpqo9YmMqTa5LjmgtRCS39HHoLwiEbByi9BvLzgN0LMT/XYfG3KR/z8ePbW4QvGwYzCFoWHkd6onSOHJtlLv514SHljWq53lwzU9tAlBsuy/edGI0jXey1kDpo=
X-Microsoft-Antispam-PRVS: <CO1PR15MB107742A17FE3CC05BBDCD30DBE890@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(11241501184)(944501410)(52105095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(39380400002)(366004)(81166006)(2906002)(8936002)(50226002)(52116002)(59450400001)(86362001)(54906003)(6512007)(2361001)(8676002)(51416003)(2351001)(6486002)(36756003)(186003)(16526019)(25786009)(2616005)(39060400002)(16586007)(316002)(46003)(53936002)(478600001)(386003)(6506007)(52396003)(305945005)(47776003)(50466002)(48376002)(476003)(4326008)(53416004)(5660300001)(7736002)(6116002)(1076002)(6916009)(6666003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:odUGmmUhDOyY7LXVP1hoV1MAGJRg6Y87y6cfeBfIb?=
 =?us-ascii?Q?FHsag/T8ShC+UAI+JIbcYWT137oRBa1ayET/fJnE24vtY8HdZ6XeoimQtZfA?=
 =?us-ascii?Q?6BiiapFmllyvkfi2uHHMLVyxl2iF1DrP3RMJUeIBebZdctswpltbHJiqBdLk?=
 =?us-ascii?Q?eh64Kot9A5CHb4Ot6n2fJuZlAfbQ0JFNrK5tIj2bCTGSJOxbSgtiF9Kq2oMS?=
 =?us-ascii?Q?ivhqh7vHds3xIWnAvHUYxsxozyPN0NHgHIR91ytLv931+cWDqEdUqORNz6Oa?=
 =?us-ascii?Q?HoQeogfysM6Ace8tmFlE9RwPPOhFG4+lgJFZZ9SQF9tmggTvV7XnSa/jeBzT?=
 =?us-ascii?Q?88cMqIzgGxfNKM610kI6NDuikIRWkrrJ8GHABbst8un1uUEgAEmHGZHY6Tl0?=
 =?us-ascii?Q?VYxwHkMdpY65PTUS6nnzjOjXTXplxSlJfRCrdSl5vKUZGMFHSfwgbE2MQZDM?=
 =?us-ascii?Q?lBSff3arvhLuRGq41sUNDFG9yL2pIPFtbffXcgeClo89y3RlslaFu+koq+5F?=
 =?us-ascii?Q?RwcJGosT64RAP+5Z8rBxbtjylz29g5fTLU7MqlPyQrVQu0JI6dZ/6RAen5st?=
 =?us-ascii?Q?bmXihfj/1njvyIeCn5ZW49ol5eOI0zbuqfsYzx9B+IbLlMabaqVJD+cOLyoy?=
 =?us-ascii?Q?pMGEnnkZ4xGHmGuEvmQPIdE8VE7EQrZloBY9q1fZTTjCjRKU2U4c9qgXCp33?=
 =?us-ascii?Q?Lh2cA6YdEmp7GrKfQQGkkUxvYDfIsRNDBKmXeJl88yEn8mKOVvisF9SM4Erq?=
 =?us-ascii?Q?LE4FXDeF+0QTU9ISNYndrF+Kdu7M+cW5r1mz+GroiNU9G4sRLcSIjbq/0XTe?=
 =?us-ascii?Q?xSkWnVCg4TGbA3DUrTkJDY5ZA8vNeRf7l66e1g3VHv0l2lzL+0wPkhuvqwrC?=
 =?us-ascii?Q?pqEXPq8mMD9sogdi4uHm1k6vjcNqrl6Qk4TMG8vuwGA+fVvvDS2v316pgibK?=
 =?us-ascii?Q?owE9mqdca44vDA2XYPBtvoCV95aNoOjJyijz4IsSpB416dWMfSpsVnD1UC6w?=
 =?us-ascii?Q?sopayLriGhLHz5RX4SaYYz2Q+wWhsniMFtp/1SwhXWcmGm36y2ij/W96vGqi?=
 =?us-ascii?Q?8oDICEvbRgCWlSrfMegAVFbosI7rzs3qgH53KODARwxdHjrgA=3D=3D?=
X-Microsoft-Antispam-Message-Info: NJcsDspFTUUiv15KD6aN5yXaDXBh3QMNyilp8E+yotJeZ9xSoMgH6Mmv6Yxm3PeG/wC8smsM0YPuq8fmuxLKhcbp1PsSPgsIGvU3WOiTqWGKH13NxZjmo6y95T8SkUWboeQKA/xSnApsvL8n+QtMJHMikHdZ5EDck3Ugdc7pJkGBV2RmaogP9mv+2hr7facu
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:fkYuNBkjAaxd4kwScvgzH/zLJRnx8eajHAsO+xziZ+A2wuLLNZ4kBQYc5/nbZHr5GskiYo7bvhGUvCs04FgKJyyX74v3lK6tP19JKUg5W//QRyKxwlm7TuoHaNlsx28HUsJC7wPee5ZCBC4JmZbnEKb6yto/rPVds92TtaDknmLROveV2TkyEXdiDEFTANlJgL8FgRd0qAZ0turCsy4SfVxLuZubHXuprc1aYsgh7PVsGi8ben3vLWGivUXmozoDJtcblMEchNLLQLu0fnmefoaAQGEG+XGvngZ3tiNGnYoS4Mdc2K7v31t6NizcTz4EDGfez1GvdE7F4ARXiqZYpw3CWXa+TutrsTrz9IZNqIrKWHeR9fo0wxMmAczzRKpWo/Eok1BGeTJG6xvT3P3bkDSU/W1Zqqh0da/eawtbIEmuOmB7OMH+t76gz7D25yk3l93MS5o4vTZAVbQKo4JwSw==;5:Js7V9rbZjpNqtRwNjF0N1owFQ/+TxLjndSmHgc1a+wKFvLbvZxzxwa8cw7zHgSNqYsoBRaOWnTi/MoFAQMOi4+AvyL+GK1QqGM2+LysFx30LL5R9o10IgIwLebCQOymL/JFDDjKpzLoxadvJn29D7MGEIr3iiwsNvBOS9Gfetl0=;24:78RkYf034D2GTk6BGUHhtjWB4hJrJk8hIr74BGI4TFct/GHyHnhf7atiS6KKUld85C6lSRgIFd/A1GBjjx1UuFyyeCX41KcgZUpCDMsjo/E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:ZE/270C5v0feD/obDxbU/oIbwbehN0UDC0NrateHBidVwGJ4V4oBT8+Ca/lu8mrRIWvD5MjMHqfjJSYmvzYULWZu8vJuphDugWzs3WEh9qWnzLQ43YSdxWhtKOuVkFXQrfj1O7gLpJB4t771GVyZOFCLtMKYASUbKj5UwjdSgAxZNoCiHomp4rGDv+oO3asGXYcJrv8JYmiDsZwvleKZ/K6FpP3+IcGJ77/LQjcAZdcWE6lKj904YcRNFvppgBNo;20:QfqITa1S0rs2MxUFVhxDZum30kt2PJgITlirc4rk94owNREhdAPg8OgfkQCfFoPCAUWjfzvUt2BI6tu5cSfzav/W349nEiUUW2Y7wKVODa8fkuXQidGjmuHioYgW0Snk+4jFHFKSyfEa0bphZZ4XC3r0H0HltpCidFvR33Mhn+Y=
X-MS-Office365-Filtering-Correlation-Id: 0773009e-06c3-4a9b-a67c-08d5a916de72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 12:36:41.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0773009e-06c3-4a9b-a67c-08d5a916de72
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
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
index ab60ff55bdb3..6aa47086105a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -59,6 +59,12 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
+enum mem_cgroup_protection {
+	MEMCG_PROT_NONE,
+	MEMCG_PROT_LOW,
+	MEMCG_PROT_HIGH,
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
index 25b148c2d222..34b8f597f48c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4508,6 +4508,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	}
 	spin_unlock(&memcg->event_list_lock);
 
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
@@ -4562,6 +4563,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
+	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
@@ -5299,6 +5301,36 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
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
@@ -5566,6 +5598,12 @@ static struct cftype memory_files[] = {
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
@@ -5621,19 +5659,24 @@ struct cgroup_subsys memory_cgrp_subsys = {
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
+ *   MEMCG_PROT_HIGH: cgroup memory is protected
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
@@ -5678,51 +5721,78 @@ struct cgroup_subsys memory_cgrp_subsys = {
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
+		return MEMCG_PROT_HIGH;
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
index 9b697323a88c..0a42ab1ce42b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2544,12 +2544,28 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			unsigned long reclaimed;
 			unsigned long scanned;
 
-			if (mem_cgroup_low(root, memcg)) {
+			switch (mem_cgroup_protected(root, memcg)) {
+			case MEMCG_PROT_HIGH:
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

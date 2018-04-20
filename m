Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDTQhk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:37:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56044 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750972AbeDTQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:37:18 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] mm: move the high field from struct mem_cgroup to page_counter
Date: Fri, 20 Apr 2018 17:36:32 +0100
Message-ID: <20180420163632.3978-2-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420163632.3978-1-guro@fb.com>
References: <20180420163632.3978-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:b8e3]
X-ClientProxiedBy: CWLP265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::22) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:WF7lcZqD7+sY+Pkiw60SvyBNUR2t3w73g14aIZzg40CY26u1CLFDD7YAKM39FdZvOMSsHWPWr1m2t6d9B6ifUZKZSf+rkmqmAEfLEPD80QCOR1EEUHgj5a9o2WugeDYmNJJSvmLD8jE1Y0BeS1m0ZbB5/3q9MtIDTE4966JqEKSV+ffdbaRIqOm7Ngsb1lNG5cHRBfCRwhsnghjO2fDu+mU6cI6THfc0OfRZK7iLpE3Ik1SO7NxyhNb0mbEsdz1R;25:IgaK3eI7AHCtWAhp65SyCJG77UVT5VhnSI9ixDRB2Llm4HnXwOl4b+PiGbLJeBZeHL5XtnmfvDKDHqLiH3FklfAi0x/jNYHuQ67/IC9dGaUCE00Xmm1pAoLaO/Esfe6q+WtzdAzxwAIZ2XmkLZVv4IwgSydlxXg+jJxH/wqSiCKJjn47awV2oGZ/Xv0PRUGxe35fB1ARnwa7gUUtzjr29THlUMvpr/OUq0LIEwtS95eV9AXnBpw1oREk0Ip5x46njF+WwGy+6GPu29AweUJtyDFrm03ToKHqS9YRDVuKc+DwYs0nCEJ+7f3AUqhW7mV2NgVAUqcGHlmXbV7tSkIzfQ==;31:17r1c+AklHGutjY8MlEfpFD7NVDFVTEOQj8avjI2HRS9a6xaGyfRCr1szcWCHzQ5j439wSyK6rRfIajywJu96XmG76rQswowV5x061RQrs9mzp7/9fVjhbH3Z9pOzXXYlqx1pPAQRDbzLPn6m9fWKKxgB2jFnLMduevuUhDupntoeQVa9A/da2Cd8kpQySyOGbTo4s6uIUmFsYBn+t0jHld4q0JFBStzUOmlPJd9ajQ=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:HxX7UYRJZddMTxWaKc3uoCuNyL9lWe4B01Dz8oK3aqnxUOu0q0Blftp8Sa8m5BwjOXHIRIeOfKAZ/kS825q/ViYOPih96TFlio2nesO1rJ4Va8ZmrjEtFNXF/kio51v4LNa+juN/qyea1lVUM8ss6na+46CYhyOWtNemgeeXSODvACFvhmnnVDUFGkM8JRVV+dUkT3wFrARqh0ytmKxIFLtgEg/2hqClA/MqCr3/oB3Hdv8ijpwtcuLCtW4uwyQup2PziHeEkz8CJOdJCj7AkP8B9mKn6DrTyzRHNMKT4wHlNvJ93qix8W3l3f9JJhvGyHQcAicZnD+jpKWOpMdrioLzZVIleeGCXfRMUhDhf7mFIVzgCWw9jkZF2GjRuGdJFvxjW53ZBgzcotmLxif6eEoL701SQySeAEmZncCI434zGky2aAHI9lEXk9gbPa+9npKKnWWsNCN2DCni4eD4QNeSesboh7Rq5j7n61j54bV7Fp7qdqklyG8O9ztUGIek;4:IxZ+j2GZLVXC8nrK8dyPWv4i1jcjiQhO9mHOAPtQsKJ/9x47TvJXRs4qDmw95qy15iSSAbJ37yGT4kp6bwZ57uOqJNHWpg/pLdZNO8atnwqGcpIXRK2KLDT6XvmzTuj6aV6x3f03DJjNDQ3KUWo47snSfp1TkrMbMGnSvxm625om3LSQ/DSps5p7mHKvt5tKS9DAaRz6/D41RECTxnAxVTsaTOHIiwjwj4O3vGk3xfbThcfsVpEO718/akqKVTwLdlOJPL9jfdl8u2oQm0w+gtRKp085EG0DhcdfL94o8LVClldS+qCQ9A3zPHkXEPp68m+UfmYwEQFES7DQ/vLKYqzQIs0sW99FGWibeEHJHt8=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1078A68833C5D49F99959CE0BEB40@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(11241501184)(944501396)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(2351001)(2361001)(53936002)(47776003)(25786009)(8936002)(36756003)(476003)(446003)(81166006)(11346002)(2616005)(6916009)(478600001)(52396003)(53416004)(46003)(8676002)(6506007)(386003)(76176011)(51416003)(1076002)(52116002)(59450400001)(6486002)(305945005)(7736002)(6116002)(16586007)(39060400002)(54906003)(50226002)(4326008)(316002)(48376002)(6512007)(86362001)(50466002)(16526019)(186003)(6666003)(2906002)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:nWjvjAluk28v+gHJ3XYxDnmbvjbczCOKUsS1vrioj?=
 =?us-ascii?Q?+1V1iYyfDKfj45oJcmt5m8JsftihBicTcL2kz3P7Pq+TE3sZy0nN3D0e1x44?=
 =?us-ascii?Q?L1UeWtGkLzP/aVlTRaQL1Nmy1a4nn5VPX8sPJCp/zCu9fQFHJPCoK4LZ95VD?=
 =?us-ascii?Q?B4LA6c+lCah9EgorXKEqVcI5IrNoYeDKXxeFejugrhjN5+DcSLhdPC1wTpbx?=
 =?us-ascii?Q?Ye8/hPHh3KCHSJxtZgVx+Bt0hpls06As9ZMm0BZxfxVwKPW2KXI1eSWkPN34?=
 =?us-ascii?Q?mZnd6DmpiXRjb6H13YdOr/4eXk3rsO0FA4vS1bmWE3ZWo14XPOLwlTa7ZswB?=
 =?us-ascii?Q?EHZFK2DCIK2htTofsHCGqVWp4+P/NBYFM/ueHZ9MDUQvPGZCXpJ+S+dB6Mrn?=
 =?us-ascii?Q?ricFva1w4WykKyNRFrqiuXLmdEdEL8lgEP5IS4zzYGD7v8y5AfCbVG9jCN1X?=
 =?us-ascii?Q?b5ld5UfGkwOTjP05n+t1ugYBXjl0iUM9TbyAw1nd473mRRM983rxAMJphiVq?=
 =?us-ascii?Q?1xgQcNIopyWXSdGzB3ZMQ9eNufVsll6lCjR00erCDGqZvz2Dkd/3rk32L0SF?=
 =?us-ascii?Q?fHgoJX4dmaEE5sU1KvXHeg/lar3x+CbnG4p5ia9UVz78HneBgTgLOu1nLwCY?=
 =?us-ascii?Q?n/kQ4GRkIMHlwyknFonHyXi5d3XBB6a7ZQ0+tEV8M+KznIITCFHjq9uDlg+d?=
 =?us-ascii?Q?+npklhKcttB/GNyJjomo+diH6HeJ0LIccRyK7zUH/yDWik6jBctFyASywW+Q?=
 =?us-ascii?Q?FL0hKXn0zpV5sKMpITKggFGt01umVnXWflSYX/IafJrAmnY7T9vFyxdbm/nZ?=
 =?us-ascii?Q?FWstLI4wqiYnKC2sbhyvvIuD8/K6V2utwks1OkkQ3o4Y6wFH++Z0SEaNMHyt?=
 =?us-ascii?Q?vMElt/lCHYcKly8+cEes/vWHN0+fbjhQ0NP7szg64ofsXm1bcXsHjgjvyTvh?=
 =?us-ascii?Q?OR96ap2vll4BOy2vU38tzqyQdzt12ihnL/FyKGp3VJfcdq+pTcGomkw1JWvK?=
 =?us-ascii?Q?cxBYViwkdkenRwpB51SngZlxQ8VUOuzlor+BkyrfC/t7YOC8b2yt8NUjv7Au?=
 =?us-ascii?Q?6HmdzUkJWMFyEsst87MAm1IR5tOVRrhHatqCsIRX7ToWe/DCfr1lLtxKwZKn?=
 =?us-ascii?Q?HN2xMR+PIQNLtfg+qRpaimD7Xn1qafrC5GU4zecocY1msxnLthD0A=3D=3D?=
X-Microsoft-Antispam-Message-Info: DUUAYASLTieULTM8roVGPRHqc8Tjjwaq42RKUnWJ4tFnc/g4zOigtOMoqVlzFn/0v4g2j9bPe8/ZzPVDpZ3xv8Y15bTEzmskbsvH3mhaXh4+ru8CCEsW7bs7rBiiOi+ljwqjxgGahblbHBsTJ+vt6n0dk6cS7Ox2F/ekz4eFxdnCgOeF4cI9CM6pZTtn3+9k
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:dOUsZT1K9TaeZH3druq4lF2nGMcuFZnkVUeFHKF29vhirEbxatulGnV/EG4m3Pir+wsBJ6j0Hmg021EsGwo7fk/lqe4Vp1L8yIqL7qMbXIvYGJjyZ/hUtdvfZN0RqIkoBytLR12XQZLdglmYhk9FpUAg1JCcWYIQjjydXg+rvIIz9k2d0FUpoiWFu+A3uFs4a1okNNcn4u+qXl+QZPixEeZSUr6uHQNo5i8URFUjIFqJXNs7+Td504pOU3GaKM9MCMB3GsRi39nFN3aqB58mNodeB2TslMRrIQz6hnQ8bdSB+vVD7HmJ/OHy4fx/QIiTm8WIwGRXpJp/pJzWOl3RAiNiqYAkE8IMUXSIGmlfwGr0DpJi1s8omrUYJ1BKECb6Okd3ggQbtNkA/7qoXnnhiRjH4P7rCA3ss7Jm77TbiWjLj/5qv5brf1I1rIXMIInnY0gLmxSaaiHpyp6FpBnm7Q==;5:5k8li1J+USVTDaHsZbPDKVuaCZII8Mc7ucroob8qJkZvHkA5n0MELriQ/2QVXo4hTGCYTZodZAUMyu9YUsMYNoFdfFRPH6lxrqB3GEdiXg4nGFQyabrJQFK58jkD5VKuxIPtKv80G/ciR/gHOlJNct6tDwMJEF9YPm7OcqcCMPo=;24:Wzzhot8IRTPnAUPxyrPMS5bpIP0opELG6ZUG0frVWSluGtEtC9ze+FsXd3IvulmJDC3cxuK/fh+sTi294v9m7ZVAFg+xKPxz89lXn2zoYJU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:yYpeqRJ55FrX/NHo7tyx/sK5rPqTkw4qzp0Mh81BJCxT8gTbTSGw1LP+YmvZCFmQ9rgZoxECnv0cx1wrR6qm/+RYI//+8aCnvTUZV1ba/8wqE16TsYVrLZ7fyllnh1lWZvRoYrpVwW8UzsLD8N+fSpGAHxcwCeg3+1ddApYFb404YVxhhXuVVVXddaNSUKrDGJymYDKSgKPODf3EnLcAwjxIIXEJrEuLFPzJbFqiqADtPl7IZ2yq/R3UevI9zrp5;20:CloUuxbYCmfPW1B1BsH1NHOO0AuG3xINGuOe/sl37vjNDnCiA9kdq48MbiiUNOErQ2+mkks0OCP4/ovBZYZJ5z8CnD5JYQ8JP0YSxax4ro8O6bJeevnrKRhnODWMi2K7lxUt3ZYGEKVMiVOypWLw+Dlf6zIPtw6la9lnEZ+io/4=
X-MS-Office365-Filtering-Correlation-Id: 1f925e82-d29e-4458-a37e-08d5a6dceecc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 16:36:55.4384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f925e82-d29e-4458-a37e-08d5a6dceecc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do store memory.min, memory.low and memory.max actual values
in struct page_counter fields, while memory.high value is located
in the struct mem_cgroup directly, which is not very consistent.

This patch moves the high field from struct mem_cgroup to
struct page_counter to simplify the code and make handling
of all limits/boundaries clearer.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/memcontrol.h   |  3 ---
 include/linux/page_counter.h |  3 +++
 mm/memcontrol.c              | 18 +++++++++---------
 mm/page_counter.c            | 12 ++++++++++++
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6ee19532f567..b89e060d0283 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -182,9 +182,6 @@ struct mem_cgroup {
 	struct page_counter kmem;
 	struct page_counter tcpmem;
 
-	/* Upper bound of normal memory consumption range */
-	unsigned long high;
-
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index bab7e57f659b..83999441a43e 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -10,6 +10,7 @@ struct page_counter {
 	atomic_long_t usage;
 	unsigned long min;
 	unsigned long low;
+	unsigned long high;
 	unsigned long max;
 	struct page_counter *parent;
 
@@ -38,6 +39,7 @@ static inline void page_counter_init(struct page_counter *counter,
 				     struct page_counter *parent)
 {
 	atomic_long_set(&counter->usage, 0);
+	counter->high = PAGE_COUNTER_MAX;
 	counter->max = PAGE_COUNTER_MAX;
 	counter->parent = parent;
 }
@@ -55,6 +57,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_set_high(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9c65de7937d0..f9724dea017c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1869,7 +1869,7 @@ static void reclaim_high(struct mem_cgroup *memcg,
 			 gfp_t gfp_mask)
 {
 	do {
-		if (page_counter_read(&memcg->memory) <= memcg->high)
+		if (page_counter_read(&memcg->memory) <= memcg->memory.high)
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
@@ -2040,7 +2040,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * reclaim, the cost of mismatch is negligible.
 	 */
 	do {
-		if (page_counter_read(&memcg->memory) > memcg->high) {
+		if (page_counter_read(&memcg->memory) > memcg->memory.high) {
 			/* Don't bother a random interrupted task */
 			if (in_interrupt()) {
 				schedule_work(&memcg->high_work);
@@ -3857,7 +3857,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	*pheadroom = PAGE_COUNTER_MAX;
 
 	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(memcg->memory.max, memcg->high);
+		unsigned long ceiling = min(memcg->memory.max,
+					    memcg->memory.high);
 		unsigned long used = page_counter_read(&memcg->memory);
 
 		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
@@ -4433,7 +4434,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
@@ -4558,14 +4558,14 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	page_counter_set_min(&memcg->memory, 0);
+	page_counter_set_low(&memcg->memory, 0);
+	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
-	page_counter_set_min(&memcg->memory, 0);
-	page_counter_set_low(&memcg->memory, 0);
-	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	memcg_wb_domain_size_changed(memcg);
 }
@@ -5364,7 +5364,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 static int memory_high_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long high = READ_ONCE(memcg->high);
+	unsigned long high = READ_ONCE(memcg->memory.high);
 
 	if (high == PAGE_COUNTER_MAX)
 		seq_puts(m, "max\n");
@@ -5387,7 +5387,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	memcg->high = high;
+	page_counter_set_high(&memcg->memory, high);
 
 	nr_pages = page_counter_read(&memcg->memory);
 	if (nr_pages > high)
diff --git a/mm/page_counter.c b/mm/page_counter.c
index de31470655f6..7f0013304afd 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -202,6 +202,18 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 	}
 }
 
+/**
+ * page_counter_set_high - set the upper soft boundary of pages allowed
+ * @counter: counter
+ * @nr_pages: limit to set
+ *
+ * The caller must serialize invocations on the same counter.
+ */
+void page_counter_set_high(struct page_counter *counter, unsigned long nr_pages)
+{
+	counter->high = nr_pages;
+}
+
 /**
  * page_counter_set_min - set the amount of protected memory
  * @counter: counter
-- 
2.14.3

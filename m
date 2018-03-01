Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162565AbeCAWSA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:18:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33544 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162494AbeCAWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:17:57 -0500
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [RFC] mm: indirectly reclaimable memory and dcache
Date: Thu, 1 Mar 2018 22:17:13 +0000
Message-ID: <20180301221713.25969-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:180::1:9e4a]
X-ClientProxiedBy: HE1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::22) To CO1PR15MB1080.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434c47a2-e5d1-457b-1788-08d57fc23f44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CO1PR15MB1080;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;3:p4EgKH9kui06iNkbAT49VwXILBhiTfYqAOigGumeDcPEh0poA09GApoKz1S1b5RYSxTMSQuVdr3yPOwg70pM7aP/LM5TfO1oHZP30XK4CZ+lPU3E3tvSPFxOtceqG59owxu1CFsOxsqcyZ/W+dqPruuX15jxzHCqyaVgeqxMDY8tdy4d2gDOMTHHNcYAkIi8emgkpxhxHk03sVjnIfGNnQMtiCy1mEBtr2IKYvMWQ9OcaBtrlweFzh0a8eSo4rWz;25:eJhWuqWLyAquKiZVTo7+pQSzx9w8kF/2LjeoH7/uABnr4arDfCVa2Uxkem6+6lCOVcec46RTEx3pqVCPuCKsug3ZkiDuAyrpNN0CPDT+ymxw51fKFER5mhYyAfovhdmAWsMSRkoF8uPWhEmIk111ladQvL6iLcPaJfO5U0NjA5UQG19MBvQPrIlrCC6j5iZOni7QPuwfd5VT831FSr02f7Qy+R2rufX1Z72u0AkWPmDDGPJ3kZuz3fUG26oNNI1bIR7uJW6BMgA4Tg4sebtd2k5WRs5f89TYhwlGf+HMD1qZsq3epV8b+iLGnbNgtdMnKttb5ZrrpiWzz59HlXKMcw==;31:bKKYhZCGcgGtfoF+FoKoaplOK0tX33FTxYi+Jpr7wCaxtMplJdkfXsblrf+1i1StAr31WfxV/hGJvoJ48v80oB4zQGyE0at7SlyqFZ5IrU5WUCBdBTplbhKe/PbOp8kFrElRfjLJeVjmGAl1Mmrm/mgwKsRGKuKXei8Q5QNe6J5MU7s/gKJtksRBRzlqpPR/BGfGwDvxCwc9NG330N344w1+NiYlUC1GOLp1zP1c2bw=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1080:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;20:Mo+1kh2pmmcXymDKpS8FKOuA8dWU6AljmlT82mvxUCuizrdqPaCRGpSCyt/tghNO9wqFXIuW1bMqjqinGEjwm2zRfpFYW3zfoOrS1TlTSEezkZoXdoNgKcsVsKAsWcsexgGv7vXbGsTtmNncbiGp89tqoERFwrpPhFYB2HlozWfV/mh5o8Pd2rdBsFJluSjMTfKXZkozcRI1ckOVHaVXg367qTECtGRCA4XejlI8g7HBP5sdEMZZMTTMLj2ypyXh5U64Mt18zdiVzmLrPnuiuPwN0SSDTvl6IhX6Nd6Wmglx5PFfmX/raIkGAMFslvhPuSKX6iiIoFfh3vBoiWKhoKStufzDmVCTUBYW13JV+T8x18uzdLZD3UPGDXlQDJ/aItMyIVIEsLqtHo0Q/lAP2c1rn3J+0K5FShR5XpAa7sdHo5m9odYpYSB6w4cs14G/XtZHsEsyHZa20FGm1uXDkAG/bJGuPjH/etzSVgAPnecZTw9vH7LSl9aDa48cZmxe;4:W+IrrgXCzkijCaDpKiaVB6Ua30P6cqrFW8pE7z6iGHl1/1McN7O2TZTIbmg90/HU7hMJ6f91JIfE/BnB6aAaf2e1290+eZJBrMUSmgKGe0BTDzYD3tVPfSkmv2CT/2Obw9YLwt2R2yvhyn5ahCyXUroujVNkSEJUB+Jez7ugSJ00ygniRug88GMBtI1WWzHrAUTv/UK+XtwnCPxMr6/03V9amHyPuYqx1aZEQvbGFi9pxy/lRS+HJSllo4g12MijTMck5TZZt7CD3xyofMyQssl+SVTzEu9BAhm/iR0QdrQ0vjbjXlQrqK8rpb5GCY2QkI2B3zV/8NVUfHsV/tsZLvw09nwMK8MPhxEms9/zrfI=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1080FDDF7F335C76ADDB42F6BEC60@CO1PR15MB1080.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231220)(11241501184)(944501224)(52105095)(93006095)(93001095)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CO1PR15MB1080;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1080;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(199004)(189003)(48376002)(6916009)(25786009)(6666003)(2361001)(2351001)(50466002)(53416004)(106356001)(105586002)(46003)(1076002)(7736002)(305945005)(575784001)(86362001)(2906002)(50226002)(16586007)(8936002)(6116002)(316002)(81166006)(81156014)(8676002)(53936002)(54906003)(36756003)(47776003)(52116002)(478600001)(51416003)(97736004)(5890100001)(52396003)(68736007)(6486002)(6512007)(69596002)(16526019)(186003)(4326008)(386003)(5660300001)(59450400001)(6506007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1080;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1080;23:48ixCqtubOJYyIpIoYysdFwQ8ZnL2/l0juE5Omaz6?=
 =?us-ascii?Q?Jssr3pqMONEx12CD1TndI4So4kFrxruovmmUkAbB9ip4LhJADA/3XI02Su/h?=
 =?us-ascii?Q?ONRzlAEVeIakrkj6U7iuLlp63P174K3IBHjOxJxqdgqeLWHBQO+hF708bcW6?=
 =?us-ascii?Q?RG3tn6vaPadSrL7rx0RAgwg4Ke72StkyfYkwSVcjUYTGOLuSGucDo52T+pKg?=
 =?us-ascii?Q?EDJVWRyF9svIjByQRITHhjIdfApDgFFsFgowGH+5hPT09NSSx+F/4YCwMaWo?=
 =?us-ascii?Q?FfCUx8wrJ9KuUdlRonRb5vdRS4vHjvK74Vvr8O3cVPqVo/wb1KKoheHLp1rL?=
 =?us-ascii?Q?stDRecv31IBG76htb2VWWFWvjJ3sMYqHsFOvEAY1BoaW2UqR78TDA/S5odEc?=
 =?us-ascii?Q?Rvk/QNjPtLswdI0OSq0qzHLW3L9z2o7ArQ/S1PhxGENgTHi5RiUK7prBhbeR?=
 =?us-ascii?Q?EIDZoSvdzj7m15EjlWL2gKVHe+vNEJ1j8cKb6cdnq7wNQoR2Kw5p/vh0/tmT?=
 =?us-ascii?Q?Xpnoy4RCev/6qifmEyVS/GccpiOX1gLIQGrEeQqmGC8r2k5KMmQdrMjnGZBT?=
 =?us-ascii?Q?8ZJqL5gSJlkEDgOj6TUP3a/vw5XIZwL0uTb84hwn3xGgIaSgs4OHNS6m08kZ?=
 =?us-ascii?Q?K9jUbXZS1fUVv6ppdNQiGHU/OkSqH8BPybr6sM5CYMsSGr5p5qd9tpaP1YC3?=
 =?us-ascii?Q?rcqtTpysXUo28GBw+P7RT1ZjcqMn5Ei+QT5uInZ8A8DLXak2B/i5pOw2vASW?=
 =?us-ascii?Q?+DCqkL0m7OJKt5gb2owoi427faiGLwUCnXecEiA1WpDXEyZmP3sK7tkXSuPq?=
 =?us-ascii?Q?XYLlXv+LhbjLsarxu3Lz7vAKF5jplxsyZrman2JM8ord0633oNv/sUhpdxu+?=
 =?us-ascii?Q?EPsMS+o5BjSExOrBPsDTJmzSHgmidf0M/TlQONtzbvWUoNcU89nlG99/AyTH?=
 =?us-ascii?Q?FLTpmdY1komzmt1YATkJ7FNk7WLSivMoJfgzdC9cUsVqWQONVace5SlSfXbr?=
 =?us-ascii?Q?f4Sh4Xf/6x8GBEo5jwlTMY/qCSI1PBwmXzIkoC/zyUhr02Tx3+OrjQEflMaW?=
 =?us-ascii?Q?ujAFmjFBT7pLep4Wi8aT8+HZyQja62nvorEyF6rkvIvIXlDLoBV1elHNB70F?=
 =?us-ascii?Q?+tVyAOvIan9qBCViCXH7+V3DpevjZynqYDx/cvm+DYYxHJurRsqnJhKSDufF?=
 =?us-ascii?Q?Q2H0wgnyprqj0Z6KZtgsG+MnD6Kjm26nZO+GhPlPec5Py2mJRkCq4U477UrT?=
 =?us-ascii?Q?jAFnwQXXMBG2egussc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;6:I4mmRL8SHGOLDycJWDRm8PADV9cLPOXZ4EF412ErN9p2nTiA86qaAfkayKaDp9krgxJ4akta+tgLjpGhM/u/OFu34hKIlV6hO89BPYsZYqEF6CybdQldf0aQyb+X/4Hbisv81JPejsqAzfPLnAR9Y/hyypqWjc3wn8g+vTi0Dr/QPJacGjqmCKKVhbKLCoGvdueEoNCdD8CYdLX65/4WGTxrb+ZaEK1TmpBIju8ZXFe2tfYX5nLuqSDmnFfRpZDUqJ+qDrSiZFEbJT9Qqq8JWuK7cCfkTsKptdBXcMz5io9FrsJkfl4yYGkpHZWz/+/hFZEU3hmMP8OvKIDWlzjW+52QBpqA0C/QbhXt+V5P1oo=;5:+UvWYkAsQdHsunSmkKEShFBq46bS/VUfbUwdS7GMlLJPEFOoGvwUZH1+K4DLtp0J+iIQ8yl4HiCrOSgeDjKabhUsa79u8xsrkngFK6EjIKTaWLQDCYLIA0MMwnEPmbLL3Wo/evHsRIxUeIhz2mGDHdhp9m7n/ZR5j2EowivA60c=;24:VFjc1t+GCgJE6kXNCfGRr6A3//mKti1L6mzfVmHbAPIWAkMK4xfKYmmzxouWGVrePUoFSBXZKdxbviIODy92YZeTIj/cfaG5twfC7XMJpOQ=;7:IDxU+n8guM/xsgrGqo0DFIbDsZXrDqTfDncnGMymonfTlGJEOZQpggknaVg0xBf+wsoSwd9qsEwTOyKlkSYI4Tix4YvoBH/5zS+WY2KwWT2kOL5Q2JMzI8wVzyTRdiO2pc55XOX+8cSUEo/LWvPaPMuO6XL6m9ww9FOUArSS9X5Fde3vCE7IrbPmjFXdGZb09BLxQT3QRq6wn8V5o9hgwYfRy2MpU+n+ja0/ZySY54u0xkApImVU3VM4rHN0Ygjo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;20:Nh5cqBnofScP8mA/UKbqUaF6jiDZXF68XRL6s8yzB5z+ES01zIWEZyOx0BpGMBVxWEiq3ZV7NIqqrSY341fPrYbToCYv8hDkLW+x+g58wHY/B5S2aQwGh4O1fYK2+JHNO4NKuztU2PmR1Zns2+b+qsGkjWdiFdKx8dqzfXhSPeI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 22:17:37.6633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434c47a2-e5d1-457b-1788-08d57fc23f44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was reported about suspicious growth of unreclaimable slabs
on some machines. I've found that it happens on machines
with low memory pressure, and these unreclaimable slabs
are external names attached to dentries.

External names are allocated using generic kmalloc() function,
so they are accounted as unreclaimable. But they are held
by dentries, which are reclaimable, and they will be reclaimed
under the memory pressure.

In particular, this breaks MemAvailable calculation, as it
doesn't take unreclaimable slabs into account.
This leads to a silly situation, when a machine is almost idle,
has no memory pressure and therefore has a big dentry cache.
And the resulting MemAvailable is too low to start a new workload.

To resolve this issue, a new mm counter is introduced:
NR_INDIRECTLY_RECLAIMABLE_BYTES .
Since it's not possible to count such objects on per-page basis,
let's make the unit obvious (by analogy to NR_KERNEL_STACK_KB).

The counter is increased in dentry allocation path, if an external
name structure is allocated; and it's decreased in dentry freeing
path. I believe, that it's not the only case in the kernel, when
we do have such indirectly reclaimable memory, so I expect more
use cases to be added.

This counter is used to adjust MemAvailable calculations:
indirectly reclaimable memory is considered as available.

To reproduce the problem I've used the following Python script:
  import os

  for iter in range (0, 10000000):
      try:
          name = ("/some_long_name_%d" % iter) + "_" * 220
          os.stat(name)
      except Exception:
          pass

Without this patch:
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    7811688 kB
  $ python indirect.py
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    2753052 kB

With the patch:
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    7809516 kB
  $ python indirect.py
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    7749144 kB

Also, this patch adds a corresponding entry to /proc/vmstat:

  $ cat /proc/vmstat | grep indirect
  nr_indirectly_reclaimable 5117499104

  $ echo 2 > /proc/sys/vm/drop_caches

  $ cat /proc/vmstat | grep indirect
  nr_indirectly_reclaimable 7104

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 fs/dcache.c            | 29 ++++++++++++++++++++++++-----
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        |  7 +++++++
 mm/vmstat.c            |  1 +
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5c7df1df81ff..a0312d73f575 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -273,8 +273,16 @@ static void __d_free(struct rcu_head *head)
 static void __d_free_external(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
-	kfree(external_name(dentry));
-	kmem_cache_free(dentry_cache, dentry); 
+	struct external_name *name = external_name(dentry);
+	unsigned long bytes;
+
+	bytes = dentry->d_name.len + offsetof(struct external_name, name[1]);
+	mod_node_page_state(page_pgdat(virt_to_page(name)),
+			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
+			    -kmalloc_size(kmalloc_index(bytes)));
+
+	kfree(name);
+	kmem_cache_free(dentry_cache, dentry);
 }
 
 static inline int dname_external(const struct dentry *dentry)
@@ -1598,6 +1606,7 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	struct dentry *dentry;
 	char *dname;
 	int err;
+	size_t reclaimable = 0;
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
 	if (!dentry)
@@ -1614,9 +1623,11 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		name = &slash_name;
 		dname = dentry->d_iname;
 	} else if (name->len > DNAME_INLINE_LEN-1) {
-		size_t size = offsetof(struct external_name, name[1]);
-		struct external_name *p = kmalloc(size + name->len,
-						  GFP_KERNEL_ACCOUNT);
+		struct external_name *p;
+
+		reclaimable = offsetof(struct external_name, name[1]) +
+			name->len;
+		p = kmalloc(reclaimable, GFP_KERNEL_ACCOUNT);
 		if (!p) {
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
@@ -1665,6 +1676,14 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		}
 	}
 
+	if (unlikely(reclaimable)) {
+		pg_data_t *pgdat;
+
+		pgdat = page_pgdat(virt_to_page(external_name(dentry)));
+		mod_node_page_state(pgdat, NR_INDIRECTLY_RECLAIMABLE_BYTES,
+				    kmalloc_size(kmalloc_index(reclaimable)));
+	}
+
 	this_cpu_inc(nr_dentry);
 
 	return dentry;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 67f2e3c38939..953af0232023 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -180,6 +180,7 @@ enum node_stat_item {
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
+	NR_INDIRECTLY_RECLAIMABLE_BYTES, /* measured in bytes */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 76c9688b6a0a..03ff871ad73e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4599,6 +4599,13 @@ long si_mem_available(void)
 		     min(global_node_page_state(NR_SLAB_RECLAIMABLE) / 2,
 			 wmark_low);
 
+	/*
+	 * Part of unreclaimable slab which is held by reclaimable object,
+	 * and can be reclaimed under memory pressure.
+	 */
+	available += global_node_page_state(NR_INDIRECTLY_RECLAIMABLE_BYTES) >>
+		PAGE_SHIFT;
+
 	if (available < 0)
 		available = 0;
 	return available;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 40b2db6db6b1..b6b5684f31fe 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1161,6 +1161,7 @@ const char * const vmstat_text[] = {
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
 	"nr_written",
+	"nr_indirectly_reclaimable",
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.14.3

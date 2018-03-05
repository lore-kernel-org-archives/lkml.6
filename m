Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935142AbeCENim (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:38:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934037AbeCENia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:38:30 -0500
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 3/3] dcache: account external names as indirectly reclaimable memory
Date: Mon, 5 Mar 2018 13:37:43 +0000
Message-ID: <20180305133743.12746-5-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305133743.12746-1-guro@fb.com>
References: <20180305133743.12746-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:ec6d]
X-ClientProxiedBy: VI1PR02CA0076.eurprd02.prod.outlook.com
 (2603:10a6:802:14::47) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c1f60a-0011-4f96-184d-08d5829e5867
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:0zPiRMlX8Rqb6SbyUoCsj6b9lhs7CcDYE8IYXsaxv8HAhPpKDc3exneQJqpHp0X4FfwNUD3tTSnKZSUiU7i9hrx2SXmm9l4H0owLFChI1SupAmMcTUgBrrSSqVQZkltqTNnseTSzVpqe5GYqgwbjYUa2eSk3/lyCg29h03YhbOTa3qYUtg2PHhxWZua/SiTgz2gvq39wB2AZnhJvLa9JnFhxu22dMZwj2pn0M2Y+FhGSqz5YQ2GrKxo/2nbp3LdI;25:svw9XjI0yt/2P9Cl/hB0pIhvYAoMVbDgM1g6M5+Qfnkg+d/Xftqt+oN4doqmd9YGsSsYQoFFDt7xXGJ51wp42HnKZCkjbnnAOnZ0DqGryavIVGrLMSskgpHP9m5YH1dm3IeZeG8XnjpDVFyXhjyp+rHfUcMhKyn74tBTVOKzXGPG0HKHhp7ws0mUYvXsT/HQgkYoOxPgPMsWQtQurq/xmaw+ZG+NGNpkmStTb2J7GwYGeml+/ihT5P1Wu6jRUTsb6aBI4NifPnRCZYIMYaVB11IxFYqIspI3RGfSJ50/L2h00st4Jyc8tIBD/Ln4HlFvVDWtZYiZ/v84S+VBnn2C4Q==;31:T1AqYAYRUbtj8VSqSErAVzxEVxmdVUWS8gj8CL/XrMBV1AlJoKaThdtvooFPNuzORFldM7lS93CrJT91pakTKRxmNMoZg60IwncGehh/46LRmTB8sGTE7nDdMYRqkytgodrfj3t1HO9QDvv6hSbDrBVuivZrItc+nXX5QlEr8GnaDRsOTBdtbvf+valI4rnKIXN7sA1xJiJOsqW94iljajlpf830IlkOKvoCF/WkJ6w=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:sYYg1zGKOiEu9iNrAaRa49gdL4o7PLvQ3oes0DxXomVY2jzW2OKqdTuPc1Rw4/qBUShrzxTp2Posh4GS2leR5iOILiVm3rsbuvfFdirYnTemPGw88xgUhfAMyIAbKRZj1/zMvgkTQCTHMyBbBUlsOL5qV83tT+Fl4l/eI79+Hm3BZ9yssc9I/Slbix8yZdvOUkyv5Y3u+0RO1a4iGKxazko2/6EATsBUd7k8isOl0FXQGPvv/6ADAfu7u9yctKYakeFiHGWLgsQmsUIsnUswDNvZVUka0x2RdNlvFCwhR/RZ7TCuBuU+Hzp5XUsAYUJlR+5CrZXp/DsP4x7HRb5q4G8D3ok8tr324vy7j4G2KnSnGikU1PWul1QYZ1YryQQSPvIh6/546k2pNN7HS6M1De4wlLJjhU4Z30BlJdqHd9ZO/P61h4plF9vqmY0chTN0EonsLo2AbyzXD7mHIfRKdWQNGMstUiMwYm9216LrvZcstJPKuSJPElm6a+b1Lsb4;4:/8OPcfwKlhNiuPaoo1mquygmwRPm8Gm4D/yFDdy63ralG7dtCEeiPt+MprTY8vTT/W7b57DApGXqiLWbdOwDjBGDt4RToB4jldDI+IPsPQJLgWQY4uE6sde4S0xXjgp5HPD5PPENlx7eNOJG40phTtWeeolOvoyZ4iiS3E9MJ86pvXRXdwJOnrU71fBj0rhFr7VD1OOeeJdlIc68LXP1o0BhkFcLB/Xr0FGGP7tlqBwsFb9b2gcuYm/yhjF2Ow6RJ1YRvGfzOvWhh1s8r6WzNv+AT3OwudoM26swVp0XvwqTAZNIaah9XLc8AAAvaCv3JQ1D0b/1dR2eVWrZm+iFxe40ocEHL1A5604XqUix2Iw=
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076DFA9F54985BC4A82C1E1BEDA0@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(189003)(199004)(8936002)(47776003)(50466002)(1076002)(50226002)(48376002)(7736002)(5890100001)(16526019)(186003)(4326008)(305945005)(8676002)(81156014)(81166006)(2906002)(59450400001)(6506007)(386003)(2950100002)(5660300001)(2351001)(478600001)(36756003)(106356001)(2361001)(6666003)(6916009)(6116002)(6486002)(16586007)(316002)(97736004)(54906003)(52396003)(76176011)(52116002)(46003)(51416003)(53936002)(6512007)(69596002)(105586002)(25786009)(68736007)(15650500001)(86362001)(53416004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:QG47vYHY9o/JQVy3HxhUVkn9ufm05bIaQrhDCUHGa?=
 =?us-ascii?Q?8lEyh2bDexqfbpbfFmmJLB7u68nfBcq64EICusn+eK8SZxB0papp5wHur/l4?=
 =?us-ascii?Q?NFujMawl9chk01Ysur0RWeOI0f/fFn8B6OL0tHh0sJcCSr5xhvpna5BmJPGC?=
 =?us-ascii?Q?EyWujYgav6vRlqLycf1GnQVmsZPAw7w+s5PiQbpZpe5LzqrnL9dSNK89n8zs?=
 =?us-ascii?Q?T72L0ESau+ccafJglqQ3jltaRbcaqTsf6vRzYkMgYIeueLXi+Caf2mvnXd62?=
 =?us-ascii?Q?sjQs/wLJnjHIvrt2LOb78DqYoIK+DANScEFGZqKkNjAQn3lwYpcA4LhKiQrR?=
 =?us-ascii?Q?EiV/3WtH8YH7A3Mm6r9WqEzeF/ri8JZFpoATdz44UNxwBUjXzx0k17ZWR+4I?=
 =?us-ascii?Q?RUMUBtr9ES3esfS52XwvFf5q66luWAgh62xcVKezlS6mJXEJt/E0G6Rpa3Gd?=
 =?us-ascii?Q?UAzMDSU0wYPfmBv4hQlBqrFeQ5aWeXFINAQJaBSHXrbQ2M1p0LCgF+19anVa?=
 =?us-ascii?Q?RDhBa/NKv6FOX3lR09T/e1HcJ2h49JZhtq0OYN2UXS10jCo8XqhwPj6bY7fj?=
 =?us-ascii?Q?O4hiAIqdRHY6hn58adNrVTRjFZDUWomVWlhZPQ3uNpyA8bJVV7KwBplrnzN+?=
 =?us-ascii?Q?E93Jlk5kWbRPRbvIYDqXI9vrMLcrAvY3sh2NxsnyUp8ZgE5vqWeHki3Abapi?=
 =?us-ascii?Q?gjOMrp40weyTEVS+WLBMM7rnSrv+bnLMNEO/PqqFzPSaDThryvr5dJXYAO6z?=
 =?us-ascii?Q?m24Yl3f8DrAPLtnB0xX2JSfk1RZuyGbX/otQrVTZnPmDCZOnkhlEY4N3KYzL?=
 =?us-ascii?Q?C9MpY0mhx+H2DQ+pf/DT8UZ7kkFiJL6qf00DkRrHRRjPQ7RYzkMGIXKo8npL?=
 =?us-ascii?Q?igrf4F4MqTg81ZXuE5mKLprVoXwPuwlKQQ28CPkGYXZJ+kU5WzkDqaH7KBDB?=
 =?us-ascii?Q?cT7zeHQBDTp5ncB8IavV+ON3PZPCyRu7J9FK5s+yMnVLJbSw9/LWiLCGgxTI?=
 =?us-ascii?Q?1B3he4EllPXYyXlGrw6U/YFN8SNiEkQWNvfAUzN1mIxZahU6a+1rWb1ejZ2q?=
 =?us-ascii?Q?AjBxrPJ1TNmGZxJHmoLuTGvsKKYDD8uu7ujgvDCC26ZDQ1UbQEnqtY58kG/P?=
 =?us-ascii?Q?w8fTJTebzX64UI4P4V3N79hd3lHlYMNvIPqFNF5q4yrVaABStweMp0jy0iF5?=
 =?us-ascii?Q?MiIf6l2ev4sWW+HFPUEEEMc3r/lvpv1yU/VxuQu/CTtMBAdrcQ1vPP4WnoKo?=
 =?us-ascii?Q?GDMSMblE4BFiJ20nw0f5UcosaNMFF63hhYeimNiD/+n0V+9qYybD/INxHm98?=
 =?us-ascii?Q?aLBGE6Fdz6E1LgYNR/BGUQ=3D?=
X-Microsoft-Antispam-Message-Info: D0pn9PK1nMpqlBBJKBYWxOxieXteW5lTVLX8P4kptMBKSn63AMRuKdoBoV8B1eCmgSmdj+YB6OEwZSLwzqmc5n6sAIvKFugoth2KEegmUxpXc0rN+Iwnr9YJAOvuIU6lZ1yuxCJ1JbWM4leKbh8zFZYfLnONT3N/oDLx55q3MK1j5GKz3cvXi032qKXynZ2A
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:z2vG0trKLwBZZwavKUy7Y52c2a1aaGSEpKu+6ANjkTJdxeM90cGl2QTuTkJR6R6R11myw2obRh7e/0Pa7i4ykojx/g3xTcTd6+uX0lcVxGng1dHHMHksesHIzJH1t+aCDLIkQpfg2Q5JUsgbHbuNM7wJlJGgy0H2Zx6uUHgn2z+MdTnYtIjjSu+q0qPe+sHFp9ImAPxk8yFEyrtWuDJlQBWaYQOrWXUgrcXOqo2K8C6tFqWNa5cPBvJBgfSQHh8pwg0ahKYeyGSiFDEfjlJCMKWFtS1LPLEPsPskLYUPlbMh4+IRUmR2Yc+QYkXqRDhUAanVzJYURgJuXRF5mJTFn3RtHfFl20tYvYxmyGSQlS0=;5:GXy1r5RqZTNXBF+Z9HsAd6hdH+CHw8Ag1I3fWCZ315BcqaHO5O/Vkxhgk74FcPmc88A4cjHQ3BRifx/JlMQmCGykmTM5g9+OjIjd7z0jXNsf60wz+L+pReD8hrN+y4wBBciGq0CNZsRaIwOz38WBFuQtBx9T4+q2sK6yxgvwi1g=;24:S9us2uGfnXgt105kZy2iQmB9vR23qJcIlJYV/3N4t/KcqPm985+GvZyppXmYujrBfoSf6Tms1IGlXVZaPg+vf2zfN1a/zzGNDivFkGDYtEg=;7:Vta0rZv5anQMHn++nT0QirYFNe9wDKP8Y1eUhh2SsMLGe1N0pmMkskjqYcHkDoIehNrwM/mW2F5j6xQOqz199Lk7GIZSVzewWg7PvI6gxlOUwS8NB7aN/uLXxcH5ALt06stxQFrDI5E3iiKBR0rD3I8RTjS4pOV9fWIItYV6Db18/41bynCNGzfUgqmUblH3+PYKtpAXqpzGSE6aCphemrBSnFc7b8vwEFgcRdcpfFfT3gUmGQFgbuY3irk23Gmx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:H57OM+wE/UJhA0emr43N5RliSj/ANoON5QWl66N4NrktTVu3mqXPwYOL8YsspCGkriP2xQK/vAlrt1QXZNgaGUHPwD4IKA1j4JRa6ymn/utvxFQAdmu8QOnycip2Pz8NNjtdqJY6RP7HFH64aFtUKbwo9ghiPBN9dfNxlohY1+I=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 13:38:12.6919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c1f60a-0011-4f96-184d-08d5829e5867
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_05:,,
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

To address the issue, the NR_INDIRECTLY_RECLAIMABLE_BYTES counter
is used to track the amount of memory, consumed by external names.
The counter is increased in the dentry allocation path, if an external
name structure is allocated; and it's decreased in the dentry freeing
path.

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
 fs/dcache.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

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
-- 
2.14.3

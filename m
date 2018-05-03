Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeECLp2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:45:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751121AbeECLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:45:13 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 1/2] mm: introduce memory.min
Date: Thu, 3 May 2018 12:43:57 +0100
Message-ID: <20180503114358.7952-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:d1b9]
X-ClientProxiedBy: AM5PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:203:69::34) To CO1PR15MB1079.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1079;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;3:paiOKpFyQQughDGErfAoK8P5mSI7z5F+l3EVXPUN4GjqBqvWWUXJVHbYMF8JlTR1kcITtlHt6rxt3OcjrUP+EpKa5pF/b+yOJwHFAvTR3zl2RvumHZIAD1YCghDTvS8Wb30KQnLRdl71niEZZwmtTBd7oCuowinZ39qgig94Upbu5fVGEIk9VgrTVEs68ZEaDlkxZVE/tCKW2QQg0wjcJWskvzQ3L/1gsc/1eloQgL71MTshLNP7MZb6otcg7Hda;25:z62OsHEI/+zLwv8xH+FADFNsyFPlIml5r3d9Yl3Mj5KdQf7Bi6Gvq9vhGm3/u2Ndix48qH5mfTqmb1OAJaKBdLZy0UAT+zyCwHROajCTht1AjxJhfuqmzInudazSOpeEJoskTHLvCrHWj6qjs6lZNuAHsbJ9x4l7fF1PDPSrXDOndrll7ABIXFDOmjFrFy+D+BQub0JE1la37TUfpl/YcfcJmRgMJz6z/44teExwhX1wzIIqftznSe+RCMeI4bGx0x4LgfiaB6xnv3AIqjUyEEf3Xqhxq5W76A4R1oMnctEjPZ8Nc42zLSH3WHz925TGgMgccrv4ARbHAhv/cREExQ==;31:kwv6X6XQTR7/3ABgsPbaZd+4+uNUsLjw3h24fJmJ06+XFAp6/bY/wJMeP1lf83kWUofVb+t6JV17UTWuO8fhNwzbLLD+2ls5CvULW8Knatof/XvIlMOoiWozQN5JN+R1FjmW22mBPtv4dWW0oCi64tJaMGx3I3OVI6hai7MPsg+Xy2No/PAYmvTzpKSj01ZPGl4sFn8rm7g8GZg1G+ZsIwZtglcEGONit/3EQ2aZ9wo=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1079:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;20:tfUKhDsF5NWM1/2l9UjhUPKFPpXDgwcqaOP28yEw34g/fhAN9DBjunXu/QuUjepvFuOnac8EiKUc/VOKHN3bHvJC8twLSZbZYLVzH745Pa2nVyKHY/1ShYioSk5UMlPHshW2SeX5RcJrME87MMvohG+CZEG8cEjb7SRxPDKmlKO438bsvI4Dy/UYEUoY4YjidPKs6w8mzG7OTU9C4XHiLEVg0V9uVh685I+/cSxu+ylZqfcKZmuFX8IvjOnf3A9Zxz1eIs9gx/WaOwK0nYpE5r2zm15WgnBAYvEOZkI9TmOcHdjc6eS2N2lf2pbr0UjjxBWoWW8GSchjb/g8A5Fm//ujPKXdwVpJv42WBwURyn45OA8y3NIinaKqn1bZ+jaZ5vCZfHuxdYIVtc8BBm6+fkADjd9u2GpANAQ/wlzuZC8fPsgci8pxy2OFpRufzDZiJeECTPHBqt+bgFxdQ0/WaR+LoLmpSc0lYq0zx/QXhzo74ASmUmbSVP0yCbxMTwk8;4:UpdXlWKFstNRTchmePXHQOOxLXrnRfvHNOEv3msQiYETankYPlv7zbqT+NJm7mXf1RT8gu2+9R4vo4Wjz4Qw5Rc9ByEhGDQvHIVRIoo+WC5o2rG0Xp3fl8b1rD33IqKOZjhJxb1TuKoFFv3iHRVDb6pJExqExD18YZmaDlFgvfUlwUR7HCWIdyvM0Dv/EzBH8TtinqNdY8LIGVBjRjuWLN5brlqO8cpKjnXpQoTZOaEw70E0e0WcU5YOAXPBnHfBBMS8zW3/mQnAanTtZmkSZ3iLMFP/CJ9ajeZ2bUhmIy+mxB5R4oxndkwpzwd3WWWtVXRyR7bBO0KFPS/P9zSUoRhCJToTWAsuO7gdyzcvXoI=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1079EC293F53828F914FF6ECBE870@CO1PR15MB1079.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1079;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1079;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(199004)(189003)(2361001)(59450400001)(97736004)(106356001)(50466002)(16526019)(305945005)(68736007)(4326008)(186003)(2351001)(86362001)(105586002)(2906002)(5660300001)(48376002)(53936002)(53416004)(1076002)(46003)(39060400002)(2616005)(476003)(486006)(52396003)(52116002)(69596002)(47776003)(25786009)(6916009)(81166006)(81156014)(6512007)(6116002)(6506007)(36756003)(6666003)(478600001)(8676002)(386003)(50226002)(51416003)(8936002)(54906003)(316002)(7736002)(6486002)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1079;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1079;23:TyeosOAZlEBtfB3UihBUAnrxGVsJNmE0G7u+fI8MI?=
 =?us-ascii?Q?eIjz4FhtJkiNs+8hVPsHIj5jta3dUfCBnvWaYoW0jxs2rTJ5cMRT6j/W+/Kg?=
 =?us-ascii?Q?IE9ZlnLlnZheZHg6ILwfd4l8MHgjDMOXmok/gkx+vi8hLZvhPV/gwZGE0onb?=
 =?us-ascii?Q?JEHXCjjqSiBXxK0/srBm/o1p6jY4YyfIpjNoixF4SK5lDM/wA4FDieRptKJv?=
 =?us-ascii?Q?f3Au77E8sJlkVqu1pd5Q8SJEuybUTymUexNbpRi7tGbCXldSJBRm9efXen+d?=
 =?us-ascii?Q?6MaFC+g1hKPCI29tYuAcMYSG5ZVsZxywKZmayBpkNRLQyE8JGNDkkped0GkX?=
 =?us-ascii?Q?e+90WEg+1/B84oQmlnqBA0OU4/8XRYhWRQRW07pTeeSAq6wvW58+VqgZpCkK?=
 =?us-ascii?Q?pJQXCb6K2sx75PRzjgLm0t3Jy8R+fRQkupO8IuTS7hqv1jTKOO700VYJQInS?=
 =?us-ascii?Q?IJ8fUA2Fgb0WLKle7z7j4WuUjJ4ELuFU515pvYa4Lf6x5Qbe0IC0hGiN1BR1?=
 =?us-ascii?Q?ceUkEmbT5r3Pd488NZLRuhbQxkwc5iQX1r+Fl74hM3F2L3ASx/1XAmSs4NwH?=
 =?us-ascii?Q?Hn6rH7STuw1D29F2y81iVYvI6aIBLta5SoQz0LJCghLrnBX7BT0zuSnbzUG7?=
 =?us-ascii?Q?Hbx/fgLNTjy+2L96hSrY2uH6SUi17u41YB9yxFr+dYzGBtelRB6hHMjH2bCV?=
 =?us-ascii?Q?5izuEVCh6tFCRsaxAD/7Ybe1dm9teazx9KYCZTkIcwtLSKrU7F88vpslos6Y?=
 =?us-ascii?Q?9KTIu9pGG+Donmiqt9/Sy21K66bcauN+X9/Urs+8Bpj3YJgNFxp6D1Y80pDq?=
 =?us-ascii?Q?wyDz/jBlbtml7oUet37X3BwyOntOYCZHejFNTlx0w2g9knBA1Vk+s7VG8HDf?=
 =?us-ascii?Q?5YPoNEr7KQq74yi7qDArX5ZgT9wYvqazlvbL1jLfPKjCeKJdJZJjJcUL9osj?=
 =?us-ascii?Q?M+ekHAdzO7Z//xnkndgzUPIKVrgBgEupu40KQORGn75rkySZ0b5ePMiLwTHP?=
 =?us-ascii?Q?I6bcgJ38A1oSIs9Cp8b3OUZewhYaHYZ++rOL5XBZEO+WSdjYssMEgiAweNVx?=
 =?us-ascii?Q?6Ra+xEepgsY+RMuvMX88rm88pgiNFIP5/is44P8T0JUQt5rQE404m6yrvL36?=
 =?us-ascii?Q?59GqtIuvUHyTkA/mdeyB+JVj7pTqvCmsCcbnRGJ8XcfvC3kn/dttvhPObjYj?=
 =?us-ascii?Q?h7hGHA6LuhV8S4I/lwsYZXhPt/OG4WXzvmA8nKpXqw9Z0HiTSm64ISekG6rW?=
 =?us-ascii?Q?AQEi2tngHLE+Jgxxws585EGsANXsEQCO/jvTieUqWv/icxffm1qvTzIu1OHS?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: akusBYfkbYjFkS3Rgl6+ppdILZIJrY9KW/r4FWSJzeYMzibS+Yb8F75pFbvjEUEqox+2HO1/W7c4nUCfVXI77zoOWVbGfHBUOx5tEe9BnrBqTYfD7wtF1AnCDtHWSNmtPXwGkZ7F0VSkbVcbTQUColZqQ06OpobsA2oHfxho8pTlRzrKPszppB2+H8PXm8oK
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;6:Ry7nCPfDUnPfgk7CgRelYwZKgHPsDSQ3OddmiULViLRdopDvHfVXIrmG0u6H9DCqvV5qE2ju07AFUHvtB9iz4kmfrqLZiRKj4ihBQhAfWZxXZ+N8Aljp4WrOgiS5HzUf6I9iyCI8ha9CoZaLInbw9wICHRSXY2l+FPWW2TQe3YxSzsqzZv2l8+nPQgIJBRnvoFgba8OsAjg7hi0UoYg8gaECQZCBkGxSdYKcOiUkXVi9VaLhjwyOdRLarWOjH1mrDS3/5FcMv/bBPOyAKFmvao9DO8ajMOUbHZzvWzjyjJn+LAnIxo0amEI8w9bVcb4CDX+K2D2k9wWNMoQmy0l4HX+0cesUABYT0SRExDECoVm3wxNZ0U1WOjdF5aMA3r/QVLL+Z5WidWrtsbbOOPl8hUujiG2tu2tCszXk8y+mmbX5s6NCCLu0LKbnqrlKoXEyY237P0ATWg3cN/HVU0avbQ==;5:9+1VHES6gFLy5PnntGhMI/9qsmJ1loc59oljrsqoP8bLYW26RaqSNqp1DDJ1YMn21PgoWZEmjdDNGDhO/qY33Fyn3P0GC/uMmSOBmVlhzGBjpbccid9t5/Q7+0dhwh7uZ0JusJ/qNSzAksjT9J8peVv2MyG+zpn9QnKnsf1OOX8=;24:wIh8RqKtTJml5kVruFY2bkAfqUgY6Y85KHb/eSkiaew7cEJtgj4oqQ7rkCSt2Z/B8rYR0p6N+hBXTiIgcbOHdyn1hu3/oY6FJTlH5NE4Vxs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;7:WmuPoetRoqnPVGoG2ZHLcOs3dc/50jKlIeJJbsuKRKnaNCEy+2EnEh8a+kaFWU03TivSRQ9vnKMA7ZGjy/8m1pocH16W4+MsFKznvHb3BZVs3JDLm4//vBjSwMCC3KzWMnZlcQwxsSmRBxst46ktRcS2sOz/7xyj8zDv3qSg9HxoghDcNER9zyTCuPJpI8SRBQoBjV36aAn4jfJ6eUarLJD/EEN5WaaRrd6D7ul2NKyJIEVTk8Caf0AM9k+3Krx4;20:/BezrXrqnkAU/jojaEayFeniDxqyy0YhJpqt4HvGFCpnWOqQLpV1FyOCIjcw0oJ4Y2CVLEk2oEKdBchdLBR1zORIW1jdGYDhIzWrvbs+a4zyKBrpQlMfemLPNkm7b5SGZ2WFxOp++LgJtElfb21MF/o2D5xsM0azK30KENyy1P4=
X-MS-Office365-Filtering-Correlation-Id: 6e057853-bff1-4920-637a-08d5b0eb418e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 11:44:38.9571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e057853-bff1-4920-637a-08d5b0eb418e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1079
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_06:,,
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

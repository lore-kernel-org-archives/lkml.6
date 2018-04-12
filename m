Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeDLN2A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:28:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751711AbeDLN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:27:58 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Shaohua Li <shli@fb.com>, Rik van Riel <riel@surriel.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [PATCH] mm: allow to decrease swap.max below actual swap usage
Date: Thu, 12 Apr 2018 14:27:05 +0100
Message-ID: <20180412132705.30316-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:53ee]
X-ClientProxiedBy: VI1PR0401CA0012.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::22) To SN2PR15MB1088.namprd15.prod.outlook.com
 (2603:10b6:804:22::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1088;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;3:C/CLpj1pDFlb9Ki+2adD7N1gkMgCv3HznyeaI2SyPWj+qBkTcnBLgSc5tAx5aCoVFxrvmoc15rxj5IVmea4YvhImgiBnpVr2otsB440FbzNvEZtT+axC5rXN4gJLJKDSYwOSdOYGyr4f8upSaVbr5D8/Fk9T3ODggmcTXhTtyEJcvlkDXfyE4kIHM4ig8hAHKnBBGcXpzeM5pLjPRvmfuVZjWJU/dDsC/qqjkWAwMXB+PYtX7G6RIgpfto8WEoct;25:+wNbVp3awBCy/3p9c0hpHZVS6ZZjEzGGKlaIzOl1lX6ljF+XFM4+Hm+gPxz4uaD/AJp/ssBHKdTxHdoJ3ipftkTmsMbZZHDPT1d0uhuwrzvxDn3eZJaT1UmKo9tkCm2SYekF2Hopz8RNbtA4z7R4GQl79wS36FY9kPp8QZ35JJy/tVDzUQAFjq8c9mg7XNe6yEXIcm/TJ15ktc+63ztK+w1hHoLxbVLPAuGlI4ypYLLV6cc0rNPjHXVGu2eeJaNN7hF0phloZipwPxj4AQwEFAAuFKUlvMgU630VIyc0mb4/a4jJ/nI1Vt1KxpGTUWfzWPljOsgeshrr35GYbmpNHg==;31:ss7C8mNA7Ex5kTCnISnNfEph5yoeOWzQmYKFMLXLka3SE7BVwkyVWyqWrhTazgPNc6iE1amYUVSr//1sz/VbY1//bXtfhMHMGs7XgUO++x4y4ncniTGky05WwVKg3RDZiFO6I+Q1HN1tP4JvbUptvpO8ji6CEYkyTD/uwtht68vZ91TQ9oYL+3+wDTK28nCEnTiZcRH7Sq/Wqvv/e3jH4Zl9cIxR1IhZHwxy/Q8bdrk=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1088:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:X7HvtgaSF3zMz09KBrd1acvzIGraS97QIZlYn4zFFLt669ryzmUB8bAF4UHzbV0Y/G7LHtLZUoByOaHfpLFSwXUu9FyDEqIAraJnEYHDvrUqyrcC7uL/ofGZg+akDfAxHEuOw+Xfituye0yqSXC9o/i1/6r05bXZvY+QzhsDyjMzc+QoVKpBCJPWV3tYWriklWA8ud8gNtqo0aPR24Z0g48p6TOtYP/WZCkCB6YJXl0qTCMgTSopoznY1XtEy/u5Rt8y8yJIQ5im0nTdQGSPwoMg/C0N5kSelDPQBIb/sHgOYqdY/PD4pMeds+c5gyjqQSc5ynPeNBOd86TLQEPi9WeQLlDjrOqumr3Xu9oaUPkeR4xkzgRY3hoxvGYB2eNz4LuOQJoRF8jYtZoaxbq0ymfOpe31Db70zdBQ2htU3knSIoT3PawmcIxz6/sDIXtc4kDm0sOZAmN2nutG/MCSvhUkTBs8DRJGeWOfAgzCXqD2R6zpBs9EpEx6va7txVPI;4:6OCGJTH6GRgcjbwjGCuVVYjhdc0i5GItn7SHwhBERtkQCyHEZSzSmwiJT4Vi8IYwoqP0uhZH6ef2wNIq3sFdBb9w28sEej4uw2bQYYkL0a4zv7fHoZHvR3hOkEb12V5pZSFN68Jk+ebtBevocPp8jJhGuOJHjcT20KmlpjwEgFXTM481FacEztEILnfyR32p7jJ7YNQOL9o8MNS0KEOzJrcddvpeoS9ezXEhGM8KAsIRdL2vdDb7r6pN730kvKVjHLNMxd58qt7cgWMDGFBydnGquCwXlqGJf9LZDZLQowLMAnicnPEw4pRYGWdWEQNr6agosK+2KhXpDK+zBrCbZbsjLCoOaN13+/Fu7jYtGA8=
X-Microsoft-Antispam-PRVS: <SN2PR15MB108891CE4F34B29EFD86E86ABEBC0@SN2PR15MB1088.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN2PR15MB1088;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1088;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(6512007)(2616005)(86362001)(46003)(5660300001)(69596002)(53416004)(486006)(25786009)(52116002)(4326008)(1857600001)(59450400001)(2361001)(386003)(6506007)(16526019)(52396003)(16586007)(186003)(6486002)(106356001)(47776003)(36756003)(50226002)(8676002)(1076002)(6116002)(7736002)(8936002)(305945005)(81156014)(54906003)(97736004)(105586002)(316002)(51416003)(2906002)(81166006)(476003)(50466002)(2351001)(53936002)(478600001)(48376002)(68736007)(6666003)(6916009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1088;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1088;23:p8xryIdk5c8JhwCYYSddyK4xa3+HFjyy/98672W0n?=
 =?us-ascii?Q?VCxkAU5l17es+MvD7dYKxfCD93dgklou4SlW4TnxN+wAPzGoVMLhHuNpDVzd?=
 =?us-ascii?Q?/AbQHPB6HdIS1yMEOs2t6fSYJifeA5XtC7DkPO/C9+E/UIs+R0ODNlSYTGYH?=
 =?us-ascii?Q?YzjJiPLcAw3et2qe5Qzbz/7S3zbtP3viarDhyHVJuUQlIWRNmttuezYZGQBn?=
 =?us-ascii?Q?RDU++ZXi+mmURXVnJ9tbNFEDaUJ0CMwJ8XxKQB/LWRgHnvXDYxm+mEScfN2a?=
 =?us-ascii?Q?K2fAY90EoHBpFMWlOoPPe/pgYTeEn4BI02Nbt2IzqI3CFblcMUrgUrUatjcH?=
 =?us-ascii?Q?bp9DwbfGi7CRoEa3lH3ii/LiDuLUZ4azsfGJwKt5tfzEHNlxd9QJgMBd/2fo?=
 =?us-ascii?Q?z+ABCMiWdnDzazdotmcctNZLmhZ3dlhKmLeZ1uxxtl12k8qr0NTpi7KXKJUj?=
 =?us-ascii?Q?uVdEyeV1a5VibzaXGCEKlX+Pa6uppZTCDXpePEKojgnPsLyRpRnJUw8e8O0+?=
 =?us-ascii?Q?QR9FpYjGftfkLP4i6JKdRRGeh5uol44CqVCVnQznLJ2keU8FM1HKTX18vMMK?=
 =?us-ascii?Q?rSRzclaK7+fPdad0sUO6LimED/hwJsojSzYlPcKExbEKYtyZToE5H2TOf0kw?=
 =?us-ascii?Q?3yOsAbg4UJg0iGMiyXZoJ0UqgObBPEZz4yg/O7aiwdpqtRPusACkk9aiGaq1?=
 =?us-ascii?Q?69CNcq8JACKdEJK5I4GmlPzFnhIFBYJmRCkrh3YVAFzEDo5pmDDWyZ7uuFyQ?=
 =?us-ascii?Q?tfgT326cq0WlubGtrJ0aERzJ1bkGILUOlA1hCUdSVEo9k9gXOgeGG7kj1qO5?=
 =?us-ascii?Q?XkSFbXI3rLJn8KGL8nKG/lGZjJ86xg7zFVSVC/1rRAe1PAnayftYUwMfwWGH?=
 =?us-ascii?Q?oPo9X4qlMaEGwlmeDAfj13M2hrkgPHKgBDY9mDpFp4eavZDkfaCv2W1qo7KA?=
 =?us-ascii?Q?ZszVMVnZ46Qr6KOB4T12FWkstT63+IuOSupNdRJ1VFYSS034h8n4MCjIz37a?=
 =?us-ascii?Q?/OpClMArnJEWUWeGgisiCHq9gaNRke5tAnddwUTeD82URMpyH9cZJEWur+m5?=
 =?us-ascii?Q?ETHOjgXoXdHtWm4QeAqQVxlNtJq53HY+++myiLJENbDZuKYOgGSmdBJvEvdM?=
 =?us-ascii?Q?j4EuPGec2f8DjWj4OcKtn6VGBGlTfQsGeSdD5aO8T9oy/Gf7/+aHX0+161by?=
 =?us-ascii?Q?2UvOf+sT1nT/v0g7bZHhQZK41akRbdDOfyNw02Amd6/ZjCK95wpDckY8a4IE?=
 =?us-ascii?Q?3/eGH5izL5dIWwCOf+/1MUH55dEMMA0YNS+l4s3?=
X-Microsoft-Antispam-Message-Info: RaQKadLEkCHGbEdNNkDb2fk2z9Pbvpt7dEXv+VJLbtSh/OdVmfHX1No3XwYO5Y60q6YN1MHk+/RedhQAlIBWRdcpI4hVMIJa20n34ME9r1gWtqDlnWbfF03jUafXbPLEUF0YfOzxy9QCc23hSwi1whAfnftnkhkKprWW78vBNmjPW/Q2wfml8sz74zzdXDED
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;6:4HGfhRUWPdF1EivLeAuf6qJQZl2A8njmpliLL5plXQRHOn2rAV+OZSvtpGobjiA1xfidO4I88K0KbDKOc27IvfDF6HTbnfdN7IgzT8SZeZe7MIOmJuXW74olVwYoxksvgtQrDFl5i02A0hoB4IGGMSQe0uyGYl5aJJuuuyITnRq72yAwFZ+k4Im4SCU+BgYookAKCrcbWlmLvvk80zlB41mAY+KT1fDqRr2fO7mjubd2q2ZvMs2pqRqsVSnfIYQrR2sYE8AUE0DVapiJaK+bgX3HIPwddWzFFuC2HNBui/eCigtMpK2y6XT3erJOUSMqqn7Clmz/h80v/11Os+PzHyZX2EaNHuAbfco9ubn4qXOhWmi2kwC8JR9OovaA6Q1MMJbSdxV7/fCAOSAzBGffHcR3AA4+jPviZmBDT+xxG2bzfWiD14iz9omRm8+5XW/K7HvpTB9/v22YaCUUcu8Ptg==;5:hmnFwWSfKBW0HrWs3oCCkLAZ5pSogb3L2lkIj4fDxKhyFBWv4Q3xlY/tA0PT6VLg+ipSkz7DZteaYZRO3uP5vo9klX9I+yhynj8/z02rO1BeGHr6Ng9GfJYFmWHqimdcNIVrpmRsj00c3Q+cSNw1uYqOZtnXUyMeoyqfIWGaGVY=;24:2mNPsq9BeE+DEke6wnTiZ6UCRCuc6qqAfhCN8mJwj6PojSQ274w5UCUo/IHFS3lGB2NaLKHdYds/jOIguHLmxNRCZf+rBdxzKOytDe9nSy4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;7:mf5eFOW8jm2KnhT7Hijons+OodEslMAvF5DsPzqhm6xD7cTxAaub6E/0ZhmeSo0i+qZbopdnk1B5dPZpOo4jCZ1eS6WYC0Dji11OJmh5lAKfBgbaGxboylF/woMvFwcxD4Bm+aGdYFuGUsx6XLGRE+OVg9C0gIdJPrCUQQ7es3xwlxCTWBZPsDaXzaAf02z1lHCRd/qllZNJM7iKzeZP32jRqXDgbO017ASYfz17XQ/fGPuVhv/QF+g3yqobNQIx;20:RG1sU35f82Y6PulCkU2aqI0I4navhbzKqTVh5kPoN/REQ4gErkUEib1ymAkSpuwv/5R51ljFK8nO8F2Inprsv2ffwoepT7vcpMCYyR6Up/RBNrrzPq2sLqYm/bvafEo95FSZt+F+d1LnFBfa5sVlWGxZMVHsFQAOqsP258hMGk4=
X-MS-Office365-Filtering-Correlation-Id: 85368fb5-4099-495e-7c4c-08d5a0792a94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 13:27:39.0528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85368fb5-4099-495e-7c4c-08d5a0792a94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently an attempt to set swap.max into a value lower
than the actual swap usage fails. And a user can't do much
with it, except turning off swap globally (using swapoff).

This is an actual problem we met in the production.
The default value for swap.max is "max", so turning swap on
globally may lead to swapping out in some cgroups.
As it's not possible to lower the allowed maximum,
it creates additional configuration issues.

For example, to disable swapping for a particular cgroup
it has to be re-created with memory.max set to 0.

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
index af9eed2e3e04..a0825cc61ee7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -186,6 +186,7 @@ struct mem_cgroup {
 
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
index 3e7942c301a8..bacb1fd17100 100644
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
@@ -1870,6 +1871,23 @@ static void high_work_func(struct work_struct *work)
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
@@ -4394,6 +4412,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		goto fail;
 
 	INIT_WORK(&memcg->high_work, high_work_func);
+	INIT_WORK(&memcg->swap_work, swap_work_func);
 	memcg->last_scanned_node = MAX_NUMNODES;
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
@@ -4529,6 +4548,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
+	cancel_work_sync(&memcg->swap_work);
 	mem_cgroup_remove_from_trees(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
@@ -6415,11 +6435,8 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
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
index 5a280972bd87..45ef9858645b 100644
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeCTWex (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:34:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58324 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751468AbeCTWes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:34:48 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC] mm: memory.low heirarchical behavior
Date: Tue, 20 Mar 2018 22:33:53 +0000
Message-ID: <20180320223353.5673-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:180::1:8fe7]
X-ClientProxiedBy: VI1PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:800:90::23) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c63e82a-ee86-4059-861d-08d58eb2be24
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:xWpIUACNc98fMo0DCdJrkrRj0xvZYxtQtnpLXeIt7/Tr6sHz9ojBgARiHLwMbzBSFR8f1zE30on2o73v9w7uTdPVENbDrjiW6u2JJWFnDd10re0D8WfEGE/hf7tV9ebUVCxyHxpGT6agyT/YnOd97Lug0x+33DV7c5T85fmxsvYj/NSpMScIqPag+acKU/6sQb40eKSS8QJuhjQR+IqZCNB57aGpxdG4Gxqy2dzzJq5z0Mk090lAhqWf/FuztFKK;25:5tNhqSUbrBEiccvQ97VdpAh3+efjBgeildOBpF16igg5LYrUQal3wYwZLnPZlsdtOW3bkayefsKZSOwf8d6eGLqfxy05cCDHZzV1vJxO7TTSq7kZzMNyO2xXYNXH3gQljr/LjPDof2tJ9VL/NG+fIMm+ZPnFYi4YViSetzHECTAOF3W6WkacbpE8RwBQW9pHrYWHcZJHXxMdrFN7aL3d8jwpF4oTQ0HbLF4wLNIlJQ08VDe9AjPwfgBnKQqE7MCDIzWGGuuJp3boyc0M6M+SGGKSzWVZoLpKWRbl6dgf4ramaK2n0syR1tR+AmqBD17S4GCmuPetDUYbns87aSYKaw==;31:+lAmbE/7BmQNniwJv0jsNr/aeo8SX26dP74B4W9pjkYc1Lxb9kuOB3RvIsHqA93q65pPjCvllpGPWO3BjxwkN7EF4kiPkBMnNItbjJRxVj2bTvjF4CHgbbb065oV5NpRrgad5s93FzcZ6fHJu8k8Zoz7jVpDldy3gmh+rMxj5XubnvgcQj+u3wiBcYWKsO56ikVMJ7PFYsgOg56/szu7wF0eSv48kPCiSd/OjSXaWAU=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:/0yQ/PWUK/u6FVXuTvMf0dPDk0AGcpJGkyHnyNHPe6pcdnCCjlMZyM2SEvmw2GNNv1QdV4HiUJhHw0C4e+b3sZasL9vyiLSdmSR6pSDqMY694WTLUFiN2QlhWkfTLjUleiflxIxIdpgoIYz5UEgOrsIqnHNdn36zFqXneqfnnrtO3a9opetVtf6mW4xxpL9nOrbWAfSVQi5mPNjVTj6tmwPXyCyMIjt/ZT0knRkUfDlyKNhyy9rSGB2bYUKGgrGNH8W8r3D2RSvDfUfMBb84rJmf3kxjp+BlRhzZL1Cknf/+wr8bDiL3bm4fidND25qd1qrDQHMyDISvA5l2OCWExYMPxpw0vCZGb+rL61bFXTN71eQE2DlSoTv6u3iPDGeX4o6yc2S8Hs/4mJ7L1Ta8RWiXBzf2P0qj/YE1gnrPXD4oDA+5FqzhNwRJp1AsJBTIep7xfVYddkcVVpBRh1MUUki2veNa9wFYA86scLkbBNefv4F5oVRKKj2DpISqwePI;4:QyZQbNe9kxADcubkrouiuJbPRbJu5WCIP3My9dconA8fG621YfjPhwvN7qaLPVIgSjyEUkgreZgz5DOylSwjnSexON9hVulQZQ7mgms2ODnIb+upFMmo3zcujmBGbsnnbrdnosbmjk+5xPI3tOb0j7NWkEH0qUEPJhVx1p9Ak8OZ1WRharHqH3aIgumybnhJL/kepcdkYHWRg+TztrQz5EtcQKPQ9Oc+7OUPOV5ZAAznvV3NCbHeJtp9WweIB9O0JDwXTzuh1D3SzARVeGl5agfDx4T2bQmvgwAaHAA1QYXHC7AHLF5aRYy7TzEbqSyJRSoxUHC88X66DBCzqR2OPRrADsAV8RvsNLcyXpTOeqUo42UBKaaPSl2rGm8Ewzgl
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077624D6A4879A852627C97BEAB0@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(11241501184)(944501316)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(48376002)(51416003)(39060400002)(54906003)(52116002)(47776003)(52396003)(46003)(316002)(6486002)(68736007)(4326008)(97736004)(105586002)(36756003)(2906002)(53416004)(6512007)(1076002)(50226002)(6916009)(106356001)(69596002)(6116002)(25786009)(53936002)(81156014)(2361001)(16526019)(8936002)(5660300001)(186003)(386003)(6506007)(81166006)(50466002)(7736002)(8676002)(2351001)(305945005)(16586007)(86362001)(59450400001)(6666003)(478600001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:VDau/1/f16sYSCZrFUFYKvcU+juGg9B8Ubip7wa5S?=
 =?us-ascii?Q?rPMjVeC/0PXpNfRxPUQaf1TEG36ZwT4qlqB7IE9s2H+efPEU+zR7pUU11Lek?=
 =?us-ascii?Q?8lEb+JQKNC8y94GBhD2PsRje4lkTbldo3kh9XkHKWiqdtdRzTYVdWLBOsVO1?=
 =?us-ascii?Q?oNUcGNR+PTP2daNfoAqnrfgVCreDLWCEq5lxzURnKo8CuHumB6wkxDzpVaA/?=
 =?us-ascii?Q?4ohCNrOiEzflkjmO3Xo7l9DIUs8U0J0FTb6eCEY6OJnSgobMlp7OGR1hsB8v?=
 =?us-ascii?Q?v0UALaXHmZ9d8I5xKMGvG8CguGmflH8KUkx6ZZbFNHgAWcjpLFdgs+q4fiYY?=
 =?us-ascii?Q?Sk1gR7CR9plbablkS2IcLA2D3i88peAaaJqmzGy6AxezITM24D797JYZLJJj?=
 =?us-ascii?Q?P72JkGHmNBKg0sob72hhB7TShcNqEQC9s+rjpdpKoYqGn85essQTQQthKxPk?=
 =?us-ascii?Q?v1WK2M2G4KSn78j3JX1cQAYCAbachLsXWzI2dss9KNY6R+v0Fs2JEDdPWsi5?=
 =?us-ascii?Q?XTHGb3MIfk49rGv8uHox1vojCkLKFAC0MX3lZJF0cemFSlgnIsxR91r5I2cD?=
 =?us-ascii?Q?re5qHv9YEiBB4MFtZP+H2E+gGi/yfWxw/iSq85/uicKf3/0SVvEgTkuvDKAV?=
 =?us-ascii?Q?S50v7/xYhazYRyd1poe2i+ydXMSdAjrEZ/jkNkXUk60czmAa64ewOkfikxOn?=
 =?us-ascii?Q?jMXHWnkT4KOKDvDH/1H4njtWwg4Cakkw1dNezQADI3AhJ/jGTeAPySpSc/Ra?=
 =?us-ascii?Q?51rcs/XPG4+gG5H/oTywUjeaFPJSb85Gg4V2Nwe0UXdXdlHxyp4M4IlT7gWl?=
 =?us-ascii?Q?mu+wduCqOAmrAEbG4sQdk7umkBj9JSKzGE6pPWucrXRB29Ti9CmyfsU/nn/b?=
 =?us-ascii?Q?4wLGmY26JVZwlrwNfj8hAAMadrAna2UoEq8wep9rB+DX38Co1zXpGvSJQgH7?=
 =?us-ascii?Q?PVvaJot3sbhiDVSyxnLid446I6q3pgtH8PMtiE+zD7BCy8LdwC1JsMNM0RhF?=
 =?us-ascii?Q?kU3hB5vb7c38duMoP1JAVLAk0frjgk5b+iqB+3Oh3+8OhPmKSag+Yn8Ab3CL?=
 =?us-ascii?Q?CkgO68s2cSxsBl49EXZSKm1nMTMds0jnbnbPCj5cYlxzxCgUxrMWvEMwXELD?=
 =?us-ascii?Q?NB19uJvgH/PmEnLZc4KYM9hFNjolnVx1FLGv4gca6WLHSaZxvyU6VNw35XAZ?=
 =?us-ascii?Q?MSyYFsnBmouo4zm1XqIwRmsK9113jJSvFTZHYNdw4GYUb9xWafOJw3JTA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: iTSUgoEvcb2c0YdZylOYkb2ZPL2zj2BXZ1bvDxOO5pGDsA5nFJuXm/XNy0Qe56ebS2ChA7OZm2/xTVEC9AZpZyASsqhAaFVc1gykRnvoOupKARkBkPrthTJaEjKPU/W/bna5z+4ShgmRfTICieUp6zMvh3dpO7Vk9OeCznMbbNsnkzOK0OZYB7NcIGLjpo4v
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:18I+hF0UF5L6S9IuJ5p+9r7dhwxlWpu8BXoJ9VSv2WnJqdUeUPPT6x/MDjr91EDsxvqXgGRxjJKRa2Pt5GGdReGEdeGHoTRM1vUhEMVLfGaH81nZ22+3LgI7tUigjvNBx+xG99VfPHF0x89sDI9vCuPtPb+/dJwQzpFEJ16qYEWAfVwiXxzV2bIsLxIxcG5McXFPJWQtMZUFRLwEQ62YNB/XF1zMK9f/2qevGx1qpG+d2loXtPicc5WD9ZmoZ6PjXY/RBpoYspkuIMhs8+Rqm4SdSPBg6gyggZnC0flgiMxOwjm2ZVZz4+qgqYyREqxs7fRhTDFYLJm80A7QdPj6IMm0SMfLTyxui0rLOIKaPIE=;5:SQgdz9LaMfyqt0QWnViReuTNpnuKj3FmbsMrwVIQFjkLqnU+mmE/W0Nfm363adLVSb4luL5KTBBatG50yPJxM/PMQAGX4D9Eg32X0WCBhxGrrI5klsk7PwPd4a724PZgHhiW3/dgUfiEpjVI+/O/LI2tSEx5+rsRby0tC4g1Tlc=;24:EOYHJwm23WcwtYOPdfWJbLZMa5SHE8O5zdJu8c8mbLaeLzG99L3MpL8y2ah0OW6y2a/CHNCBv5jTwYIChsPw2DsoT98kElLphkfCEy5Hhn4=;7:qApQpFxs+VXKLKpkFyx1imEWRz2IIKcFSYwXWpHsdR0V13A7U1Jq4OvtTrIKaxLZOSqdjBTuiBWu3cuAXQoCAuUFdi9dvLJnR/flfY/ez36UNw9NAVoADDhiqNSlKq8SlzJsgdbPKizZMPTltyN5ICmUCprT8cV4PRzTMworYhECh1WQpZYG1is84vwORt/HKucz+xYtlY+ZLmDBp9YrcpQeNO4Gyvm/S+r6SsWhDJaOn/Xwxh1IXlm/ce3506wW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:MuqJMRhYNI9d8LFN7nhzbrYbyze1bingQrfFxT0QzuAxFci8KjEApJquru5cwUMnw+h7Q0/xx81jK07/2XD8nJeb5aHPluvbDGGaaZna2VmjkGUDEz6qwXinPAty5E130gKmElJsg42zNPG8/KXN3fx23JC6Ma7d4GoXh752Goo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 22:34:26.1929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c63e82a-ee86-4059-861d-08d58eb2be24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to address an issue in current memory.low semantics,
which makes it hard to use it in a hierarchy, where some leaf memory
cgroups are more valuable than others.

For example, there are memcgs A, A/B, A/C, A/D and A/E:

  A      A/memory.low = 2G, A/memory.current = 6G
 //\\
BC  DE   B/memory.low = 3G  B/memory.usage = 2G
         C/memory.low = 1G  C/memory.usage = 2G
         D/memory.low = 0   D/memory.usage = 2G
	 E/memory.low = 10G E/memory.usage = 0

If we apply memory pressure, B, C and D are reclaimed at
the same pace while A's usage exceeds 2G.
This is obviously wrong, as B's usage is fully below B's memory.low,
and C has 1G of protection as well.
Also, A is pushed to the size, which is less than A's 2G memory.low,
which is also wrong.

A simple bash script (provided below) can be used to reproduce
the problem. Current results are:
  A:    1430097920
  A/B:  711929856
  A/C:  717426688
  A/D:  741376
  A/E:  0

To address the issue a concept of effective memory.low is introduced.
Effective memory.low is always equal or less than original memory.low.
In a case, when there is no memory.low overcommittment (and also for
top-level cgroups), these two values are equal.
Otherwise it's a part of parent's effective memory.low, calculated as
a cgroup's memory.low usage divided by sum of sibling's memory.low
usages (under memory.low usage I mean the size of actually protected
memory: memory.current if memory.current < memory.low, 0 otherwise).
It's necessary to track the actual usage, because otherwise an empty
cgroup with memory.low set (A/E in my example) will affect actual
memory distribution, which makes no sense.

Effective memory.low is always capped by memory.low, set by user.
That means it's not possible to become a larger guarantee than
memory.low set by a user, even if corresponding part of parent's
guarantee is larger. This matches existing semantics.

Calculating effective memory.low can be done in the reclaim path,
as we conveniently traversing the cgroup tree from top to bottom and
check memory.low on each level. So, it's a perfect place to calculate
effective memory low and save it to use it for children cgroups.

This also eliminates a need to traverse the cgroup tree from bottom
to top each time to check if parent's guarantee is not exceeded.

Setting/resetting effective memory.low is intentionally racy, but
it's fine and shouldn't lead to any significant differences in
actual memory distribution.

With this patch applied results are matching the expectations:
  A:    2146160640
  A/B:  1427795968
  A/C:  717705216
  A/D:  659456
  A/E:  0

Test script:
  #!/bin/bash

  CGPATH="/sys/fs/cgroup"

  truncate /file1 --size 2G
  truncate /file2 --size 2G
  truncate /file3 --size 2G
  truncate /file4 --size 50G

  mkdir "${CGPATH}/A"
  echo "+memory" > "${CGPATH}/A/cgroup.subtree_control"
  mkdir "${CGPATH}/A/B" "${CGPATH}/A/C" "${CGPATH}/A/D" "${CGPATH}/A/E"

  echo 2G > "${CGPATH}/A/memory.low"
  echo 3G > "${CGPATH}/A/B/memory.low"
  echo 1G > "${CGPATH}/A/C/memory.low"
  echo 0 > "${CGPATH}/A/D/memory.low"
  echo 10G > "${CGPATH}/A/E/memory.low"

  echo $$ > "${CGPATH}/A/B/cgroup.procs" && vmtouch -qt /file1
  echo $$ > "${CGPATH}/A/C/cgroup.procs" && vmtouch -qt /file2
  echo $$ > "${CGPATH}/A/D/cgroup.procs" && vmtouch -qt /file3
  echo $$ > "${CGPATH}/cgroup.procs" && vmtouch -qt /file4

  echo "A:   " `cat "${CGPATH}/A/memory.current"`
  echo "A/B: " `cat "${CGPATH}/A/B/memory.current"`
  echo "A/C: " `cat "${CGPATH}/A/C/memory.current"`
  echo "A/D: " `cat "${CGPATH}/A/D/memory.current"`
  echo "A/E: " `cat "${CGPATH}/A/E/memory.current"`

  rmdir "${CGPATH}/A/B" "${CGPATH}/A/C" "${CGPATH}/A/D" "${CGPATH}/A/E"
  rmdir "${CGPATH}/A"
  rm /file1 /file2 /file3 /file4

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memcontrol.h |  4 +++
 mm/memcontrol.c            | 64 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4525b4404a9e..a95a2e9938b2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -180,8 +180,12 @@ struct mem_cgroup {
 
 	/* Normal memory consumption range */
 	unsigned long low;
+	unsigned long e_low;
 	unsigned long high;
 
+	atomic_long_t low_usage;
+	atomic_long_t s_low_usage;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3801ac1fcfbc..5af3199451f0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1672,6 +1672,36 @@ void unlock_page_memcg(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
+static void memcg_update_low(struct mem_cgroup *memcg)
+{
+	unsigned long usage, low_usage, prev_low_usage;
+	struct mem_cgroup *parent;
+	long delta;
+
+	do {
+		parent = parent_mem_cgroup(memcg);
+		if (!parent || mem_cgroup_is_root(parent))
+			break;
+
+		if (!memcg->low && !atomic_long_read(&memcg->low_usage))
+			break;
+
+		usage = page_counter_read(&memcg->memory);
+		if (usage < memcg->low)
+			low_usage = usage;
+		else
+			low_usage = 0;
+
+		prev_low_usage = atomic_long_xchg(&memcg->low_usage, low_usage);
+		delta = low_usage - prev_low_usage;
+		if (delta == 0)
+			break;
+
+		atomic_long_add(delta, &parent->s_low_usage);
+
+	} while ((memcg = parent));
+}
+
 struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
@@ -1726,6 +1756,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&old->memsw, stock->nr_pages);
+		memcg_update_low(old);
 		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
@@ -2017,11 +2048,13 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
 	css_get_many(&memcg->css, nr_pages);
+	memcg_update_low(memcg);
 
 	return 0;
 
 done_restock:
 	css_get_many(&memcg->css, batch);
+	memcg_update_low(memcg);
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
 
@@ -2059,6 +2092,7 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 
+	memcg_update_low(memcg);
 	css_put_many(&memcg->css, nr_pages);
 }
 
@@ -2396,6 +2430,7 @@ void memcg_kmem_uncharge(struct page *page, int order)
 	if (PageKmemcg(page))
 		__ClearPageKmemcg(page);
 
+	memcg_update_low(memcg);
 	css_put_many(&memcg->css, nr_pages);
 }
 #endif /* !CONFIG_SLOB */
@@ -5642,6 +5677,9 @@ struct cgroup_subsys memory_cgrp_subsys = {
  */
 bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 {
+	unsigned long usage, low_usage, s_low_usage, p_e_low, e_low;
+	struct mem_cgroup *parent;
+
 	if (mem_cgroup_disabled())
 		return false;
 
@@ -5650,12 +5688,29 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 	if (memcg == root)
 		return false;
 
-	for (; memcg != root; memcg = parent_mem_cgroup(memcg)) {
-		if (page_counter_read(&memcg->memory) >= memcg->low)
-			return false;
+	e_low = memcg->low;
+	usage = page_counter_read(&memcg->memory);
+
+	parent = parent_mem_cgroup(memcg);
+	if (mem_cgroup_is_root(parent))
+		goto exit;
+
+	p_e_low = parent->e_low;
+	e_low = min(e_low, p_e_low);
+
+	if (e_low && p_e_low) {
+		low_usage = min(usage, memcg->low);
+		s_low_usage = atomic_long_read(&parent->s_low_usage);
+		if (!low_usage || !s_low_usage)
+			goto exit;
+
+		e_low = min(e_low, p_e_low * low_usage / s_low_usage);
 	}
 
-	return true;
+exit:
+	memcg->e_low = e_low;
+
+	return usage < e_low;
 }
 
 /**
@@ -5829,6 +5884,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
 			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
+		memcg_update_low(ug->memcg);
 	}
 
 	local_irq_save(flags);
-- 
2.14.3

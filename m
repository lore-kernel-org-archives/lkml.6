Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeCWQjN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:39:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751471AbeCWQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:39:10 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm: memory.low hierarchical behavior
Date: Fri, 23 Mar 2018 16:37:50 +0000
Message-ID: <20180323163750.8050-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321182308.GA28232@cmpxchg.org>
References: <20180321182308.GA28232@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:ed8c]
X-ClientProxiedBy: HE1PR09CA0080.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::24) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99dfa88d-8bd4-41e6-e3ac-08d590dc80f3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:HNKyIX+fpz7PTbqf8RUgb3pPSbbR7wVA7+tFvpNP34REfSmGIAIDxXVcUEJDYvEdHkaOeQ8efzsEjzFZuihiFiyo/dmEs5bGc9/rupL2u4LPLfUwI68VasQngCyW58uEkEttH0X1J8dOyfUJIZ878XqEpHTWg9fWUpvbdGAGg6oTJ/wkg4QwW+atmUAMmtphd1WkoN7r+6/IEfo8tKzN8R6lk+lWU3uzrVbb08kt013roEP/VkoaVFAmM9sE+uVP;25:jOXBTYAOgYkUF1swnbpMtYpVqF2Gaxs3gTqLDbqut4fELg9hYImkuROd5RZHqvP8QIpFFmY4U0UG68vP4A2VXD8eTaMQLQqYeRUO5qlUttQg3nIeWUpHI8VdvTqk7vObyd6ITJH4bzN1yiLb6xkhyOugQrVgDAPIjp6+KQTaZQB3gT1hasrmrvccAZ7HaeQW5zr1YIvQ8f5545h0AS8DDWO6CmDVObFPAawr2PxiUTV9Dx3n8ETo6ri+1DlyYzSJbVEy0vVij5n2aLEypUcf4I1RNfiAKQtXkRcT7Enw6sNd9d8fpu1bKrihVy7IM96CpLdScjM3MN+udmfmSXv+6w==;31:vRz4WYtgr5s4QJKWTg0z/r8sJD1jdK+CGrJglmnvcr4utE/zMG7aniSrO7LdLXe6N9qyEJ87E1gcTHWQY/XYAkVD67A0A6s6mPxoq35I2nNwhjCe1AV6nL/bVnNwQMuQ5BMV9u53TQxWDWHAFk9x7hr1Dfa20WoPfQddcWut47pTQl8Xm9HtznKDK1ar6xJQeQQJeYr8atXDe21KeNmFJ/yWLQ+3HA71Lz3joO9Oe9I=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:KLTpGpeSbSrhyW24/Xa3hJMic4PMyI93PbIjkj5mP0GBubmSyARvuLFzhwa/oXc6+huG+rSPvxBygQ0ihBeIrHu2MlZLKqwaxlwm5siAjou+RPs4kUGu7MRAwcxFyez1vvDn85IcWpQEMZZbGlkMtvtoNoT9qRV7id0R6XzGZ2n+eWPKFgPby7WvSJ6nIbsKRjYjs95xZL/6cdXUlRXXlfu5/Eub/wjWSEGxp64a+a5oEMl4/dB6Jc2eLzxT/PFiiFGjjmDK5ZjOZHyrS/AVBYcxOn8+evYDiI+rExXNkGF5UGh0mf2azfwdRjjdXqTEpuwMSXCEpl/YdQ4uZfexqWzoADt5F/5H/aZKcRC+aJ2dcsdC4JDX95ffjSOQvfLJNKZAcsbrW9wUafcXZ/ObFamtr6gWW1CDHPtcqol1eW1MlxukEaGyxMjq4evklUpyyqvUZavJLk/WcXDib28PcHewol3aKaMQUPukfLrl3fwN6OYBeiyEoWGFj8SGoRZa;4:qbhltRlmdagLuo3Ph3nln15TpYt9MKcJdWI+t35auSGE5/Dr9C96L1i160UQLN5Xt69vuOcZRxVA/6M3inVsW1w2RxiaELlTlnl1fBCfI74nzl+vBrbkzWr4a0UMi8RfGu0weLi2Y7vYsX32/CVlQxqi7j3hEpik7QOK4doxOutz8uVF4Bek2d/BUesTrD5anXBb7FTVmzqQ7cQ9STuxO7qDyyonDB5+/RsLBm/c7kf8e6Dh3nik9M1MCDf9pQVJvuye5enMMFaqPkwIoFu4wgqR0QAfyUS3vry1D6CaLUSfahdZbGnZ3FxTJkb34EBXuYWlW3KKm+eHE3cFZgJTdPQjPVkyqCGUIci0TCdXDNjsMhtivB4qsbVK64+QaWq1
X-Microsoft-Antispam-PRVS: <CO1PR15MB107813F34062CBED53D487FBBEA80@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(39380400002)(199004)(189003)(81166006)(6916009)(16526019)(2906002)(6666003)(386003)(478600001)(186003)(8936002)(50226002)(8676002)(2361001)(1076002)(81156014)(6512007)(53416004)(6506007)(11346002)(106356001)(105586002)(2351001)(6116002)(6486002)(53936002)(68736007)(50466002)(36756003)(25786009)(39060400002)(305945005)(4326008)(16586007)(76176011)(316002)(446003)(86362001)(52116002)(7736002)(47776003)(52396003)(54906003)(59450400001)(48376002)(46003)(69596002)(5660300001)(51416003)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:3QNKIuwMx0zGbIE7WbnW3/0FZoqhPpx9xSG8U9o/9?=
 =?us-ascii?Q?B88jpmAR0+R8W2nUoGR4U17TeogEhzWqne7tHQ0iP19KFRItcVl3UhaD6Fb4?=
 =?us-ascii?Q?+lp2dVtZWuTO+kqr9koj4ifBosRcXPisrMEXcd45lpkk0Zx+//NYTryDGkoT?=
 =?us-ascii?Q?sF/oZQ023l63AkdNAnbfG22CIa8N9DwGdcOuAwe56HL8FujOcoNk/Q18bNsO?=
 =?us-ascii?Q?aszViQo2ucDZbITxMWCiW8hxBAgmWYkNLnW9VTV+ROnElQhSpPYWtmv+uAxA?=
 =?us-ascii?Q?zUysCKB3mjvulcItTs/1QycdCdrWd+jISBkaN9d4Nx8PCReXEBXp1sms8xo7?=
 =?us-ascii?Q?+1ctYjUDC3sbGVnm2T6Dt+fjYZplYpWs9GBu+YVpzoRegLn7suzAHr4t9tMG?=
 =?us-ascii?Q?CGJRPqauUO5FHlFMfLMKJMFHQnlKBOYJk7mzVjqR8K2JvHURL6qCRlITsOtC?=
 =?us-ascii?Q?SA7tOjoP5kxQaJehodjl9V0/NY3JnS7SnKksc1A34C5GVco6ha+BfFOuxDEK?=
 =?us-ascii?Q?eTlcrJ6DgMSZYCezKMeJBkw3htBca6elCTa5wdwvVc6sD7BRt4Xel/JC8HcE?=
 =?us-ascii?Q?cz/iZlw0N2fIbUXQCq7z2IOTYHe1GzBGv3D8BSYq27WD/rnv6XRrn4uYT0BZ?=
 =?us-ascii?Q?eNJfipTkBbLhIKHqTV16DUtiZwhBp0uEM92pp2qKklwZHpnkCQ7Rr/yYGEO8?=
 =?us-ascii?Q?i2ArVJKaZtgXbdCCLVRu/Vk0OFZhoNNf6kjb3hw8SM7If3lMegHIvSXhzAbi?=
 =?us-ascii?Q?/5Dr2McniNshj+EPnvxGJ2eOZvs5m9yrAZrQpcLYAPEbSWJFpG+LP1FDH8g2?=
 =?us-ascii?Q?1Wilx243cYUgtZmENZVpk0HOl6yVMIkDN6BM0wUnIFaerK9a2cKGVZj+FckZ?=
 =?us-ascii?Q?42HOIElXOJIb8XUCS+W7MN6HX457vMMK9RMM0+auY0uKpBMk0nO8zqdzirTn?=
 =?us-ascii?Q?rAws+yzKaJ3htiNgfQ3ZES7qPzreuAXyTRrPJBJRI7YkXTlFlxf9SdYcQpeo?=
 =?us-ascii?Q?640Xhj8ePCYxsUewEL51ysIvmpo6CDl/+iCIywu5iqBVO8Y8ILQz6YU0rMtK?=
 =?us-ascii?Q?lDvvWZlM+8TpBjlIQaeZJNGAd8MFKvNNhhhrQQ2D0ozUZYCunw2GJOeFt/hD?=
 =?us-ascii?Q?x/vp1T6DrevldWWtYgq7BYKN3psriCt7nwxtzoTtfVX1cHY6HQJ/RGyGXFhv?=
 =?us-ascii?Q?kwk1mGsq0rexblVk2bjk2ZWsGi3gT/aUtRZJiU5lxk1ShywO6bbwOePWWANg?=
 =?us-ascii?Q?P22btMvRtE5sBJECOQryHbT3ZjUUmjGtIRX5jPU9t5mDAX8BInyPLfgmzlAR?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: ps4/NtTvmA56Lg5NlksdBL2QgQaqs8oTuiRJjoLU4KZybs9YFKt87H1UL9N8KPP7oIrbIILrfORRsW+2AzrLpopkBNfwZhyRbt6lDUEBjTDqYbAllm+/uj6kESsLmga6qr+T2rv4FU0wLJwHy96AVI7uoMnu/FzJSY5YEQInE7qYokuWLrQp8NpwAjX4GTru
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:BGyYW4OM7CY/IVkQiwUUr1pCC0IXqh5XYv4GHvr7vTNJEVMLB/Tohzi4wUtIFtICRdwb60mlxMhqVv4CDcGELIpGjrw88EUZKvD+vDzopDRBGdiLM8R/1J/mPLdDtecQPkDcBCwFs/fUU79o58NiFwNPrqWfHGHVR6fw7HV1uBZpdzl4+3tkWIyfBF80/qoM68ogSWgbLdasPTlwlozWFNMbhykKQfNO28VYijqCheHV4KqCwI4L7h6Yy/KYz7mB9e9rf2WvUMbOfmOraA7e6Qw0b5FxVvoQYET+JoRCRK4x/4/PJNO6dIcJJnSqV1PdVrHCYveIyl4nccvV+pnHqceq9QstTUUiyDTlQ2jTFSHmqRuP9pq0Lt1s/2mcS076k+hJQQEWZvCmkYajycKKV4gFb+3d/tdF/LrV+UgVv3TX14IqZOhUMNrOGs6IzZbCgQ0sRJL8AT52x4N09RWhVg==;5:gXXLe1jJEN7J6sXRrUl05HSVvMpDQcCOc12UNFHtKtxJbMz2uWLQ8SMAk0/lKeTxuNd0IC0lcQBYPCo0eeO5cbGkPf4Dv2X11v9DKQMZMQ90M9I+k4ekKH8ZrXntaSsoSjc2wMmy/YedyKR/URcP3XU8mNX2I0kPQkFi+QP4hxk=;24:ufmpdrPCDtSIGe54yyJ1Z7C+3YCQRE9jLC1oW0naEqO2EOoQrkEsOgctZD9qPLcb9rXbGEP/BtlQBPNWNA6rkipHnSKrkcWrvlRiP/rkzS0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:OdJE43mj56mCgNetc0c7e6qC5r+iy32kmZMkMgzIcXB3yXzaVL4Hq6/WdG/+Pv+FB/KeifjW4u1AogbWK4tdSGP6TrP0LC0pi3bnLFQrn/gAMlC1ebT5MDgO4moeq+CpbPCUKpTv8O6cRhQdS+NxeYh2kOhhiOhtBUOZWQ+re6z+6OiQ58UeujkjaG4IHJenHkgNDiA313q/5mHZmyqr96gj4tTyo28y/gCW0yK3laKxgipxFRS+hmiins01/yLf;20:13juHamBhDbl7SAI1oGF15sGSMHCrSHSUHJUrTIpMtCSLV3kw9Tr3oOfJzVpQteMHBwQo2nerbzdI7cAfekKZZlnDZ5KELvO/gG6M8h8lyOU0zO81BbN88V6uMEPVOQ96BSwnGmD5rERKiiTJfh3ZUd/d18EUVGNCK2XnK0i1Vo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 16:38:24.6120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dfa88d-8bd4-41e6-e3ac-08d590dc80f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-23_10:,,
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
BC  DE   B/memory.low = 3G  B/memory.current = 2G
         C/memory.low = 1G  C/memory.current = 2G
         D/memory.low = 0   D/memory.current = 2G
	 E/memory.low = 10G E/memory.current = 0

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
  A:    2143293440
  A/B:  1424736256
  A/C:  717766656
  A/D:  790528
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
 include/linux/memcontrol.h |   8 +++
 mm/memcontrol.c            | 140 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44422e1d3def..59873cb99093 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -182,6 +182,14 @@ struct mem_cgroup {
 	unsigned long low;
 	unsigned long high;
 
+	/*
+	 * Effective memory.low and memory.low usage tracking.
+	 * Please, refer to mem_cgroup_low() for more details.
+	 */
+	unsigned long elow;
+	atomic_long_t low_usage;
+	atomic_long_t children_low_usage;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 636f3dc7b53a..24afbf12b9a6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1663,6 +1663,36 @@ void unlock_page_memcg(struct page *page)
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
+		atomic_long_add(delta, &parent->children_low_usage);
+
+	} while ((memcg = parent));
+}
+
 struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
@@ -1717,6 +1747,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&old->memsw, stock->nr_pages);
+		memcg_update_low(old);
 		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
@@ -2008,11 +2039,13 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
 
@@ -2050,6 +2083,7 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
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
@@ -4500,6 +4535,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	spin_unlock(&memcg->event_list_lock);
 
 	memcg->low = 0;
+	memcg_update_low(memcg);
 
 	memcg_offline_kmem(memcg);
 	wb_memcg_offline(memcg);
@@ -4554,6 +4590,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_limit(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_limit(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	memcg->low = 0;
+	memcg_update_low(memcg);
 	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	memcg_wb_domain_size_changed(memcg);
@@ -5316,6 +5353,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 		return err;
 
 	memcg->low = low;
+	memcg_update_low(memcg);
 
 	return nbytes;
 }
@@ -5612,36 +5650,69 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
- * Returns %true if memory consumption of @memcg, and that of all
- * ancestors up to (but not including) @root, is below the normal range.
+ * Returns %true if memory consumption of @memcg is below the normal range.
+ *
+ * @root is exclusive; it is never low when looked at directly
  *
- * @root is exclusive; it is never low when looked at directly and isn't
- * checked when traversing the hierarchy.
+ * To provide a proper hierarchical behavior, effective memory.low value
+ * is used.
  *
- * Excluding @root enables using memory.low to prioritize memory usage
- * between cgroups within a subtree of the hierarchy that is limited by
- * memory.high or memory.max.
+ * Effective memory.low is always equal or less than the original memory.low.
+ * If there is no memory.low overcommittment (which is always true for
+ * top-level memory cgroups), these two values are equal.
+ * Otherwise, it's a part of parent's effective memory.low,
+ * calculated as a cgroup's memory.low usage divided by sum of sibling's
+ * memory.low usages, where memory.low usage is the size of actually
+ * protected memory.
  *
- * For example, given cgroup A with children B and C:
+ *                                             low_usage
+ * elow = min( memory.low, parent->elow * ------------------ ),
+ *                                        siblings_low_usage
  *
- *    A
- *   / \
- *  B   C
+ *             | memory.current, if memory.current < memory.low
+ * low_usage = |
+	       | 0, otherwise.
  *
- * and
  *
- *  1. A/memory.current > A/memory.high
- *  2. A/B/memory.current < A/B/memory.low
- *  3. A/C/memory.current >= A/C/memory.low
+ * Such definition of the effective memory.low provides the expected
+ * hierarchical behavior: parent's memory.low value is limiting
+ * children, unprotected memory is reclaimed first and cgroups,
+ * which are not using their guarantee do not affect actual memory
+ * distribution.
  *
- * As 'A' is high, i.e. triggers reclaim from 'A', and 'B' is low, we
- * should reclaim from 'C' until 'A' is no longer high or until we can
- * no longer reclaim from 'C'.  If 'A', i.e. @root, isn't excluded by
- * mem_cgroup_low when reclaming from 'A', then 'B' won't be considered
- * low and we will reclaim indiscriminately from both 'B' and 'C'.
+ * For example, if there are memcgs A, A/B, A/C, A/D and A/E:
+ *
+ *     A      A/memory.low = 2G, A/memory.current = 6G
+ *    //\\
+ *   BC  DE   B/memory.low = 3G  B/memory.current = 2G
+ *            C/memory.low = 1G  C/memory.current = 2G
+ *            D/memory.low = 0   D/memory.current = 2G
+ *            E/memory.low = 10G E/memory.current = 0
+ *
+ * and the memory pressure is applied, the following memory distribution
+ * is expected (approximately):
+ *
+ *     A/memory.current = 2G
+ *
+ *     B/memory.current = 1.3G
+ *     C/memory.current = 0.6G
+ *     D/memory.current = 0
+ *     E/memory.current = 0
+ *
+ * These calculations require constant tracking of the actual low usages
+ * (see memcg_update_low()), as well as recursive calculation of
+ * effective memory.low values. But as we do call mem_cgroup_low()
+ * path for each memory cgroup top-down from the reclaim,
+ * it's possible to optimize this part, and save calculated elow
+ * for next usage. This part is intentionally racy, but it's ok,
+ * as memory.low is a best-effort mechanism.
  */
 bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 {
+	unsigned long usage, low_usage, siblings_low_usage;
+	unsigned long elow, parent_elow;
+	struct mem_cgroup *parent;
+
 	if (mem_cgroup_disabled())
 		return false;
 
@@ -5650,12 +5721,30 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 	if (memcg == root)
 		return false;
 
-	for (; memcg != root; memcg = parent_mem_cgroup(memcg)) {
-		if (page_counter_read(&memcg->memory) >= memcg->low)
-			return false;
-	}
+	elow = memcg->low;
+	usage = page_counter_read(&memcg->memory);
 
-	return true;
+	parent = parent_mem_cgroup(memcg);
+	if (parent == root)
+		goto exit;
+
+	parent_elow = parent->elow;
+	elow = min(elow, parent_elow);
+
+	if (!elow || !parent_elow)
+		goto exit;
+
+	low_usage = min(usage, memcg->low);
+	siblings_low_usage = atomic_long_read(&parent->children_low_usage);
+	if (!low_usage || !siblings_low_usage)
+		goto exit;
+
+	elow = min(elow, parent_elow * low_usage / siblings_low_usage);
+
+exit:
+	memcg->elow = elow;
+
+	return usage < elow;
 }
 
 /**
@@ -5829,6 +5918,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
 			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
+		memcg_update_low(ug->memcg);
 	}
 
 	local_irq_save(flags);
-- 
2.14.3

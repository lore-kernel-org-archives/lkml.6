Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDETBk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:01:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35912 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751802AbeDETBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:01:37 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] mm: memory.low hierarchical behavior
Date: Thu, 5 Apr 2018 19:59:19 +0100
Message-ID: <20180405185921.4942-2-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180405185921.4942-1-guro@fb.com>
References: <20180405185921.4942-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:c820]
X-ClientProxiedBy: DB6PR0601CA0040.eurprd06.prod.outlook.com
 (2603:10a6:4:17::26) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8718194d-8db5-420b-f927-08d59b2766b3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:iISq4jQHaFvjh636DNoqNS9snd5z1yLNxkpG6tBRFIT3uG+VdMp9vowx9XrC77lAszapmfc7jp92RWWSPODXITffUw4Xf/gDhAnXcJrLoVy34luWCwBgO9f/CkIh5eOrmzionTqtcU0JkQlnSM1uQ4B7v4INRa5aLoNy8mcbRYgp6PO91WioMm2MoXQ+5QEO1QeueAaBmwZps0OTTVqBA62sWIwc/0tQ63/az9Bvu9EtxF9/FplcRSzVx5/VNirO;25:xVe0VUYH9HUqLqvJtb1Pc5mBMPDVUPGMatcfeBbKmt7a7VCULLul5Z8x5uKR/pdZ0MkJl3znajsEzveeCiiuPHU3GKIvgVmIKFHE1JEL1/VDAAwaHi8Cls/li8PMn1GXQdUGR7v6tvaM+meYfhA19f9apzRf1WqWzgg63EqGEcTLK9bfQdLnk/hwKcYjg1lezZWT9AV37Fvcm32b+aQwv633eLtK8hAZcfzKbGRaSWUuqMZ3iizYy/xqVkSWX2a532XviL+AWlBBkhnKhn05eH71VYp3mcIc2E8SJpeX/2K8pv1yQyt/QSmIIWvAyKiqIvB5mh3fvLVXtYjJ2PDvAA==;31:1C2DWP5DBuT2Iw5IBwPSCxc5J6IIP0NK1epg6NPBLX+WJmth+x66zwLIUZNgyS91xkMLwmaEZFosxiXMykvF8eUZ8NAL3Be+O3BZB6HXwDvDQU3hNJt6nbG+oxFclXDD1ZT7wxyAe63XQzvpZunD3Duu867AIs7/peTapMzFa/nsKPI0cnILgXOYtjYuco7cLjy/bhfkdcTRvduXtHorrryhTWnpWP+jM5FpiAsY2kE=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:Cj713V4WfAyUob8mH5kbqaUY0TkGOSZ3Gt2dR57CCdxVoXjI9tTfMXXXUZtKgDp/ao/oLA2dpNf9o3GmVll0+YYMf5ds69nfkEdrs8TeqtkgCPcuZP0odCMXFOMQPgFT7pZk4bf4tOiH3NPv94ZbRslEYEoxO7NkRPfvnH7vvD+R9/rMyvKw+MLL/9hbdCSsXTbH7qoX6hSlZvLBKbAbYJieyI/ySueRZyhCNv4FtGeGOq+Wk+ca1CSDi4UgV8SWCkpMSdwailqfQ2KgeQFl1nF9UjvVPCBdY7bKne7CQx7wkaappRdRIB/PLeK8R7L/g0sqJxVfMTEuY5y087xaKXX/QFtLPIvHo6zS4o2xQtl4Ceh4XtGr57zX0sB2ZnsqTXtelfNoWB8a8vDMH/V7i9JKG1g0nql5x5QCVVw5xsMZhOWBuDrJdRZiSIkp9x2mFz8etLCeTipPUmKzk0FE76nWUHU1K8n1b9e5nwfRhTQmS7cIHPtCxVIoSLYy1Cat;4:TjIzKsx5uOoAsjWj8knKG0UiRPk7bNXItrN+cNGXTqVaBs3JhC1WXBiD0lOisrpALh2HCkQNcf2RUftbnrRB9TZGTBQq6NsB0lTWF68u4B7pbEV/2Nn86sYR7Ffnpu2diliNBW2dM8NalVC3kmc0cvHkVRzlZaWAGaMHmjs7T+k8r8vqOEItUNQQdi7j/NQm+Az5CGOfZ3jU65ALW/FjK7pHAEaQhuqwWrcfASZOLD3cVKD3ir7bO/Zs7o4EIsw8MuVtpHo6wXGkSkcHQrJeLLdNEoUJ2lyPfy+U3+nN0SKOEdepIJ730WWvGmil8cIFCFErLfZecUhD5JI6Ukp7xaxRFqDU0XHwYfHErTGxpHG4yZ7C2QU2UdDQMpwHW8Pq
X-Microsoft-Antispam-PRVS: <CO1PR15MB10780BD609043F700E0B4EB5BEBB0@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(2361001)(2906002)(316002)(5660300001)(76176011)(69596002)(51416003)(52116002)(446003)(52396003)(106356001)(47776003)(11346002)(86362001)(46003)(68736007)(305945005)(6116002)(486006)(478600001)(7736002)(16586007)(59450400001)(50466002)(39060400002)(1076002)(48376002)(36756003)(6916009)(2616005)(6506007)(53416004)(50226002)(6666003)(4326008)(8936002)(54906003)(476003)(97736004)(186003)(25786009)(6512007)(53936002)(16526019)(2351001)(81156014)(105586002)(81166006)(386003)(8676002)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:ChAtfqLbUGfHlg5FAyIkPXN4lOX5PxtvR/GgxlKcU?=
 =?us-ascii?Q?l1D4kM+Ku1x0qEPifQ7bMe6gKZw6ntXzFVt0fTYV7wx6Ci+aLokBWo8qBAkC?=
 =?us-ascii?Q?EBzecATC+WHujeDIVSq89cotIB9IoLeLOaYqwT08i8Lesiesf0/2P7leAKso?=
 =?us-ascii?Q?sibLydIDkLPd5gO7xtSDG7/ZT1vrXyWejPhbR4Jt+y3atFi+CLVLAA1vRBNw?=
 =?us-ascii?Q?WDrufelUSBdgibjLorVuENgxDBMhAokIvn4U4GrbOgDzGQ/DrS0MuPD1uacj?=
 =?us-ascii?Q?/rNulwnnM7vQORiHodzgJvgqxPtwbNe+VPc8dvAGPf4bAXW3jIYS/VW/aVWb?=
 =?us-ascii?Q?zaVlRFPTWi88hmSXJVSkIsFR3/Q0eFK5zeIdHGaSVeBpmB8LYt1Aj3XOsYbD?=
 =?us-ascii?Q?Svc3dTR6GxuxPsN6SWmjNNjALvl7y2nRcs7BcVnPedsWsrGo/LtgdgH/I0jw?=
 =?us-ascii?Q?2Ru7AvLDUcwI4bJEfRwxvK8SCN2+yaZA86nNwieURQEWzLkbcqMU+sSsqlM+?=
 =?us-ascii?Q?7hbyCUu0M3AJz7EFSwq9U+wpQFxHRkJAdNYvdkI9+MWDIzbcNghPSccUxFjP?=
 =?us-ascii?Q?byFfnM7JRES3h6XGsw+iReND68orHaEYFXAgJ9NoReS51OB400kvUIsLmn7q?=
 =?us-ascii?Q?nac44hxsZHFbDxrZ59I4ZVwnBwACodv6b6yTzvJiMbcprFt6eNVRGHdbAlw7?=
 =?us-ascii?Q?g0L5b8fQt9pKqCRU0/oj7C6Pp7nWSc54osxbJArOGfNh70RV6v83no4HM7mZ?=
 =?us-ascii?Q?AuDC3Lo1hgUJBYclzcG81wg/IWtsDN88a+FNN7U30XZF03vBMTnvJTUmkPfT?=
 =?us-ascii?Q?KxFNSJbCHnfydSjHj+pkk6y0b+dVndcFjdVvN95KDh4DBL5O8P6m7H7LMd8c?=
 =?us-ascii?Q?oPM/PKAWnKLTGM2tzCwoDuovANuQy5/uuN7BSpvGNxGRiS6gxF2iq4oDLM2I?=
 =?us-ascii?Q?XBm2wGnEy+P5edOaRQRqwfNjF7kHStSYK3pEgwEu/27KjIqdkSHiHL7gjYVM?=
 =?us-ascii?Q?s1WZ+c8gJWHkoZvsN0DYWVSsvw0Z7M9TqRHfo2sijCU5wY5ARKFOFsbOQBmL?=
 =?us-ascii?Q?Nl73oROaLw3YCWrRM7dCXop2xQCTydRD6yAaQRjlMZvhu4oeNuRNfnCDFLeU?=
 =?us-ascii?Q?z7PX/6xEDc8/gEFtrbk8VX3bGTrrzGTL4TMOZEnEN9jo9uYh/RjfvsdbeZdd?=
 =?us-ascii?Q?aZZBehFbvd9PuO95NvzvaA8ZvLKhhke6NosXfwDX+KCSEABolP3ECis7Kn+s?=
 =?us-ascii?Q?zuriDFB6Y96sAmPCqDTWd0xGQ/4fZmk3mNHO6M6ajB0DGkSjyDIDpZL9BGWP?=
 =?us-ascii?Q?V/std/SKKs6gytxVV8r8bDOnD/Pn8xAIwnSk1LSs5d5?=
X-Microsoft-Antispam-Message-Info: WeY/bQLk13dcqdfOLWi2HbYeZ9jygEBSCMDff64Eo1UevoUft6aRfY50SrE7Oo1o4jFsa14+9yEZhB22Y5+jwO/jxzhF5X293QId8OcNTgLczJuX5BMFxa7mQd/BRXzsxEf+hKk0Os6fpbHT/orvXuEJqCd4oZs04kxXlHkf3+PXSETyFNPCSfbtq5DpeHAN
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:yUCVa+JPquNne63Zoy6H4J8oCbhlYUxwOM8iKhzcDDWbUCD4LMj7tQb0UHpiJlGqXu0UYV8CkTO2isTQjPz6F5H/toEzwzeOYpOOUJ23cdIOytoRKmXkuFza7IrGnYgz4jYyz76ANVUeNkI26c4EnFnJwONqDkyI5hflx6H3l6daen0xI8iFlosUyVKLwElEVSPw1iEvVxrRBrfeAs/SGXL56Qqar/qT8Yu4s9UD9GdrSoJRoefy2cGvFkILTv+swsB+AZRpAN8YMtw849QIAEM9xsgrD2Jra8GZE1w+40nceyDfT9BCFdAjUa3UmCvBop4dRDML/DIoD/JgvzVvbgL4pe3DJPRsImWqrJH5DBeP7CU2k5NwWGxk61t+U8pAVs+br9Tr35TTVSnDmhXqpoFd2D85aQ2L4E5t6T3ymte4bbi8YXxZWHeZzLjXb9Twg8Oi/TE5aE17062jrgrq+g==;5:lAmC5U2HwGubgyagTa/hI1rJgOv53Wz7TWQdvtUqa5jk0dJs2S0H1MnDUAZVeVegA2BKdvIEWHtfknSt8xuO7zdf5M6iaYhgQTMFLqBVYeZxu/7DR34oXIPqvS7egFa3KpLRI9pk/FsMC4a/keAzsJJNjob1u4/oLuw1WAvIEfk=;24:lLrUOd23qp89yeFO6pjvQBdkzi3+qACnzF7nh6TIdoXw+xpcEzSL8MoPTQTS7+nHx5gZocaskJC9xRxXfXtqF8KNwmZVvE1aYqzGz2l1f7s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:/6EX4TOGszaCp6vyBmV3wuNCuuAgDdcsmo8qWSlZ0kgWQyC/4lVDeGWPmBbvnLTeDjMCfHsIfQkcUBGja2QXCjZOk176udiQqfayxgPpKJ0MixuaLAjg6eMebgYgBR0T0AamY8z9iCcPF5hDIkKoQeVonxXXuKsNufeZb6dm9RJw8tbYeIHVUvQStUn2BvSrbHF2cUfyWfy3TChZ8R7V8scVIUuQ4ceD+ctfRTXQCdJfc4YUnpPllt2OdMfzIKp4;20:9CbI+05Ut1j0OTKBheKFWP/32/zfwjypZ3hYQmNv0h6KH20O88x8P22IxxhZgcVtKwbRZ+1O67pwbXvjUtsDS+6AZ8jr+de7SQEtjkSKipH52vWyvhqHMbWwMaf+jC2Zfm+ZIGIm0RwBLJO2pkMk4mkPi8We8uc6ScHSagt9I+Y=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 18:59:45.2674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8718194d-8db5-420b-f927-08d59b2766b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_09:,,
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
memory distribution, which makes no sense. To avoid traversing
the cgroup tree twice, page_counters code is reused.

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
  A:    2147930112
  A/B:  1428721664
  A/C:  718393344
  A/D:  815104
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
 include/linux/memcontrol.h   |   3 +-
 include/linux/page_counter.h |   7 +++
 mm/memcontrol.c              | 112 ++++++++++++++++++++++++++++++++-----------
 mm/page_counter.c            |  43 +++++++++++++++++
 4 files changed, 134 insertions(+), 31 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index caa31cc09e7e..0dfda3ac6e70 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -178,8 +178,7 @@ struct mem_cgroup {
 	struct page_counter kmem;
 	struct page_counter tcpmem;
 
-	/* Normal memory consumption range */
-	unsigned long low;
+	/* Upper bound of normal memory consumption range */
 	unsigned long high;
 
 	/* Range enforcement for interrupt charges */
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 94029dad9317..7902a727d3b6 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -9,8 +9,14 @@
 struct page_counter {
 	atomic_long_t usage;
 	unsigned long max;
+	unsigned long low;
 	struct page_counter *parent;
 
+	/* effective memory.low and memory.low usage tracking */
+	unsigned long elow;
+	atomic_long_t low_usage;
+	atomic_long_t children_low_usage;
+
 	/* legacy */
 	unsigned long watermark;
 	unsigned long failcnt;
@@ -42,6 +48,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     struct page_counter **fail);
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 50d1ad6a8fdb..78cf21f2a943 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4499,7 +4499,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	}
 	spin_unlock(&memcg->event_list_lock);
 
-	memcg->low = 0;
+	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
 	wb_memcg_offline(memcg);
@@ -4548,12 +4548,12 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	memcg->low = 0;
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
+	page_counter_set_low(&memcg->memory, 0);
 	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	memcg_wb_domain_size_changed(memcg);
@@ -5293,7 +5293,7 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 static int memory_low_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long low = READ_ONCE(memcg->low);
+	unsigned long low = READ_ONCE(memcg->memory.low);
 
 	if (low == PAGE_COUNTER_MAX)
 		seq_puts(m, "max\n");
@@ -5315,7 +5315,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	memcg->low = low;
+	page_counter_set_low(&memcg->memory, low);
 
 	return nbytes;
 }
@@ -5612,36 +5612,72 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
- * Returns %true if memory consumption of @memcg, and that of all
- * ancestors up to (but not including) @root, is below the normal range.
+ * WARNING: This function is not stateless! It can only be used as part
+ *          of a top-down tree iteration, not for isolated queries.
  *
- * @root is exclusive; it is never low when looked at directly and isn't
- * checked when traversing the hierarchy.
+ * Returns %true if memory consumption of @memcg is below the normal range.
  *
- * Excluding @root enables using memory.low to prioritize memory usage
- * between cgroups within a subtree of the hierarchy that is limited by
- * memory.high or memory.max.
+ * @root is exclusive; it is never low when looked at directly
  *
- * For example, given cgroup A with children B and C:
+ * To provide a proper hierarchical behavior, effective memory.low value
+ * is used.
  *
- *    A
- *   / \
- *  B   C
+ * Effective memory.low is always equal or less than the original memory.low.
+ * If there is no memory.low overcommittment (which is always true for
+ * top-level memory cgroups), these two values are equal.
+ * Otherwise, it's a part of parent's effective memory.low,
+ * calculated as a cgroup's memory.low usage divided by sum of sibling's
+ * memory.low usages, where memory.low usage is the size of actually
+ * protected memory.
  *
- * and
+ *                                             low_usage
+ * elow = min( memory.low, parent->elow * ------------------ ),
+ *                                        siblings_low_usage
  *
- *  1. A/memory.current > A/memory.high
- *  2. A/B/memory.current < A/B/memory.low
- *  3. A/C/memory.current >= A/C/memory.low
+ *             | memory.current, if memory.current < memory.low
+ * low_usage = |
+	       | 0, otherwise.
  *
- * As 'A' is high, i.e. triggers reclaim from 'A', and 'B' is low, we
- * should reclaim from 'C' until 'A' is no longer high or until we can
- * no longer reclaim from 'C'.  If 'A', i.e. @root, isn't excluded by
- * mem_cgroup_low when reclaming from 'A', then 'B' won't be considered
- * low and we will reclaim indiscriminately from both 'B' and 'C'.
+ *
+ * Such definition of the effective memory.low provides the expected
+ * hierarchical behavior: parent's memory.low value is limiting
+ * children, unprotected memory is reclaimed first and cgroups,
+ * which are not using their guarantee do not affect actual memory
+ * distribution.
+ *
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
+ * (see propagate_low_usage()), as well as recursive calculation of
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
 
@@ -5650,12 +5686,30 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 	if (memcg == root)
 		return false;
 
-	for (; memcg != root; memcg = parent_mem_cgroup(memcg)) {
-		if (page_counter_read(&memcg->memory) >= memcg->low)
-			return false;
-	}
+	elow = memcg->memory.low;
+	usage = page_counter_read(&memcg->memory);
+	parent = parent_mem_cgroup(memcg);
 
-	return true;
+	if (parent == root)
+		goto exit;
+
+	parent_elow = READ_ONCE(parent->memory.elow);
+	elow = min(elow, parent_elow);
+
+	if (!elow || !parent_elow)
+		goto exit;
+
+	low_usage = min(usage, memcg->memory.low);
+	siblings_low_usage = atomic_long_read(
+		&parent->memory.children_low_usage);
+
+	if (!low_usage || !siblings_low_usage)
+		goto exit;
+
+	elow = min(elow, parent_elow * low_usage / siblings_low_usage);
+exit:
+	memcg->memory.elow = elow;
+	return usage < elow;
 }
 
 /**
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 41937c9a9d11..a5ff4cbc355a 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -13,6 +13,28 @@
 #include <linux/bug.h>
 #include <asm/page.h>
 
+static void propagate_low_usage(struct page_counter *c, unsigned long usage)
+{
+	unsigned long low_usage, old;
+	long delta;
+
+	if (!c->parent)
+		return;
+
+	if (!c->low && !atomic_long_read(&c->low_usage))
+		return;
+
+	if (usage <= c->low)
+		low_usage = usage;
+	else
+		low_usage = 0;
+
+	old = atomic_long_xchg(&c->low_usage, low_usage);
+	delta = low_usage - old;
+	if (delta)
+		atomic_long_add(delta, &c->parent->children_low_usage);
+}
+
 /**
  * page_counter_cancel - take pages out of the local counter
  * @counter: counter
@@ -23,6 +45,7 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 	long new;
 
 	new = atomic_long_sub_return(nr_pages, &counter->usage);
+	propagate_low_usage(counter, new);
 	/* More uncharges than charges? */
 	WARN_ON_ONCE(new < 0);
 }
@@ -42,6 +65,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		long new;
 
 		new = atomic_long_add_return(nr_pages, &c->usage);
+		propagate_low_usage(counter, new);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -85,6 +109,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 		new = atomic_long_add_return(nr_pages, &c->usage);
 		if (new > c->max) {
 			atomic_long_sub(nr_pages, &c->usage);
+			propagate_low_usage(counter, new);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt.
@@ -93,6 +118,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			*fail = c;
 			goto failed;
 		}
+		propagate_low_usage(counter, new);
 		/*
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
@@ -164,6 +190,23 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 	}
 }
 
+/**
+ * page_counter_set_low - set the amount of protected memory
+ * @counter: counter
+ * @nr_pages: value to set
+ *
+ * The caller must serialize invocations on the same counter.
+ */
+void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
+{
+	struct page_counter *c;
+
+	counter->low = nr_pages;
+
+	for (c = counter; c; c = c->parent)
+		propagate_low_usage(c, atomic_long_read(&c->usage));
+}
+
 /**
  * page_counter_memparse - memparse() for page counter limits
  * @buf: string to parse
-- 
2.14.3

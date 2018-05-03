Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeECLpP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:45:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750947AbeECLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:45:13 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 2/2] mm: ignore memory.min of abandoned memory cgroups
Date: Thu, 3 May 2018 12:43:58 +0100
Message-ID: <20180503114358.7952-2-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180503114358.7952-1-guro@fb.com>
References: <20180503114358.7952-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:d1b9]
X-ClientProxiedBy: AM5PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:203:69::34) To CO1PR15MB1079.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1079;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;3:kY8zUXG93gCqxTSY8DrldqzUX5Lca0OAepJ6ITq++AysKSWfdJBtKG2/OrJt/vAKcekYJGw0euKF61DglLaCaURYc0SltpZGs64W+VbMO/CjtxSq+yMFiFpqzCo3LWkNkhWJen8LLryhpB6/27LJyq9khYIv+dlCBdLBYIXBmpw+pjBFrT6RGp3+0gdjIAw5tmigmf0UJe1GKb4ta+LawDVHKprnYSqMZ96jsQ5aDGeIqOzZkvZAumQo3+UPo/7Z;25:SWS9JzMRXwnYzH89nnuUZBU44cC0Av/9r6WMUKWZ0QQYbYUhZx6XvJM4dkghIow1t1V/OOJ62xprC9B4qtPRFTpemwLtF84f0xqmoq97osjtjHvDRY9QqucB4D/rnSOgtn9kCleSWoQ/khEIDb0kwYgMhxGzEKVApzlEXJ2nylOM0UjAzBBNVEOj9yeIt4QJjd5808ac/oqX2wBJA/zwaqqQxZHL9tw4CXEQ+CFVmxQzB4hq4e9efwD+AwwYylq7rqo9rnlecXP5cFizBVEW+vK19pv5klDee/AYd2Hbfn2fMcH5X+6dtdrWwi7uB9pSVIWuIfDdWqPr83p0asM7IA==;31:RNt0iGq3HIcM4wOtaaUmZwNdXPMK9lTGX3/koOhYepWlQhbI98guDE1DdwWxaursUJ1eotLc0BonMTX8eWAdVRo+B6VqWTqdBOXf6jprFW/ELFbRl2k+mcZPAgyK7cln1IqAKXvjmZQNT2wx2pUNn7a2GV+cA6e+EgWl9SyyNHoyGC8nDD+AuMzCnocv8c9iWe7DKgnVveOcBOGrVA+18VUyP62yOJc7OCpIQGicyVw=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1079:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;20:O2IUfD0b8IDJApQh/JAFS85SUNt/3pWVKz4IKDbLtjjLcg7ui763XJcqbT4pn2cyRDeiYoOJxdizNLVfQhepKkCQ+PuCg7f0ccsRGSQ94npC7aglNtt53cBocTtbWzzYxvLV84Mawb5Hwmz4yFJHI52f+ouVXjtgqUWJCoH/vYPROt6vvBMbeLgC0FLt6ihERocvaBXjdSTIVLRRhG+FTSUDY8rFXH4FdhAE1Gv97HTTmurx3ut04Lj/KEVcgegmzbcQ8PuRgRiPfy1xlnP3Oq4AEKIsYEP5vUDpIzYzUJ+1WhR60R8QFTduGAuisSCs5K739L+B7hmV0+OaMDGkAfmm0QiBzkxgqj4gNilCYJREMb1ZYA/EijpJnF301QV8ZSI0Lu2Tc1QpCvT2dWHs6Ou/MGV68DUA0jnnqr1VnG0msul5dVyPDdfUxuuoMYHKTa17Dutu67d9A3suBtLE7rxr570HETEvGkfZTkoaefzniivUVlh81g2YUav7DsRH;4:Uo0a68ij+ex3PBC6jgLxYX7h2HqDmHpTtakItVbY1vPcKQNGUeLt/pAggHKXOqsehOA4I+lrALEVf1jqpR3niGP4eYTFlPG46sM53+XALy8h6s20gKm2W0CP/Tr4WvULMGt/L2/LxHu8vrCHoT/gq5p9SmaEOU8rCmz7Ou6SUaQMEYULkpoc9/rTRP9Q4VHLFFEsFfS9YiOuKjohYiryY0BC3NmV817BaFquGH4lZouXDfq0/Tu1GVQXl75zgx+ZCf0jAR6XDeUi5X0KSPZQBa+NZsZY6yzWujbzfQ+BRppHHcg+nWTCGHORvXjSjQrJ1qdt1COA91ZTmpl8bMp/7+tccHdKYT2eVLmEycq8a7U=
X-Microsoft-Antispam-PRVS: <CO1PR15MB107909AB64A5CBE2A11F0676BE870@CO1PR15MB1079.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1079;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1079;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(199004)(189003)(2361001)(59450400001)(97736004)(106356001)(50466002)(16526019)(305945005)(68736007)(4326008)(186003)(2351001)(86362001)(105586002)(2906002)(5660300001)(48376002)(53936002)(53416004)(1076002)(46003)(39060400002)(2616005)(11346002)(446003)(476003)(486006)(52396003)(52116002)(69596002)(47776003)(25786009)(6916009)(81166006)(81156014)(6512007)(6116002)(6506007)(36756003)(76176011)(6666003)(478600001)(8676002)(386003)(50226002)(51416003)(8936002)(54906003)(316002)(7736002)(6486002)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1079;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1079;23:Ku7zxunQ5rRy52/sH1p6jqLbyyTGdBoRksQ/ofUat?=
 =?us-ascii?Q?tobE+etebaqAVfle3JsljEIzu4SP93QOu7FuzATVKpbmP27T+e+WYFk+VgN6?=
 =?us-ascii?Q?la8+bkKwDn48EbkDnZE2EjvSBS3Org7JVqn1XHyTzdMy49SlWTI8mNh+efxW?=
 =?us-ascii?Q?kDV80/IRjAZXMxF0WOHxHG/jR1D0Oglc/rB5JSDOuQqwCnmxP7+wbA7W5sxX?=
 =?us-ascii?Q?M++QsGfxnCK8SizP/LAiZ18Xcv2npZEmpirhmSZASUaw+w/EaN63jsA2HYZU?=
 =?us-ascii?Q?tjGeiPc0fAB5KDoYUNVifZ3OImbC/r7B8LAKIDPrcJ0Ds/UFmxNiN3KZsxZw?=
 =?us-ascii?Q?hxJzO+Dyz7H8UKjG7f8YHppnAJ+H/GGND8TPddIQukbtt4n89d0srdO/7cop?=
 =?us-ascii?Q?CIOy9bcR8rs2mooZi4mYRYHyeAxN3K+rshsatoATw82vkErihhGYTtYMrC0L?=
 =?us-ascii?Q?Gfi4Op9e4dcf290QmM8s/vHs+7bWyMbj67AVi/S4xLSV6oVKYDloCj7kfw4g?=
 =?us-ascii?Q?TQXmCqv02MGI9qU+pcb4wyExk/MWF3g5djFoCRLwMtjRjBcqWlJqwfCO3Ajw?=
 =?us-ascii?Q?oSHp48Qo2ks4shjk5SPg6s1z3Yn3FlOqwPWuhmBHRs3eHk8HGbfIr+V+oSWo?=
 =?us-ascii?Q?g55iQuDgd7djuFS3/N4qoVxfM0rRPssEYiNi9qXmqUtRUlrkDC02UP2GpcLX?=
 =?us-ascii?Q?U4FMQojfX91T6QXoUlb6ypm6NlB0szF90KYPKR8jb5B1B8VBeBLQ1X4Cnq+7?=
 =?us-ascii?Q?Rx+X8ypD2GBuum3VHRx9N21Cx8y1HSiaC6n7DZb2pkDITXj2qDyp5amPAvkX?=
 =?us-ascii?Q?4/LSRHaiJ2U6MRD/XOiH+34nMgiuHoOWEVaF8D/UeBptTDn+C3EuxXXV7Ebf?=
 =?us-ascii?Q?ZiaIU6QDETYA+SwBNoiObAjTwFgfUXV+0MrA7Rvxqa6PN81BYe26Or4vsysq?=
 =?us-ascii?Q?UaTdNjyRWdd9TWbIB//EskCepYsyXhhdhyeF+F1TB8Q3s7+F6s6+fLV7Vnr9?=
 =?us-ascii?Q?U4p4My78st++5i6DWLuSUCOS21XeSE6SF8/t5jp7L+bkV0ZiLYwiPTdxfQKt?=
 =?us-ascii?Q?VeJp5YiA/30oINBvRw194vx2MiDuVe8SnhjE9PPhC5VPPTV5RGWAEKqbEdaP?=
 =?us-ascii?Q?aRHxA5Fjt+zG8DvbIgeDrJhIRZRbSXx8uWj8Pz2h5JW16FVm+KTUDJ9MkGNs?=
 =?us-ascii?Q?lPSNEiokXdSrkaRnl/CVlXnIBxwwY0199Nui4uKdbCKEUBGGBDBLLKLXSb+h?=
 =?us-ascii?Q?V6Kn4rbX7MACNtjaLWTEvV/uPTJCsh6C5m+KyM+AWHWGVsQjuraO7tYqBTVu?=
 =?us-ascii?Q?YehwaF70OLH2T6LReMIxuMlYKIDFiV0gi/swHqOij4+?=
X-Microsoft-Antispam-Message-Info: frxAwr9SU8y7bcF0lUZpvj3YcFn9y9in0trkSBXaqJs0C3N5smpzAWMBRq/8iuQSLu7AdLgGkxXAbwUja4hvJMDic6w19RJB8FThQl5XkicRAGeWqefV0c8kQL+UtPakO8xXxYwQbhNTGaBr5x+AfIR/cL3HRSCtl7EnROk2XMndFbMaoqpsVByQ+eaa6w62
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;6:3IeJRYQNVD36AdRHJuLapu3zfTAb861UxVxhnvQBxfmeOA7kfD9QRWDaO2DhIUOIWAe3N/FDkUB2Q9nO7jGCVO30NL/E5zhdVQ67no6sVnf51hWX7vNYrgFovCzt8tX6vJNdZZPzBwc5ZBTH/ObxBtf/IW1gRtfFX99Q3d8WHnSUji5vxMyLbzADUqJiizo/4L450xWNNao58tqIBzWAB8kduW9ukt73tuzKBZaMihZaYkh11/AD9WF7bSzxGzbsjn+D/iacfwKZExGepynBRbhp9QJgaGZb9+R5ex3an12Ks9NHpKaqkeYHpZCwcIeqh6JnImQvKXeVC9cPLVwQF3Sn/1BHy+x1PloKVClD8cVXQjugn7d6lJdRlpUOGuJym7ofB1ds1NTNWqV1Ffz5+9SqZXyzLYoGVSjOzZvUCHcqheHuU2YPmNOvRBx0kol9yhj/sgvsD8Zo7fJgRpC3QA==;5:kKX/+M4Ba/kmOZ9OgSXUHRro+MvTCNQXwtWj6IGiDWWf1esTRX2dLnPXUp8jjHiLQDMhmn3fRVpVJgai+sAF4qKelU1KM/iFASdqrBDUNQmkLMc6g0QffKbYislGuKKD+zS0BwvLxMJcm1yPnRPoRCPIErkwhWSRzNFbrjFs4GE=;24:HMVNRnPQjTSdyLH0SNyhJOtdjKDVQ6ZQDhkBjRJuAHdN1fB+kiD4aard6townzqjk2hY9EqyhAI7tq7QOhsX2PMN90C/ca3eAQSbLeI+Tpo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;7:VR3b1S6MhghVYUXq3+iSfdUHiDKb5T3X5rXsu62nsYoL3t/edTqJaxnLdJat/DNsEgM008Jhi8akbTrPSn1jpr7yFw+ZWOMcLqkNneXCaU3asXGnk0n1Mytzdl0bnjlQteBVh8Th/SZ+0JyxEQYxLYLxnFfCU9SiuOuPt6D1TN7QY8/k3wk6CElMBDFlvb/6ggA4+GXPbra6Zu2q2J/MeNs5MOmsJ6D5cf8c+IAfhPspxuZt4dpWQy184Vrif5um;20:tJoXGeXyqUHHg2Hd0eK+S/lPVlX8ZUa0V6NzYWekQRgJ5r8DpCTnKwbh3nUoUfYU8XP5Mk1U7uYkYVx4K88chDu8B3gX2xUnT3s0tpGLWgoxkzqIltfeSBP9wdMgWSLfnm7IQeXQz2xnt6LpNpJgGZ6Zbf8o8yzJ47/a5GH6mAE=
X-MS-Office365-Filtering-Correlation-Id: 1ef2bc37-62cc-4eee-6810-08d5b0eb4334
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 11:44:41.7384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef2bc37-62cc-4eee-6810-08d5b0eb4334
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

If a cgroup has no associated tasks, invoking the OOM killer
won't help release any memory, so respecting the memory.min
can lead to an infinite OOM loop or system stall.

Let's ignore memory.min of unpopulated cgroups.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/memcontrol.h | 10 ++++++++++
 mm/vmscan.c                |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3b65d092614f..7d8472022aae 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -374,6 +374,11 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 	css_put(&memcg->css);
 }
 
+static inline bool mem_cgroup_is_populated(struct mem_cgroup *memcg)
+{
+	return cgroup_is_populated(memcg->css.cgroup);
+}
+
 #define mem_cgroup_from_counter(counter, member)	\
 	container_of(counter, struct mem_cgroup, member)
 
@@ -835,6 +840,11 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
 
+static inline bool mem_cgroup_is_populated(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50055d72f294..5e2047e04770 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2549,8 +2549,12 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				/*
 				 * Hard protection.
 				 * If there is no reclaimable memory, OOM.
+				 * Abandoned cgroups are losing protection,
+				 * because OOM killer won't release any memory.
 				 */
-				continue;
+				if (mem_cgroup_is_populated(memcg))
+					continue;
+				break;
 			case MEMCG_PROT_LOW:
 				/*
 				 * Soft protection.
-- 
2.14.3

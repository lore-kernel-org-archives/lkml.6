Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeEVN2t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:28:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751196AbeEVN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:28:44 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] mm: propagate memory effective protection on setting memory.min/low
Date: Tue, 22 May 2018 14:25:27 +0100
Message-ID: <20180522132528.23769-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:18c7]
X-ClientProxiedBy: AM6PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::32) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:+MoIcSs3rJDmqbW5i2VRwhoAlJsexTpUmZVe6e4UILslovj0Dc+eUyVCcP+Ai1ot3VOBlIYIa77YNQoct2lzOrv8yB3S0HU4y/9iR8BZOX6vYEKoh6ebklnQ+N0iRHS5y8OJ56vL78Ghp95wNvedWhXjZFRP6FDiRQdbeIMoAMKZGh27rCbbr+VwF/9HvO/LpKlMzUiTUhvPEnyYtTs86bRVta8w/WKhLIrFOlAgwkF4wgiMIxQSKB2YzvJF3/OG;25:yAvxpjPEZMHBoANXGf8TLSZ0SE9yA2wD+YoPujVa+vuj76mjYzK1yxZUQ4RrGY8uXL03ZY3zEa636pZ1FG3o5XCiiaYoH7m4DU1GMVUJ3RObWP/HMMtxkggUvfn1TpE8/YEd/i+oBRqn95WaXB5+aoLV4NOxhs3u1andJS8Q0gd2+E4FSgUk5ciEmAvdSC8VAM5sFaCisYFfcW5v8QYihkKHML3O+A70yuDCgiZeaKMdmbhSLqBVdVX20L4Alu8K25uZ7kXhOFfLOvr8IU7Wvw0FpQvnj/XJFSlotL0W29TVSYDCViAkGhYuiGvDijW1HLvvK5oXwj+0uIf9Y+23pw==;31:e8EPV+3yHdQdQ6CB5DMez7OsYahaHRYn1lepJtbwPZDzXmjKNkJ9Qv606ubY2S0zGlfSajExDUplEJ4WTtbvwWiVeDtDRC6kbEDS4QZdyhVkr0Y8VgM9DmASYXoGlev3i3+8lIuYhcjsvIQazOkejKFyXilQpfq460FBbWN/4KG15raf9nq4ciNU80dSy57kjh/FzaqJgTOvegkwd3VWWdSXJzWXhYlz0a2aEA0hZEA=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:tJSPn37wuluvVy1U8d9qTtMofMZK8rPZ08C7u7lWxGtmOs9ITzkglBvlBnAXMcPWEgjnqt47Qz6Sjj7DDtgNj8r3KXgRomWGLV6iPSqw6zrLjhrMdNrCguig8b6aDHitz7KzMylfQ2UOMwstDKx/xA4AOZsWYG+Z9hGPrqu4I/BGTAOmLaNW2R3r5KwppGY8KyM5gJ+TC0nkr4dNphfeQ8XpZ/z0W8S64u9p2sv1eWAhlG0fKIybM1bVi+5C0BM++537K9v6rA2XUejnrWe1NbdsNnmlZMVaSlf02k88KJo/Un5272FH6Kwd06RPFvl/KI5gPA4Hlj/JZfYQsUudNThdAX0YjCL9vKToKD6Hnlq8yuQgbKVNSJ0B0lNfwiue7QgcsyCu5bdKoaCQk58Hkq4Z0HKLVC6vlJB8kEcNriPU80pFvNjKLP4XSsS+9nRxhMjYEp81EZXVjPe84sFktd4iG3eVhRTszAxW6Rom1Jc8c4XcHjaZRD6QV2vcGhFC;4:u59q2QvK6J/o7YtMcLHJzYwh6bE779ZIVVmmI7e+ZfwqGETeAyvMgSo1DVIA9yfLGCcZCn00EA/W/jbrz8fAUwmpNlw+U2LT0A/K/od+7tKturhKS+lmzBNyqF4RVVhlv4WkREUWm00eUkBZkwU5iScVITngBQpNSzKS/AnEkAThgWL72MJ0X2VFTXSPAe64Ll6cYlfJNYCNyDT/+9pzAvQTiMOOcNY447oq0JulZ7P7xtN8GFd8eY3H3SkxY9liczq7TAMiTupI8QKKeNAtm9rPrfTfh8LeKf3cyRHZR4R/MHY8L5hCRoyGwYPf/TpcS0RAis+BCVLpEPcTXYjTeCJFFQ/Q8J8WCxXOVIX8V6sq3/Y/64rt4qPxxX7jqm5EVsPGkK3mMiww/Rtd2qlF19oxMEIZe8/GB4nrx6VxAFU=
X-Microsoft-Antispam-PRVS: <CO1PR15MB10776B10CED3B7E6C2326F98BE940@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(199004)(189003)(39060400002)(46003)(5660300001)(8936002)(8676002)(105586002)(81166006)(81156014)(1076002)(6116002)(476003)(486006)(2616005)(68736007)(50466002)(36756003)(52396003)(48376002)(53416004)(4326008)(7736002)(305945005)(106356001)(50226002)(2906002)(25786009)(2351001)(478600001)(69596002)(2361001)(16586007)(54906003)(59450400001)(47776003)(6506007)(6666003)(6916009)(575784001)(53936002)(86362001)(6486002)(316002)(186003)(51416003)(52116002)(386003)(97736004)(16526019)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:Vn8FuqW930/BVLZRWCc0dcgp3M1OwzLBKWyAANUxB?=
 =?us-ascii?Q?Q4cYIrJO5viEwViO2oGppQiYdRCAoemK+TPVn5swvO+U9yJUmCsOOtaMSw4z?=
 =?us-ascii?Q?vvm967y1jOPkoY/vHLXRVyfdXQ+FXzO63b4FvUF+d5hvYR3M3s9STSe629JM?=
 =?us-ascii?Q?WrqSlct+3SFAqfjMhjzhk8qIVmBhfVR2mL2O7LETgyhpQVg3Q5j6dNXvnFeY?=
 =?us-ascii?Q?VTUklJnsH+YS8EpzGaIRm5iAEhlF8Lr0ISM/lCRqe8yjv2tfINdNP+k/cbJa?=
 =?us-ascii?Q?4WR4Sz4w9x8wf7OmqTIpErubKa6IqfOsEJBStdgvrOwMJAKtgArgr+RR+jtx?=
 =?us-ascii?Q?Ey0KMJOHluU1APjgPkRqWyRnShEqwXcSEa8C5qfC5TIoyvt1r6B5pNygWNO0?=
 =?us-ascii?Q?la6vP06HVufGl/b02tk5x5mDRWkVwGo968kGIww8crh/ZYP8tCvuEGFsom52?=
 =?us-ascii?Q?6vfSYP7/s34hLqBfnC+oIM3PUauVHOKyvN9uAvwg1u2QNSxZVFaQF54mINNe?=
 =?us-ascii?Q?ojMFZB3TOtiMFbWQ0jeHvquxLRurPheL6/F6oXnVc1s4CYWAhlnsmV5kV3p9?=
 =?us-ascii?Q?nH1Y//2rCmF3AXzTUztZSVv6LXw25Nq9wdlg8ThU0wZimo+6m5uWjX5W5P+Q?=
 =?us-ascii?Q?h2io6enlbwHDRUSoy/0zFFOK5iBT3NWRrkwARgClbSrLoNZQRT+0jwsqpD8Y?=
 =?us-ascii?Q?QsrVNtaCwY1UP36VtxJve6rMmRDBDp0hscLEWL2roqwNu76sbglALLigAjU7?=
 =?us-ascii?Q?UrlbujlHSRkJs3OUz4ksLXobbJA25RuJEFKT0QU8FjsGxeg5CJMDe3UYNSTP?=
 =?us-ascii?Q?cPSjk7Y1GAgJj6CKS5g/tIIyrdwAggkfzBuN1j/BaUaT8Xz0zsvRdCmHYGJq?=
 =?us-ascii?Q?R+R0S9tCihLOUnQR36chuieRoD0NyL6x6DrHTgFO7WxI8D/B29B6Eqp+0hOr?=
 =?us-ascii?Q?AnO3pz0ruDF+Cvawnm0/c82SIEO3yf69qrYG67dkpDBnmJUQ/rG8255he/Az?=
 =?us-ascii?Q?0piXuy64ZAP7djUDo6e5vOrcXPAb1EdfNqqZQ1CVU/IUwPgC7AjgHPNb1ygC?=
 =?us-ascii?Q?xMYZGHpTaaT66oDCQ8eg9HOK0YHPmeWqQaAyOkAhkCiWpCaAOpPD6y1yoMMH?=
 =?us-ascii?Q?E4rn3G45EEh0R63N9nCj2GRBxapIEvn6MOypLzynJUJKORha79EtLDCc+GJh?=
 =?us-ascii?Q?n1kJCcRfe4lzJIEdtiR2S6PFJsFD+TtOfkQISzMasbktlfJaYFnfFVen2OWd?=
 =?us-ascii?Q?lKEQyWxQAk1cjgJbxckJ9kVcM+RCnOrAu5adXwbDn82aVyY9QJjMV59XBGml?=
 =?us-ascii?Q?iVuckqFx/iFRvyXWMPXCoo=3D?=
X-Microsoft-Antispam-Message-Info: 57hDFfyxQ2gMp95lW9+M8PLK15KEaz5NyLrQYm3n6Y8na1K3QhhfC0YIodSHxGXeChMqO6bhRxlQ+IgH+paAs8EQtGfWUxOYVo2bg8AjOhZa+iKTo6wMkVTMTigtiozMZPaQHLnYSEcPiem4xEzFBio66CPbrbLq/xNkS7egOdjohJTFXyxxmAZPuNH0EWBt
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:3saf4sTsPM+d7/g62e5H0hxQarHeaUDjGhKLwBxMDeJ/6cprStmRRF4RMP/oFLFZlInk488iNd9BTpW9ZXGCY4bvcKUiDq7wqqfjPNfWKhtFtLU59rSkPhr7iPomhPN4o5umPd3ZSpfLB3Q4zxaL/84/wJtpGIyeEiGVQW3p+OUvlD5rF2mYvaRWvHOdggUEq1ho99AYHYMyFpQFjUZAcy/D57WBeCpIbW+TtOF3Y3w4rXpOFEtSSvDnH4g+jyVdr6g5X/C7S6GeacaOUKN1IwDLN7zM5/BSyKpuCOztgxDbsUowet3GUQ77B5uxPwgjORIFGaNpn7hnaoXTRQzaxpNU/B7vhiimYcDuybXJQVN8VEpfboANTQmevVLNWG/AbTywPKDgg/IZqJLROdStxPOoAQgHeAvjqN9pd1czozhvqjbTVIz83orWRuqfN0/wtg2W7K1krNKYUn3f/iyF/w==;5:5OJN3aH4FkV6E4n6G+zkvfcfFjgnpEipUYhic0uhLvsg46+POfmwXm6MbXFK6ya4RCkf+eKRxnWApa7F4FbHhiGKuBq4j1CSNW0LfVHU4H5a5VX9BsJiotN378VVXCkr+qkLEhy9XnnJfEEBvOK2X1AJsWdifLC5qvb/wVcc53I=;24:kO7ZchQxtQ5uiA/Iwejl8GoUKs3Lf+tyZ4BgChz1wVFDP/NmHmjsNEQXkfWm+2qpKv4I+i++YF1XKoCMhtBFYf3otHqPEXbX3Wpq8tGufRY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:/++ugjwbuk94iWTrGtYKu+VVAV82Pitdjo/3y4SDvr99I+XmgtBMaf9lyKS2mGzGMCVklzSmynzCoES5hugmN6Ddg2sOJA4QbiiAPQpP/TRlU0OHvjChFZhRdCcyJmXh6JuYAJZC+MAjWffUUOTQ2UypZTEnL/xZ7wN9MyixpU2LVyuNl43OsyrLImaNiCJj0JAKqaIeOj7txSwWXTFqtkGlBlXc7zjEd9gxImpr995KKAZSpFC8EvbtNvV9RUMt;20:tcQuI6+f8B0fUL81gIqupfw3JGKu6eyzDUqpUCBz4hUvVOYljMvf22qf6dJu9KcjMEPHZCZ/GjgALeZRtc9XkjdjNRjr/djZnJU7zvFGIUBwIHYDZH25qKi57eK61wpjK7bi75Yh1a0McRwD4xDu/IdBTTiOl3qxmpDnuabDT50=
X-MS-Office365-Filtering-Correlation-Id: 2d9f0163-1a34-4a0e-19e1-08d5bfe7e3c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 13:28:19.8723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9f0163-1a34-4a0e-19e1-08d5bfe7e3c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly propagate effective memory min/low values down by the tree.

If there is the global memory pressure, it's not really necessary.
Effective memory guarantees will be propagated automatically
as we traverse memory cgroup tree in the reclaim path.

But if there is no global memory pressure, effective memory protection
still matters for local (memcg-scoped) memory pressure.
So, we have to update effective limits in the subtree,
if a user changes memory.min and memory.low values.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab5673dbfc4e..b9cd0bb63759 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5374,7 +5374,7 @@ static int memory_min_show(struct seq_file *m, void *v)
 static ssize_t memory_min_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned long min;
 	int err;
 
@@ -5385,6 +5385,11 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
 
 	page_counter_set_min(&memcg->memory, min);
 
+	rcu_read_lock();
+	for_each_mem_cgroup_tree(iter, memcg)
+		mem_cgroup_protected(NULL, iter);
+	rcu_read_unlock();
+
 	return nbytes;
 }
 
@@ -5404,7 +5409,7 @@ static int memory_low_show(struct seq_file *m, void *v)
 static ssize_t memory_low_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned long low;
 	int err;
 
@@ -5415,6 +5420,11 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 
 	page_counter_set_low(&memcg->memory, low);
 
+	rcu_read_lock();
+	for_each_mem_cgroup_tree(iter, memcg)
+		mem_cgroup_protected(NULL, iter);
+	rcu_read_unlock();
+
 	return nbytes;
 }
 
-- 
2.14.3

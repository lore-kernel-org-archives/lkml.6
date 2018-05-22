Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeEVN3P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:29:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751275AbeEVN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:28:46 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] mm: don't skip memory guarantee calculations
Date: Tue, 22 May 2018 14:25:28 +0100
Message-ID: <20180522132528.23769-2-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180522132528.23769-1-guro@fb.com>
References: <20180522132528.23769-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:18c7]
X-ClientProxiedBy: AM6PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::32) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:/fNJPD1rWQ9IMrl9fOwf8gfgqaEL9vbJwfgifS9kjb/UMgYIaBGYMs/JxhKhDADfBaAP80FRSVga5QKhckQViz2uFOeT7SkvJomlGcJElWj4IJqBSx+ydwmf4wxNhacr9U/YlDv/BrZfU55dMipnpXnFF85srv7aNvJs1kqfdU0ol41+6o3EFq0Aby58xQGUzlb9jBBub8dfEsS85kQr2WJRhMe5vAP1eARKDAkp3vcEc5Cpp0mdrfL4Vq4JM22I;25:nWHjUhZRTMUxKKtHLB8iU9x1owdLQ6iVGB1GuyP7a8eoOaJ/0920ob39tYsG10gJIlFWx4rEKUIIS3DVl3DDoYcTX4o5SiXipA1wBC/LPjf0QVOJIy78RGzlgO9MYc8/hDVHOF1g/ObeVpd/EVdJJexRyggYH4LVdeMFwSVfSzOVEg+HoRTtgSFmfxEr82ax/7Qbf52+8NyTCiITKmyp1EhtPmy5peraqZu+37hDEQ1qn+D4QJ8ZlBhYxhtHdrPbnfIY3t0j3BDrljA+QIP9cHLW5QjUt1xE3e82O2Rfhsdty+e/gzwoUTDUFDv9tdmdtIvup8qA+akPmDni85ft0g==;31:Iy/k0nXTJEtGyDjP7nPQhUedLK1e+a+7QI+WO3dJuDLeqDdqR0+fKsv2an/yk+AGwPVGVzjpFwkQ51Z4lJHfxJ6LzNIq5xOV01aX8HXwMnQat9KiMh4lhATmqfAI2soiTd26SM2WOzem16692IgKIp2KHQZCUsoCL6Pwl5+KvDMARlrpQHB94KyxLgGy8fO5UALb/4l4eyEm9sl08AhhMJ21Rea8eIARcY3YxXv/VsA=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:4O2RyfofP+0v2H1D8LOrLXOItxo36RA5VpHIvVP26aRzDJPtYSpHaKux1Zsd6JeAZ1LwrOn5SL9+Roku+JWoEc5wCCRiX8QPBkLs87SwsXWDjHPq0b1GNc2K5UkqVtaO85cX1L/VlRRBIAftMvWcRCHU23hsJswjIO5Yt9lHRapKoDpTV4gu5cbM6zWyRlnVjfn7dKziwnytKddFws44LoanY51MZ7kGSlymoCBVc25W5ONM6AYGuBCpZ4cqcOf+mua21d6ZzMPs+nZhxQDd/DTXP5saZkJPpUnQglGK/vciq6qgUBOAAa5kVUPm6OMhukGGDMcDQnRfebXZ0KjgpKfRZqzrXiYlzmKEDJohJxGD/Z4ft0N56peOzuAltayaYFfyiw4FEkPJaanuKv2Sv8w27UUSA8NC81KiaAWpbPkOWnO3NgXx1Q6oV1cr/SG6x4nejNXS6bpcZLzF8VddzsZnHzvh04fFu9AiwBfRzoA5KqBtQTdmvbp1Der9Y2BY;4:MexCG1IaTJKg+tzc70a+CqZN8+eCnKdRB5d/a/TT6CC3Ifxo24N1SuYknPBHE8MZ4CYeuEqb+h3HciZ1M4vS4D81faf5XkBCJi0FmdADbVYbFKnYg4zvzVY65THxZ8j+Nv5D1CYgztVgfM8fNlTShk2VZh+WdYDjDARDWfTCcWh/we+qBb2xJ/G2p7HiQs2cHuHsHP7tUUsAbH11WilZxzdZ6LF04h0ov4iNeyz1wrYzVBxADtVTyWYjbAEvRc/GSMvKoxYyjJEqJpRM5LgwkOb35NPjlUtCi5nBPhO03yFDHbJMdxvLN/0KB72P0S7mAl3nfFl4hJ8Qee7SoZqwI9YLBoa0vz35RjAvlSaxelW8P0bc8t4J7+JL7hbkhpgEs6ySGD3vFkAti/xxqQWx1o+IsNmCsR3HBc48dZsS/0k=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077571BDC9B60C54C85DB3DBE940@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(199004)(189003)(39060400002)(46003)(5660300001)(8936002)(8676002)(105586002)(81166006)(81156014)(1076002)(6116002)(446003)(476003)(486006)(11346002)(2616005)(68736007)(50466002)(36756003)(52396003)(48376002)(53416004)(4326008)(7736002)(305945005)(106356001)(50226002)(2906002)(25786009)(2351001)(478600001)(69596002)(2361001)(16586007)(54906003)(59450400001)(47776003)(6506007)(6916009)(575784001)(53936002)(86362001)(6486002)(316002)(76176011)(186003)(51416003)(52116002)(386003)(97736004)(16526019)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:zXkzcCanG96eUJxsd0dJqt0vP0HDguTl76lDsEdId?=
 =?us-ascii?Q?4UU5DEDaYXtngpP4xYCXnGRyq6A7YvmEabA+jK/Pg9ReLDl5t/aQho3VorOt?=
 =?us-ascii?Q?tkd3XUcEwbeIu2tAwccYd79TLOZiAbMdxjqOQG9XakII1mOPKJznKVC0174l?=
 =?us-ascii?Q?tCQvq0jk7h0WcY36DYnMlwyEZMjUVWeM/SD+rzPQ0b4iYqDFw2jGGlOa+yn3?=
 =?us-ascii?Q?VP+a2zteh7Nwoen9HTJ4D6bSeoHCV+A77p3KWiWD1rDHokgRvXqDK4mQd0ZT?=
 =?us-ascii?Q?XfEe5CHJ5rQjE98zbjPVGua3nv+YX5yZXwbeg1M8i4E2dJfb52HEpeVd/i+2?=
 =?us-ascii?Q?SfF6300EygMVRup5D5gV8+Tj7kuZY1RInJ9+BQPAPFMmUT1DLwhRKhcoYSgi?=
 =?us-ascii?Q?i4GD7rrBUPR/Zc5LFEXtL3npDfNlBAIP0bqdHoEAAiL3b8Jli8TUP3wNX+zC?=
 =?us-ascii?Q?0bff9n5Sn7bwqwVfUOP7v5H53pf5y9/mpWa8QurInleLjBiC9Y2aFaPsHi10?=
 =?us-ascii?Q?ihjr7SlVLX/2VmdEi29EqE7klSgiB2ejyFVK51uH16oWCNknJ8i2eBLOb7Mu?=
 =?us-ascii?Q?mri1c9/IQiil+tQ3o8LG1FEPjOH2vMdpwdrmsHUcwQzX6oUD8hRwvWzoXt5P?=
 =?us-ascii?Q?kQ52goQwMM1Io/qmh3O78c/ojJVcz0paHXdzO3yzHPzBHOiSFV3XIupqQ7Aa?=
 =?us-ascii?Q?m4pT1Mx9cDjQPhAT9bBX9hBzXagaLBp2CFWHWv2070gfJkrExdpy/vMtFwi7?=
 =?us-ascii?Q?goESFrPZymgC7H/qNx5whFR0ST34/OCSOFFYQwdhMd0v1ziOfbn1o+zDcXkG?=
 =?us-ascii?Q?3UBEFW/MuXz6wqgif2ng/i/iDUVP7n89xwMCKpdJ/j5LzHyQSVfhXstMhjDT?=
 =?us-ascii?Q?Uq/XiyvjO7ohv1JeSxLvlqHseJUs8p7Zaw5E3LXEDoA2bag7kcu7V80oBR1M?=
 =?us-ascii?Q?2YLna9sojFnRfZwrQQpQbZEjSKMdWUyJUcaZ7fb/Xhhtgus3TgpXNrwcPaPp?=
 =?us-ascii?Q?S5OgP4vFL7CyaaYxsfzLUDIwj2udeSQ5I0O5HSP5MMnPCz8Bl26NzkGqIE61?=
 =?us-ascii?Q?UnrRg/H+HNAamPyLvkOEm0fJOnMpcpWO8oMO/zm7rmxH3f0eJiEVqiQ7mJ1J?=
 =?us-ascii?Q?PjKcJNusDlPW5vXbxZD8KPCmF7GRv5t8yz95PvAFd09Jr+YLrqmsRIkum4fO?=
 =?us-ascii?Q?8irGaJDS7gJFo/osekZ7kIPRtZKg/eILmb+PTNS4y2bM7F8QMttFOUMrWOER?=
 =?us-ascii?Q?McoAotmOB6ZFvUD/pif00+Q4q/uZzHnlsea1iHDXwwUrye3uB1FFlnYLWr/m?=
 =?us-ascii?Q?T3DS/+xV9T834XsIORlDudKhKNEqo8ofIUPK5LqXUII?=
X-Microsoft-Antispam-Message-Info: IjHv05WZTe0beoS8lLPGz3jG3Djd9HMn125lOTmRXzgzXEeKBxNe6de/fIa8eSxd28k921irKPn+tw28a4zvrOcoMWXxnXKUnNs/+VYOiXS1ePhdmMx3hSxGCNHsclWWOFl/EoeCOaB3PXa2MJuhM+bxn3swynRW/SDs6zmNLMgA//Kx5b39jZ5sTnHDOvxY
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:/YhydX1s3DEvI9F/VffmYRLEN9254p/8ut6o43cbskZSqQ4xGXJ6QPAj+cxhAUcAXzz/hzOdknknW2BkNOz19brwer/VnXns8KfU/yfJCkT9zVfqKv6NQAVbpwDavlcg88nY72GhGoVYv+ZidT7KuItF0Aa8HgHP3Q9VsTmOnY/+eIEwPW/l+4avI4aAKPnMdnbezvIT72NeeS7NvdQE13BZwHcatOgXiY0fIIvyf+qvRxGddIWqSEYdeur2n2P1b1i6O1X2lbDwrkROgjzOfecC+up7h2w8ubiNM/fRsWO4ZZKlDsHsZCyMWF5KgTvnumpuu9WmIYiCTceLMHyU9W7ZokjU8Tov0qZQpzqv/BJ4WDUhb4hCNWSQ2EHQ4enPl7awtFiBFu+VOyuktq05YMuk6sgz5HiklRr0lpJU3Vv3ARP5vAPzGAzYeC4v64tgKZASCy8aPPl7LD1zxpvs+w==;5:jd45Br0gF4neDPBRmwmu1+Us2cQTUd0L8DJYoxivjVvjLq1y6RGXKwuSaw4xdVge0iJqlayjspNCZirjXmK75XL+MU70l1BB4hou+PdDdE4iSfzjPZnjU8JBSALfcgyT/eBhQr94XxGOg//WMmJukwM78zHLAU53X0E4hcQ05ns=;24:eq52bNwux1X0OhjFvuyoXwsrOlree4EZbR6omPP0uvJz3FnoT7qiiwjmTQ7V1BVLjSlEicdpIcmR7vatSSNvbGQ6pGri0Il2SFVsIgLjFLY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:UnLqalX9n7tbUN+2YNnHklG+AMNep9i5D58qPc4UcK3viov96wJbvnM2WPzRauvEm1r25yQmS7kDwvDnWHnNTMcVfu3VYuHJf/Mn/xMpvjR5bEx5lj7KoUZxcw+aluyStdbhBdxGJPQk6zjR2tM0ufJmqK9xecn8ZZvRE1d4k7nVzgZVErmN6bxhT94YpZD/C5ThK6GP2paTQvVIiBBSk8w/b37eiBOw7xrXfCHIMJC75sy5DKNDESBtf5WUFbTS;20:K8nJUfVdVTX1tMoypdKpQPp/Vf5dMoDgWXXD44kPUiYuTdBf+jB3g9J5pAF7X3pWMOMQsDkTRyh3MAZEgXadoJJ+iB3CwJYN0H34kb6rA2iWhqgqbmrEBixpHJdOBOAVubqc8qCegZFbAtS0nxDGzaNs/L/V9WS9WGfzPXZU6Jk=
X-MS-Office365-Filtering-Correlation-Id: bb544b37-c2b2-45d3-318e-08d5bfe7e55a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 13:28:22.8567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb544b37-c2b2-45d3-318e-08d5bfe7e55a
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

There are two cases when effective memory guarantee calculation
is mistakenly skipped:

1) If memcg is a child of the root cgroup, and the root
cgroup is not root_mem_cgroup (in other words, if the reclaim
is targeted). Top-level memory cgroups are handled specially
in mem_cgroup_protected(), because the root memory cgroup doesn't
have memory guarantee and can't limit its children guarantees.
So, all effective guarantee calculation is skipped.
But in case of targeted reclaim things are different:
cgroups, which parent exceeded its memory limit aren't special.

2) If memcg has no charged memory (memory usage is 0). In this
case mem_cgroup_protected() always returns MEMCG_PROT_NONE, which
is correct and prevents to generate fake memory low events for
empty cgroups. But skipping memory emin/elow calculation is wrong:
if there is no global memory pressure there might be no good
chance again, so we can end up with effective guarantees set to 0
without any reason.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b9cd0bb63759..20c4f0a97d4c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5809,20 +5809,15 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (mem_cgroup_disabled())
 		return MEMCG_PROT_NONE;
 
-	if (!root)
-		root = root_mem_cgroup;
-	if (memcg == root)
+	if (memcg == root_mem_cgroup)
 		return MEMCG_PROT_NONE;
 
 	usage = page_counter_read(&memcg->memory);
-	if (!usage)
-		return MEMCG_PROT_NONE;
-
 	emin = memcg->memory.min;
 	elow = memcg->memory.low;
 
 	parent = parent_mem_cgroup(memcg);
-	if (parent == root)
+	if (parent == root_mem_cgroup)
 		goto exit;
 
 	parent_emin = READ_ONCE(parent->memory.emin);
@@ -5857,6 +5852,12 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	memcg->memory.emin = emin;
 	memcg->memory.elow = elow;
 
+	if (root && memcg == root)
+		return MEMCG_PROT_NONE;
+
+	if (!usage)
+		return MEMCG_PROT_NONE;
+
 	if (usage <= emin)
 		return MEMCG_PROT_MIN;
 	else if (usage <= elow)
-- 
2.14.3

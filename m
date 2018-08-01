Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE98C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362B620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HkkRprUm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dorT+aIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362B620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbeHAX1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:27:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388531AbeHAXZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:33 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LWbHi007722;
        Wed, 1 Aug 2018 14:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=HkkRprUmhvSMcGRco6fVCJZZkQ34y71l5Y6KvaYT9UhuXEwXsO0BHWEaV3ea8W4Q7KZZ
 gCTBQwlJ4JI0k+q1X8o3vJkgF9KeVTMIpjM7G/PHCJBPCuxTA/Sl/xEurSuu2H9jQjuH
 3O+7ZsZI2xFINcCNFX+xsvq3LXSTXiagkUQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkgjvgsx6-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:25 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=dorT+aIvSMw5Y79zAztObklCjsp6oZfpwNOWmtykWzDfRnzktLPKSfbcWEldpejy0Rh3Q02AZHFXaz6sfkKqQMW5A0dlGkjNwQmAh/9/WWNfGLvztditY6Wk1K8j7ZUcn8DnIvfB7hrn0SPR0IB93pfXfF3KUlonf4bDhWaFiuI=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 07/14] bpf: don't allow create maps of cgroup local storages
Date:   Wed, 1 Aug 2018 14:36:42 -0700
Message-ID: <20180801213649.30751-8-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 232dc7ac-b93e-4ae0-71b5-08d5f7f6f489
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:XB/ZaK9Kg2sIsOjl6e6UR0Tgp+x1kfqrMphS2WUqO8n78CdEm3a1tsr2qx/W1F9ISlqSyIW62DKILYdFffPOW30JxPP3HYShZopR5HpAJDfLWCTYjkLXmdrlWrquDBqeCHzlOrgCPQFF/vlnb2H214fQ8SAzKAin4pK05S8WPTq4JoYZTuG27AdUiVA9+ee/1SjFWyLO9REwAC5VRqcDFFSYmI99RvjIcve6fkjPLVcHxKAAOVDo/q+PqAw/fVms;25:a/FLRNjEQfTll0t53DFVu/qMT2tRPsLZW09OqAbUnWYJTb6WrPBxFmhiUpgd882R655+JYZp5c1tUC+K7+QtPMRzBQXK+tmlqjrNECeVY43jS9F2uJKvFsOzPFEiWAN4FDXL7YDlAeiC+vg648pfd7vibUQYJXzAqpGlNw9jg78/EPHHq1YjTIZzeBW3KkcxiS8o9yWtLEl9I8sTQcTSPkpcqBg7zckSqXUl7tVTyA03rWbz4ujbYkNyNd8xma+fsmWTfAM1ZGWBp1PnT+U7rpnsEf+OyiwAJ0Xgjr2zCAHUIzv2cKWTlDYBRk0z00Sn5GY1wtB6LpeQU4JoqHOjqw==;31:kAM0S2DCtIp9K/7hL+mwgPQD4GhHpQO0tp+HiHHdYp4MqfvYsPUPvJZQZBon53Fu59EPZlQUqXznNVK1p0XMZAIIbQPw2iVch9Dj2YPIqmj0Bnv+6HHlm87JedxE6l7+Fmb0Bkk0jwho6MiHaKv/moCQNA3jKPEaEJe3jLSqmck8ica8zNg4wKgfBSJDMUs3HdCff4Hi9Y1Mcxhv+ue1kvusmFn57hkHkacp6oGQipE=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:sCJv/n50B9BqkOSgVl6+wunwRPDAGrviRajMQ9dO8Ms2mYc5YbdXL6G8bAfew1U3cAdZxEv6IzXnFeT0D3t6wFKgtZ9ZzBlEdUhgnEoI6seeQWJcNObztYEyFXAvfS1LLVtoPsC17Fhkc4PbzgMxG4RZI4BPcszoy1R3jkhow6p+AHvn20ldML/wa0vOwQ33/e1Ifu8kbiFO3gihDgP6AGHRQXz/1da8zRJCW/2IZLCQ6oj+sHW+9qTPo8ZI8H4/X+YENFifRI5/DrdpR0xsyAUcdAhuQ1BBWu36dI1CWEqyDvRpNHk1roqjPkU45pFIbPtSTfIh/ynXbs4T2fcBfA43p02GK/OeorKmRMU0+LbtwXvUeyq19pUWA8uum97Uuqov1VqfHQuUAMqzeWs8w+G1F2OYE5lWOlXpakBC1jOPzdqRIcnfnXQUbt8Rt16iJ2hOFzpHhGyW6Kx5BTc+LrydWPCRBTBYMYHlLmfR0tzGNE7nC8rooxnKvCe5BQU7;4:GHkQ2x2lwzB9TLED7EpyrrWuNn481/e1GUERDj/ss6soXgxBUd/YAoXLiltDoipWQMy2YwD523n/ilA4eN9XH1RXIBR+hbTczzI9KLZmNQq61E/AHBmB5bp/1bCWwgnpBdoEZbvx3v7WQyEs4vk5mbnMwE5pRwfnIe6R1GXhYIlHU94PwJIlJDSAYW2oSuuKZ74UxfO1ZoNKkmkBWps/lwKMax22MjG622bvB7e0BtPpe6nGKWRUMSnZoQnIP3iikiMLyxo2Zv7nmySF1f8ZZh0B12/aN+KcHQ+awx99YoP3m+bLwXn9iz5YOQ9U1Ygd
X-Microsoft-Antispam-PRVS: <BY2PR15MB01675FCC7534FE49176EAF14BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:fOOaIIH/L4HW0NADplZwsLMWyRoMME3dyVabT6bbs?=
 =?us-ascii?Q?FjK8fKa9Qo3th+Lk88xViAfnUy+IQFEmfw1PQzKE8KTPRFtxRN0vc0aklAKb?=
 =?us-ascii?Q?IObVGAwa7CjZreRhnc5HLGBdeOosklhwqwlIxqZFchROoNJHNfkarBFgfniY?=
 =?us-ascii?Q?G3JZs1geBR6LRhA22K6lJFE+LTm/2j0xxLWr1sluwFb2cj0tk/L8g0YnQvgG?=
 =?us-ascii?Q?auWYhax7tpgXpO56OevnpdOqxy43Z4Frt/k+1R2T5Xuy4D49Ci4C3NugvRmI?=
 =?us-ascii?Q?krsn6mU2X5njZj892vD3rrOyyZXu8L/s4snPAezSjtjwLgjhISAotYujJvhC?=
 =?us-ascii?Q?mvHbsZ2M2QygkSlYVhccvRUDom3zZzZHkE93JSPOpunr7eEOG7IqP/WRk38t?=
 =?us-ascii?Q?GDr3Tfg5Hz9J1AgCyYgZmkwopuDInOHlWML35XVQRC9nCQAGo6hE0u1iez4l?=
 =?us-ascii?Q?ED0cg3cE/osNXgo5ekfYTzs7hQAOCO0PSd4a302gOqednwxRxtVL8sOKU1Mm?=
 =?us-ascii?Q?T1Glh6kWqBZbTG4LEbgWPYnSmfBLiv7y88KUNfpwxyTUmJFKD9Y+9ZL4XcK+?=
 =?us-ascii?Q?25FAqmDsO25Oz/aFbtInr4exuyGOLEmFxGcbN27f8ktUk63vD4v/T91T/Bg9?=
 =?us-ascii?Q?XyDD+gZNvhLYMRNwhgUoWUlASHI7W0ExfRAiOz5vooIeG9lxlhvgLuyNQifd?=
 =?us-ascii?Q?9EAqgbNoCa2heG3TU0VQyYOJxN5fnk0n9G62RybW66GyyWeqgWbmjwt2NXuv?=
 =?us-ascii?Q?JrpN6Iz44efuOXbzPFIOVVUn/0DURIswkfNJ0zG22E2OhNhlCwjlYHk0ZEjP?=
 =?us-ascii?Q?mU2WqCcfwmY8bnSehxdgZm5/Ob6a/zPQ3h4Zp01xEPdxGKfPq4Kv2C0AhpXr?=
 =?us-ascii?Q?qJ8TC4P7q8j6xJaqjA2eGZBJiCGt7RDpvBg9WRMj3UrLu8qqKF2NEIDj+es9?=
 =?us-ascii?Q?uUf9j/008i1NX3mSZtnB0mxwNz1vUlYVEBJybB92RcYID1cpY/N85p+CbfTl?=
 =?us-ascii?Q?nh8uVvEp+sKLK53wbS4supxACn+zdCwPiqG0aooH/YACaDmSlnCCZB/63Bje?=
 =?us-ascii?Q?H/5Lv0TEEP/vWgeFjbqRY1bjh9cf9+9t7toINjAHaORBEaWBuZahvED/8g+A?=
 =?us-ascii?Q?bzj9fRR0sEURUGmJVW0Rb3POI80/iEsw2cjx0lYiT7xIEfF/cmklMGDHi+HS?=
 =?us-ascii?Q?cCiBqq03tL3zOwjHhroWbgCtX2k+4RVq+HQhnVotDjmYfjU2POJDtTjAHQBH?=
 =?us-ascii?Q?EU5SOAD0p3B75iUgdTb8dPoJ0TTUjSIJ15E1Z2qSXMCqm/smAGXG7FJMmwj4?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: Axtj2w+mmIw/tT2VoSWAl0cpl8N/D5B6Jbr401B+uneCEN7BgBD0kbnll+4lHXztq6qOhRRAVFp3dHVzI8B1YGUFXI/wmexjrA2yE5u9gRKg+FAxesU6By0mjPtRDG6SJ5k3c0pRm9iD1TjAsTrgcKOxWpgBpW5HUSItk+raw8EAi34Ohd+cIi+OCIbJufHBdAhDlby6MsuKBhikk+ypSLkVvcRbhgHRXDpZOeCd5N6B3ZaDcJzwKIeQP04P4Px1hMnbVbbn/lGg0g1pl2uTrNe6bMStiwru2g29Bv7C+Us3fJmp22HpqXweqGEcDA45mGyr62rYpWPM6uy5/iQU79Ak9Hck2MZiVXW2oycluEU=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:DolC14Mol0BSu9bUzKUKEfBZHlQPiQI7hgvpqXNZt5KrBCOeznNXFtSu0HCt6gj5Ul1nOo5YJDw9yQPAHcQY0Aa+bSFInEfqH5cqRBQpgo9NuU8FX46nOzNeTeLxdn80MDCdbwfK+OZjB7zWbz25+OILqId0ezTSvUqQJ9iFrt/RJfOPGpw4lTmDtQkaS+9ib7/teKEm7sLYXiuBB41WeETu+Y10iRhW52K7pFve/+bhgZi6JiVdcMEaF4pKQPT1RtuxWanJUjb8tZ7Ai19PZRAKz0XK+Ml89f4eVLIKLueq0HruGDFSxkFZQw1UwwrPpPoh6QIduS2v49FmFvTzAW5t6o26H4I4tp4A4Ld6DyCYXNHyxaiFPKIQFYX1Zu9bPFpKG97HnwT7R5uBDhewJ0CQbrft52XvKoXGEjyUvisCkyp8DCMJGTbbDsF2bu2/lP8Rp/XcuCXp0TBQpiFveg==;5:m2NFgDS7HnN8e0tVHrgdn2O/H/tq4cc197pTwIUQdTWirsGYWcfV9nF202iAS+xRdeRkOtCffn1V0AfH3A+zdjzP0lFzwViCrqcTjEn9+ODWTTzx2tReG4pGFuYKLmK20XNaeIeM0Bnij6zSbnP1m4WC8Qv8UR4jlK235CdzlsY=;7:nkk6JrchxwQpABD4MIn5ryb08a+90N5yMB90CPLEfjL7OLt4QAFGaSeqi22cCB3Cu3GVXPU89sf2LmxbjDJyXWsv9CG4VvyLOdDhdd0VK6qXCE981W3c8oUBkmBskjsg8jLSSGmfTrHmS6d0dI2q0SMcj+woQnM6VIPq+mW4l+buqjknH1KOsZRe1KbX7UzDKH4Pa171OFFWLQtqy1kR6/MQyI/YztvAIsHSjbhkKdXlS+aevZ/D7Y1IIUtuGcY9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:vAhbsAhI7dCit41yEBBYB9WAaLNDW7dpxikxSoRL8lGBLoIJ3jmU8QnUkoXdShDnFsosP7U7BlcBjg4l2cqr1jv+SeSCfTh1AAuUiudy5xjp7dTGXnBeQZkQ6pmFFdJxaIxyCzH+lMW3d2uC1pdfl/V5eI+aEjndBRsS5QNE+kY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:17.4252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232dc7ac-b93e-4ae0-71b5-08d5f7f6f489
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is one-to-one relation between a bpf program
and cgroup local storage map, there is no sense in
creating a map of cgroup local storage maps.

Forbid it explicitly to avoid possible side effects.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/map_in_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 1da574612bea..3bfbf4464416 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -23,7 +23,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	 * is a runtime binding.  Doing static check alone
 	 * in the verifier is not enough.
 	 */
-	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
+	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY ||
+	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
-- 
2.14.4


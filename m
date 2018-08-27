Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A5AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC61B208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OrQ7K5Uq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QtV9vROn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC61B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeH0UOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:14:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726731AbeH0UOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:14:34 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RGM8Fo012182;
        Mon, 27 Aug 2018 09:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=J1cj7ZXg2ZGUw9fXBt8+jsCqFzx1mcYvf7SzwHTz9nk=;
 b=OrQ7K5Uqoe3TBdl0Mky/jCYBxei+maPny1Rke0Tr1azCaTTThPCThTrm3zprhg+A5q2j
 vuP9N/7BtIjg8+wU1cZC8IpUf4Q6DZGIBlgoD6junED8qtx3K1SDmdTjljVti1nLcVRj
 dHTOu0FW7NN0n1gcYblAmHoeUZc1Kur62OM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2m4h470sg4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 Aug 2018 09:27:06 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 27 Aug 2018 12:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1cj7ZXg2ZGUw9fXBt8+jsCqFzx1mcYvf7SzwHTz9nk=;
 b=QtV9vROnwBbyPeRNB4A7ALdA69DGl1Nmr/6oFWYN8wTzO8Bfq3IJNCCF5DLaQX9WhftA9zKJdJm6i9fL90HRBRR592KpRPFV9nhjCGCheGQjZM56R1V4dyHCM3lm4d3cxUG4fngxybWLiEIqjVvK7Ti2ghB/FyKe3tMKBt4Z2Ls=
Received: from tower.thefacebook.com (2620:10d:c090:200::4:4b2f) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Mon, 27 Aug
 2018 16:26:59 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 1/3] mm: rework memcg kernel stack accounting
Date:   Mon, 27 Aug 2018 09:26:19 -0700
Message-ID: <20180827162621.30187-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4b2f]
X-ClientProxiedBy: MWHPR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:300:ee::31) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d698cbf-f456-46b6-95f4-08d60c39ea11
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:V7guu/R7DFX/el7iYo1/Qf4pf0Cu7eKR4vmKg1JvGPQx6oxTN+Jh6uXdF85qeVhlkef0ANyMdn4zPYqic8bTqxxvI3tOv7BOPo998GkmKG7K+IZCYy1/0OjMDNi8wJj7WEod9FK1v7rJ+QjYpTCqZrT+Lc0kqEOqZubmo/uEa05Q/cQSEkcPpC+m4gPT+4qf1mw41xISXwCwjhdoxw3+HflM2MC+LVcSq0RgqjUGCPw/7xZz0IKu16zpEq/EW/Nd;25:D/n8VUYdHiWmQmmLDsk1vRkbD5Ug8bvlDuurD6EqydivXPgmZrrrtoDDTUuowD13arSzfgGHEyzJKN4cyz1S/pyNOy60J2va+cS53jGpmfPPYukAnBciMbEzvJPmD6EMOKndCCe2MOJeAjnOgIYOMaCvCFevoHC/rEYSwqFo0A4AgWqvnY9TrJ+dG8exoN0XERvljqYQkXqlXQE3ZOHQWsl338jv7NmYvjl8HXXIpA4pMSo+LxMWpxU807slmeLhrm2SthwnGvnc4fUlAha2UnSw+tNd6V7d2xLyASOMcCNKMTQtmkfkdMkRlcYbJPzoaCT5BJjxD6+i2+bHmeZzCw==;31:JuviIVRhsgJ0/mtxcPxjTVMKgy/FnF7DVJXZrMWa510i7Fri3bUigzFJVC7TRv4KAIDZ6yJgYVEj5zELpJLtZyyxntbZIqHZzaahG0pm9+fK4TjzdhuY9jtpyLnvoZefq3re/y8q4rigNP2zcGFwGotulPmjT6ocgH9otdd3FJxKNYJ69FA8DRfksPz2J5lI2y76e/Caooj8lRVYY7Jumv+0SlXQV3XO3AbmKxOruHs=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:cI4V/AgaiT4y06E1C54k5vJXuJWDmXNdDHodtUYVxhw3voa7oSxuJRIYw2hC4Ak7mYrJ7D4Y4Du84ZAU/tiug5y+NVQr9kIHPlWh+01wdCY7C95kA1FPgfI/b1dIIi3/YdCitWKK6Oby5jhj3MItE9br9UqacpYYRhJg4jahuEaSmUNMhfD6Xxj+IK885us5l4gLnNr5bqRZ2k2pI00nVxNz0CkB/kheMVy+9kOdgjpQ6T0VC6/q+BnGX8IfQp/MjaL1UtrAw+48dk8XExh2Z6sJc+UxpbjFd8BsBDHaMxJ2+ec6YXc9KqhZQ+AAmKgSAJw0BK313TzyWCtHbL5TJeS67PZR4LQWH5GeC3LVwTOxn2M3PaGFIeMTyQF0RHVBZrmkrmlXebz0e8UAscm8387Idb8oe7En6Hq4CBbsFFlFP5GL3hQD8iOswkhnve/lo8ZNyJ77AepOaGdzEFBQtXxo8rUsKAudxAn+2JU/C0pDz1K63b1oQH75j3FGsO2R;4:aao+Q3FYqBj9A6zQaDBrMMsmdkVkrwNeUyyb5w911WBAG0UrPMEWnlD0PpZRHWX83tZRMfx2n4GrKAOzEG1suZmVXR/cg6XxG5zqFniutxaAFViyQnp/5m34oYwPOBBh712GHODnAstYQhxcfOmCYf3lpboywxOV7ktwMaPnBdPm5qtdQZ/NfIv/KY8XRa9GBU8AVaXdEO3Zlt2S/sEoKJKiRsowXyOpx98PeRDZn7aB3ZpiEgqdfIczAbT4FZ9rEsB6W5ABWp5OoaYJfVCTw+AllVY8Q3jGp5X5QI1klRd+ITppGYAg1Vttqun4p7eBKQzlWkL8pDO6kc3MjqAdj7g0fCWVrNGVUa3dbFQp5kIYe6Gs+nWKbWINuTiHS+phN4HUqt1ObtiSerX1kid9ME3NTptdAyDY5U9+OBrWy64=
X-Microsoft-Antispam-PRVS: <CY1PR15MB0170A3FD46974A5DB9B95A23BE0B0@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(8936002)(16586007)(97736004)(5660300001)(81166006)(316002)(81156014)(6916009)(6666003)(54906003)(6506007)(386003)(186003)(16526019)(52396003)(52116002)(53416004)(51416003)(15650500001)(47776003)(2351001)(69596002)(1076002)(105586002)(6116002)(106356001)(478600001)(46003)(8676002)(2616005)(476003)(48376002)(50466002)(7736002)(2906002)(486006)(305945005)(14444005)(36756003)(68736007)(6512007)(25786009)(86362001)(575784001)(6486002)(53936002)(50226002)(4326008)(39060400002)(2361001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:2M07mbOYny2ynFkW1aHmcms2fjIO1WNiDN2PnrRl0?=
 =?us-ascii?Q?Bzok7jDMQ03ZpZ8MwRHJpiGVmxD9qQ6xzpB+lPnyavyySLPlzQcHAPtY8v0N?=
 =?us-ascii?Q?q6gKMT1OYB4YWJc+HAtPu+APzwccpqreC64gy6hUV8dGybVhBM70pMwrjGpp?=
 =?us-ascii?Q?/zhXy7BWYWaULix2+yysSE3dRdZ1B3gY+67MwhXK3r7cGkpy+N7aD/nAfJef?=
 =?us-ascii?Q?alnehoMfaMhEZtB/UUKYZCI11lRWrUtPsLnEohMBA8uAdiDTkU9nhrcU8Dpi?=
 =?us-ascii?Q?9+J4kBgcDKPnHntATZhTaSh7HTNXWH+U6OfdTqv+LeLSOcZLbf8RVm9cHHND?=
 =?us-ascii?Q?39dmjsnYwoQJyVrHkzd7fFLdBtuXhsFpzB/JAzybwi6SwwJZq7+oquLsdHGL?=
 =?us-ascii?Q?p6gaZZyFerJVJjJzXVpmAOG11ApCSq7zx1Pi50xw7VY/wMN1Tz75JpwsCtEi?=
 =?us-ascii?Q?KKTc8YaP3xz/gSuIgeVxtcAv5Z+A3GGC46xwa3igekXALgNXSawx3cv7xcuH?=
 =?us-ascii?Q?tl/5d/gGLzZeZGB9aIgFfbsk1DS4MggP79wsbsZtrae5l8G7MzEQ2YiT8bkC?=
 =?us-ascii?Q?MPYBAkqMElHaaQ1pp+X0h/OVxFSVYIkdrUJWNtUx9bhpSca9twgL9MWOuR0h?=
 =?us-ascii?Q?6mcozE1Db/nOPMUy40sEa7KIMRWTaAKlvV8kdRqB5pdP/VWA8gy8t+ISZWRb?=
 =?us-ascii?Q?z76z930oHKYgsNY4T+NBdUstjQmbO18LVfQBUL19LaDNjtNxxlxFsRQtUCE7?=
 =?us-ascii?Q?M5JrFWG/fOiMQ3sdXBHrqyq9Ex8N1gX680OmpaAps3SXQiwdyoWyCzVWwBEH?=
 =?us-ascii?Q?uuFj0a+MeJXNk1c4+HjMSCiBj0M9cSJGQhI4U71SchrfQgr2mgZSEcew4GNY?=
 =?us-ascii?Q?1qbfXuZfk1dpa1J9ps21zDRvqofx1TMJLoXoWAvDBXTvs9i+soz1t+0A9K3B?=
 =?us-ascii?Q?kgnlmwdaldTFbxnrqX0jyzTSEsvIp4o/Ef1MJK/6JbHkW8gynjhC/lVaAU+0?=
 =?us-ascii?Q?yOrKNvAcx3mvhc6lhRyswzw9Up7kR/VMXGtNv7Ugevow2lOhkreZF0Bhg6gP?=
 =?us-ascii?Q?LnrgipTLVV4jpL5pjI/uCn8EzDebtM31kIRX4qdwtA5TuHtD60pu9BEF07cq?=
 =?us-ascii?Q?8MMvmnwGRHhSCVx20Fz3Hmfp33wYwh3UJ3Tc4eyz48KUVmN0pOThV64VzgX5?=
 =?us-ascii?Q?aDcXDQ9ez/A4Hqkoa5BmU0uXtQp6S/kEzm458/dfYUk8d+s9k5sin7nDP/ZY?=
 =?us-ascii?Q?DD5Eabv0KkQ3HOX1/ogeDBfbrXwA7O2CA8gJ/DOcdL8U4g4u4uT/3DPzEeqa?=
 =?us-ascii?Q?+ybedFCNebABCmigeVjzDw=3D?=
X-Microsoft-Antispam-Message-Info: Co4iOzAvYt6g6t3n+Q73aC9jiI2kRuJgIeeSB6w1gqEhOguwKgxhO7d65R+0AoK3NE93hiFDpynnPxhV6zZsgUb3lTSL4lcKR2kAIwTW6CUyxLuMy1k0HLvQw/uI36DM8HeS/uwotrp03zBQUiySIl14pKXh9p5hOrWtkKTfeLod/JYl54GiDTFlgYAW0a0uozP9zwiz/mkfIRhb5f+fNQlJ+8/P2bsW6lpR2bsxWeN5Jqr7hZbGanfr2+1ELjk6J5tOgRpYydAycyfr+V+i8DCDsmGi8of1HMfuG5XFLQqr6pEoNQJsF06Z4aTmBSVv3GircGfHaLQxvr/fS1UITxVugl3g9MuRj3OsI4Obev0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:KlW30G8EMPLB9k4qV74LprDS6/Pe0iH/FbX1lfUFeZ43dV4Na6kthxyQIFKY5mxj8tWGLz+xQ1cT3BV9v26I+7ESfs9gp/66aXJamvzi3HGOlx1/HDt6gt42Rd4Ua9e/tNEUGELjtPD/v6XWEy8wv54i7sxVC75cX6BoA3esgr49RDYG/Snu3csWBbDfRYtGcaEGmSyURTwsXFjsC2isNgZX9/XSF5IH4pvnjT22FMTtUTEhNfsJ690D36FqR2NbKOGhTG4LL3iXspkR7dInVP5eN9m0R/H/Pw7fokFUDMNQeANLgptYoejBoqDP6sES6CGGLMSBp6ywyTIQfSxLG7GZ0S4toHW0NwS7llgaKf7/UcREtn6t9lI8LD0ZtCneRXDhpXbKYVu+yo5apenZJZq7px/MGxsGi8CnuFuGP3H9FV3x7xD9RukGxZoSEvt7PI70QI+hGbIoyXd940r1AQ==;5:JFswgye3GdrmM4pEFb3rCDER51luOVZQsVQxOF1X/ZYg5Or7EY+skECkwQru6DLhvvC02Fgl+mPhd/3E3HxmrFomrYNTSrM91AO+48ojaPa90//qzz2kh1yUDjS/b+Z+aZSybGnErhVSTG16Mb6ibHN4NsvcPY4rsu/qrs5Mrdg=;7:oO737xMkoGYJe2dHfhzeiwSbHKEb4ksz77iolNcL7/94sfmu1dn/0A+CGq1LpGjINWuL5gAJQ48T8Eqj1s1MLZ2/PJE0ywcdnFLmWEirLAT/f148t/qxCuC5p5KNRF1/NGu3Zx7bv12KEPVIhB+0qc3rmUMEtrbtiIhjeY31vQ7NlSYrqe4aVRL+LS2iisSA9rLrjzsxUFiUJmwR7KTnZKP44eNBQe5u6fVDdwiNJVj/uR9u0RGlolaEs+uY0THv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:kumW2C1CX2K4cRwHwgExDSADjFPdhj3C+KmSqXhqqt9peV5TQDlwFXcdScQEZkyhMUekxGM9ZFGF5UO0ei/yF/xXgmuBMECxTtHUn4FhjGTgTwl8bZH6L4zqS/3yLK73iV4aB02rraIKORYdAK3sqw8pCuDHFbPWOmXjPVz3z5c=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 16:26:59.1850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d698cbf-f456-46b6-95f4-08d60c39ea11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_VMAP_STACK is set, kernel stacks are allocated
using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
stack pages are charged against corresponding memory cgroups
on allocation and uncharged on releasing them.

The problem is that we do cache kernel stacks in small
per-cpu caches and do reuse them for new tasks, which can
belong to different memory cgroups.

Each stack page still holds a reference to the original cgroup,
so the cgroup can't be released until the vmap area is released.

To make this happen we need more than two subsequent exits
without forks in between on the current cpu, which makes it
very unlikely to happen. As a result, I saw a significant number
of dying cgroups (in theory, up to 2 * number_of_cpu +
number_of_tasks), which can't be released even by significant
memory pressure.

As a cgroup structure can take a significant amount of memory
(first of all, per-cpu data like memcg statistics), it leads
to a noticeable waste of memory.

Fixes: ac496bf48d97 ("fork: Optimize task creation by caching
two thread stacks per CPU if CONFIG_VMAP_STACK=y")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/memcontrol.h | 13 ++++++++-
 kernel/fork.c              | 55 +++++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 652f602167df..4399cc3f00e4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1268,10 +1268,11 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
 int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 			    struct mem_cgroup *memcg);
+
+#ifdef CONFIG_MEMCG_KMEM
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void memcg_kmem_uncharge(struct page *page, int order);
 
-#ifdef CONFIG_MEMCG_KMEM
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
@@ -1307,6 +1308,16 @@ extern int memcg_expand_shrinker_maps(int new_id);
 extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 				   int nid, int shrinker_id);
 #else
+
+static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
+{
+	return 0;
+}
+
+static inline void memcg_kmem_uncharge(struct page *page, int order)
+{
+}
+
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 6ad26f6ef456..c0fb8d00f3cb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		return s->addr;
 	}
 
+	/*
+	 * Allocated stacks are cached and later reused by new threads,
+	 * so memcg accounting is performed manually on assigning/releasing
+	 * stacks to tasks. Drop __GFP_ACCOUNT.
+	 */
 	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
 				     VMALLOC_START, VMALLOC_END,
-				     THREADINFO_GFP,
+				     THREADINFO_GFP & ~__GFP_ACCOUNT,
 				     PAGE_KERNEL,
 				     0, node, __builtin_return_address(0));
 
@@ -249,9 +254,19 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 static inline void free_thread_stack(struct task_struct *tsk)
 {
 #ifdef CONFIG_VMAP_STACK
-	if (task_stack_vm_area(tsk)) {
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+
+	if (vm) {
 		int i;
 
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+			mod_memcg_page_state(vm->pages[i],
+					     MEMCG_KERNEL_STACK_KB,
+					     -(int)(PAGE_SIZE / 1024));
+
+			memcg_kmem_uncharge(vm->pages[i], 0);
+		}
+
 		for (i = 0; i < NR_CACHED_STACKS; i++) {
 			if (this_cpu_cmpxchg(cached_stacks[i],
 					NULL, tsk->stack_vm_area) != NULL)
@@ -352,10 +367,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 					    NR_KERNEL_STACK_KB,
 					    PAGE_SIZE / 1024 * account);
 		}
-
-		/* All stack pages belong to the same memcg. */
-		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
-				     account * (THREAD_SIZE / 1024));
 	} else {
 		/*
 		 * All stack pages are in the same zone and belong to the
@@ -371,6 +382,35 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	}
 }
 
+static int memcg_charge_kernel_stack(struct task_struct *tsk)
+{
+#ifdef CONFIG_VMAP_STACK
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+	int ret;
+
+	if (vm) {
+		int i;
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+			/*
+			 * If memcg_kmem_charge() fails, page->mem_cgroup
+			 * pointer is NULL, and both memcg_kmem_uncharge()
+			 * and mod_memcg_page_state() in free_thread_stack()
+			 * will ignore this page. So it's safe.
+			 */
+			ret = memcg_kmem_charge(vm->pages[i], GFP_KERNEL, 0);
+			if (ret)
+				return ret;
+
+			mod_memcg_page_state(vm->pages[i],
+					     MEMCG_KERNEL_STACK_KB,
+					     PAGE_SIZE / 1024);
+		}
+	}
+#endif
+	return 0;
+}
+
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(tsk->state != TASK_DEAD))
@@ -808,6 +848,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (!stack)
 		goto free_tsk;
 
+	if (memcg_charge_kernel_stack(tsk))
+		goto free_stack;
+
 	stack_vm_area = task_stack_vm_area(tsk);
 
 	err = arch_dup_task_struct(tsk, orig);
-- 
2.17.1


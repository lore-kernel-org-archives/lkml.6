Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3725C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B9F21829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="ImC+fQps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B9F21829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeHMKmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:42:36 -0400
Received: from mail-bn3nam01on0070.outbound.protection.outlook.com ([104.47.33.70]:42176
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbeHMKmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+8vmlGe9cr/Sgne/HL4sJUeo5qMdoM8H2g8HRcDPkY=;
 b=ImC+fQpsmU74+ZgfI7TixsXyteyHgoVJRwuvDYAMa1oAXLmO94alw2l8pJA9EygFU2t50zM83K79/GB1a1tkTwMrbHARS8Qzz6I+m9eIsKkDvJB/Y4DGEFe1jHyrIHmlHZ/ijDO6RS8kmtPJ2NcDO0/mOZ/9skD+UIWDqXw0ueA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
Received: from mypc.cavium.com.com (111.93.218.67) by
 BN7PR07MB5298.namprd07.prod.outlook.com (2603:10b6:408:2d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Mon, 13 Aug 2018 08:01:17 +0000
From:   Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Cc:     tomasz.nowicki@cavium.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v2] iommu/iova: Optimise attempts to allocate iova from 32bit address range
Date:   Mon, 13 Aug 2018 13:30:37 +0530
Message-Id: <20180813080037.27097-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MAXPR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::17) To BN7PR07MB5298.namprd07.prod.outlook.com
 (2603:10b6:408:2d::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c100fb78-1c23-4957-fbbb-08d600f2f504
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB5298;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5298;3:c3KxtJlaSdMUtKInzW6a5wsaVVWDNTbJK02gU1oOEqvcf2A2GCBPgvrS19+h/c3clqboW2o7msIAXFXYrJRkDjNW63c2iG+P+wlO1LzeTDtSpNBGRUZeICrze9Jrk90g1Qt6Ufsmg6oV9ULZlzF1qlhfCLVigAMKPe75CQh96m2uNtkwrjMrdkuFxWOFkd2HeUVad58k0vBRRyASObaOuKF2QxlF3jMe99+fF0QccTfOTcUyhleXpgCP2yXbbkdr;25:341OKXcDFwSEqfXQHiMziRI8XFn1RYSLgcndeDYAVtf4UwU62Bh/kZ5oQFormeupaAUMpY2aEUHw0FwGo7A359GyAP3xsh0EX81+rnEM6zEG+C1M7n/+MMha9H4OokP7Tho7X+opZ0crCPD3ztfDKFq3gZ+KSs1W8anHZ+8Pe2qMfsQuQUVXtPhwZRcPthSds/bKm607bjiMa2Z9Jw7v6YNE209GGPHs30CqUAHwiKnVvcN3+bihPYgFGWwKYct5c8W9DhVpPwY1BRdQ4o6tJHK2CTqtBke4ZJVp34s1lo2fDKT1amOkH+DUtOBzMPSYlqTW1hmDYSEdKQYHTBg4HA==;31:93oglmkkJOB3TiWsOl9EFCkrEcmnMceJAmZ4FIiXBU0i7hj948rMt9FVQ33ER5kr8IFX17R6mmGCEx3jdw1PIMDEHv3XydME1Lhvggi5uwv5L+PPQA/6vvcV5GglyfAv4Ala+dqX72c73NYeolP7FWTAAfezm5yTldZRENfqZTZpwPmoVEiangvIgk3p6X4o1LTUrwg+6O86a1CnDUR4Q/PVFIcwTdVVZPumd4IGzEk=
X-MS-TrafficTypeDiagnostic: BN7PR07MB5298:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5298;20:lM3ygniTN+pDvqmvk6pxtCCeHVp+fFD9Is4QLjBdkvMuh9pgV0h7+noWm6qaSwtb+Ll0iR/FBBX6oFtIRmgf/WMh3sPoyOnsXtkybS4Y+3ojF+D7UIq4nWuhxwHp3nQmaXwm2o0iRE02PtNud7g2u3dFSdyI5p7xpxz+csViDRvbcYsnGXqpEOpLU/ijWnQc37c0TM2mt/TQP8PftBjh3A3Gw+8O08zLCXc1L353FjThTevPf/+s1FMkA1GEnZEtlxP9uK+O2l2bF5KwshElIlgMtDChXybFmE+DgjDgIbqxBaTVtx19LWnpfwQkutsXV+nuE2Jvx4jl77OFXXjnL9itNPrV8BiWC9e4VAUFOX0YjUap8gMFEsonkY3IsGIHPlWzTsPc+q5aWv39ZwvWlYRyeydVTQF2RtommyPnKBHJk6nwXOaJ5eCxGW7FmZj6eHzTWJf8dSnSasakERNCa6GdyvVm8tjoPQhJm1Ug1lXnG8H5m6sqQZJLmSvxp4QL;4:ebwwP7SPDWWfEMTpj/KH/U5SmeRfXszZMb7UGSX0ExFVUHf/jhNmYOWP470o1SjApwXQ7T6ttfXAhaf9Woj9Y9v4v9yR9SIoQg3HfuFTTnOPMrEPMV3dumQOQ5KAbo2/NicuX6eSdr6RxX/Sm1WQLtqRGRDoZfiHJU15CtPuPn+fpbuoBfGCw3kyWuBfaNDya7RKyrfs+6BKaxBZOxalN4LHSArdQM3L9/wh6sm+DjwfTGbU4MOcd7319YgVcaxsA5XggDsmpOMTam9W1bM8Y0Dk7of2nvnYLOEGp9iIE5FFfxonI4OC01uR2Xes6vOU
X-Microsoft-Antispam-PRVS: <BN7PR07MB529877CF246D6652FB9E229483390@BN7PR07MB5298.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB5298;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB5298;
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(6486002)(26005)(6506007)(6512007)(6306002)(47776003)(66066001)(8936002)(316002)(44832011)(956004)(25786009)(7736002)(68736007)(4326008)(2616005)(53936002)(186003)(386003)(1076002)(2906002)(97736004)(50466002)(16586007)(305945005)(966005)(486006)(106356001)(16526019)(86362001)(36756003)(6666003)(39060400002)(476003)(81166006)(5660300001)(478600001)(8676002)(81156014)(48376002)(52116002)(51416003)(3846002)(7696005)(14444005)(50226002)(72206003)(6116002)(105586002)(5009440100003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5298;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB5298;23:/fLEUxyfkd+d/CKffc3J27wkKR17r7iHarRgx+8l6?=
 =?us-ascii?Q?cWR5Xkbi1ODrsfTudrkdjDJ191C/jfavMtG5eRWwlqJQs7Ll/Sw87ub0QuZ8?=
 =?us-ascii?Q?9PNDf/QY4ZwtuXUMlCE3fUfbyR/M4o3935DTrJlG8NmtVjoJqdh3NMhYL0NV?=
 =?us-ascii?Q?igC0a5WLjwqQPVxsLtrQG+hCghsMJOVmPdqm/qGBxyv3Xg6amLy0q7IGu3pz?=
 =?us-ascii?Q?DkGB65mjrRnMcGtCE9D/4Tb9ZzOysBrxLOXZdzgqlDmFd3EmtqWWX+Lvssjj?=
 =?us-ascii?Q?WbiR+5dTzR1mmhR8V4QgIIcH8PAcIUUb6UmJAkpWjalQXHSb465ATalqh2VL?=
 =?us-ascii?Q?Vijnw/4nlZaoF6pYyvSCoCMR4cjEL0ULfK8nscVEIpyZWCC7DMtJ0IIsKXIp?=
 =?us-ascii?Q?ldQnsGR5G1XlZp1hLerOT5NWBxveBU+Pp5k2FHoQ1EG3li3hVU6cz460laUg?=
 =?us-ascii?Q?pIBSacXGI+EBUH33HoWiO0SN1HFSojdgd5oxyiEkg+XGaB/ge0aP2V4invdk?=
 =?us-ascii?Q?f89UIl7pBIIcEjhEePZH14Tf3+fo0NpUPgLr0XLub/j1u115Dbt1AY9deOH7?=
 =?us-ascii?Q?bvLU1RkZzzlo5rdcNKwlanm4vIMjYlX3ZH+8Vv+J2J4d/vVjAppjqJKbwjmL?=
 =?us-ascii?Q?h1Qh48TzssDBRIr4Lg1g76g+MOUgZfxUJDbT5+dsJ80vzF4R33g+XWQXwsrN?=
 =?us-ascii?Q?PDQghi78D+HOnRqR7HiVV8LNjke5OK3prNA8bLxg/mnu4Bjvkne6USvDZ4y7?=
 =?us-ascii?Q?8ldrO3hU7vzf+VjT0x+0qpgeXVypNfYxYkevVMMg2Y1vdujyKQKbvVPjfBBD?=
 =?us-ascii?Q?gaV1mbvmWqVzOtM/YTr38bHZp0sN71+b9jieJhxm6nzp7nJsBYApmlA0XyF5?=
 =?us-ascii?Q?qbGLw+Pt2y1XQTX2p00KaiKGhM9OxbHcqiIUkii0Ne4Vn7lgNJjningqp0G3?=
 =?us-ascii?Q?lWsqBZcnGZnc9efnITslVeKhANSlYZ47ds354u1eYNTuSM2/sCgq8oj7yooE?=
 =?us-ascii?Q?Kv/+jSfalFafJg7eBK1xEyshGCbLqH8j4bWDjPI4O0kfoQVTW8bm21D03+qk?=
 =?us-ascii?Q?GJtGq7opDhQtW2+4e5yjAisy+uF6WuFqTT/GC6RcyScz2dCkHzmcEB+Xwo1/?=
 =?us-ascii?Q?KBeV2liVQUAvASSjJbn/TwxClcqJtMoBuFTKoWBXg9qbJ8Ag5y53AnyQqwXg?=
 =?us-ascii?Q?M5o2ogBZHBLgbfDwTP94DN4mXSYqbK+Ql6p3aZqV46XbR7g5QeN67uezgwPs?=
 =?us-ascii?Q?htciFZ6soG4Q6WUiQRamo0Emc0V9r21VviaoZgGBFnotd82gUb03LihXBnN7?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: sUVvsLGhfvJIyFTm6u9yLPeBPY865eR6ZhXpVPVUh/925RG5Fzx40+hFdUla17ox1MW35mfNhSyv57CmsByJH9n8L+n0cxTC4dHht8bScqzdglc6kwjECE9syAwNOh/YM3w6vOxtoy1pMgnHm0fBbAjpqFJ9pEHSxQYPNSiIsiAlTMR80ZmNMhGsamuvBzxrhJasxtcAzi5baMWvS+xfFP/m1o1ZmcLyT1Wpk01LpsoSq8unPgR8WHi3ixizjR8ZUoK4lyq7zBb6aezQVmN57nE8JvuJ/yLFTiSsnJCERkg7BvA1eyp4vLaEfxB3VgP+iUQ5Z7nNoD6KWI7UUpqxpZaXz/Ix/hAROw8DcoC25DU=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5298;6:zow4WPIBB2sQ9z/7+5xuBgVr6NoUy73y1cZfk7arcPb6wWoUn3xsHp+hs8+etikqUrltw6Uh2MV0oZmvY/vo7kBSAwcZW4vygD4L8oqjY2z8ZkGPKdoWRUZVyCEyrYv74sikZfj3rsyHxFtmHloSPbqu3Gn06/8ftHElnJViRMbzttCGUA1cv1+r0lhDNcORZX3DMZFDR1bsZy7NuKrmUfKx1AUbY2VKWujJgXLfjYN8QBquNZxStquk3j+V0MZH0pHy1zDBsMREYLJ/v+UKzsAaJaCcRWKpY4sS2N7JaPCKJ3RwZqvCMRobio9kIoqaFVsRrq2e+52jO7z/PjlXEdBV8jkLqU9cDOENs0Fw+4eOzHX8nT/USfcWECnSaegJ9LbCK5M2sf5v2JsaDa56nizclom2fSASG/5K7WrtfC4ohgiXwcVJboKSCraups7NUuCoWcUkYFcAHAD/Hytyog==;5:kXSpBvtZwudNvCBTUTh6UlKqFQOvafj0//UQVOk6nWDKCMYVoaK4i2tBWt058xPE9NMLl7d6wnLKpu2Pi3NH/qaKto56HL6rB241T5OJuGav2BsneDIIPG20Yd3hXVUsW+A4oGt+hpsFaOKVPoW7IAXz/SA80mXMTV9S/1/8o/M=;7:pcoVW6Y92TzLl4++ApcjtiVsB1dreO4FuvRCpk72Eb+SFST2aF8RabjpbzKLHy09rESV0BN2OgpuKU7VFlCyGn0lxjnRhIIVSbZgko2xyOkt9MKAO2qRy9GBm0xykrfzIiWcOkeKj0fwF0Dd5Gnun8Hi8UtXU+1GwZshqM5FYEJSPBef3HNFUCNq9beDmiV/1GXa/a+7rIeSwTkSsqTe2FTI0eBcFgyAPBIgzLWzPe3L0HOPUTxERA5vdup5MP3j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 08:01:17.9989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c100fb78-1c23-4957-fbbb-08d600f2f504
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an optimisation for PCI devices, there is always first attempt
been made to allocate iova from SAC address range. This will lead
to unnecessary attempts, when there are no free ranges
available. Adding fix to track recently failed iova address size and
allow further attempts, only if requested size is lesser than a failed
size. The size is updated when any replenish happens.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---

v2: update with comments [2] from Robin Murphy <robin.murphy@arm.com>

[2] https://lkml.org/lkml/2018/8/7/166

v1: Based on comments from Robin Murphy <robin.murphy@arm.com>
for patch [1]

[1] https://lkml.org/lkml/2018/4/19/780


 drivers/iommu/iova.c | 22 +++++++++++++++-------
 include/linux/iova.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe262..543ac79 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
+	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
@@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 
 	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
 	if (free->pfn_hi < iovad->dma_32bit_pfn &&
-	    free->pfn_lo >= cached_iova->pfn_lo)
+	    free->pfn_lo >= cached_iova->pfn_lo) {
 		iovad->cached32_node = rb_next(&free->node);
+		iovad->max32_alloc_size += (free->pfn_hi - free->pfn_lo);
+	}
 
 	cached_iova = rb_entry(iovad->cached_node, struct iova, node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
@@ -190,6 +193,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	if (limit_pfn <= iovad->dma_32bit_pfn &&
+			size >= iovad->max32_alloc_size)
+		goto iova32_full;
+
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = rb_entry(curr, struct iova, node);
 	do {
@@ -200,10 +207,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		curr_iova = rb_entry(curr, struct iova, node);
 	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
-	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
-		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-		return -ENOMEM;
-	}
+	if (limit_pfn < size || new_pfn < iovad->start_pfn)
+		goto iova32_full;
 
 	/* pfn_lo will point to size aligned address if size_aligned is set */
 	new->pfn_lo = new_pfn;
@@ -214,9 +219,12 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	__cached_rbnode_insert_update(iovad, new);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-
-
 	return 0;
+
+iova32_full:
+	iovad->max32_alloc_size = size;
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return -ENOMEM;
 }
 
 static struct kmem_cache *iova_cache;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 928442d..66dff73 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -75,6 +75,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	unsigned long	max32_alloc_size;
 	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
-- 
2.9.4


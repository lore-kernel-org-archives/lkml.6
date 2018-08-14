Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B86C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6B621722
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="A9XVZ0pB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6B621722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeHNGHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:07:23 -0400
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:32325
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbeHNGHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Yl387/f0XEn8cSnCIs8+oYgIlEIDdq+H01Xj9hUVo=;
 b=A9XVZ0pBmpDcsCqtXs/pz6AMDmv1CXOlXwNkZ4jT90Umvy1JfWHjU+VNzw3VKkDe+5o+d/PDvqpOQLEW7comLmPVuueUSbibK7pBnMHP+/hCLwoY/rZ2yeoe0UGnVgk34INaDeCZgR5iaTe7xQdH/zW3ioQqtoRHRAbAAX/DNB4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
Received: from mypc.cavium.com.com (111.93.218.67) by
 BYAPR07MB5301.namprd07.prod.outlook.com (2603:10b6:a03:65::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Tue, 14 Aug 2018 03:22:05 +0000
From:   Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Cc:     tomasz.nowicki@cavium.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v3] iommu/iova: Optimise attempts to allocate iova from 32bit address range
Date:   Tue, 14 Aug 2018 08:51:27 +0530
Message-Id: <20180814032127.6698-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BN6PR22CA0031.namprd22.prod.outlook.com
 (2603:10b6:404:37::17) To BYAPR07MB5301.namprd07.prod.outlook.com
 (2603:10b6:a03:65::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c8b39a-facc-4fd5-6dd5-08d601951e24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5301;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5301;3:3kjsQD/OJ5MGz5KVKWGn/uTw9Fme8wyTImec6PQcikaFVlfqhnBCAovkq1et+cI5imoJowsjk9mLOogQmQtB9leqAZTkWfp9zfbvN0d0tCSZkQS+xwP0oslmr3iiO0kA0+EOhPFY2v5/nTxLVRdfi3FP+IP+0Qb7EclSNEgQxuGdKK42fMo3V+/jh7LgkYDKBS+v2M/pLDGP4J8U01kGmcK1s5KirFElIJHQe+dPbWxsR2UsmU7T1K3CwH98K40L;25:V2DXDRLLOBsFRaUWRNLZK8sUACjw/cWbMSLq5CEe6I5wks1zvSYbZtvBH/SThsPr15/G5Q0NF5jTelCWxdabM3t3YGQR6Ogq5mo0WTPKDLScNiE+EXO4ACFt/BrYzCeF0a4nd6Ad0XbdeZQpDBbWk+DEpgxQJUUttr++4rsMnjaZkFPcOUVO2H6jwL6EkOUWh6LWXf0HmtLoYNBDIJOBlPoHaSgz+uN1j3c7EUIloAHBBFJWCGwN2NNzZI1ejmOXZcH5O4traExUOaCHVn/WfQKbRdOf6pxGhNQtWZT+/H8/IBzsl3gQNmOCpsTbT4KV4wLFcjCie71ZnVaSqaf1Wg==;31:D420hGPgW+zhh4C0c/svX8Kgn3iTl+9g2dPduI+krNqz7sgYYsU5/yUODw6lMYlHbkTAkklOwKZrtakaTkONdh47AU6mo4v35btD+Swmwi7aRZeQNEsi1lOIu2Y/bjWzlMJ1QCciCGnEFDInjlEEdPF0zIvLEsGt1dLLFFN0NMSpPMlV+3rrV50fYsknIYlT+XSwbXn6fQtKpA8ve1zLg51x4ccqbky+4NiF4X5Jg/Y=
X-MS-TrafficTypeDiagnostic: BYAPR07MB5301:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5301;20:/cKX/d8yZq8sRHLsfYT1HxZil41yCl4j2pfAJaSBAYVorYS02JxIwTxYzE9g2erl8RWbBjLL/1r/PzNqr7HSc+nryhoIN+aO10ZnjMkmmEgJMo3KX9lUa2ARwtE+kHtqQ7uwuxiZgBhB3/LIwaO3K0puAYYmgVAJ6B6HwADVqmn78vam5HIlp/bX10zENNsPitGtMbHnjZHdLO+tF5kPky/utGMA4o3j690jInSzZOXE7Q9opqqF53kRZKY2M2sPNAewwpyiB12Ar4Hp0RwHiDLvJfc0RLjzSVuriy00NJX02GfvgzqZhfzh0x4sivQI3eKjL6i4AZy91D0M9esi+5jcOHNJhWselTpFAMG6hMHvHsmSpVtEqY+RE1dO2gGou0ElIGNDihY2xirPK02vzUlKBaJBxDRe5HwYC4mDiPqw924l3yQpiydVSXNUMeo+Ymt75+L4pdY3bW2vwRi01xsYIqP1KAJOUztu/pr4pQ6N8AfVXYcMCPE9fJTO4n+t;4:sx7gldAiQ7pHgYKb8s+qg7tuUrGsBIrwxOgkfYxjLascN9yXbbnA26qAotUrmFs3R3rsx7zMtBDbLmRV0ckyW4MabXZ9GRS5+lu2yiUKlpmJCi1p8TRb6rx8nyOEKPW5uSzR5VcuDuLsYteGnrqDo3WJaUoWbvkG+lcYdE5Y52TMiV8auAiDmFg32Tmt2LYLyNGutRGzSsIizKuekQ0kWZ1ZzNQMIllODICGtJzYIXjCQDQLkl2JK6UUTLuMUU4Y0mBGmHBA+KODUsLDLYRRCxh2sQPoaTkMyRgu+n7QF69kyrXlEdA/gT2k2CxbuzWW
X-Microsoft-Antispam-PRVS: <BYAPR07MB53011CE324C630A8B2C3081F83380@BYAPR07MB5301.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5301;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5301;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(50226002)(966005)(316002)(6486002)(16586007)(81156014)(478600001)(8676002)(72206003)(14444005)(50466002)(66066001)(25786009)(47776003)(8936002)(5660300001)(6666003)(68736007)(106356001)(105586002)(2906002)(48376002)(39060400002)(476003)(6506007)(956004)(3846002)(2616005)(5009440100003)(386003)(4326008)(97736004)(6116002)(186003)(7696005)(51416003)(6306002)(486006)(44832011)(6512007)(1076002)(52116002)(53936002)(26005)(86362001)(81166006)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5301;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB5301;23:v4gUBlYJTUjfswKgEJGrdg8aE9qenYKpON9WnNoRR?=
 =?us-ascii?Q?vPMaXKw5zghUIDvceFQmC7poFCdjXe3TU/gblYrAZxqn1XkgomqdYOb+A4x1?=
 =?us-ascii?Q?kXxpaPbE5B4ovHYV4R0LIVC0qrj64GIx4cm9UZjyMX43xCg/3rpNOOZmG9dp?=
 =?us-ascii?Q?RJO6PO+TJVJNFaGcGvR3LZV4C8bFf12L3jtyEskhfQny4AoRjNnclrkDrmJT?=
 =?us-ascii?Q?xcG0LMOstsOLLzLqd/7R4IrIdb90hPrFYowgF3FosJSfVNziFxc7BZ9L6jWY?=
 =?us-ascii?Q?0pfIlZtVcMC3kKSLnVx54kulHKQs7r6y9+/zFYY7XHDQmXrzQUwNSLTJG7dS?=
 =?us-ascii?Q?KsVscKjRfdom7ZUucM25i4hKVlrRme1KmQdRNzDnuPy1OSM5gjbc6awohJxj?=
 =?us-ascii?Q?651OpR0E0lvxGX7rfs9xVspt9+sgDYXfRAQahIiXM/BmG7xx4MMrMUjfeg6W?=
 =?us-ascii?Q?ZAUnojv5AjUKbAiEfW1PyQEVB1YmPKNzQXs5oNs6T+nzOgYm2q1gK7ULRtD1?=
 =?us-ascii?Q?2bqqggIEbfyVLqZ1mwgHaDin/+qcpEiktuUfkIfI2f2fMyDYz9xqgTS2Uisp?=
 =?us-ascii?Q?UvuLmCxpIoRCNi448kiM7YsmZDuAr5VLHy4wGfxxSXhk4Ynhe5LpXL8+KUrX?=
 =?us-ascii?Q?AB92HWgLTklzuH75PZ/6Xa1XM2TcTA/bwPJJWB6G9PMhIyXq/w/dmwONza0T?=
 =?us-ascii?Q?O2ngKcRSPgb/J8/drTbAYWA9e2MMFtCWTMWorS4eRUE8bGiezEp9AoIgJWFt?=
 =?us-ascii?Q?h7uLXHXy9KIpgIZWtFI1DHgDRV2e5MeLV29JvVD5kTWdKOV4arU+p2wa3cKa?=
 =?us-ascii?Q?escrvZsQsilUNq1y4F9pVMNoGMbofgufhAqJOU1cpAndNHJDp4k/ZUIZTlKd?=
 =?us-ascii?Q?noheIDd/OWM5Tfvc+ZVCAK3WPREhyYwcEOX28tvYALaBJcFao72v3HiOTJS8?=
 =?us-ascii?Q?0hCaC9kAKZcfaFm3CTAbPUorFB74VyTz1Ez6T+udAjknOu0pHfUmnhY1gWun?=
 =?us-ascii?Q?eElR91ySlvDBYHz5ZgJ4h2LGqMeQi7gkDR/hdZZuqSkxSjMLM5DT4cRQncj8?=
 =?us-ascii?Q?08ldVOihcAePRfSX1p5lBPdVt0FuKukHlEFzbXavF/EUKGKOpHOp+HBY7pRS?=
 =?us-ascii?Q?dMXDd9ZsxGs/LUn8dqQHhh8/Ws7fdt4vx/xYEAsQBI9MSLrxvj/dn2e5nWXE?=
 =?us-ascii?Q?fTuRcDoYRMR/U+LnBMoLqjC2BvGLvNBOFCYE8O6hDn72ks2n1KEICTAJs0hb?=
 =?us-ascii?Q?Rpw+eZA9XLjKLIon7MrM6jcJdmvxNVMrFwujPDseCkxlsO0QyRqzgb/fW0oI?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: ICgbj9h+xG399oJcIzBhkX6pP2vA71PIEa4vu9QgL/UQDuR/LKwwT/JZhL+iIAZYo7+zoF4z/KWkUYk8s4eqvwc2anUMA8pYKIpo5jTT915Wa9BTbGfXwNEFD/ueMeGrulYkqeDDv3thkM9SA5wkjO/U621+OVO1zoHlUSUHy+NBj+KEIRfo/zUNLWgeC+Hnt078UOhN3h5f1N+1SfVpLoBcA5mOzuwptbOJBVfY2Tz5u70b8EgkHYbaADDZC5BU0kUObG+49BWuEJkKZKBoYuoLj0mssA5R5UYaNawMXuh3KecrnKSqo0D+R1LeWqLnDtkTDT1+xbea0OgeNtzHIp+VJ5ixDPB8ZnVtFXGhbr4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5301;6:/LVXLgrhEHrTcB8a+xZ5v1zS4VEFDzeGYg3nYqymL6r8njNFap/LroHRVgcFi3KEuNXJLQxR6Mv08pfzOiMwYDKmslp8uP4iSCAQ05ssofxJ8ApYCAqsD33g2qD5aRL1XFdYzY7F28bG2W+6AVwuiUwNoh6Y/H9/Ge9kwRbRKfG6iLIYTbNg2HDVlx73r9Z7YOHCk8dO0YcDRIzy/Rw5GJMpWeXJ5rxFMDiK2M6SYCSd+z7hPFsYnJ4v9Utysw98NYLly/I1kIeQK0FJWxKs7x2hrKPHcUyU9sKax6JLJf2+EMszcx4KV26c9Nm/cl+dwcrXjDxfCyCuOqNyT8/mnQdWydV5GVTkwQF0b+gDEkJNgfYsbPpfnLwqihjx1LqOJbnNI/WBzzp3g8ILcQbTmHGOAavlVlTWB52r3g5DWMMcpxllJQnI5IbJ7dPKq5osGpkKv1h0XZNn/7tDpH3kgQ==;5:uyy5IYslcu3ah6urmiSbUSicrNWpoknB2ioI58LOgg0tGpzk7Wk6ZVWMVg7O4u3Sra7B3Hx6duiZcI27Xe0xE/w5ZpzPaIXkXjSEau06Ou5tJMAagtAFPMEMF4s+QeJSmKi+bE+A4FefM18iyYf1ag5zdeiNN9/O42o31Vb2cQo=;7:5TC79QYPh02gXtupYOdDVoI2qdxBFT9QNG/64go0M3d00TdE70cft9KMoXhbeyCqfj+RJLInY7M5LVvAS89yCamfR4R5Zmhk44F1NdqrScbEVtevtsuFTdzcL2CEQ3YFQ6M+G+hzaQp1To4TpMZgIJpWEJQbe/hz9kuAkyPvYOpvAy/JApNyZpcMbyB1gBzZinAr6EaUabBewrDhzXDdOBS86u7KtUvSFJYvdsM4UmLCfnJUMRcLQvcActSOAxNk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 03:22:05.0715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c8b39a-facc-4fd5-6dd5-08d601951e24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5301
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
v3:
    Update with comments [3] from Robin Murphy <robin.murphy@arm.com>

[3] https://lkml.org/lkml/2018/8/13/116

v2: update with comments [2] from Robin Murphy <robin.murphy@arm.com>

[2] https://lkml.org/lkml/2018/8/7/166

v1: Based on comments from Robin Murphy <robin.murphy@arm.com>
for patch [1]

[1] https://lkml.org/lkml/2018/4/19/780

 drivers/iommu/iova.c | 22 +++++++++++++++-------
 include/linux/iova.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe262..28ba8b6 100644
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
+		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
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
index 928442d..a930411 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -75,6 +75,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	unsigned long	max32_alloc_size; /* Size of last failed allocation */
 	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
-- 
2.9.4


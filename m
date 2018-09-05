Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29485C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB802087B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="KYeykfUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB802087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeIEI4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:56:33 -0400
Received: from mail-eopbgr710071.outbound.protection.outlook.com ([40.107.71.71]:2814
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbeIEI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqk7yimcksjabWgAgaPRayHI7eF/49oLEJCgmaObcD8=;
 b=KYeykfUKIamrm6Q74DOg9L2uWCSXe6Pjm783cc70/dwrDT48aRQ6EM7w+1C/exTbZiC3GaxbCSIDFxzt+tQT+tdUUaw2gw178q4dehTF0Te+UryxoDEzvWgie3/b0o0baRkxKeKBRIuUY+F9ceI1jS/qoYmGKwCD2mxI0g0GGFo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
Received: from mypc.cavium.com.com (111.93.218.67) by
 DM6PR07MB5306.namprd07.prod.outlook.com (2603:10b6:5:45::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 04:28:08 +0000
From:   Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Cc:     tomasz.nowicki@cavium.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH v4] iommu/iova: Optimise attempts to allocate iova from 32bit address range
Date:   Wed,  5 Sep 2018 09:57:36 +0530
Message-Id: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::28) To DM6PR07MB5306.namprd07.prod.outlook.com
 (2603:10b6:5:45::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156d6773-55c4-41cc-4dad-08d612e7fd73
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB5306;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5306;3:1rraQKxipT3uaCaUqG1NcairU7zejxwoEX5p3NKiV9LQl6P84H4oEie79q4C2JXJ7nFdnrh51b8OmBkKQ5s1Wy/Ugg/jA7BAtA36YXWrCY6qDUWn0tDFp1ti78q7T5m458zpIEIt+oGvwhsul9GcM5/qf9cm9GXhEdaOLpANZlCt8eXsO0sk83WtYD3yYeCeSXbHvdMTu/p3mVU9mRu78MXuWmSIrVQpjCHOMjuKX1XwNNTO1lFXvCKMn4/E1tOj;25:ow3EB28pGKlHAKoP4lAFlV6xBMfBVIYmKmi7KFPv1duNzciWcGS3LKy9TQvN3tLs0ecn8gdNiFioNhIduhuqJhUBI+VFLkyivQNcxgod3tkFxPZ2OpbzKsfBIO9ncSOZpklK0cRMOib2nJ3q5eGNGh6FMBNA65VqYB2mbYzkleay7m4enHmqXTCjHi66n8Z34NyZo5i7kf41LS1SKc2nUG3rZ9dWFJVeyDprVrB/Jru0s071q9TsPIOFmDFW+RM2Nhpn4GiTv3vSimgVtOCZ+3m8lo5FGVO75QVg+BNm0jAlZhQpfjWnclsMIBpD+5dfql/FGiqO9KuWpfkOnE7bDg==;31:7unUesS3ic4itKr0htN4VgfTBQWHTSBjVRhK6ZGtYugKJioIGhRMW2TFkvbj2h1mrLitv2MpNfJh6LtwVw8VTPfr0VqX7RfMTyCozX3r0OyGDwIsZ/bPB4/i8A3/SVkFOVFt8JsCDJgmtuilBa5FfG/6g19wD7X3n9XxkK1AOBePuuQSd1IlYSlDzpx8yXPOBSSSr97ryZ2tC6iwRlX/e+8gmwgYXz8quid5aYdQn8U=
X-MS-TrafficTypeDiagnostic: DM6PR07MB5306:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5306;20:uIeaVag4TAhfe8wcIOq4xj4zIjkeXKKk4HQZ1TShTBCjIe7DHqTIl7oMow6lh2fKOtuBiU5VMttUZYTGo8EgqQwL7+PS8iEEixiLjajLnYzcwAVVkIorl5N92BIRGdVII6DHchU2RzjUFL6a4AxuuRdnS2ZWBMkZpzo5pW5e9PkNKyRwzy9VuwPMjbWv2JEnFlF7dGDA5LRIW7Waa6sbo6ZPR4UziHaIQLVzEKSeFq0ZxaFELRZiFcYommyApbinB3bFxmUjqrrOJRvwUgJ0Yh3HGA0/CjTkcIpZQNdFd1z2+KhVNq5ELJ3efe2Lsf1wCU5RI2Ci3WpNVs7GNMPjrzdlSo1yeBtD/bIaf8GMTmTCXQ5ukDLh0i1+8O2e42iuklernfBEBAySUM0J891JZCkEipdVjMORAtKDARRKUsAg79rjwk4L+A1aYiRJfytmjpoKsP7ZfLX/L3W5ZBZFad7ePph5cXm6mKkh6eXXYKQ4ggrydMwD2SJSZ9dyorf9;4:mzlVW1MBxFpUI7+20KG5llyRvF1unxcs1tcNGZI8ArEMm8rvvO87FJYAsrsbRnpoPQsK7ZeLkec2bBJfsf6n1l1zRNR1xriQqYQrcjdsbsE8J9f87wN2grKfSSBYQyo1AiiaSpwYMM4n1S5Vq3b9TNI0NB9UrFETx5d3w+dE/MNIymy03rcisPdnQvhpFC2wS9HsemUJ80V7zyMwkKXsScYbnwSJ8NCwAutFMt6eFyKa+8lJ82KtJYsMOZjA18aVb+ktEXhtxWCk9WLxFMV96Xq0Vq7yyh9OSAUqLUWzktcW3CXmCuwGVMkLFQQAcyq0HTPFWR1VLV6MrkNh0zFp/uqOZI46g8Kc+Ebcy5QQyD8=
X-Microsoft-Antispam-PRVS: <DM6PR07MB53063B72F87635E1A7394A3383020@DM6PR07MB5306.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR07MB5306;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5306;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(50226002)(8936002)(97736004)(81166006)(4326008)(36756003)(486006)(68736007)(105586002)(25786009)(106356001)(6666003)(5660300001)(48376002)(6486002)(39060400002)(478600001)(44832011)(72206003)(16586007)(316002)(47776003)(8676002)(52116002)(7696005)(5009440100003)(66066001)(6512007)(6306002)(51416003)(966005)(186003)(1076002)(81156014)(7736002)(6506007)(305945005)(6116002)(3846002)(53936002)(476003)(14444005)(86362001)(16526019)(26005)(2616005)(956004)(50466002)(386003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5306;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB5306;23:QYzlFD/DNpB03Hl34ediL1BclRTpymXpJhG1spR3u?=
 =?us-ascii?Q?TP24Avq9LCcMB82Qvk4toamkgmpWpB17ukbYz5ieP8JAYXD0Ft75ECCTFukr?=
 =?us-ascii?Q?kb8EuACW1i2E26gmJpxxqYlZUNFs8AqQygq1AVW2BKDqRzt8Lpf56CmB2iIb?=
 =?us-ascii?Q?KjnhPHzbmTnfe2I8w0xZX+PO1YodmC5zQGC/Y8KBeppblgp9kKJlfUMPiFNi?=
 =?us-ascii?Q?HypTwmE639VVRYVgWKcJyLeMRpljyBZaKdgoY4fhDXoKPtqjTFqhTKoop65R?=
 =?us-ascii?Q?B7cVKXGZfoWby2CRzQsJteCAPibLSKGHBGJVbCU/JLEOmwWY9DFr56LAQAum?=
 =?us-ascii?Q?2btgLsDuIkOIRd+gEyUkDvEsu7o9Ss05uutQbXR/fTwdL1b0b7GP32sY6EKd?=
 =?us-ascii?Q?9fy+PCy21qcGIO2qBKNdRlCpa8JhI70QD06yLHTtsSm1B7npOqGF9TfHOujn?=
 =?us-ascii?Q?cZuQ1U8fj8pYn6d0uaiydLlrP3pmUfGnv4/O77qN7baBplnSA1jjxIUSKb+v?=
 =?us-ascii?Q?imHtm3UdQNS3igJ+dSU695D9cNiVxlzav6n32cR1w09ifsEW4RTJI6rhA54D?=
 =?us-ascii?Q?D+CwHn/YXiRQrHr+Zt+pLW/e1SiqfwJeGHgOfv5jp4dcvon3Y0D6Jq0ZZXri?=
 =?us-ascii?Q?ANUnjqZHoS9QpXSorFi0An6PeSzBaiNkmVnzhL6ZlnFnchi/wTeHBOEFbUoR?=
 =?us-ascii?Q?LKcWGHLL4eYR9zgBrEEuKTEiK1MDbZ54JeJ3F67NaN7/p4OT7GU3Z//TCpQp?=
 =?us-ascii?Q?pb+eYC+W5DDGTX2qetv2RufMBhY2rJV4itlLbdDSUZAV4XsafOxQWigQZwfB?=
 =?us-ascii?Q?33MlgNV7LE7ny27zjOOG1tf6tl8ZTVY8JdD0OP6meVo/SFfug+kkrxTF43PV?=
 =?us-ascii?Q?a7TJTzMsOJpzJKi4G5AnoZs0dmm4AATn7mlkF0r8dtteF1NuWubztfgP1z9S?=
 =?us-ascii?Q?kq+ZYuurDYEBkQO9IMz6ATvMScqVPZoxcYRuTQZ09K/HCvx1slhOtovhQUx5?=
 =?us-ascii?Q?BRPdMj8mZYEMTPgz9libjGvwlOsSf27U/KN9hIhJQxIzCFALfmaVKV9yP2H3?=
 =?us-ascii?Q?R5yMt7bRvlb9YAMCN+9P7vPruzfzJy2SZpv8GV929JYmkkRaCEzONIlGeOdS?=
 =?us-ascii?Q?9wMooIS06E5J0l7Y9+7UuQgejd5tkCb9a+yFkx4ktUKRZ1H0L9ypTHdcW08y?=
 =?us-ascii?Q?0m87cvwskKCgQ36DDOA+Otr49cLKFjLvPmJ3lsRo0/Frl0kr/LxxhkhX6XiK?=
 =?us-ascii?Q?LZa/CmJn9mUqsj50zkfEzkbAhisAMMDNeq40oj0O47Gdwt7mYnU0MQdGMW8R?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: WPlk5AW3rnJTu6ww748QX/DSpnwB4QR62LaZqsLc9faQJ+WWFSkfM67c5Lvq1cIfGwcBmyvPJ3Gc80MjSvfA51Bi3AkdVkDr01/5GTmIeMPyKt5vkBPlsFEQL01iaceMqjXcxzK199q2WfBMofAN67TNSWPOecRZUqKzVNu+JVaEc06khZqY7LHT2/qiNRx1nl8PmZfsnFyDOD0714bkrOAO5kY0at414AjjXche/YjeVl/XdJxCxN1M3cOJR6Qvy6Ml9L3II9CzWYeI2YOt7omONdDNatAsdPMDjkc5jiLUd/XsmpxHWDWhokt0CSZy/zhQNwdXDSNgmcGKzRJ8VX47wpTWZ2eD/EWKreD2xGs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5306;6:M8bQtQ/AGLZ0fbAzR4v38Wh+tBpf14tY98qIL13dZ+k71z/q0PxO5Ug0qPJNreFGICG3hBhYCVQT4gp+g8jD0wvAFE5oLBHrHX4Lhu+ZaMLn9TOphXBr3FNTwB7TZ48VzGuhMeHg7m41xEKEvq3TUxIR0i+AofWxBpAS6qB2XtGZAm61Kv9RpceO2lMoHTTRZefB7HJ2cBvyqvIskrnB+aMji6FqkDnkhHG2n9ruInpObQVLmLTVFMVV9RFkBeJju79TNULLVPRLKF/QhNaS31CEzFGVaCiZSRHcAQh9PXTRJAF7Gaic+ljiXhdjUCnlt67XLDKZIBJMj4929gWPBne+3CyoBwiPM/L8DKkNJ5Q98xzaWIg5qkbsOt2tiKeE1J/qwv1Q6am1K8Ic9q2gMRrQouHEI4SZtSc8AH1dScLJBjJNS4xh+6IKurzTEbAqhn9FNTEguHh7Q3wEKWHK7Q==;5:jfxI75oUMi1Xy4uUDU1TZMmx9jDmXaIzH/cvbipsIL8uCNWyQOYtjLgv7dMXglRsdCKSfyNyytqsk8nXIQH7tTeoIKMvknJDGY/cVvHVuUt5Z5Lo7TfZ459yMXlWYe6HIf41t54O2eKqXTVkYg3B+atZL67AUB2CxXyDr0Z5QCw=;7:qmte3EfoHHHc1Zwc+A5EjX7toPj/WphyK3Vyrhe1MkAeiD0ClwtDN8fiB5AmWJFDQtldM8IhiAKCCZsOkGHhmkztak2Kkdv49UzEROOkdP56JEy5at46V0+GZyuLd7N6RMNlX7wkjfY+ZinGoVb3/7u9G0VlcPHr6qbCjr3+tabcrph4A+5gPRGClaUJRmh4SI2ATvF4kA0qULla3mV/60ZCS4f1oOD5f9biMTdkeYCnkCIxIY+C/ZUi4SCytfJt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 04:28:08.7816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156d6773-55c4-41cc-4dad-08d612e7fd73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5306
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

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
v4:
    Rebsaed to 4.19-rc2
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
index 83fe2621effe..f8d3ba247523 100644
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
index 928442dda565..0b93bf96693e 100644
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
2.18.0


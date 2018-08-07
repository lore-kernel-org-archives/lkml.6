Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC8DC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1679208CB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="cbUOUFPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1679208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388379AbeHGLIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:08:41 -0400
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:37798
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbeHGLIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRMCiNqN3d3RFJBO4qewZr/O5PFQSAhn86jGeh21fKE=;
 b=cbUOUFPzxu9fSnwi7euHEnBbXKdhPFOWyjS14j5jeD3CXbrrfHL/XkcV/sE+qI4elY057wBaOchXwueB8UbsxxW0xPRxux87BioRq7u9JX95SgFyV6zJ2vqT+WUJwnhqxuddRW/31iaVwBnYQvTS0FouQ71/gHpBSe4mFmAqT1w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
Received: from mypc.cavium.com.com (111.93.218.67) by
 BYAPR07MB5303.namprd07.prod.outlook.com (2603:10b6:a03:65::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Tue, 7 Aug 2018 08:55:13 +0000
From:   Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Cc:     tomasz.nowicki@cavium.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Subject: [PATCH] iommu/iova: Optimise attempts to allocate iova from 32bit address range
Date:   Tue,  7 Aug 2018 14:24:37 +0530
Message-Id: <20180807085437.15965-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: DM5PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:3:93::34) To BYAPR07MB5303.namprd07.prod.outlook.com
 (2603:10b6:a03:65::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c78c7781-8925-4364-d427-08d5fc437f2b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5303;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5303;3:KnZmSchD50oIwfFrgAExGO71VoD5Tg9CON8rzRNmcQR83nGhW8oUzEFqn8EQz/PqS3Ty6Iq4JYp/NZzg7bI9dkl1aR1AvZ15zxXlPSlqvYMVehjLyF6rGjv9oQ47U6Cq95xTfNUPjLjGTYQdGWgJ+ngJHTBbKeowbbfWkIcRJvo8ucV/s03G9euS5M8/bYejkWHR/aZW242KqxrwLw74vzdCS4Auife3rzre4BxMUpVJ6MGaTDN2cj13ASmfml02;25:+QddtDyRNGx+Mj+KSIxpd13sptspzjiKL43gFrb6YQCMGCkHK8xrFse4iUXEV3KDtn2ZkhvhWgBHLKGtXSbf69XljtbeqorwYCeNYWkoO/vv1PutjeU+q8Pyzaq7vCvI5xNENr1wGFL2yqCoTlCuLaj0mM8N+HtC/2U8gYRD4yV2TpQRsLOFkhEJDIRjdsHdslpQeLS0EyHa7CVGVFYk4VvsIF6mm95+KAiZCn0E3OcQjTsAUSIk6FkFjZPcq9ghwssnzvgCTr8q3Dnh524gQi1V0mSrVjn2Y8axc3DaJI9tcGedIJuI1PdEnk875ZYwkfliaseossBe6JpTeRjRYA==;31:BbQcfdPQXuyQ0fvHwIeudariBAKKDjWDPqO7IISCVvzSbYuE+gZbNHfJ8cFfY/T5KPiSrOg/1C7bVgcXqrk4aSqUO6TrNEF3ig0ufl39GV7mzHWJ/UqswdKrUXAw0VAZRUvgXoTMz/KEeWyEXAxU9+1CdXViternVre+Kc/WPsXfYUq2+dvY90mNidMz8FksRvKTk9pLRN0nRhRyN2m6c9uVJQ4iE+vcNE0lBJr6hRs=
X-MS-TrafficTypeDiagnostic: BYAPR07MB5303:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5303;20:ofV0heZDqIl+UbSA8VoGS1/tFKDyVvNOf51sj87KPiOIdXGrGPUwTzM6mF54sP9uGlv0S6laPe7M7f60qdqXjyRl2+S0WJYGUucqeREMG4d8CFOQ7Mw5U0KUgC+aAQEwfPn24ro7BpCgjFrNXcpGmHWnEot1wiePEf1w1SL0557JIYvRpRCkeJkkTgi1Hcdz5nuYT47QERZH2AtpUbq27hyT11M1PpZAZMUkx0Qt7Cb1VGT9XGbRe54zyEc51tLinYByT1ZEDLgeHnQTaeDwb+6gi66vG+9wtwNtE4V4yvySjlYanvWUXLqKEgUwu/95hcvP8LK3t5ggvZfR3tvis/OHNg9Dp7SFdUpS6ZKwvjtFMiWIBTwIUYv/ndNcVpL/max6zRdYNu9up3jdqOTIFKsS6sJDoRWi2ja5WjonkLvfx/Hxab9R0AxvuazzODn9gU1lI+46YrdWNt5Mefo0Mg2tiURYnqVFHPeO0JsDtFU3DAuXgQIVhC3NdGfWwnKA;4:ACoRVc5eKbKr4loB1d5zVAUpWBr2r3hNYqPOuxqiyEgX2uJmQP3Zrtnt2DymUnlJZcE6OtuMxOXUgE5eqHWwz1gudOn8500Dibqg6+h+flmp5JYXQjXD3y1azoHEQQR1TIvOJHkSga6Q7URmxGozazjWU+1aYS9708k1VBlDPITL/znwYwbEWW6Uo+yPVagiVr6UOQl71zvdRx/had9UdW0cHb1JZ385XbSHQjhlVGK4LDUgaeTwhbOuwq80L2v5XI+OYTOmPOzTpYrUqE3KjR6SlxGaXrKMAARE4p02G2O/CMPfQzLVwHlMyG1/xgCD
X-Microsoft-Antispam-PRVS: <BYAPR07MB530308E6C6CC38977F6A98CC83270@BYAPR07MB5303.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5303;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5303;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(44832011)(39060400002)(26005)(5009440100003)(53936002)(6512007)(2616005)(97736004)(1857600001)(81156014)(8936002)(2906002)(3846002)(1076002)(81166006)(956004)(6306002)(6506007)(186003)(486006)(16526019)(8676002)(6116002)(4326008)(476003)(386003)(25786009)(6486002)(7696005)(305945005)(16586007)(72206003)(50466002)(6666003)(36756003)(5660300001)(51416003)(52116002)(7736002)(478600001)(47776003)(106356001)(50226002)(105586002)(48376002)(14444005)(86362001)(66066001)(316002)(966005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5303;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB5303;23:GjS90JDKxu5HvYX91abNBsXh8iL3+iK7n+qQdq2s6?=
 =?us-ascii?Q?RGWg/HEjinjuYecvTEm8FO3DF9QR6Pe8X+oqU5Vo3ITsVeg/FtAgrutUHUhQ?=
 =?us-ascii?Q?mEnUc77cBo997yLeE4AgIym04qdnRzpD0+jPDv41/BmOxQJf4T+RI2RgQkWT?=
 =?us-ascii?Q?Ycv2fF3jU3VmYTeAwD748aQzc2/GLDRfifYgz7AKe1OaxTo2dCJI7Wj/xmA6?=
 =?us-ascii?Q?CSEfXWF4U22K71tcHO/A6alRNAzvOu4aRGHk9KUP2cCHyr8DiPMDMo8rAJow?=
 =?us-ascii?Q?h/h+LERVeDcYG9UCLGagpKtrXtqH15t0EzeJAGfQOSSq7lz0eF0YeAiNeDPa?=
 =?us-ascii?Q?2xyEeuIT33SS+RgogWNok3DLRchOjVDT9UenFU2h17Cx5YxwCfD0MqSIoNdW?=
 =?us-ascii?Q?sae6vDeS30CvhNdWQn8QZItJXHAfeXu1EVx012bL2iKWpUBWSw0uuBOeIUQK?=
 =?us-ascii?Q?aa2E721E6Kslh1PIPYjLieLNKUf8mjrlskdQsGSdwxql7TpXNzl723BU6JFJ?=
 =?us-ascii?Q?eKEdjvIvk0o1+1SPXstptqycxRNuZo3g3JSYMb9NAeGViOKde/STPyVu8kqn?=
 =?us-ascii?Q?pOo9whdJ7A8BCDhg1/26cRhCuPOcbB2jGCsUYW056HteRx0rY0MXreFshf4N?=
 =?us-ascii?Q?6phP8ynXDpi7wqUWJt+mMe7lsUIi+bCOiQxrQyEi1qsiPNIdBdoeU/lzvpjl?=
 =?us-ascii?Q?GNim8xx+RuT67I5PqRWEkFxFoq/qp9IVvIWinjs8/HQEJtIa5j/0eMcYJZ+3?=
 =?us-ascii?Q?2cQLYsd+4BVaDJIhz6h0bT6Zov6CDeF0YyDjN3SSCwWUQKdx6PDFD8CfaUwJ?=
 =?us-ascii?Q?KjaZBGfEx4uXEdOV+YKy0aoC7OeUOxmQ8o01ZM0ccRdOfrX+8Et+xH+kQKcc?=
 =?us-ascii?Q?hCCraxa6AdzlAYYVYRIXXRuhELWX2zte2yZx4GX+AJpZpMOCm+CcJcmw48h1?=
 =?us-ascii?Q?3cQgFiOAmDp0iby/Myj3GTDlrLtSWOLiDN3ZmES9Q9lcZBUbQw7qSfZ8E4yK?=
 =?us-ascii?Q?7RwheVBEIkN5PhPN4xJMOYuYmFtPWUU2RsndKA2+yO3Sznv/cjsnt5BEUlXe?=
 =?us-ascii?Q?4WJf1bFgH4zhyd61TcOhlOiXsJHpCrOUPwcGhDGQUkTdbXZAgK3oZNXopMEk?=
 =?us-ascii?Q?ADbJ0Dbprlg8+b4PfmQc5gLmmzeQDMz/ASs8ScEfwEi8y/x59StYQmkGfjGM?=
 =?us-ascii?Q?pOb9K1442lo3Fy15NPzEb6xRhez7mB0ukKVkXGnuHe2Ie4ZRRnk256pClELf?=
 =?us-ascii?Q?sONl/kjDDnv8NTx1x7QVfenmFmTy+jEyMC3XHeqvFXa9/swWUk3bEvj4yREG?=
 =?us-ascii?Q?QeT4lpJOS9kAkTdIjB2uyU=3D?=
X-Microsoft-Antispam-Message-Info: Hw9tmq89dZ8DD+h0iiK2hiR8F2Iiux0qhm1hD3r+hZgFksCvLiqg8gjxk2LHNeKPVF1pRlNZIu7oFppGtQUxcrC7wB6n+L7rxbxy3B7OoFJ/oWn1PDxLFT/hvtpBEbzEhO2kmkLSb6As6mY5bySb9YcEoLo4N18kGtCoXB5vQMccNzU80B67pklJzFbLlDtrDEynXoACCndRDLuVDv66hdS7itJQrldmHVjp5Cjn4UsP+mU306qpFtblWygYtaPx9EYjwbXjb8oXgtnS+5JgTRRWZTOxujbNgYErBJXRHhN2KsfXEOolRy16LJLj9j2sJx5FSyPE6B8ETV0DruTzJX4GfVrFfJxqapqr4Gq5AMs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5303;6:0cuRftmW0cizWbPcrQWTB03cVY5/7SoXanXP3n6jhYORpm9W53xXFkC2kzi8VEjDn5eRYllTbamXnj5BIJgDd1UUp/Fj56ZvpThZx4Y+SL6ORoSJEHBl/BdLVzRslr1A4yS0IKjVy73tqTZpIxQjLbDC+DRHpA7B1JL0zkigriUiXK8n42/ppcVjnUER+kGwW7JcOaWSFmqUhpgRtLG2ILjq4lSa3nDQLcHYwRY+lkyIvrxTLuvC9GXyWoXOvEAj2WmCl/RiA4LxF8UU1l2NwxGHvHZAmIg6VypNlgcV0loRZzwqhY+dqFvH7qcJzJ7ppJEkNFoYtOBIpUjt2O1G3WdKPxJpXvcExt73dC3rSdKMRso3B/oafWHJYo6lnR11QQ7FLsrCo4dKJ46eUzj7TJc+0xY/d4F4RDEJhgO9YMOeQsKmXxEkZ6dqTIwduuQsbvHhc8e9YvbCtlLwyuGFMg==;5:d4nYYVH3QmIF0V/y0nQVXanCvzVtftvCrqGPgOpjJ179toGiFqL4LNSxHaHH5+LQPaA2fuOOJi54SkB8geXn6nwTKOdAuWfuduqIIiFeegHgp5Qxtt5uM0b95iQ9X0TLfzb5GjrlPpfo/alG+arnYJE/JuupskrqgoY8jfc4C9E=;7:2GJHpf7Oj9YB6zuSlBecu+fcvXl1iYzk75bK/jor4FmOb+TQPwoyg7bdFIkM+M9Xt93EOxwQBW2Bz4FZ97z+zDErp1gP0PuJ0IjBDbKHeEm+MfU0IRCzI+iYdHcKeebvcnD9A5F0AisUXf4FnZM17Jrhvsu99muMqN9gvVsSSWCy2VjPnvvCFkMe/VOtV4N4bqg/awfTgLWZ2p+MIa5xsDSLsH5bb2Sb7xBcBxOGNEG2Jfmyq4WME3/Le8C9F9w2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 08:55:13.4615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78c7781-8925-4364-d427-08d5fc437f2b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an optimisation for PCI devices, there is always first attempt
been made to allocate iova from SAC address range. This will lead
to unnecessary attempts/function calls, when there are no free ranges
available.

This patch optimises by adding flag to track previous failed attempts
and avoids further attempts until replenish happens.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
This patch is based on comments from Robin Murphy <robin.murphy@arm.com>
for patch [1]

[1] https://lkml.org/lkml/2018/4/19/780

 drivers/iommu/iova.c | 11 ++++++++++-
 include/linux/iova.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe262..d97bb5a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
+	iovad->free_32bit_pfns = true;
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
@@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 
 	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
 	if (free->pfn_hi < iovad->dma_32bit_pfn &&
-	    free->pfn_lo >= cached_iova->pfn_lo)
+	    free->pfn_lo >= cached_iova->pfn_lo) {
 		iovad->cached32_node = rb_next(&free->node);
+		iovad->free_32bit_pfns = true;
+	}
 
 	cached_iova = rb_entry(iovad->cached_node, struct iova, node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
@@ -290,6 +293,10 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 	struct iova *new_iova;
 	int ret;
 
+	if (limit_pfn <= iovad->dma_32bit_pfn &&
+			!iovad->free_32bit_pfns)
+		return NULL;
+
 	new_iova = alloc_iova_mem();
 	if (!new_iova)
 		return NULL;
@@ -299,6 +306,8 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 
 	if (ret) {
 		free_iova_mem(new_iova);
+		if (limit_pfn <= iovad->dma_32bit_pfn)
+			iovad->free_32bit_pfns = false;
 		return NULL;
 	}
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 928442d..3810ba9 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -96,6 +96,7 @@ struct iova_domain {
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
+	bool	free_32bit_pfns;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.9.4


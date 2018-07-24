Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0563C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF1D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF1D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbeGXOum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:50:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53058 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388348AbeGXOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:50:42 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ODfCgF015606;
        Tue, 24 Jul 2018 06:44:03 -0700
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2kc4bg8gmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Jul 2018 06:44:03 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 24 Jul
 2018 06:44:01 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 24 Jul
 2018 16:43:59 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 24 Jul 2018 06:43:58 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id F39D53F703F;
        Tue, 24 Jul 2018 06:08:42 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
CC:     <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <nadavh@marvell.com>, <omrii@marvell.com>, <oferh@marvell.com>,
        <gregory.clement@bootlin.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 1/1] dmaengine: mv_xor_v2: use {lower,upper}_32_bits to configure HW descriptor address
Date:   Tue, 24 Jul 2018 16:40:30 +0300
Message-ID: <1532439630-23555-1-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=495 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

>> drivers/dma/mv_xor_v2.c:647:36: sparse: constant 0xFFFF00000000 is so big it is long
   include/linux/device.h:678:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/device.h:678:13: sparse: call with no type!

Use lower_32_bits and upper_32_bits to set the hw_desq address, instead of
using constant.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 drivers/dma/mv_xor_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index d41d916..8dc0aa4 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -642,9 +642,9 @@ static int mv_xor_v2_descq_init(struct mv_xor_v2_device *xor_dev)
 	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_SIZE_OFF);
 
 	/* write the DESQ address to the DMA enngine*/
-	writel(xor_dev->hw_desq & 0xFFFFFFFF,
+	writel(lower_32_bits(xor_dev->hw_desq),
 	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_BALR_OFF);
-	writel((xor_dev->hw_desq & 0xFFFF00000000) >> 32,
+	writel(upper_32_bits(xor_dev->hw_desq),
 	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_BAHR_OFF);
 
 	/*
-- 
1.9.1


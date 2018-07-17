Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1428B20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1428B20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeGQLFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:05:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53712 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729717AbeGQLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:05:37 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HAUMTW022403;
        Tue, 17 Jul 2018 03:33:36 -0700
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2k7gpg8rt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Jul 2018 03:33:36 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 17 Jul
 2018 03:33:33 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 17 Jul
 2018 13:33:32 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 03:33:31 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id C51AC3F7040;
        Tue, 17 Jul 2018 02:58:11 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
CC:     <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <nadavh@marvell.com>, <omrii@marvell.com>, <oferh@marvell.com>,
        <gregory.clement@bootlin.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 1/5] dmaengine: mv_xor_v2: explicitly freeup irq
Date:   Tue, 17 Jul 2018 13:29:59 +0300
Message-ID: <1531823403-3683-2-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531823403-3683-1-git-send-email-hannah@marvell.com>
References: <1531823403-3683-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=639 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

dmaengine device should explicitly call devm_free_irq() when using
devm_request_irq().

The irq is still ON when devices remove is executed and irq should be
quiesced before remove is completed.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 drivers/dma/mv_xor_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index c6589cc..e16083a 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -174,6 +174,7 @@ struct mv_xor_v2_device {
 	int desc_size;
 	unsigned int npendings;
 	unsigned int hw_queue_idx;
+	struct msi_desc *msi_desc;
 };
 
 /**
@@ -780,6 +781,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	msi_desc = first_msi_entry(&pdev->dev);
 	if (!msi_desc)
 		goto free_msi_irqs;
+	xor_dev->msi_desc = msi_desc;
 
 	ret = devm_request_irq(&pdev->dev, msi_desc->irq,
 			       mv_xor_v2_interrupt_handler, 0,
@@ -897,6 +899,8 @@ static int mv_xor_v2_remove(struct platform_device *pdev)
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 
+	devm_free_irq(&pdev->dev, xor_dev->msi_desc->irq, xor_dev);
+
 	platform_msi_domain_free_irqs(&pdev->dev);
 
 	clk_disable_unprepare(xor_dev->clk);
-- 
1.9.1


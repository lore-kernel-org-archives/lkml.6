Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D92C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AB02073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AB02073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeH3RW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:22:28 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:56752 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbeH3RW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:22:28 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UDJVeE030914;
        Thu, 30 Aug 2018 08:20:08 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2m33hnprmb-1;
        Thu, 30 Aug 2018 08:20:07 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 52221611E12C;
        Thu, 30 Aug 2018 08:20:07 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 Aug 2018
 14:20:06 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7UDK5Td025647;        Thu, 30 Aug 2018 14:20:05 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v11 1/2] mfd: madera: Add irqchip data pointer into struct madera
Date:   Thu, 30 Aug 2018 14:20:04 +0100
Message-ID: <20180830132005.19500-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=982 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808300139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the pointer to struct regmap_irq_chip_data into the parent
mfd structure so that the child irqchip driver does not need
a trivial private structure to store only this pointer. As
the irqchip child driver already has a pointer to the parent
struct madera it can use that to store the pointer. This also
means that the irqchip driver does not need a double-indirection
from its local struct to get at the parent struct madera.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/mfd/madera/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index c332681848ef..fe69c0f4398f 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -148,6 +148,7 @@ struct snd_soc_dapm_context;
  * @internal_dcvdd:	true if DCVDD is supplied from the internal LDO1
  * @pdata:		our pdata
  * @irq_dev:		the irqchip child driver device
+ * @irq_data:		pointer to irqchip data for the child irqchip driver
  * @irq:		host irq number from SPI or I2C configuration
  * @out_clamp:		indicates output clamp state for each analogue output
  * @out_shorted:	indicates short circuit state for each analogue output
@@ -175,6 +176,7 @@ struct madera {
 	struct madera_pdata pdata;
 
 	struct device *irq_dev;
+	struct regmap_irq_chip_data *irq_data;
 	int irq;
 
 	unsigned int num_micbias;
-- 
2.11.0


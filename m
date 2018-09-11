Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C52C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF6420865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF6420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeIKMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:25:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9507 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbeIKMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:25:34 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8B7OJCx031677;
        Tue, 11 Sep 2018 09:27:10 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2me96f8260-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 09:27:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C2AA3F;
        Tue, 11 Sep 2018 07:27:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F34991E06;
        Tue, 11 Sep 2018 07:27:09 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 11 Sep 2018 09:27:09
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 7/7] dmaengine: stm32-mdma: enable descriptor_reuse
Date:   Tue, 11 Sep 2018 09:27:00 +0200
Message-ID: <1536650820-16076-8-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable reuse to spare descriptors creation on critical UC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-mdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 6b6e63b..80a17dd 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1715,6 +1715,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	dd->device_resume = stm32_mdma_resume;
 	dd->device_terminate_all = stm32_mdma_terminate_all;
 	dd->device_synchronize = stm32_mdma_synchronize;
+	dd->descriptor_reuse = true;
+
 	dd->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 		BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-- 
2.7.4


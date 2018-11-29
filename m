Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7645BC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444CB2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444CB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeK3Igz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:36:55 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:64871 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbeK3Igz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:36:55 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wATLTaCk001701;
        Thu, 29 Nov 2018 22:30:03 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nxvnb6ggj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 29 Nov 2018 22:30:03 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BEFB4468;
        Thu, 29 Nov 2018 22:29:33 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0DD55983;
        Thu, 29 Nov 2018 21:30:02 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov
 2018 22:30:02 +0100
Received: from localhost (10.129.6.191) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov 2018 22:30:01
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 5/7] remoteproc: fix rproc_alloc_carveout() for rproc with iommu domain
Date:   Thu, 29 Nov 2018 22:29:26 +0100
Message-ID: <1543526968-56091-6-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543526968-56091-1-git-send-email-loic.pallardy@st.com>
References: <1543526968-56091-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.191]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_13:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct remoteproc core behavior when memory carveout device
address is fixed in resource table and rproc device doesn't have
associated IOMMU.
Current returned error is breaking legacy on TI platforms.
This patch restores previous behavior. It adds a warn message when
allocation doesn't fit carveout request, but doesn't stop rproc_start()
sequence anymore.

Fixes: 3bc8140b157c ("remoteproc: configure IOMMU only if device address requested")

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 61c954bd695e..f19bc6961e40 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -719,6 +719,18 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 	dev_dbg(dev, "carveout va %pK, dma %pad, len 0x%x\n",
 		va, &dma, mem->len);
 
+	if (mem->da != FW_RSC_ADDR_ANY && !rproc->domain) {
+		/*
+		 * Check requested da is equal to dma address
+		 * and print a warn message in case of missalignment.
+		 * Don't stop rproc_start sequence as coprocessor may
+		 * build pa to da translation on its side.
+		 */
+		if (mem->da != (u32)dma)
+			dev_warn(dev->parent,
+				 "Allocated carveout doesn't fit device address request\n");
+	}
+
 	/*
 	 * Ok, this is non-standard.
 	 *
@@ -736,15 +748,7 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 	 * to use the iommu-based DMA API: we expect 'dma' to contain the
 	 * physical address in this case.
 	 */
-
-	if (mem->da != FW_RSC_ADDR_ANY) {
-		if (!rproc->domain) {
-			dev_err(dev->parent,
-				"Bad carveout rsc configuration\n");
-			ret = -ENOMEM;
-			goto dma_free;
-		}
-
+	if (mem->da != FW_RSC_ADDR_ANY && rproc->domain) {
 		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
 		if (!mapping) {
 			ret = -ENOMEM;
@@ -771,7 +775,9 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 
 		dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
 			mem->da, &dma);
-	} else {
+	}
+
+	if (mem->da == FW_RSC_ADDR_ANY) {
 		/* Update device address as undefined by requester */
 		if (sizeof(dma_addr_t) > sizeof(u32))
 			dev_warn(dev, "DMA address cast in 32bit to fit resource table format\n");
-- 
2.7.4


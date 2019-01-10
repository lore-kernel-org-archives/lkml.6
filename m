Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0820879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAJNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:49:47 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56059 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729056AbfAJNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:49:31 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADfeXi000390;
        Thu, 10 Jan 2019 14:49:25 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptybn9m4m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:49:25 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6B2D38;
        Thu, 10 Jan 2019 13:49:24 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB503504D;
        Thu, 10 Jan 2019 13:49:24 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:49:24 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:49:24
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 5/7] remoteproc: fix rproc_alloc_carveout() for rproc with iommu domain
Date:   Thu, 10 Jan 2019 14:49:09 +0100
Message-ID: <1547128151-44077-6-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
References: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_04:,,
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
index 0ecd37993f41..e85722ee156b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -721,6 +721,18 @@ static int rproc_alloc_carveout(struct rproc *rproc,
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
@@ -738,15 +750,7 @@ static int rproc_alloc_carveout(struct rproc *rproc,
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
@@ -773,7 +777,9 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 
 		dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
 			mem->da, &dma);
-	} else {
+	}
+
+	if (mem->da == FW_RSC_ADDR_ANY) {
 		/* Update device address as undefined by requester */
 		if ((u64)dma & HIGH_BITS_MASK)
 			dev_warn(dev, "DMA address cast in 32bit to fit resource table format\n");
-- 
2.7.4


Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A3C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F45E208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F45E208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbeG0OhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39847 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732452AbeG0OhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDE242014483;
        Fri, 27 Jul 2018 15:15:21 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg1tj8pt1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:21 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7DB0338;
        Fri, 27 Jul 2018 13:15:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FCA75780;
        Fri, 27 Jul 2018 13:15:20 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:19
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 02/17] remoteproc: add rproc_va_to_pa function
Date:   Fri, 27 Jul 2018 15:14:37 +0200
Message-ID: <1532697292-14272-3-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new function translates CPU virtual address in
CPU physical one according to virtual address location.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 437fabf..8e5fe1e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -140,6 +140,22 @@ static void rproc_disable_iommu(struct rproc *rproc)
 	iommu_domain_free(domain);
 }
 
+static phys_addr_t rproc_va_to_pa(void *cpu_addr)
+{
+	/*
+	 * Return physical address according to virtual address location
+	 * - in vmalloc: if region ioremapped or defined as dma_alloc_coherent
+	 * - in kernel: if region allocated in generic dma memory pool
+	 */
+	if (is_vmalloc_addr(cpu_addr)) {
+		return page_to_phys(vmalloc_to_page(cpu_addr)) +
+				    offset_in_page(cpu_addr);
+	}
+
+	WARN_ON(!virt_addr_valid(cpu_addr));
+	return virt_to_phys(cpu_addr);
+}
+
 /**
  * rproc_da_to_va() - lookup the kernel virtual address for a remoteproc address
  * @rproc: handle of a remote processor
@@ -711,7 +727,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	 * In this case, the device address and the physical address
 	 * are the same.
 	 */
-	rsc->pa = dma;
+	rsc->pa = (u32)rproc_va_to_pa(va);
 
 	carveout->va = va;
 	carveout->len = rsc->len;
-- 
1.9.1


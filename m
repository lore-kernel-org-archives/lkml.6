Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2484CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D715F208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D715F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbeG0OiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:38:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39860 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388587AbeG0Oh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDE4if014486;
        Fri, 27 Jul 2018 15:15:29 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg1tj8pu4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 054C431;
        Fri, 27 Jul 2018 13:15:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDBD5577A;
        Fri, 27 Jul 2018 13:15:28 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:28
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 11/17] remoteproc: modify rproc_handle_carveout to support pre-registered region
Date:   Fri, 27 Jul 2018 15:14:46 +0200
Message-ID: <1532697292-14272-12-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current version rproc_handle_carveout() function registers carveout
for allocation.
This patch extends rproc_handle_carveout() function to support
pre-registered region. Match is done on region name, then requested
device address and length are checked.
If match found, pre-registered region is associated with resource
table request.
If no name match found, new carveout is registered for allocation.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5dd5edf..c543d04 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -840,6 +840,29 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
 		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
 
+	/*
+	 * Check carveout rsc already part of a registered carveout,
+	 * Search by name, then check the da and length
+	 */
+	carveout = rproc_find_carveout_by_name(rproc, rsc->name);
+
+	if (carveout) {
+		if (carveout->rsc_offset != FW_RSC_ADDR_ANY) {
+			dev_err(dev,
+				"Carveout already associated to resource table\n");
+			return -ENOMEM;
+		}
+
+		if (rproc_check_carveout_da(rproc, carveout, rsc->da, rsc->len))
+			return -ENOMEM;
+
+		/* Update memory carveout with resource table info */
+		carveout->rsc_offset = offset;
+		carveout->flags = rsc->flags;
+
+		return 0;
+	}
+
 	/* Register carveout in in list */
 	carveout = rproc_mem_entry_init(dev, 0, 0, rsc->len, rsc->da,
 					rproc_alloc_carveout,
@@ -1120,8 +1143,15 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
 			 * In this case, the device address and the physical address
 			 * are the same.
 			 */
+
+			/* Use va if defined else dma to generate pa */
 			if (entry->va)
 				rsc->pa = (u32)rproc_va_to_pa(entry->va);
+			else
+				rsc->pa = (u32)entry->dma;
+
+			rsc->da = entry->da;
+			rsc->len = entry->len;
 		}
 	}
 
-- 
1.9.1


Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC09C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E07E208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E07E208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbeG0OiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:38:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10721 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388585AbeG0OhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDESkq024978;
        Fri, 27 Jul 2018 15:15:28 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kg1up0nsm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EECF238;
        Fri, 27 Jul 2018 13:15:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4B21577A;
        Fri, 27 Jul 2018 13:15:27 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:27
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 10/17] remoteproc: add helper function to check carveout device address
Date:   Fri, 27 Jul 2018 15:14:45 +0200
Message-ID: <1532697292-14272-11-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a function to verify that a specified carveout
is fitting request device address and associated length

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1e0fe3e..5dd5edf 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -259,6 +259,53 @@ struct rproc_mem_entry *
 	return mem;
 }
 
+/**
+ * rproc_check_carveout_da() - Check specified carveout da configuration
+ * @rproc: handle of a remote processor
+ * @mem: pointer on carveout to check
+ * @da: area device address
+ * @len: associated area size
+ *
+ * This function is a helper function to verify requested device area (couple
+ * da, len) is part of specified carevout.
+ *
+ * Return: 0 if carveout matchs request else -ENOMEM
+ */
+int rproc_check_carveout_da(struct rproc *rproc, struct rproc_mem_entry *mem,
+			    u32 da, u32 len)
+{
+	struct device *dev = &rproc->dev;
+	int delta = 0;
+
+	/* Check requested resource length */
+	if (len > mem->len) {
+		dev_err(dev, "Registered carveout doesn't fit len request\n");
+		return -ENOMEM;
+	}
+
+	if (da != FW_RSC_ADDR_ANY && mem->da == FW_RSC_ADDR_ANY) {
+		/* Update existing carveout da */
+		mem->da = da;
+	} else if (da != FW_RSC_ADDR_ANY && mem->da != FW_RSC_ADDR_ANY) {
+		delta = da - mem->da;
+
+		/* Check requested resource belongs to registered carveout */
+		if (delta < 0) {
+			dev_err(dev,
+				"Registered carveout doesn't fit da request\n");
+			return -ENOMEM;
+		}
+
+		if (delta + len > mem->len) {
+			dev_err(dev,
+				"Registered carveout doesn't fit len request\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 {
 	struct rproc *rproc = rvdev->rproc;
-- 
1.9.1


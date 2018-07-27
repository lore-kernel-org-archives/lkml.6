Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF9C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700B4208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700B4208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbeG0OhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11802 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388298AbeG0OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDEjsr025001;
        Fri, 27 Jul 2018 15:15:24 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kg1up0ns8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DA6631;
        Fri, 27 Jul 2018 13:15:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 156EB577A;
        Fri, 27 Jul 2018 13:15:24 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:23
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 06/17] remoteproc: introduce rproc_add_carveout function
Date:   Fri, 27 Jul 2018 15:14:41 +0200
Message-ID: <1532697292-14272-7-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new API to allow platform driver to register
platform specific carveout regions.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
 include/linux/remoteproc.h           |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index b76760e..fe6c4e4 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -747,7 +747,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	if (!carveout)
 		goto free_carv;
 
-	list_add_tail(&carveout->node, &rproc->carveouts);
+	rproc_add_carveout(rproc, carveout);
 
 	return 0;
 
@@ -761,6 +761,20 @@ static int rproc_handle_carveout(struct rproc *rproc,
 }
 
 /**
+ * rproc_add_carveout() - register an allocated carveout region
+ * @rproc: rproc handle
+ * @mem: memory entry to register
+ *
+ * This function registers specified memory entry in @rproc carveouts list.
+ * Specified carveout should have been allocated before registering.
+ */
+void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
+{
+	list_add_tail(&mem->node, &rproc->carveouts);
+}
+EXPORT_SYMBOL(rproc_add_carveout);
+
+/**
  * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
  * @dev: pointer on device struct
  * @va: virtual address
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 4bc961f..55f30fc 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -558,6 +558,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 int rproc_del(struct rproc *rproc);
 void rproc_free(struct rproc *rproc);
 
+void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
+
 struct rproc_mem_entry *
 rproc_mem_entry_init(struct device *dev,
 		     void *va, dma_addr_t dma, int len, u32 da,
-- 
1.9.1


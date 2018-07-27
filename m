Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9620C208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9620C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbeG0Oh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25781 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732124AbeG0Oh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:26 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDEJ0x016198;
        Fri, 27 Jul 2018 15:15:27 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg26xrjvt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C30531;
        Fri, 27 Jul 2018 13:15:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C7C5577E;
        Fri, 27 Jul 2018 13:15:27 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:26
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 09/17] remoteproc: add helper function to allocate rproc_mem_entry from reserved memory
Date:   Fri, 27 Jul 2018 15:14:44 +0200
Message-ID: <1532697292-14272-10-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces rproc_res_mem_entry_init() helper function to
allocate a rproc_mem_entry structure from a reserved memory region.
In that case, rproc_mem_entry structure has no alloc and release ops.
It will be used to assigned the specified reserved memory to any
rproc sub device.
Relation between rproc_mem_entry and rproc sub device will be done
by name.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 37 ++++++++++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  6 ++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 2c51549..1e0fe3e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -857,6 +857,7 @@ struct rproc_mem_entry *
 	mem->alloc = alloc;
 	mem->release = release;
 	mem->rsc_offset = FW_RSC_ADDR_ANY;
+	mem->of_resm_idx = -1;
 
 	va_start(args, name);
 	vsnprintf(mem->name, sizeof(mem->name), name, args);
@@ -867,6 +868,42 @@ struct rproc_mem_entry *
 EXPORT_SYMBOL(rproc_mem_entry_init);
 
 /**
+ * rproc_of_resm_mem_entry_init() - allocate and initialize rproc_mem_entry struct
+ * from a reserved memory phandle
+ * @dev: pointer on device struct
+ * @of_resm_idx: reserved memory phandle index in "memory-region"
+ * @len: memory carveout length
+ * @da: device address
+ * @name: carveout name
+ *
+ * This function allocates a rproc_mem_entry struct and fill it with parameters
+ * provided by client.
+ */
+struct rproc_mem_entry *
+rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, int len,
+			     u32 da, const char *name, ...)
+{
+	struct rproc_mem_entry *mem;
+	va_list args;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return mem;
+
+	mem->da = da;
+	mem->len = len;
+	mem->rsc_offset = FW_RSC_ADDR_ANY;
+	mem->of_resm_idx = of_resm_idx;
+
+	va_start(args, name);
+	vsnprintf(mem->name, sizeof(mem->name), name, args);
+	va_end(args);
+
+	return mem;
+}
+EXPORT_SYMBOL(rproc_of_resm_mem_entry_init);
+
+/**
  * A lookup table for resource handlers. The indices are defined in
  * enum fw_resource_type.
  */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index ea95b04..4cdd0c6 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -319,6 +319,7 @@ struct fw_rsc_vdev {
  * @node: list node
  * @rsc_offset: offset in resource table
  * @flags: iommu protection flags
+ * @of_resm_idx: reserved memory phandle index
  * @alloc: specific memory allocator function
  */
 struct rproc_mem_entry {
@@ -331,6 +332,7 @@ struct rproc_mem_entry {
 	struct list_head node;
 	u32 rsc_offset;
 	u32 flags;
+	u32 of_resm_idx;
 	int (*alloc)(struct rproc *rproc, struct rproc_mem_entry *mem);
 	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
 };
@@ -573,6 +575,10 @@ struct rproc_mem_entry *
 		     int (*release)(struct rproc *, struct rproc_mem_entry *),
 		     const char *name, ...);
 
+struct rproc_mem_entry *
+rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, int len,
+			     u32 da, const char *name, ...);
+
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
-- 
1.9.1


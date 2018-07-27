Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A1EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FF2208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FF2208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbeG0Oha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55205 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732124AbeG0Oh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:29 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDEJ11016198;
        Fri, 27 Jul 2018 15:15:32 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg26xrjwa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7D9638;
        Fri, 27 Jul 2018 13:15:31 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CDCE4577E;
        Fri, 27 Jul 2018 13:15:31 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:31
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 14/17] remoteproc: keystone: declare reserved memory region for vdev device
Date:   Fri, 27 Jul 2018 15:14:49 +0200
Message-ID: <1532697292-14272-15-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces keystone_rproc_parse_fw() to declare a
carveout region based on reserved memory for vdev buffer
allocation, if a memory region has been declared on rproc DT node.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/keystone_remoteproc.c | 53 +++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index aaac311..ef542f2 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -293,11 +293,56 @@ static void *keystone_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	return (__force void *)va;
 }
 
+/*
+ * Custom function to register platform specific memory region(s)
+ * before loading firmware resource table thanks to generic
+ * rproc_elf_load_rsc_table() function.
+ */
+static int keystone_rproc_parse_fw(struct rproc *rproc,
+				   const struct firmware *fw)
+{
+	struct device *dev = rproc->dev.parent;
+	struct rproc_mem_entry *mem;
+	struct device_node *node;
+	struct resource res;
+	int err;
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!node) {
+		dev_warn(dev, "No memory-region specified\n");
+		goto out;
+	}
+
+	err = of_address_to_resource(node, 0, &res);
+	if (err) {
+		dev_err(dev, "Bad memory-region definition\n");
+		return err;
+	}
+
+	/* Register memory region for vdev buffer allocation */
+	mem = rproc_of_resm_mem_entry_init(dev, 0, resource_size(&res),
+					   res.start, "vdev0buffer");
+
+	if (!mem)
+		return -ENOMEM;
+
+	rproc_add_carveout(rproc, mem);
+
+out:
+	return rproc_elf_load_rsc_table(rproc, fw);
+}
+
 static const struct rproc_ops keystone_rproc_ops = {
-	.start		= keystone_rproc_start,
-	.stop		= keystone_rproc_stop,
-	.kick		= keystone_rproc_kick,
-	.da_to_va	= keystone_rproc_da_to_va,
+	.start			= keystone_rproc_start,
+	.stop			= keystone_rproc_stop,
+	.kick			= keystone_rproc_kick,
+	.da_to_va		= keystone_rproc_da_to_va,
+	.parse_fw		= keystone_rproc_parse_fw,
+	.load			= rproc_elf_load_segments,
+	.find_loaded_rsc_table	= rproc_elf_find_loaded_rsc_table,
+	.sanity_check		= rproc_elf_sanity_check,
+	.get_boot_addr		= rproc_elf_get_boot_addr,
+
 };
 
 static int keystone_rproc_of_get_memories(struct platform_device *pdev,
-- 
1.9.1


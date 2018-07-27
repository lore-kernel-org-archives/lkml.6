Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E83C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFC6208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFC6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388806AbeG0Ohc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39878 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388746AbeG0Ohb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDE18u014480;
        Fri, 27 Jul 2018 15:15:33 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg1tj8puj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E53533A;
        Fri, 27 Jul 2018 13:15:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2B58577E;
        Fri, 27 Jul 2018 13:15:32 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:32
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 15/17] remoteproc: da8xx: declare reserved memory region for vdev device
Date:   Fri, 27 Jul 2018 15:14:50 +0200
Message-ID: <1532697292-14272-16-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces da8xx_rproc_parse_fw() to declare a
carveout region based on reserved memory for vdev buffer
allocation.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b668e32..679a076 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
@@ -179,10 +180,47 @@ static void da8xx_rproc_kick(struct rproc *rproc, int vqid)
 	writel(SYSCFG_CHIPSIG2, drproc->chipsig);
 }
 
+static int da8xx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = rproc->dev.parent;
+	struct rproc_mem_entry *mem;
+	struct device_node *node;
+	struct resource res;
+	int err;
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!node) {
+		dev_err(dev, "No memory-region specified\n");
+		return -EINVAL;
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
+	return rproc_elf_load_rsc_table(rproc, fw);
+}
+
 static const struct rproc_ops da8xx_rproc_ops = {
 	.start = da8xx_rproc_start,
 	.stop = da8xx_rproc_stop,
 	.kick = da8xx_rproc_kick,
+	.parse_fw = da8xx_rproc_parse_fw,
+	.load = rproc_elf_load_segments,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.sanity_check = rproc_elf_sanity_check,
+	.get_boot_addr = rproc_elf_get_boot_addr,
 };
 
 static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
-- 
1.9.1


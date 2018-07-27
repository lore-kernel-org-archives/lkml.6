Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BFDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003E0208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003E0208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbeG0Ohn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10631 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388298AbeG0Ohb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:31 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDEIkv016195;
        Fri, 27 Jul 2018 15:15:35 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg26xrjwm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56D3A34;
        Fri, 27 Jul 2018 13:15:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37CBA577E;
        Fri, 27 Jul 2018 13:15:34 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:33
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 16/17] remoteproc: st: add reserved memory support
Date:   Fri, 27 Jul 2018 15:14:51 +0200
Message-ID: <1532697292-14272-17-git-send-email-loic.pallardy@st.com>
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

ST remote processor needs some specified memory regions for
firmware and IPC.
Memory regions are defined as reserved memory and should
be registered in remoteproc core thanks to rproc_add_carveout
function before rproc_start. For this, st rproc driver implements
prepare ops.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/st_remoteproc.c | 96 +++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index aacef0e..45958d5 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
@@ -91,6 +92,82 @@ static void st_rproc_kick(struct rproc *rproc, int vqid)
 		dev_err(dev, "failed to send message via mbox: %d\n", ret);
 }
 
+static int st_rproc_mem_alloc(struct rproc *rproc,
+			      struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	va = ioremap_wc(mem->dma, mem->len);
+	if (!va) {
+		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+			&mem->dma, mem->len);
+		return -ENOMEM;
+	}
+
+	/* Update memory entry va */
+	mem->va = va;
+
+	return 0;
+}
+
+static int st_rproc_mem_release(struct rproc *rproc,
+				struct rproc_mem_entry *mem)
+{
+	iounmap(mem->va);
+
+	return 0;
+}
+
+static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = rproc->dev.parent;
+	struct device_node *np = dev->of_node;
+	struct rproc_mem_entry *mem;
+	void *va;
+	struct reserved_mem *rmem;
+	struct of_phandle_iterator it;
+	int err, index = 0;
+
+	of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
+	while ((err = of_phandle_iterator_next(&it)) == 0) {
+		va = NULL;
+		rmem = of_reserved_mem_lookup(it.node);
+
+		/*  No need to map vdev buffer */
+		if (strcmp(it.node->name, "vdev0buffer")) {
+			va = devm_ioremap_wc(dev, rmem->base, rmem->size);
+			if (!va) {
+				dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+					&rmem->base, rmem->size);
+				return -ENOMEM;
+			}
+
+			/* Register memory region */
+			mem = rproc_mem_entry_init(dev, va,
+						   (dma_addr_t)rmem->base,
+						   rmem->size, rmem->base,
+						   st_rproc_mem_alloc,
+						   st_rproc_mem_release,
+						   it.node->name);
+		} else {
+			/* Register reserved memory for vdev buffer allocation */
+			mem = rproc_of_resm_mem_entry_init(dev, index,
+							   rmem->size,
+							   rmem->base,
+							   it.node->name);
+		}
+
+		if (!mem)
+			return -ENOMEM;
+
+		rproc_add_carveout(rproc, mem);
+		index++;
+	}
+
+	return rproc_elf_load_rsc_table(rproc, fw);
+}
+
 static int st_rproc_start(struct rproc *rproc)
 {
 	struct st_rproc *ddata = rproc->priv;
@@ -158,9 +235,14 @@ static int st_rproc_stop(struct rproc *rproc)
 }
 
 static const struct rproc_ops st_rproc_ops = {
-	.kick		= st_rproc_kick,
-	.start		= st_rproc_start,
-	.stop		= st_rproc_stop,
+	.kick			= st_rproc_kick,
+	.start			= st_rproc_start,
+	.stop			= st_rproc_stop,
+	.parse_fw		= st_rproc_parse_fw,
+	.load			= rproc_elf_load_segments,
+	.find_loaded_rsc_table	= rproc_elf_find_loaded_rsc_table,
+	.sanity_check		= rproc_elf_sanity_check,
+	.get_boot_addr		= rproc_elf_get_boot_addr,
 };
 
 /*
@@ -254,12 +336,6 @@ static int st_rproc_parse_dt(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	err = of_reserved_mem_device_init(dev);
-	if (err) {
-		dev_err(dev, "Failed to obtain shared memory\n");
-		return err;
-	}
-
 	err = clk_prepare(ddata->clk);
 	if (err)
 		dev_err(dev, "failed to get clock\n");
@@ -387,8 +463,6 @@ static int st_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(ddata->clk);
 
-	of_reserved_mem_device_release(&pdev->dev);
-
 	for (i = 0; i < ST_RPROC_MAX_VRING * MBOX_MAX; i++)
 		mbox_free_channel(ddata->mbox_chan[i]);
 
-- 
1.9.1


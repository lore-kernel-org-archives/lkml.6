Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDDC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826F92086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2IYf7Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826F92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbeKGKBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:01:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34900 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388888AbeKGKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:03 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so14309411itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mChNx9VPrLoj/ohW2Qed5LeAGe8qnQ1vrW73K+GOCFs=;
        b=f2IYf7Ra+LGI0tRtEQXE1i/zvFYB5PcP6cP0XaOJJoYU3TIQD5yu68p7FJ+FIftxEE
         BI4Y+iL5A7iSOtflBBDOu/YRZ6HidRJJS/jB5LmZw0Gfqz9EwAa4Loqzq44Gc2IdwZp7
         TjG7nYw0kDn1vb4IfZXPMC7V/JSDzCNp2EHe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mChNx9VPrLoj/ohW2Qed5LeAGe8qnQ1vrW73K+GOCFs=;
        b=oRBWj5GtshQ9dRQ94BCO5iug4srsUURhBiCO9EK1uOmLSATq8BEQjXL2JvA4MiBxwA
         AMf2PCj9up1YWQlltk9++gBFSPCcu0N3LsqO0VCz7zPLsbGS9PUriSa+uLEElBttN8kj
         RuJrRiAWejzlz8j3Yc0Ti+bHo2wU5n4zi0lqRC2B6kc83wgVaxm9mMsn53Sn7FUfbjU2
         smWDqjBRAEIp2VDMl39V+zEeML351qlewZrFbJs8O7WhodA2p4sPjxln/B0IEhW5LaW2
         mPL77bmiwivBC0CpyavrI7TUR+pRjmEBvFicXEoSfgirdTApwactt4bnU4y+YyJ3I3p1
         XSpw==
X-Gm-Message-State: AGRZ1gKzUQ+1O2ga9xwITgILQqNFJT1QFeiPdavKopCtULwrtX905pya
        Etebd/yMSM+6QsabTxBIa/cfvg==
X-Google-Smtp-Source: AJdET5fc96+Vvpxcaxjsyi6rLtBcRzz7GokxwEQ2SeDLr5Pay1oBKGGI8r1HlytuVfQSsqvCDEDUfA==
X-Received: by 2002:a24:4a95:: with SMTP id k143-v6mr117987itb.132.1541550788960;
        Tue, 06 Nov 2018 16:33:08 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:08 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [RFC PATCH 02/12] soc: qcom: ipa: DMA helpers
Date:   Tue,  6 Nov 2018 18:32:40 -0600
Message-Id: <20181107003250.5832-3-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes code implementing the IPA DMA module, which
defines a structure to represent a DMA allocation for the IPA device.
It's used throughout the IPA code.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_dma.c | 61 +++++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_dma.h | 61 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_dma.c
 create mode 100644 drivers/net/ipa/ipa_dma.h

diff --git a/drivers/net/ipa/ipa_dma.c b/drivers/net/ipa/ipa_dma.c
new file mode 100644
index 000000000000..dfde59e5072a
--- /dev/null
+++ b/drivers/net/ipa/ipa_dma.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/string.h>
+
+#include "ipa_dma.h"
+
+static struct device *ipa_dma_dev;
+
+int ipa_dma_init(struct device *dev, u32 align)
+{
+	int ret;
+
+	/* Ensure DMA addresses will have the alignment we require */
+	if (dma_get_cache_alignment() % align)
+		return -ENOTSUPP;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (!ret)
+		ipa_dma_dev = dev;
+
+	return ret;
+}
+
+void ipa_dma_exit(void)
+{
+	ipa_dma_dev = NULL;
+}
+
+int ipa_dma_alloc(struct ipa_dma_mem *mem, size_t size, gfp_t gfp)
+{
+	dma_addr_t phys;
+	void *virt;
+
+	virt = dma_zalloc_coherent(ipa_dma_dev, size, &phys, gfp);
+	if (!virt)
+		return -ENOMEM;
+
+	mem->virt = virt;
+	mem->phys = phys;
+	mem->size = size;
+
+	return 0;
+}
+
+void ipa_dma_free(struct ipa_dma_mem *mem)
+{
+	dma_free_coherent(ipa_dma_dev, mem->size, mem->virt, mem->phys);
+	memset(mem, 0, sizeof(*mem));
+}
+
+void *ipa_dma_phys_to_virt(struct ipa_dma_mem *mem, dma_addr_t phys)
+{
+	return mem->virt + (phys - mem->phys);
+}
diff --git a/drivers/net/ipa/ipa_dma.h b/drivers/net/ipa/ipa_dma.h
new file mode 100644
index 000000000000..e211dbd9d4ec
--- /dev/null
+++ b/drivers/net/ipa/ipa_dma.h
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef _IPA_DMA_H_
+#define _IPA_DMA_H_
+
+#include <linux/types.h>
+#include <linux/device.h>
+
+/**
+ * struct ipa_dma_mem - IPA allocated DMA memory descriptor
+ * @virt: host virtual base address of allocated DMA memory
+ * @phys: bus physical base address of DMA memory
+ * @size: size (bytes) of DMA memory
+ */
+struct ipa_dma_mem {
+	void *virt;
+	dma_addr_t phys;
+	size_t size;
+};
+
+/**
+ * ipa_dma_init() - Initialize IPA DMA system.
+ * @dev:	IPA device structure
+ * @align:	Hardware required alignment for DMA memory
+ *
+ * Returns:	 0 if successful, or a negative error code.
+ */
+int ipa_dma_init(struct device *dev, u32 align);
+
+/**
+ * ipa_dma_exit() - shut down/clean up IPA DMA system
+ */
+void ipa_dma_exit(void);
+
+/**
+ * ipa_dma_alloc() - allocate a DMA buffer, describe it in mem struct
+ * @mem:	Memory structure to fill with allocation information.
+ * @size:	Size of DMA buffer to allocate.
+ * @gfp:	Allocation mode.
+ */
+int ipa_dma_alloc(struct ipa_dma_mem *mem, size_t size, gfp_t gfp);
+
+/**
+ * ipa_dma_free() - free a previously-allocated DMA buffer
+ * @mem:	Information about DMA allocation to free
+ */
+void ipa_dma_free(struct ipa_dma_mem *mem);
+
+/**
+ * ipa_dma_phys_to_virt() - return the virtual equivalent of a DMA address
+ * @phys:	DMA allocation information
+ * @phys:	Physical address to convert
+ *
+ * Return:	Virtual address corresponding to the given physical address
+ */
+void *ipa_dma_phys_to_virt(struct ipa_dma_mem *mem, dma_addr_t phys);
+
+#endif /* !_IPA_DMA_H_ */
-- 
2.17.1


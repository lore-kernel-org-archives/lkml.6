Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28797C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED54E218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X9j8cW90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfAaJcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:32:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39146 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbfAaJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:32:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so1219387pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYayTLAIjqbiHgbKVBbyF73pC5IYaCQpN6ywaeYZLhk=;
        b=X9j8cW90LeK2WsQyDgUHYwTnO3OihBXBDRBqlI7Tc1CJ7NuruPbmi0DTo3FNQbQjxd
         0Gqb9vHPSR0CiPBhAHp9kpfvZieAkc5G70SYXUvPzJLvsRVh2KLKU1WkrQUJPrGiWKJu
         5C0X0oGn/kMpST7Ljlsom3sMiPKw/nM7X0gJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYayTLAIjqbiHgbKVBbyF73pC5IYaCQpN6ywaeYZLhk=;
        b=U6BnCqacEOD6uZp4k5b87fOCRlEoT+4SgC/dW5gjRYTPl1b9orGFUuH6ijVO2gOOUD
         +GRVKl493hcOUAZazgdSFQAe6iyiVvQEZ721W+M3wP/2Gq6GsbvjiKVNAuv7DPtL0zuI
         /p0JSCkCYkIb43Z9uuyLKL26oKMNo/2i+VeTWFCrIEQ4NWI/zovl4rUPBJoFrSzG8YXM
         FTzqmV3DRceK5L/Vyf0b4lG6VY486DJAZTGnJPlaAiuzUl3QoPETSMcSuFNqRfuv4Yv/
         AdxvLKOJm39N1zMF7hMkEbH5jJedLVh0D30p1HH+/Yujwyz6EdwdOvyVC/09TKGv31Yy
         sFxQ==
X-Gm-Message-State: AJcUukfgh1SvfAnYmib+tAlY7+MgRuj7TtO4ZSipA4hUsYTq0JeVXpmf
        B+LtXneZoxzT70WukuBaeTWl8A==
X-Google-Smtp-Source: ALg8bN7DUK6LyOrUOEcGJ7vtN8iZZyAFdTD0HIW3jW/LZF6c5e+10zrYeAmDej9RsedLjCe1N5g6fQ==
X-Received: by 2002:a63:f717:: with SMTP id x23mr31147048pgh.317.1548927125228;
        Thu, 31 Jan 2019 01:32:05 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id w184sm4531197pgd.34.2019.01.31.01.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:32:04 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/6] remoteproc/mediatek: Load ELF instead of bin file for mtk_scp.
Date:   Thu, 31 Jan 2019 17:31:31 +0800
Message-Id: <20190131093131.245531-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190131093131.245531-1-pihsun@chromium.org>
References: <20190131093131.245531-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better flexibility on loading firmware image, change firmware load
for mtk_scp from a plain binary file to ELF format instead.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v3:
  - New patch to load ELF instead of plain bin file.
---
 drivers/remoteproc/mtk_common.h  |  2 ++
 drivers/remoteproc/mtk_scp.c     | 59 ++++++++++++++++++++++++++++++--
 drivers/remoteproc/mtk_scp_ipi.c | 11 ++++--
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 7efe2e7374e5ec..dffca9fbea9f1e 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -73,4 +73,6 @@ struct share_obj {
 	u8 share_buf[288];
 };
 
+void scp_memcpy_aligned(void *dst, const void *src, unsigned int len);
+
 #endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index c0375119c53289..314ae3f8a82cf7 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -140,6 +140,62 @@ static irqreturn_t scp_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+int scp_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	struct elf32_hdr *ehdr;
+	struct elf32_phdr *phdr;
+	int i, ret = 0;
+	const u8 *elf_data = fw->data;
+
+	ehdr = (struct elf32_hdr *)elf_data;
+	phdr = (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
+
+	/* go through the available ELF segments */
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
+		u32 da = phdr->p_paddr;
+		u32 memsz = phdr->p_memsz;
+		u32 filesz = phdr->p_filesz;
+		u32 offset = phdr->p_offset;
+		void __iomem *ptr;
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		dev_dbg(dev, "phdr: type %d da 0x%x memsz 0x%x filesz 0x%x\n",
+			phdr->p_type, da, memsz, filesz);
+
+		if (filesz > memsz) {
+			dev_err(dev, "bad phdr filesz 0x%x memsz 0x%x\n",
+				filesz, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (offset + filesz > fw->size) {
+			dev_err(dev, "truncated fw: need 0x%x avail 0x%zx\n",
+				offset + filesz, fw->size);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* grab the kernel address for this device address */
+		ptr = rproc_da_to_va(rproc, da, memsz);
+		if (!ptr) {
+			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* put the segment where the remote processor expects it */
+		if (phdr->p_filesz)
+			scp_memcpy_aligned(ptr, elf_data + phdr->p_offset,
+					   filesz);
+	}
+
+	return ret;
+}
+
 static int mtk_scp_load(struct rproc *rproc, const struct firmware *fw)
 {
 	const struct mtk_scp *scp = rproc->priv;
@@ -157,8 +213,7 @@ static int mtk_scp_load(struct rproc *rproc, const struct firmware *fw)
 
 	writel(0x0, scp->reg_base + MT8183_SCP_SRAM_PDN);
 
-	memcpy(scp->sram_base, fw->data, fw->size);
-	return ret;
+	return scp_elf_load_segments(rproc, fw);
 }
 
 static int mtk_scp_start(struct rproc *rproc)
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index 1026089335a5c3..b6b248c9da50ac 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -55,7 +55,13 @@ void scp_ipi_unregister(struct platform_device *pdev, enum scp_ipi_id id)
 }
 EXPORT_SYMBOL_GPL(scp_ipi_unregister);
 
-static void memcpy_aligned(void *dst, const void *src, unsigned int len)
+/*
+ * Copy src to dst, where dst is in SCP SRAM region.
+ * Since AP access of SCP SRAM don't support byte write, this always write a
+ * full word at a time, and may cause some extra bytes to be written at the
+ * beginning & ending of dst.
+ */
+void scp_memcpy_aligned(void *dst, const void *src, unsigned int len)
 {
 	void *ptr;
 	u32 val;
@@ -80,6 +86,7 @@ static void memcpy_aligned(void *dst, const void *src, unsigned int len)
 		writel_relaxed(val, dst + i);
 	}
 }
+EXPORT_SYMBOL_GPL(scp_memcpy_aligned);
 
 int scp_ipi_send(struct platform_device *pdev,
 		 enum scp_ipi_id id,
@@ -117,7 +124,7 @@ int scp_ipi_send(struct platform_device *pdev,
 		}
 	} while (readl(scp->reg_base + MT8183_HOST_TO_SCP));
 
-	memcpy_aligned(send_obj->share_buf, buf, len);
+	scp_memcpy_aligned(send_obj->share_buf, buf, len);
 
 	send_obj->len = len;
 	send_obj->id = id;
-- 
2.20.1.611.gfbb209baf1-goog


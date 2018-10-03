Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D74C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170D92098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg5ZoEkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170D92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJDAix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:38:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35750 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeJDAix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:38:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so7115383wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pCLnfMcmeguDpAo592wfBUt9AqVNERm1HQcztKrjVI=;
        b=eg5ZoEkNhKqEu0Vd/RcXCKXwYhJa/wxk50j8Y2ZE3L/4jO6F5xZK4FHeVTSAEHorSe
         Ldw1CN9VjSkq9FKzHnMsFpabZ4LWqashNbYvwdsVDWa3yXqcsCC6HOIe50dKuGhUAPR2
         gvLJUk7dG0ICiQOne6picj9A5ycQj+eKm89bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pCLnfMcmeguDpAo592wfBUt9AqVNERm1HQcztKrjVI=;
        b=LzxyX6azcNrITH8/cmHq2k/pTzWJkqzBm+JSf1Dg3sYCTFFFh9+YPesZwdx6FREvLz
         pdGH99xdfnh06LzTDOuCLRjIkpopjDFHnKMpsV84Odg5RaWZxB0zWDdPqtC3tDeVogNV
         t9ybHCzOYYGtytmcih1trzY7cvhz7frH6JxWMyl03S0k3u8x1O9iy0obCIZtQ+knTIil
         hEeNoyiOxcYCuFBMwVU7Qz9R55Ugk+mCLiuXYLE5GPziGc6ZSJnz3obzAs/LbZxB5rQY
         UXRjqiPYm884LR6BY509rXDWKNJIbLYhKLgoSnCXN3sWNFbx3fBnsMhVzLn8soxg+4x+
         qmSQ==
X-Gm-Message-State: ABuFfoixCOe0rkOrImCPQcoIm/wsgkm2poYS1yVXmcv426+B1yPb32Cp
        48cRoCZrsGMtChHzrjbjZpSxWA==
X-Google-Smtp-Source: ACcGV63WPFxvdVsTiwEY2RNq5lhCh5Pvg1yHri3dLOz22nwyBm7LWsP5ZVTSEGwGQhSX0pAHqtLwrA==
X-Received: by 2002:adf:9b19:: with SMTP id b25-v6mr2198149wrc.35.1538588967237;
        Wed, 03 Oct 2018 10:49:27 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id a105-v6sm4052005wrc.23.2018.10.03.10.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 10:49:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: Convert to using %pOFn instead of device_node.name
Date:   Wed,  3 Oct 2018 18:47:04 +0100
Message-Id: <20181003174704.7067-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
[srinivas: rebased on top of next]
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index cc815bb2eebd..b4c09bc20b67 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -298,6 +298,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
+	kfree(cell->name);
 	kfree(cell);
 }
 
@@ -547,7 +548,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 		cell->nvmem = nvmem;
 		cell->offset = be32_to_cpup(addr++);
 		cell->bytes = be32_to_cpup(addr);
-		cell->name = child->name;
+		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
 
 		addr = of_get_property(child, "bits", &len);
 		if (addr && len == (2 * sizeof(u32))) {
@@ -564,6 +565,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
 				cell->name, nvmem->stride);
 			/* Cells already added will be freed later. */
+			kfree(cell->name);
 			kfree(cell);
 			return -EINVAL;
 		}
-- 
2.19.0


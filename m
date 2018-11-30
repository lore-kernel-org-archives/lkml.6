Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CDCC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGi6bGe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7985120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeK3XCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:02:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37013 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3XCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so4617823edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uj1/fNKFSJQYG76kuDm1FhuBMKBVCAd9YSvKr8WrTa4=;
        b=iGi6bGe9CChIjYcRzSpisHvA43kjJnB48BH0bQ/6M4hwHFGilDwB9KPDp3etl5AVpu
         9nakJgnDfy9X2r86z9ncUSuhKONAlFwARHER2mF0UFxI0+wkv4li56tGRR1ixi9tN0Nr
         kEulfebILV24arikfS4nhFXI7AqsjqP4I1i54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uj1/fNKFSJQYG76kuDm1FhuBMKBVCAd9YSvKr8WrTa4=;
        b=KydOMvz5MNGgVMEnOVXDlfiXOSgUNPMgoxPZ9pTQ+dHs1ncGIpLLWJFNsGJS8rRfnN
         4H1WT6Gb8CwByf7VEZXZyUiRX+u1HoELTGnUgE9GpL3GlBw1uCMyHUqPds+BxmDTAE3h
         wZfpNIy+FXDNlmlDGlnot151dk2D5lxiMiPig3A52tQKtikgDIw+ea+Ws4l/L21+L9HW
         lT8k3F3OjltfSRBoH9D2DXPIcmZo9uhZsjxDNyp/A/YcIY8wY+DxsYwW1suk99iAvwqK
         zvkgJKHzXikDHxcart6WKFigMDNUSJGz0LmTpl0Xv+RHdQBtfnorBkuywnxRcVa8631E
         R0FQ==
X-Gm-Message-State: AA+aEWbMgaALYvAzFBiIBX68tBwLIwqP7mVMLbKZ1ZZn6hqUnd2QP9Be
        cVjX+HaSVSgAG78G9JS7kihU4g==
X-Google-Smtp-Source: AFSGD/UJb6+p/mX98bK4XTMPikT/XgQhJcSXSgbRZ4NjhTuylLDgYeHCH6CKocEZrBupcaMi6kiXZA==
X-Received: by 2002:a17:906:154c:: with SMTP id c12-v6mr4477480ejd.69.1543578824107;
        Fri, 30 Nov 2018 03:53:44 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t10-v6sm767932ejg.41.2018.11.30.03.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:53:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] nvmem: add new config option
Date:   Fri, 30 Nov 2018 11:53:25 +0000
Message-Id: <20181130115325.16539-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
References: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to add nvmem support for MTD. TI DaVinci is the first platform
that will be using it, but only in non-DT mode. In order not to
introduce any new interface to supporting of which we would have to
commit - add a new config option that tells nvmem not to use the DT
node of the parent device.

This way we won't be creating nvmem devices corresponding with MTD
partitions defined in device tree. By default MTD will set this new
field to true.

Once a set of bindings for MTD nvmem cells is agreed upon, we'll be
able to remove this option.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 3 ++-
 include/linux/nvmem-provider.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 22345e65a301..f7301bb4ef3b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -635,7 +635,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->dev.of_node = config->dev->of_node;
+	if (!config->no_of_node)
+		nvmem->dev.of_node = config->dev->of_node;
 
 	if (config->id == -1 && config->name) {
 		dev_set_name(&nvmem->dev, "%s", config->name);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 5b2dd0a987d2..fe051323be0a 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -38,6 +38,7 @@ enum nvmem_type {
  * @type:	Type of the nvmem storage
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
+ * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
  * @size:	Device size.
@@ -62,6 +63,7 @@ struct nvmem_config {
 	enum nvmem_type		type;
 	bool			read_only;
 	bool			root_only;
+	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	int	size;
-- 
2.19.2


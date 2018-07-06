Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3EAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A299622439
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYNYSDsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A299622439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeGFPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:07:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37754 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753732AbeGFPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:07:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so4525958wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MszlGfMwfZkMi1OchCWI4zsvVKuSKrnb//3WWCFbafY=;
        b=eYNYSDsnm03nX5Pdk72wjXgNSBthVAVLawLSKAmzfjmsPKNGM40vnB5ntexMFZMFfC
         Wqvfj6I4+KUryOOrjEqUpuhzj5Z+6frnqXUYa9Aev5AFXLDKo+ypk7lpPTE37f5uYyNZ
         XGyZzi2R/HIM3scaIFOzpMWnzKWe3F2Ty5pKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MszlGfMwfZkMi1OchCWI4zsvVKuSKrnb//3WWCFbafY=;
        b=QoLB5m36IfX8qXMm1FwXDwKOoB2XiSjE7dvGDOs2oyJYwLAh7EPPBRmU2vWDHIOBk4
         AF5DOLflWaVDcGEVDAjFJbKusQ9/dkbWxA0Ejr2+PaFpMVgZIudpUEZdkl9hNDG8zyo/
         MvfTPic3WBWfL+Jb1Ib/lbSzsRnYsLGgCmgBHTk0QtjnnGVNTqTLqDNZ8d/TNN1VBglB
         ZT+zQ9MEynqQVrNCOUOc4z4K6ECg9YoUjUx0CyQdiGkMJ1zTVYvD6zvJk37Iip7ItTK+
         0UMNCuB5meicAi1Ql0SGHKQittxleQK5/yRQRBBCbEuJ0vhwA7kbYkKmWXpBzQC2OogZ
         vm4A==
X-Gm-Message-State: APt69E1tzshZUX6QgZ8/GsvY/H6xf91KnVS2zJTBZcyIZlZs4g/SDyXH
        DPUB2XgJJ3Au99nzUPWCKtncsCUMVxo=
X-Google-Smtp-Source: AAOMgpenOvifA1UzbExI4u2AfZSs7V4asKCnQ6qzK4r30yj5wbW03ImGc1sXKPoWGe92308xVbM3GA==
X-Received: by 2002:adf:8597:: with SMTP id 23-v6mr8475274wrt.31.1530889659166;
        Fri, 06 Jul 2018 08:07:39 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id a184-v6sm11499651wmf.30.2018.07.06.08.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 08:07:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] regmap: slimbus: add support to multi read/write
Date:   Fri,  6 Jul 2018 16:05:27 +0100
Message-Id: <20180706150527.8811-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLIMbus supports upto 16 bytes in value management messages,
so add support to read/writes upto 16 bytes.

This also removes redundant single register reg_read/reg_write.

Also useful for paged register access on SLIMbus interfaced codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap-slimbus.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 91d501eda8a9..0968059f1ef5 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -7,33 +7,24 @@
 
 #include "internal.h"
 
-static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
-					unsigned int *val)
+static int regmap_slimbus_write(void *context, const void *data, size_t count)
 {
 	struct slim_device *sdev = context;
-	int v;
 
-	v = slim_readb(sdev, reg);
-
-	if (v < 0)
-		return v;
-
-	*val = v;
-
-	return 0;
+	return slim_write(sdev, *(u16 *)data, count - 2, (u8 *)data + 2);
 }
 
-static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
-					 unsigned int val)
+static int regmap_slimbus_read(void *context, const void *reg, size_t reg_size,
+			       void *val, size_t val_size)
 {
 	struct slim_device *sdev = context;
 
-	return slim_writeb(sdev, reg, val);
+	return slim_read(sdev, *(u16 *)reg, val_size, val);
 }
 
 static struct regmap_bus regmap_slimbus_bus = {
-	.reg_write = regmap_slimbus_byte_reg_write,
-	.reg_read = regmap_slimbus_byte_reg_read,
+	.write = regmap_slimbus_write,
+	.read = regmap_slimbus_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
 	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
 };
-- 
2.16.2


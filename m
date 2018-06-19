Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51089C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E917120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E917120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967283AbeFSVg0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:36:26 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42264 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935985AbeFSVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:36:22 -0400
Received: by mail-yb0-f196.google.com with SMTP id m199-v6so46265ybm.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UjGDXF+8qLWxuODlZhvjSlO5xHUxXCW+YQ55dOr6t0g=;
        b=LawXjzqX4/zybbWxyjoWd7IKJ4FyulvFJ901/+44fA3qUDuWFkhwPEuJSnfAEQwH3y
         MZNUmS38wBfKxnFXQK58memB4VeAx0WUsviNqkIqX5qAPNT5OSV8C5n7uTkJy9F1fcwh
         uSRiZbjSz6wr13fbJr221ImzrRYLp5A+M4DUc0f7OxnnARAWa31jxx1DvivXJS7i33a7
         vd8C6hyyiDnRawRUzeef2do8o5jwbRvHGiTcDIVgGsrZgXpWrws8lYe/SGJAXOO0X9HU
         Lld+puNyhKJwvUyePBzbrX8CVXrdARYkXqMn8aQrc3OSKP9+v7cjLslHd/PX6B921Zsf
         skcg==
X-Gm-Message-State: APt69E3dUFBAjw8K3uHIIynXb3oOBF/yRBXDa5mrHAemBr6HaGaoL1D/
        yEMUeAjTvYOoSH+PQEJjlZlhbg4=
X-Google-Smtp-Source: ADUXVKJI5LaBiD/gccmNIz7E4Lt0FRMkT6J5r4RhW2EYBmJyFlnTDKBstVDB4iYc6BZtVFFqgbWP6w==
X-Received: by 2002:a25:ad83:: with SMTP id z3-v6mr4490927ybi.246.1529444182187;
        Tue, 19 Jun 2018 14:36:22 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id i205-v6sm309535ywc.103.2018.06.19.14.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:36:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] microblaze: remove unecessary of_platform_bus_probe call
Date:   Tue, 19 Jun 2018 15:36:19 -0600
Message-Id: <20180619213620.14146-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_platform_bus_probe has no effect because the DT core
already probes default buses like "simple-bus" before this call.
Michal Simek said 'xlnx,compound' hasn't been used in a long time, so
that match entry isn't needed.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/microblaze/kernel/platform.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/microblaze/kernel/platform.c b/arch/microblaze/kernel/platform.c
index 2540d60610d9..b9a414552d9b 100644
--- a/arch/microblaze/kernel/platform.c
+++ b/arch/microblaze/kernel/platform.c
@@ -14,15 +14,8 @@
 #include <linux/of_platform.h>
 #include <asm/setup.h>
 
-static struct of_device_id xilinx_of_bus_ids[] __initdata = {
-	{ .compatible = "simple-bus", },
-	{ .compatible = "xlnx,compound", },
-	{}
-};
-
 static int __init microblaze_device_probe(void)
 {
-	of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
 	of_platform_reset_gpio_probe();
 	return 0;
 }
-- 
2.17.1


Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844EDC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DD520661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DD520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967291AbeFSVgn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:36:43 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43291 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967205AbeFSVgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:36:24 -0400
Received: by mail-yw0-f193.google.com with SMTP id r19-v6so432510ywc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPMtP57+31psf6v11jTqOaoOthX7tz/4iXgNxK0eo4o=;
        b=GumEjh4LqlyEVtZxp7YkiqC/E5bgk7A9rlIe/bvi2mP2jmLvMHDl4i68Ov3ZXT8ZS2
         ztWRXwBO+3Mknx1E7Ja++t281qfAuE+nVYUfq2kJT81G1qdaS+u0K9E97V8e6ozU5i9R
         cxGBc1so90hfn0xu7LzhLib3B6bgCjIxvbf69LmWulHrqjN7cryllDLRCZqYjUwxLXDE
         NRuJpWSm+rlEF82lQe5zXnCYx/JH+F/TQtGuX7EsIV1vjmAEaCAGH3StvMN2exNm6CSI
         pMe4In1yIAHqy/1wCRKxBEGwiKS8Le2A1RFiYh2b0Yk0b9zofvZrvf6+0xhQjNXtGTsW
         XpHw==
X-Gm-Message-State: APt69E1WZwtA6OVATK9FZvR4+yLzq/ne85+h9mGiWpuAPUVt1b5DMU8g
        jZZOTv6YmWfVmjbbcIJFmnBPPqo=
X-Google-Smtp-Source: ADUXVKKb22+Y6//8i2pOOvGvtOj/gTgd4OqjlR02AEiBvl1FdgJ0VTMfbrYHpn5xFJLJXw+4+0uJ7g==
X-Received: by 2002:a81:65d6:: with SMTP id z205-v6mr9217594ywb.155.1529444183670;
        Tue, 19 Jun 2018 14:36:23 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id i205-v6sm309535ywc.103.2018.06.19.14.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:36:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] microblaze: consolidate GPIO reset handling
Date:   Tue, 19 Jun 2018 15:36:20 -0600
Message-Id: <20180619213620.14146-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619213620.14146-1-robh@kernel.org>
References: <20180619213620.14146-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that platform.c only has the GPIO reset handling left, move the
initcall to reset.c and remove platform.c.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/microblaze/include/asm/setup.h |  2 --
 arch/microblaze/kernel/Makefile     |  2 +-
 arch/microblaze/kernel/platform.c   | 22 ----------------------
 arch/microblaze/kernel/reset.c      | 11 ++++++-----
 4 files changed, 7 insertions(+), 30 deletions(-)
 delete mode 100644 arch/microblaze/kernel/platform.c

diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index d5384f6f36f7..86d2663d3fd0 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -26,8 +26,6 @@ void microblaze_setup_heartbeat(void);
 extern void mmu_reset(void);
 #   endif /* CONFIG_MMU */
 
-extern void of_platform_reset_gpio_probe(void);
-
 void time_init(void);
 void init_IRQ(void);
 void machine_early_init(const char *cmdline, unsigned int ram,
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 7e99cf6984a1..6c4c54826aae 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -17,7 +17,7 @@ extra-y := head.o vmlinux.lds
 
 obj-y += dma.o exceptions.o \
 	hw_exception_handler.o irq.o \
-	platform.o process.o prom.o ptrace.o \
+	process.o prom.o ptrace.o \
 	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
 
 obj-y += cpu/
diff --git a/arch/microblaze/kernel/platform.c b/arch/microblaze/kernel/platform.c
deleted file mode 100644
index b9a414552d9b..000000000000
--- a/arch/microblaze/kernel/platform.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright 2008 Michal Simek <monstr@monstr.eu>
- *
- * based on virtex.c file
- *
- * Copyright 2007 Secret Lab Technologies Ltd.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/init.h>
-#include <linux/of_platform.h>
-#include <asm/setup.h>
-
-static int __init microblaze_device_probe(void)
-{
-	of_platform_reset_gpio_probe();
-	return 0;
-}
-device_initcall(microblaze_device_probe);
diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/reset.c
index bab4c8330ef4..fcbe1daf6316 100644
--- a/arch/microblaze/kernel/reset.c
+++ b/arch/microblaze/kernel/reset.c
@@ -18,7 +18,7 @@
 static int handle; /* reset pin handle */
 static unsigned int reset_val;
 
-void of_platform_reset_gpio_probe(void)
+static int of_platform_reset_gpio_probe(void)
 {
 	int ret;
 	handle = of_get_named_gpio(of_find_node_by_path("/"),
@@ -27,13 +27,13 @@ void of_platform_reset_gpio_probe(void)
 	if (!gpio_is_valid(handle)) {
 		pr_info("Skipping unavailable RESET gpio %d (%s)\n",
 				handle, "reset");
-		return;
+		return -ENODEV;
 	}
 
 	ret = gpio_request(handle, "reset");
 	if (ret < 0) {
 		pr_info("GPIO pin is already allocated\n");
-		return;
+		return ret;
 	}
 
 	/* get current setup value */
@@ -51,11 +51,12 @@ void of_platform_reset_gpio_probe(void)
 
 	pr_info("RESET: Registered gpio device: %d, current val: %d\n",
 							handle, reset_val);
-	return;
+	return 0;
 err:
 	gpio_free(handle);
-	return;
+	return ret;
 }
+device_initcall(of_platform_reset_gpio_probe);
 
 
 static void gpio_system_reset(void)
-- 
2.17.1


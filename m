Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeEVUzP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:55:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51085 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeEVUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:55:13 -0400
X-Google-Smtp-Source: AB8JxZoUzoFX39jAECyqylQyUq2Q6qEvjK8h/MIf1IFm0Y3rGyD7aPqt/F3DEFDcNGpIV7CCL/9Drg==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jassisinghbrar@gmail.com
Cc: leo.yan@linaro.org, olof@lixom.net, linux-kernel@vger.kernel.org,
        xuwei5@hisilicon.com
Subject: [PATCH] mailbox/drivers/hisi: Consolidate the Kconfig for the MAILBOX
Date: Tue, 22 May 2018 22:54:49 +0200
Message-Id: <1527022489-2012-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current defconfig is inconsistent as it selects the mailbox and
the clock for the hi6220 and the hi3660 without having their Kconfigs
making sure the dependencies are correct. It ends up when selecting
different versions for the kernel (for example when git bisecting)
those options disappear and they don't get back, leading to unexpected
behaviors. In our case, the cpufreq driver does no longer work because
the clock fails to initialize due to the clock stub and the mailbox
missing.

In order to have the dependencies correctly set when defaulting, let's
do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
automatically") where we select automatically the driver when the
parent driver is selected. With sensible defaults in place, we can leave
other choices for EXPERT.

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Split the patch into the mailbox specific and resent as requested by Olof
Johansson.
---
 drivers/mailbox/Kconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index a2bb274..567cd02 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -109,16 +109,20 @@ config TI_MESSAGE_MANAGER
 	  platform has support for the hardware block.
 
 config HI3660_MBOX
-	tristate "Hi3660 Mailbox"
-	depends on ARCH_HISI && OF
+	tristate "Hi3660 Mailbox" if EXPERT
+	depends on (ARCH_HISI || COMPILE_TEST)
+	depends on OF
+	default ARCH_HISI
 	help
 	  An implementation of the hi3660 mailbox. It is used to send message
 	  between application processors and other processors/MCU/DSP. Select
 	  Y here if you want to use Hi3660 mailbox controller.
 
 config HI6220_MBOX
-	tristate "Hi6220 Mailbox"
-	depends on ARCH_HISI
+	tristate "Hi6220 Mailbox" if EXPERT
+	depends on (ARCH_HISI || COMPILE_TEST)
+	depends on OF
+	default ARCH_HISI
 	help
 	  An implementation of the hi6220 mailbox. It is used to send message
 	  between application processors and MCU. Say Y here if you want to
-- 
2.7.4

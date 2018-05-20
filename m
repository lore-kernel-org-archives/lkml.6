Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeETKQ1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:16:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36105 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeETKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:16:24 -0400
X-Google-Smtp-Source: AB8JxZrj05WW0ppBkeYIxoqWZd2uZ6dsw14+Jf+UJ5xg0uCRAIrbtAcmIHf7FRHLGV+yvo0AyGinyw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v1 1/5] ARM: trusted_foundations: Implement L2 cache initialization callback
Date: Sun, 20 May 2018 13:15:38 +0300
Message-Id: <20180520101542.12206-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520101542.12206-1-digetx@gmail.com>
References: <20180520101542.12206-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement L2 cache initialization firmware callback that should be invoked
early in boot to enable cache HW.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 3fb1b5a1dce9..198ce5c75ca0 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -18,8 +18,13 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <asm/firmware.h>
+#include <asm/outercache.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT		0xfffff100
+
+#define TF_CACHE_INIT		1
+
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
 #define TF_CPU_PM		0xfffffffc
@@ -63,9 +68,27 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_cache_write_sec(unsigned long val, unsigned int reg)
+{
+	pr_warn("%s: Ignoring write [0x%x]: 0x%08lx\n", __func__, reg, val);
+}
+
+static int tf_init_cache(void)
+{
+	outer_cache.write_sec = tf_cache_write_sec;
+	tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_INIT, 0);
+
+	return 0;
+}
+#endif /* CONFIG_CACHE_L2X0 */
+
 static const struct firmware_ops trusted_foundations_ops = {
 	.set_cpu_boot_addr = tf_set_cpu_boot_addr,
 	.prepare_idle = tf_prepare_idle,
+#ifdef CONFIG_CACHE_L2X0
+	.l2x0_init = tf_init_cache,
+#endif
 };
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
-- 
2.17.0

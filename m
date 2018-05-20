Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeETKRZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:17:25 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40792 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeETKQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:16:25 -0400
X-Google-Smtp-Source: AB8JxZqCYZQ6KmV55zoh3xvV01UIUNfg2gzaCsHuzeGfbTxBLeQOn9FrLKR63sVI4WiHKq+NffGwQA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v1 2/5] ARM: trusted_foundations: Provide information about whether firmware is registered
Date: Sun, 20 May 2018 13:15:39 +0300
Message-Id: <20180520101542.12206-3-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520101542.12206-1-digetx@gmail.com>
References: <20180520101542.12206-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper that provides information about whether Trusted Foundations
firmware operations have been registered.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 5 +++++
 arch/arm/include/asm/trusted_foundations.h | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 198ce5c75ca0..0428351574de 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -120,3 +120,8 @@ void of_register_trusted_foundations(void)
 		panic("Trusted Foundation: missing version-minor property\n");
 	register_trusted_foundations(&pdata);
 }
+
+bool trusted_foundations_registered(void)
+{
+	return firmware_ops == &trusted_foundations_ops;
+}
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 00748350cf72..bfd0d780824b 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
@@ -41,6 +42,7 @@ struct trusted_foundations_platform_data {
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
+bool trusted_foundations_registered(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
 
@@ -68,6 +70,11 @@ static inline void of_register_trusted_foundations(void)
 	if (of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations"))
 		register_trusted_foundations(NULL);
 }
+
+static inline bool trusted_foundations_registered(void)
+{
+	return false;
+}
 #endif /* CONFIG_TRUSTED_FOUNDATIONS */
 
 #endif
-- 
2.17.0

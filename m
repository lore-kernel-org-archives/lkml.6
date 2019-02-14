Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6F3222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hi1criUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394594AbfBNRFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:05:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfBNRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:05:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so7109772wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4hUTjly/AFQKT943z1vIP2NLqLHWU7HEz8Xx6XhU0TI=;
        b=hi1criUcHyxwVWY+CPrenF5q8eQ+PIYV72xZ5FwrNqmZ3Ny4VOe2qcTef0ZFrgzo9Q
         zcz7LGRHvaifuCYFTtDW73iruPM3QZKmgwD4PfNd82JMkc9WUKl0VBesbyUrH2lbHBfm
         jKzdsDxbPPpNSLdbHEtdIfpdsFMXQQ5sZVTu6WRkkvd6FkSU7CSmnQ7SMmSgEj6MZ/YR
         2nOLad4rIx+n6pHinDP6m3xd8NMzrWcuNbvQJeTj7EdAVAw08JMUH7HAufYMJDGE7OSb
         JjoyTqyvmTkQXTFunS01f3DsY6lL2TxOPT753RwH+3dC/2VrOLuhpqUM+pOimEyO56mC
         9Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4hUTjly/AFQKT943z1vIP2NLqLHWU7HEz8Xx6XhU0TI=;
        b=GyVw0Aaim+K2Nw0eH9BnUVSjSK95Vu8otuZjoA+h+ho0eEG7KFZn9F0PdZVe2cHBoz
         V1S1ZdVqKl0JlqceMVEtmnM1e7NR+DOtcX4cdL8IWSHNyGtF+CYC8EPBH3KyTu0q8QPn
         EGTA0DQJpV4Up5edkYTL2y5jomj7YnjGTxkfuLn7+ze1+imZjYrUYXfJA/08a/tzrQ7O
         rokSV2YWXieYO9hVnSQiSFFjbpuZLcBxnLR8jEPpio+KMGggnokYv+JxakmL314O9jJr
         KO66wooJ8c2Co97s0iGH1QgtvQUT+z+uuT6jumjZhaUIps8XJyHldboSe3kiZo3+7vyd
         dzlg==
X-Gm-Message-State: AHQUAuaWr+qpxCLWNN5/FfF26SfkyrDqR89GLQVFA5zKlK9RYK7B6x17
        zWd4CSW79K4/DkEICgAZy9kfuw==
X-Google-Smtp-Source: AHgI3Ib7XlWSsFKm7ADikAZWcnh6HSGHIVdikVDr8NDDZvgXi+O7YrSrAjw0VlYAiPHY1i9JxcJycA==
X-Received: by 2002:a1c:d049:: with SMTP id h70mr2586970wmg.81.1550163919391;
        Thu, 14 Feb 2019 09:05:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id f187sm2028695wma.4.2019.02.14.09.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:05:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] cpufreq: davinci: move configuration to include/linux/platform_data
Date:   Thu, 14 Feb 2019 18:05:05 +0100
Message-Id: <20190214170505.27251-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The header containing the configuration structure for davinci cpufreq
driver lives in mach-davinci/include/mach/. This is fine for now but
if we want to make davinci part of the multi_v5 build, no code external
to mach-davinci should include machine-specific headers.

Move the configuration structure to include/linux/platform_data.

While we're at it: convert the GPL-2.0 boilerplate to a proper SPDX
license identifier.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c                 |  2 +-
 arch/arm/mach-davinci/include/mach/cpufreq.h  | 26 -------------------
 drivers/cpufreq/davinci-cpufreq.c             |  5 +---
 include/linux/platform_data/davinci-cpufreq.h | 19 ++++++++++++++
 4 files changed, 21 insertions(+), 31 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/cpufreq.h
 create mode 100644 include/linux/platform_data/davinci-cpufreq.h

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e7b78df2bfef..a02ff431ba47 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -21,6 +21,7 @@
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_data/clk-davinci-pll.h>
+#include <linux/platform_data/davinci-cpufreq.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -29,7 +30,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
-#include <mach/cpufreq.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/include/mach/cpufreq.h b/arch/arm/mach-davinci/include/mach/cpufreq.h
deleted file mode 100644
index 3c089cfb6cd6..000000000000
--- a/arch/arm/mach-davinci/include/mach/cpufreq.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * TI DaVinci CPUFreq platform support.
- *
- * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef _MACH_DAVINCI_CPUFREQ_H
-#define _MACH_DAVINCI_CPUFREQ_H
-
-#include <linux/cpufreq.h>
-
-struct davinci_cpufreq_config {
-	struct cpufreq_frequency_table *freq_table;
-	int (*set_voltage) (unsigned int index);
-	int (*init) (void);
-};
-
-#endif
diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index d54a27c99121..940fe85db97a 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -23,13 +23,10 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/platform_data/davinci-cpufreq.h>
 #include <linux/platform_device.h>
 #include <linux/export.h>
 
-#include <mach/hardware.h>
-#include <mach/cpufreq.h>
-#include <mach/common.h>
-
 struct davinci_cpufreq {
 	struct device *dev;
 	struct clk *armclk;
diff --git a/include/linux/platform_data/davinci-cpufreq.h b/include/linux/platform_data/davinci-cpufreq.h
new file mode 100644
index 000000000000..3fbf9f2793b5
--- /dev/null
+++ b/include/linux/platform_data/davinci-cpufreq.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI DaVinci CPUFreq platform support.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ */
+
+#ifndef _MACH_DAVINCI_CPUFREQ_H
+#define _MACH_DAVINCI_CPUFREQ_H
+
+#include <linux/cpufreq.h>
+
+struct davinci_cpufreq_config {
+	struct cpufreq_frequency_table *freq_table;
+	int (*set_voltage)(unsigned int index);
+	int (*init)(void);
+};
+
+#endif /* _MACH_DAVINCI_CPUFREQ_H */
-- 
2.20.1


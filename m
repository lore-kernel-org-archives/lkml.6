Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D9AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1BD20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhFtXVj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1BD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeH3WIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43806 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeH3WIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so7899497lfi.10;
        Thu, 30 Aug 2018 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JvSO0dczpNLWTzHOOBaNzPUDUqa2BMj87UWzjeeshg0=;
        b=JhFtXVj2j4o8LMl2qgBvT9Z8dT812PGiK3s5tu243KhPWIlbK7bzO8vzuoX7xEmoZb
         jO/7evKIfqGNIro8kSGyVpJRQO2drQOEcL9RYGy/sQi/50HWjwLFz8R94HOtF4RZ3uR+
         AeImLlqlhg8rBJ8b8K1o2zqPhpUn/4V4S3ooal7rJjmBa88gqwi0S4Oe0MwnZw498zuN
         bIYv+dB0frEJj3itoQ9aYYZSwq6yFld4mVu5IMLQqI74BvwTQ7RVSs5mKanCYL86kMF8
         kUM4jAcrFppFbSdFPTYl5o6zt4nV71KiC3/wNHjdrJGbkHDlz9R4vhOBPFz6nLD87gZP
         MaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JvSO0dczpNLWTzHOOBaNzPUDUqa2BMj87UWzjeeshg0=;
        b=VeMJFnyiA3+/H+KcaENI7LPXb7kPlpA7GE60BIadXjdZ6uAeJB7tLYVIgp/nCXYUek
         OqejEyAE8Pgt05UwKVKwQ9QXxYI8XBKtniGn31LAbWP9MjYAMsAqcr+EPw2xpykz/7Ii
         zHPmQ3SAdPdxi0OP02XBIcHz/yjjChuz6ATFr8Sc1swXVRTDqrBlDUpBpZF4BxpGfSy2
         B1aHzcr2LppxScRuAaIA0yI4Wrsyb2DKnCcSloZepq902RidJM1dCyFvgnaxIcV7xKyN
         8/JT72E5sy8BC+p90dzKwfsl8cBQLMdNbRyB7ZxSldWeHLk+9Zkh2S//zxxJ0hIG1v7Y
         YtYQ==
X-Gm-Message-State: APzg51DUzthgb/eoUhCH9UpJGsEVfg2mn2oTnI5Be8TDk4NrUItV3A5y
        L/ZFjaubqzoK2mhPzilBqcM=
X-Google-Smtp-Source: ANB0Vdb/m5Rdj9LgsSQAYgyq+EsfiZDKo8eZeD36wlslUlZH9TxcBplZT7cU7CHpBkw0KxOfQMQ8hQ==
X-Received: by 2002:a19:2a91:: with SMTP id q17-v6mr8574174lfq.74.1535652322600;
        Thu, 30 Aug 2018 11:05:22 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] ARM: trusted_foundations: Implement L2 cache initialization callback
Date:   Thu, 30 Aug 2018 21:04:14 +0300
Message-Id: <20180830180421.6415-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement L2 cache initialization firmware callback that should be invoked
early in boot in order to setup the required outer cache driver callbacks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 689e6565abfc..3bf61a5933b9 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -18,8 +18,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <asm/firmware.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT		0xfffff100
+
+#define TF_CACHE_ENABLE		1
+#define TF_CACHE_DISABLE	2
+
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
 #define TF_CPU_PM		0xfffffffc
@@ -67,9 +74,48 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_cache_write_sec(unsigned long val, unsigned int reg)
+{
+	static u32 l2x0_way_mask = 0xff;
+	static u32 l2x0_aux_ctrl = 0;
+
+	switch (reg) {
+	case L2X0_AUX_CTRL:
+		l2x0_aux_ctrl = val;
+
+		if (l2x0_aux_ctrl & BIT(16))
+			l2x0_way_mask = 0xffff;
+		break;
+
+	case L2X0_CTRL:
+		if (val == L2X0_CTRL_EN)
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_ENABLE,
+				       l2x0_aux_ctrl);
+		else
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_DISABLE,
+				       l2x0_way_mask);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int tf_init_cache(void)
+{
+	outer_cache.write_sec = tf_cache_write_sec;
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
2.18.0


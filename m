Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8C9A0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376EF208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUOpp5nA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376EF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935422AbeFMLdT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:33:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41320 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935399AbeFMLdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:33:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id az12-v6so1379972plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ChAuc8lHvl/YQvwortB1kFZ67NvvCDDalDvR66fi15s=;
        b=DUOpp5nAmdrtHRyQb6PaSZNfAE3m6sZnlPGP1mmIAaHXGQp0FoXsqh51Vcw28Tw5xn
         fG0ENvQ0ssbmVGPyGu5b9cEr2UNxsC5JIcmUEYGFN5n1bVfJIo7vMhCpV1ZKsXvMBf4f
         D/bTyXn2tIZVgc9tlCNd0EgRE0byK1KWocuEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ChAuc8lHvl/YQvwortB1kFZ67NvvCDDalDvR66fi15s=;
        b=j7aT5jUu8NkXaPJ8y9vwox2/wv37CAbKVQM/lW5XWIpi285fZDNzv8nbdh0U7BBVWT
         qIyw+7aV2FMaSfnBpWFL7FQTymyQDcLNahziGrhH2Z9XlZNT45QlTlJ5rxhwWvxmTAEd
         7pjPhYlkGBVzPtaaEo7Ku16wEBiSXv9BFKc/CpHdpvDaM9HogikUizwf6RqOTn2jb8ZQ
         phNWZXKueqj8k5Gv8msEarnvENe/L+CkrStcPfll2tiO7X4oFTqYrKxJsdccspQWdTEp
         ITFMTksCtm/OC5hlfc9P3DnweTHD8ZmVwcQAh6ej+IXwrZ4ktRGDfYFT8etXih3cIL61
         X4Eg==
X-Gm-Message-State: APt69E20n7/gXhT4dMyYsQ9a/t3CyiPaAOTSaIoQRNhzMbs+oBFIqDYd
        zFlrd8LtvIYWF4eqZuldaJX6Fg==
X-Google-Smtp-Source: ADUXVKJyd2UpfyXGO955Lxj4ezEgVH7f/LyMWkVY544weQZGGStnRqbMnqyQ9Jrkuu2ugV1s1PJ/8Q==
X-Received: by 2002:a17:902:1127:: with SMTP id d36-v6mr4855932pla.267.1528889594807;
        Wed, 13 Jun 2018 04:33:14 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.33.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:33:14 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org,
        daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com,
        aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com,
        marc.zyngier@arm.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
        rdunlap@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
        linus.walleij@linaro.org, viresh.kumar@linaro.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, len.brown@intel.com,
        rajvi.jingar@intel.com, alexandre.belloni@bootlin.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 2/8] clocksource: sprd: Add one persistent timer for Spreadtrum platform
Date:   Wed, 13 Jun 2018 19:32:29 +0800
Message-Id: <95ec43d6f335e31d6e1da4eb0db522008728363b.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Spreadtrum SC9860 platform, we need one persistent timer to calculate
the suspend time to compensate the OS time.

This patch registers one Spreadtrum AON timer as persistent timer, which
runs at 32bit and periodic mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig      |    1 +
 drivers/clocksource/timer-sprd.c |   80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd8..7f11c6c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -455,6 +455,7 @@ config SPRD_TIMER
 	depends on (ARCH_SPRD || COMPILE_TEST)
 	default ARCH_SPRD
 	select TIMER_OF
+	select PERSISTENT_CLOCK
 	help
 	  Enables support for the Spreadtrum timer driver.
 
diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index ef9ebea..c6f657a 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -3,8 +3,11 @@
  * Copyright (C) 2017 Spreadtrum Communications Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 
 #include "timer-of.h"
 
@@ -157,3 +160,80 @@ static int __init sprd_timer_init(struct device_node *np)
 }
 
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
+
+void __iomem *pbase;
+
+static u64 sprd_persistent_timer_read(void)
+{
+	return ~(u64)readl_relaxed(pbase + TIMER_VALUE_SHDW_LO) &
+		CLOCKSOURCE_MASK(32);
+}
+
+static void sprd_persistent_timer_disable(void)
+{
+	sprd_timer_disable(pbase);
+}
+
+static void sprd_persistent_timer_enable(void)
+{
+	sprd_timer_disable(pbase);
+	sprd_timer_update_counter(pbase, TIMER_VALUE_LO_MASK);
+	sprd_timer_enable(pbase, TIMER_CTL_PERIOD_MODE);
+}
+
+static int __init sprd_persistent_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	u32 freq;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Can't get timer clock for %pOF\n", np);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Failed to enable clock for %pOF\n", np);
+		clk_put(clk);
+		return ret;
+	}
+
+	freq = clk_get_rate(clk);
+	if (!freq) {
+		pr_err("Failed to get clock rate for %pOF\n", np);
+		ret = -EINVAL;
+		goto clk_rate_err;
+	}
+
+	pbase = of_io_request_and_map(np, 0, of_node_full_name(np));
+	if (IS_ERR(pbase)) {
+		pr_err("Can't map timer registers for %pOF\n", np);
+		ret = PTR_ERR(pbase);
+		goto clk_rate_err;
+	}
+
+	sprd_persistent_timer_enable();
+
+	ret = persistent_clock_init_and_register(sprd_persistent_timer_read,
+						 CLOCKSOURCE_MASK(32), freq, 0);
+	if (ret) {
+		pr_err("Failed to register persistent clock for %pOF\n", np);
+		goto persist_err;
+	}
+
+	return 0;
+
+persist_err:
+	sprd_persistent_timer_disable();
+	iounmap(pbase);
+clk_rate_err:
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-persistent-timer",
+		 sprd_persistent_timer_init);
-- 
1.7.9.5


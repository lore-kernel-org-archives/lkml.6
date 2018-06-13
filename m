Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 72616C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281C1208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwSPbK0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281C1208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935475AbeFMLdo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:33:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34794 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935459AbeFMLdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:33:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so1388594plq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VFxhbhsSuXUmiZ9cQAUkdhNUFAU4y120/7wyv8wzRCU=;
        b=GwSPbK0OGf/jDreDhJlTg4vRKQl2zMu36mc/NSHeoDaHQ8K0xkwMYZBWZamkImUBzo
         qWOOGdi/faD9AkLS16WjIwAahe+/R5LAloQxJ1UBATQ6iz27y0U66bAh/7Ll9Td1xoi+
         6nOFrd3OlxGVfclu7h330U4UkuZTY/m8deJE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VFxhbhsSuXUmiZ9cQAUkdhNUFAU4y120/7wyv8wzRCU=;
        b=IRlKGgbHUOdfHh1nHFNCyxp1YDb7LpH3AIrCN5ZxsiVaz2sTso19v06quPEw5Yrdrx
         SDiC1LJEj8CSDyl7XrjLKc6FUZ305dYD2txAK7RJxsi+L35XwyIQNtETi2JlM+Jdy7JA
         Ol4o7TgzoVRcqCMwExgASNNILQdwAABEENpflpYUoENfPrFr6b1ImLAMWStMU3q2rkOw
         DiJxpwtBMMXLXe7ciiNqdaKNfnDF3Mzy9mJRIJiINGSJqA9T7eEjNX/omeb/Xw7XfTsY
         zpRV4UgG5xFlojbNiH73cNYWGjLieJfRQ6KlMmIXOvR5V0xWFwe+fZK9Gee/Sh2gsM3U
         G8dA==
X-Gm-Message-State: APt69E3Bl6L9MKKtr1PzPJaRrU/P8UhaETokCpU8qSQ0ShnzVjLmuyv/
        kjKvtYVbe8GbbwY13mOcZpCzkg==
X-Google-Smtp-Source: ADUXVKLYIGMkwIV0T29opdgUBlMg5KARNS7oxaxxhPheGD5fpuyIcQnllz5pT6pMVGAP2/FFLwexSg==
X-Received: by 2002:a17:902:7406:: with SMTP id g6-v6mr4745245pll.90.1528889620901;
        Wed, 13 Jun 2018 04:33:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.33.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:33:40 -0700 (PDT)
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
Subject: [PATCH 5/8] clocksource: timer-ti-32k: Register the persistent clock
Date:   Wed, 13 Jun 2018 19:32:32 +0800
Message-Id: <904493423cadb90576a712acdb3b512b4ed44887.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 32K counter is always available, then we can register the
persistent clock to compensate the suspend time for the OS time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig        |    1 +
 drivers/clocksource/timer-ti-32k.c |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5e51fcf..3cd136f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -262,6 +262,7 @@ config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK
 	select TIMER_OF if OF
+	select PERSISTENT_CLOCK
 	help
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
 	  available on many OMAP-like platforms.
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861..353ff9d 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -41,6 +41,7 @@
 #include <linux/clocksource.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
@@ -120,6 +121,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
+	persistent_clock_init_and_register(omap_32k_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), 32768, 0);
+
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
-- 
1.7.9.5


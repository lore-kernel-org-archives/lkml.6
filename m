Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F114EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A573F204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHjcCH44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A573F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935491AbeFMLdx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:33:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33936 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935459AbeFMLdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:33:50 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so1152903pgr.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2jKomMyu3aPBvQwHnJ5xi/PxkWHSmOUr0jIrlPwlqUo=;
        b=DHjcCH44PAE//jlj19ah6Lf6VjIsxwDZljyjvo8mQDpaISZEmORUdgHGSx4ht3wvIo
         pNE8+itgpZQ4tEBXVSCgOJGMq8RAxczNzXxO4kOtXjs0s0uoyPuMMkwm2LD6nr6tiWdT
         1b9HW6mWoxEHvbOSLIhKIRT/00Lf48AZgpap0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2jKomMyu3aPBvQwHnJ5xi/PxkWHSmOUr0jIrlPwlqUo=;
        b=bhwHpXf9j11tDi0ZwO1VTKW5XVthSmjAvJDc+XMvq4QsEvcRDP9/YoL6qD3qiG1FZ/
         zqNEDRRshv4CGjvUS9GWECHao1fLaDwHUqx5rj194cMjxM5bCl7iengk8hBTZayidGYa
         sDLqkjvxRdHWAO/H1uHV9Kw8OxxyOeELFd1IXVv7gCxCCLsryfed5RlI/pUtLkdfc9dR
         CzQjl0Vbm4RyqyXKvFntJWbol6BOH5wxN9oFZzJi6l0mOmQw/OE9ZKsQr0yJt9rU7h4m
         6eIsg6cY5H62Ttc60rfrN0zWPbXFyOx34hZlfQI+r38DYTXxA1ClaqugXNO8bFlJuokO
         FuGg==
X-Gm-Message-State: APt69E1AjDoq8usrrjZsyat9U/eRkFOHIiNK/xWAtVfB5YV86zzhDi4o
        gHJiUVWGY6ihAJqOvTgxS+DZhQ==
X-Google-Smtp-Source: ADUXVKLTizWTXbXFsSjgSErRHW7sVMXM1YRtFLO1ja/eanjd30bHW28hZhyerTht2cfBRKmYv0wYgA==
X-Received: by 2002:a63:7707:: with SMTP id s7-v6mr3862017pgc.426.1528889629540;
        Wed, 13 Jun 2018 04:33:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.33.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:33:49 -0700 (PDT)
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
Subject: [PATCH 6/8] clocksource: time-pistachio: Register the persistent clock
Date:   Wed, 13 Jun 2018 19:32:33 +0800
Message-Id: <e00f46be05f74439eecd9c4fb43baa4cd0dae297.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the timer on pistachio platform is always available, we can
register it as one persistent clock to compensate the suspend time
for the OS time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig          |    1 +
 drivers/clocksource/time-pistachio.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3cd136f..af552ba 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -255,6 +255,7 @@ config CLKSRC_PISTACHIO
 	bool "Clocksource for Pistachio SoC" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select TIMER_OF
+	select PERSISTENT_CLOCK
 	help
 	  Enables the clocksource for the Pistachio SoC.
 
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index a2dd85d..5c3eb71 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sched_clock.h>
@@ -212,6 +213,8 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 
 	raw_spin_lock_init(&pcs_gpt.lock);
 	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	persistent_clock_init_and_register(pistachio_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), rate, 0);
 	return clocksource_register_hz(&pcs_gpt.cs, rate);
 }
 TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
-- 
1.7.9.5


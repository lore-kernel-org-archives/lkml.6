Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3DAC10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9320120675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDySiRAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfBWNIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35681 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfBWNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so4279798wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqlZ9y60+g61RglAPoiE/a+Pic8KuxjtCcTeAXdOW8w=;
        b=UDySiRAEDlj+2/nVLaWr1kRMDEterDlOGCjGMrfb5Qcyxd3BCAjB9t+XzXvOc70r3G
         hElqqI6om74Ug3hEio91Ol9EbkkFnJh2QrbqlI8cYMgnmPq0FzrF+EzGPU/HkOk5LeoQ
         jAQfXM2AF4+g3cZ/2w0YDGcpBJ0D1pLuZ8DWVLzmc/V/cFVS+7td9moAOrKf0WPbUW3d
         iF/+XVkeqPq8o5/wskCbGn7u2XlxHuISEU3/imhDFYLwjNvihWjcT4Q3IAWMKbit+t3N
         DmTgqKugwVilOQIhbZ4Ma4I57VG1bBKd6WiDIxAQgzjGmOr3Fs6ht00liZAW+d4iraDk
         QJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqlZ9y60+g61RglAPoiE/a+Pic8KuxjtCcTeAXdOW8w=;
        b=BxPfmr2alQToMQdTzOXIBaakrLX8q1oyYC5+f3mUDCdmKNM3/hEiWoxCUHwA8ml4MD
         2yAqHc9AKLzTxSCDz72PmtsaBOj5TyfIqHysr75LJMNjmz5S7OL/Nru3qfhtQEbvD+q+
         UBFNFXMhjRvyzVvgfN6QJMScf9rJC3P1tzMwpGnUwSq/hdhG5Qq0A2nBD9geqUV3kkNS
         TCnP4N0Gb21BdCv8XAxPy/MjL1NAvkAAUP6CBv1/yStKRoALBBn/diB3hR/ruiIl57oy
         3SsCtN0hix4sCrcnUisw+eHGNOhWUzlJ6TkIgMQzETTl6A04ShaTnmb3wNqwFrZSeIOz
         Py4g==
X-Gm-Message-State: AHQUAuZsAH70dyX6tyzQtvHGfiO2uH92wGVEh6ijFjtSAfJ9T27F0aG0
        pmuyi8etZ07o9M5TPUE1elbkEg==
X-Google-Smtp-Source: AHgI3IYxiS+rGiapRCkzcSK+HOI3psbZAHYZpe7CQU9xEIZxBMd7B1DR4p+Dsn0MoLQtcD+1MEkOWQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr5676166wme.93.1550927288008;
        Sat, 23 Feb 2019 05:08:08 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:07 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES)
Subject: [PATCH 09/18] clocksource/drivers/exynos_mct: Fix error path in timer resources initialization
Date:   Sat, 23 Feb 2019 14:06:57 +0100
Message-Id: <20190223130707.16704-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

While freeing interrupt handlers in error path, don't assume that all
requested interrupts are per-processor interrupts and properly release
standard interrupts too.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 647ea9fc752f..33e90c080877 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -562,7 +562,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	return 0;
 
 out_irq:
-	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	if (mct_int_type == MCT_INT_PPI) {
+		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	} else {
+		for_each_possible_cpu(cpu) {
+			struct mct_clock_event_device *pcpu_mevt =
+				per_cpu_ptr(&percpu_mct_tick, cpu);
+
+			if (pcpu_mevt->evt.irq != -1) {
+				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
+				pcpu_mevt->evt.irq = -1;
+			}
+		}
+	}
 	return err;
 }
 
-- 
2.17.1


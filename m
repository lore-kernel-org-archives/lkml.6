Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96428C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AD321871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhVGVzAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeLRVbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:31:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37102 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeLRV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so4271008wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8OL+k0Oli0oh0o5ZlNIy/mrqQdCQT5aJmvzbj58HEcI=;
        b=XhVGVzADfWNk7GAASYs+Sbh9M84UHWLiE52M4lnhMh/zkwF8LtNfWwv8MkgiOquy4/
         utFt18xv1Snx3sK6bWfwg0C/kieJpBwNcSS7wHb3mR3Oz/Y0ZdAjiwF1WocnYFcjvegu
         LKjWqMxQtKWidfem0pVKdaNl5sV8fDTMI0WbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8OL+k0Oli0oh0o5ZlNIy/mrqQdCQT5aJmvzbj58HEcI=;
        b=Lb7VmzDs0+RmVRQU4tGviyaj2pz2Lul50bf7h4TrvR0NZOwO+ingFppzpNxiorOJmo
         MnxZ4FfSqUTKnvHUVJYAqMzZgWaj0zW0yputLylG7Sd8Tj9UzF1GCDQFU7WLxIGr0g1x
         /4g+7QiN3iUc4hp79/jmXL/r833zXlykkxGcoMyw7nA0KJrpj624e+ot2qNOpvK17ozB
         TUsHDFEREX0CrLhSAKXehm9Nhgu+2/P2miWwPyIENa7KdzTPQ4fPr1XSq/+PDJweBspL
         PAT54rFygchlykxjIvZ63OpyTCHw5bkmA1AakFV409bQVqD8Q2eONDL54th5GjJuswp7
         9MPw==
X-Gm-Message-State: AA+aEWblnkCvvJiWhpaTwPBqpKfQmgTsNU0Pgg/rO+uH1aRB5XOpiSRS
        N+jI5YybiwmO7psSfK5W0yJO//Cim1g=
X-Google-Smtp-Source: AFSGD/VwZE8+Q5HsVCmctOv1QZDTN4q2mK0HRiMlxkrvMu8OJyPw+yUUF5H982IE29VVT/f9hm+1/g==
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr4575081wme.108.1545168554928;
        Tue, 18 Dec 2018 13:29:14 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:14 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/25] clocksource/drivers/timer-ti-dm: Remove the early platform driver registration
Date:   Tue, 18 Dec 2018 22:28:22 +0100
Message-Id: <20181218212844.30445-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver is no longer used as an early platform driver. Remove the
registration macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b224b87..595124074821 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -991,7 +991,6 @@ static struct platform_driver omap_dm_timer_driver = {
 	},
 };
 
-early_platform_init("earlytimer", &omap_dm_timer_driver);
 module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-- 
2.17.1


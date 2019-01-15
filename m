Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67125C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316B920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwDltzlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfAOPEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:04:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41365 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfAOPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:04:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so2274258lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KB+g7eKeJjC3ka4b3nc5CCCT6CKjA+7sv61OrWFHims=;
        b=DwDltzljmC67hvozDhb8jEP6SLD+qIaP/sF4hn0phWOQJD0VVCmz8aUvbHgs2SOueu
         PnSnS5Zpjfuw3f0EuMOgYECYM/IAtw3dyv4nTDprKV3E8tPh0eXIuY18qRLfrEArNkPT
         QaeMPZp3t3io8jRRX52xb4yZMzINQPB+U2IWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KB+g7eKeJjC3ka4b3nc5CCCT6CKjA+7sv61OrWFHims=;
        b=KY4dIpO1VA9EK3SqQEKh7HazlV+1aZAhqeMmlk7vdqTTkOWHwvP0QOW1DFgvaj/t1+
         GDDvW/TnhVG/LZREmEX8+Te4aBaPEJNFAm41pZAWml3q62coySuHhV7RujzquXV4k1t2
         zzi5c+9aq8RCS6Kd8usNew4x59IiSPVnDk95+rSNMA7+PwJyrcR4BqKzo2yDPbapCHEj
         iB17WxKrUTLjH9pHxxrf0JsbHCslp2jbhpeZ20qWtDiZWR6XGu255abOLG2OjHjGq+EW
         7PBdXC7T8M+sT7fLiCLh48+pn7KCo9C5SZLyp+pBtHqtD2VcBKNSyEFbTLGYMUVaam6+
         kplQ==
X-Gm-Message-State: AJcUukeNLGqRh860HEMZv53uO/soljoc/kRdKHokXNzpxE0LEkOVCnpL
        d6C2XCdVZFG+TQAE8pGwArvocA==
X-Google-Smtp-Source: ALg8bN7WOKqCa3IrpISaplME60JVrWY0qDoHtpu1vYYn//J/nwaFnqgY2GVIhr6CVQOWvDLW6YuMdQ==
X-Received: by 2002:a19:c995:: with SMTP id z143mr2907187lff.79.1547564679112;
        Tue, 15 Jan 2019 07:04:39 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id p23sm667304lfh.47.2019.01.15.07.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 07:04:38 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalr@ti.com>,
        linux-wireless@vger.kernel.org
Cc:     Ricardo Salveti <rsalveti@rsalveti.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jan Kiszka <jan.kiszka@web.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH] wlcore: sdio: Fixup power on/off sequence
Date:   Tue, 15 Jan 2019 16:04:33 +0100
Message-Id: <20190115150433.12558-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During "wlan-up", we are programming the FW into the WiFi-chip. However,
re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
is made in-between the programmings.

To conform to this requirement and to fix the regression in a simple way,
let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
(runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
current code is to treat this scenario as an error, but unfortunate this
doesn't work as expected, so let's fix this.

The other part is to guarantee that a power cycle of the SDIO card has been
completed when wl12xx_sdio_power_on() returns, as to allow the FW
programming to succeed. However, relying solely on runtime PM to deal with
this isn't sufficient. For example, userspace may prevent runtime suspend
via sysfs for the device that represents the SDIO card, leading to that the
mmc core also keeps it powered on. For this reason, let's instead do a
brute force power cycle in wl12xx_sdio_power_on().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index bd10165d7eec..bc73085fe806 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -163,6 +163,12 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 		return ret;
 	}
 
+	/*
+	 * To guarantee that the SDIO card is power cycled, as required to make
+	 * the FW programming to succeed, let's do a brute force HW reset.
+	 */
+	mmc_hw_reset(card->host);
+
 	sdio_claim_host(func);
 	sdio_enable_func(func);
 	sdio_release_host(func);
@@ -174,20 +180,13 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 {
 	struct sdio_func *func = dev_to_sdio_func(glue->dev);
 	struct mmc_card *card = func->card;
-	int error;
 
 	sdio_claim_host(func);
 	sdio_disable_func(func);
 	sdio_release_host(func);
 
 	/* Let runtime PM know the card is powered off */
-	error = pm_runtime_put(&card->dev);
-	if (error < 0 && error != -EBUSY) {
-		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
-
-		return error;
-	}
-
+	pm_runtime_put(&card->dev);
 	return 0;
 }
 
-- 
2.17.1


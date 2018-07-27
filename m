Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7E9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B1C20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR/mJOAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B1C20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeG0KS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:18:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43157 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeG0KS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:18:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so2853668pgr.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tAknk93iXRXfEaLS/SlYbFRYN4UqDbUTH7Wuwk94oZI=;
        b=QR/mJOATjfVpI09KHpDOjepdigOp+0D2tJp2RS1QKhtStnruR09Uhim8PHH3y6SkvU
         ukfY7wALM9cmWRFS5S6y3Y+m0Hkk8CHRln+qwfFgsA44+eis3sELZV/oMppiu5kgUOb7
         NDfrt9f/LdQQOxpXu16XIy3qg5W6D7tCAo51AjRiYRb5ijUasbpSRtbCgBwnAnO3wf2f
         P4sM1RjNFVrPuziJ7zhsUW3urwXePh1rBti3qbRzUSpZchqvCw3BG9GAZc1kKXhFHBwl
         Mro8uDpAZkopsR8AQFpexkMa9cfnwhdE/WMlmWxNTQ61bgoYMrEzpvcd0FHbh1aXUJjL
         N0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tAknk93iXRXfEaLS/SlYbFRYN4UqDbUTH7Wuwk94oZI=;
        b=Qk6Tct1R/czVQuKE2mgq1gXOhwM2WasWrd9OpPnQtyOQubHbcO4BhVuQLJN0M9+bv/
         NFIM750Qp+puMXOYORNrPyGcAiWRGspXcfRzNFq7gMHYCCJspSyr6q0mfBAlQ4dUC+9A
         ql5bCjrxALTivBnv1exCf2hT/aTuPDmGBECIgEOVruIW0i9pp0WkuvtRCQyl7/5momwZ
         HSqzZL0fV0rQfJpLllUzmPVH4H1KjuOqKv18kNf/2aeJL4bkPyb/yx+eJO8/MK4s+ZZn
         KBcyhRUHdD7j9UyEfuvunZyvoHMuvYsk9Xet5DNHmpG+S9pWcfeqruPSmT6kdmwwt8Od
         l6yg==
X-Gm-Message-State: AOUpUlH4Rgq5wqt/V93ETpEpx91qG8SskJbo2D55QQhIe9B8SWuLEz2D
        9hbdL4PMz7iB09tHs1pti5E=
X-Google-Smtp-Source: AAOMgpdJjOlNzEgrH4LKgx/mKaNdSQXheAEHqJ5iagrUq6xFrEw0jhgdEpaXJ8cPmMmxN/AIWEB1Vw==
X-Received: by 2002:a63:4c21:: with SMTP id z33-v6mr5195920pga.383.1532681883307;
        Fri, 27 Jul 2018 01:58:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id t21-v6sm6678693pfi.73.2018.07.27.01.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:58:02 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: pci: cthw20k1: Replace mdelay() with msleep()
Date:   Fri, 27 Jul 2018 16:57:56 +0800
Message-Id: <20180727085756.12440-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hw_pll_init(), hw_reset_dac() and hw_card_init() are never 
called in atomic context.
They calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/ctxfi/cthw20k1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 8e6eb9d7984b..6a051a1c3724 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -1319,7 +1319,7 @@ static int hw_pll_init(struct hw *hw, unsigned int rsr)
 			break;
 
 		hw_write_20kx(hw, PLLCTL, pllctl);
-		mdelay(40);
+		msleep(40);
 	}
 	if (i >= 3) {
 		dev_alert(hw->card->dev, "PLL initialization failed!!!\n");
@@ -1407,7 +1407,7 @@ static int hw_reset_dac(struct hw *hw)
 	/* To be effective, need to reset the DAC twice. */
 	for (i = 0; i < 2;  i++) {
 		/* set gpio */
-		mdelay(100);
+		msleep(100);
 		gpioorg = (u16)hw_read_20kx(hw, GPIO);
 		gpioorg &= 0xfffd;
 		hw_write_20kx(hw, GPIO, gpioorg);
@@ -2030,7 +2030,7 @@ static int hw_card_init(struct hw *hw, struct card_conf *info)
 	hw_write_20kx(hw, GIE, 0);
 	/* Reset all SRC pending interrupts */
 	hw_write_20kx(hw, SRCIP, 0);
-	mdelay(30);
+	msleep(30);
 
 	/* Detect the card ID and configure GPIO accordingly. */
 	switch (hw->model) {
-- 
2.17.0


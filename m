Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED70C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071920894
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7071920894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeG1S0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 14:26:49 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:39726 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbeG1S0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 14:26:48 -0400
Received: from p200300ccfbf73b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbf7:3b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fjSZ4-0001JI-Lv; Sat, 28 Jul 2018 18:59:34 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fjSZ4-00049L-7I; Sat, 28 Jul 2018 18:59:34 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, j-keerthy@ti.com, tony@atomide.com,
        linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning EPROBE_DEFER
Date:   Sat, 28 Jul 2018 18:59:14 +0200
Message-Id: <20180728165914.15871-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got this in the kernel log:
[    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
[    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22

the probe function has to wait until omap_dm_timer_probe() in
clocksource/timer-ti-dm.c has initialized pdata, so defer probing

Fixes: b7290cf6ff78 (pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops)
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/pwm/pwm-omap-dmtimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c8fbce..808835179c2e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -264,8 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
-		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret = -EINVAL;
+		ret = -EPROBE_DEFER;
 		goto put;
 	}
 
-- 
2.11.0


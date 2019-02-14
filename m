Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FD921B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wV5gWe9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503299AbfBNU6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:58:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38240 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390459AbfBNU6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:58:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id n15so5592049lfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PagzdWaUTNSAgesiK6p5To+FsV4qJSp38NqiU4uGyng=;
        b=wV5gWe9J9qZVt5iM4ZHC9p3M0igGdTL6VWUETYqsLlrNpUl4UrFdCee+ifqWeZQTao
         ZPYr1TmNmcejs01b6SPP0jUl0+laqmAPAjYi0ZbECvJxIRZ5u6Q3eFdx5Y92Pw8h2cwg
         /Bv1BvVPr03n3a8YJYG4AvmcmqGvfN0trJtcoWbfcaOapVJP4d+rbvxHBCrx0hcWSr85
         GacWiGZyIC63AwhRnMZXQCahg/F+5kpF8kzILn7XL+qY3oXPxugmizZ0MQtPoeQGyOTg
         33RSsmg3zocnWYpwLKwAfzQt4Os/cYL/uAjb8KYq9N+8nHrHgUGaobUY1YWH+rLuHmcf
         +WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PagzdWaUTNSAgesiK6p5To+FsV4qJSp38NqiU4uGyng=;
        b=sWozU7R4R9nnORKTj//XSBDsFot0Rga8e9fi1EiZTk0Tiwz9jTUEOgoANwtsEMRHiH
         sGsE39eVN+e4f2Iqo0SZ7HUu742cPIm/c35UQ5YAed6tsOHnk+MfRrwuJ1EwVktkanmu
         kpYkUijqoZFLpZ3YWRFFQVlygDu6/XcTizWMI2iO8NrV61tWD5J/ycmvUyhvsDcvG5Wz
         843EW7MvQJFXhK/U4qxWmbj/97IYIPxylEuWwE/iHy+5/sOOb++vRnL4SX0jwCtprmmX
         f6lZwaNNqXkstDt5M2rZY/fR/pnh72mZF2H38rTQAfzXVF2Tf2Y3nVyGMcJaoUj6lqmn
         kEjQ==
X-Gm-Message-State: AHQUAua1ub/Y1GeI+kTaZ6ACBf1ureG6wyTMVEtP2HQHaBWHk3sK09kQ
        INVr1NyrzEPynAOAD3ZiY/JAWg==
X-Google-Smtp-Source: AHgI3IbpQVBiUPYe67Ymio/QGwHqQPdnwtzc7u0/WmcEaoKwEa7aC/jANyaGMbFD69YynEuclX6yIw==
X-Received: by 2002:ac2:5205:: with SMTP id a5mr3546133lfl.135.1550177899514;
        Thu, 14 Feb 2019 12:58:19 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id e9-v6sm633609ljk.92.2019.02.14.12.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:58:18 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] leds: lp55xx: fix warning unused label 'out'
Date:   Thu, 14 Feb 2019 21:58:12 +0100
Message-Id: <20190214205812.7311-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building leds lp55xx a waring about label 'out' defined but not used.

drivers/leds/leds-lp55xx-common.c: In function ‘lp55xx_firmware_loaded’:
drivers/leds/leds-lp55xx-common.c:217:1: warning: label ‘out’ defined but not used [-Wunused-label]
 out:
 ^~~

Rework current code to remove the label 'out'.

905c2157dd19 ("leds: lp55xx: fix null deref on firmware load failure")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/leds/leds-lp55xx-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index 64986f0fd367..723f2f17497a 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -214,7 +214,6 @@ static void lp55xx_firmware_loaded(const struct firmware *fw, void *context)
 
 	mutex_unlock(&chip->lock);
 
-out:
 	/* firmware should be released for other channel use */
 	release_firmware(chip->fw);
 	chip->fw = NULL;
-- 
2.19.2


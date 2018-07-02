Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326E24F91
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6326E24F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeGBQuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:50:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35773 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeGBQuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:50:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fa229-0006BX-To; Mon, 02 Jul 2018 16:50:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: max8997: use mode when calling max8997_led_set_mode
Date:   Mon,  2 Jul 2018 17:50:37 +0100
Message-Id: <20180702165037.20035-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable mode is assigned to pdata->led_pdata->mode[led->id] and yet
is not being used when calling function max8997_led_set_mode. Fix
this by using mode when calling max8997_led_set_mode.

Cleans up clang warning:
warning: variable 'mode' set but not used [-Wunused-but-set-variable]

Fixes: 8584cb82f151 ("leds: Add suuport for MAX8997-LED driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/leds/leds-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
index 4edf74f1d6d4..8c019c28f9f5 100644
--- a/drivers/leds/leds-max8997.c
+++ b/drivers/leds/leds-max8997.c
@@ -268,7 +268,7 @@ static int max8997_led_probe(struct platform_device *pdev)
 		mode = pdata->led_pdata->mode[led->id];
 		brightness = pdata->led_pdata->brightness[led->id];
 
-		max8997_led_set_mode(led, pdata->led_pdata->mode[led->id]);
+		max8997_led_set_mode(led, mode);
 
 		if (brightness > led->cdev.max_brightness)
 			brightness = led->cdev.max_brightness;
-- 
2.17.1


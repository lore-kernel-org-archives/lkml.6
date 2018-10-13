Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF5C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82D2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D82D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeJNE3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:29:50 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37288 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725734AbeJNE3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:29:49 -0400
Received: from localhost.localdomain (unknown [85.140.179.81])
        by mail.ispras.ru (Postfix) with ESMTPSA id 44410540089;
        Sat, 13 Oct 2018 23:51:17 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Damien Riegel <damien.riegel@savoirfairelinux.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] watchdog: ts4800: release syscon device node in ts4800_wdt_probe()
Date:   Sat, 13 Oct 2018 23:51:03 +0300
Message-Id: <1539463863-21867-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put syscon device node when it is not needed anymore.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/watchdog/ts4800_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index 2b8de8602b67..89843b16b04a 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -135,6 +135,7 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 	/* set regmap and offset to know where to write */
 	wdt->feed_offset = reg;
 	wdt->regmap = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
 	if (IS_ERR(wdt->regmap)) {
 		dev_err(&pdev->dev, "cannot get parent's regmap\n");
 		return PTR_ERR(wdt->regmap);
-- 
2.7.4


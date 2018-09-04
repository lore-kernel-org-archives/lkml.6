Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEF1206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEF1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIDXB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:01:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40459 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDXB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:01:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxGAL-0003Dd-Ry; Tue, 04 Sep 2018 18:35:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: wm97xx: only unregister wm97xx_driver if it has been registered
Date:   Tue,  4 Sep 2018 19:35:05 +0100
Message-Id: <20180904183505.10693-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where IS_BUILTIN(CONFIG_AC97_BUS)) is not true, the
wm97xx_driver driver is being unregistered even it has not been
previously registered.  Fix this by only unregistering it if
IS_BUILTIN(CONFIG_AC97_BUS)) is true.  This fixes the warning
message:

[  834.111248] ------------[ cut here ]------------
[  834.111248] Unexpected driver unregister!
[  834.111319] WARNING: CPU: 2 PID: 11749 at drivers/base/driver.c:193 driver_unregister+0x3b/0x40
[  834.111319] Modules linked in: wm97xx_ts(-) ....

..and a stack trace.

To easily reproduce this, load and unload the module on a system where
the hardware is not supported.

Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/touchscreen/wm97xx-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 2566b4d8b342..73856c2a8ac0 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -929,7 +929,8 @@ static int __init wm97xx_init(void)
 
 static void __exit wm97xx_exit(void)
 {
-	driver_unregister(&wm97xx_driver);
+	if (IS_BUILTIN(CONFIG_AC97_BUS))
+		driver_unregister(&wm97xx_driver);
 	platform_driver_unregister(&wm97xx_mfd_driver);
 }
 
-- 
2.17.1


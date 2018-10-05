Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B3C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9092148D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+9FpMLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9092148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbeJEXQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbeJEXQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C87213A2;
        Fri,  5 Oct 2018 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756197;
        bh=sq+5z8/F0NlZ8vUz1E5tKUIFWF3Do+U2+n5rd29uWzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+9FpMLBhQH+kZ2RfZbA2dI/NSBw9k4fP4s4/MrbAD8AkpIT6lIZdBu7hIRPPc98g
         4AZWEOtMm8W+Qx36vKDC7YBp99pVbVI9MOrRhWu20InjbSYqNCbvCn/+3CMnFGc95x
         +Ktfwr8fVu4iUpqOaCd3flh1qIocKGj5fRD6BAtY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/23] ASoC: wm8804: Add ACPI support
Date:   Fri,  5 Oct 2018 12:16:13 -0400
Message-Id: <20181005161634.20631-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161634.20631-1-sashal@kernel.org>
References: <20181005161634.20631-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 960cdd50ca9fdfeb82c2757107bcb7f93c8d7d41 ]

HID made of either Wolfson/CirrusLogic PCI ID + 8804 identifier.

This helps enumerate the HifiBerry Digi+ HAT boards on the Up2 platform.

The scripts at https://github.com/thesofproject/acpi-scripts can be
used to add the ACPI initrd overlays.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/wm8804-i2c.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8804-i2c.c b/sound/soc/codecs/wm8804-i2c.c
index f27464c2c5ba..79541960f45d 100644
--- a/sound/soc/codecs/wm8804-i2c.c
+++ b/sound/soc/codecs/wm8804-i2c.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/acpi.h>
 
 #include "wm8804.h"
 
@@ -40,17 +41,29 @@ static const struct i2c_device_id wm8804_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8804_i2c_id);
 
+#if defined(CONFIG_OF)
 static const struct of_device_id wm8804_of_match[] = {
 	{ .compatible = "wlf,wm8804", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, wm8804_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id wm8804_acpi_match[] = {
+	{ "1AEC8804", 0 }, /* Wolfson PCI ID + part ID */
+	{ "10138804", 0 }, /* Cirrus Logic PCI ID + part ID */
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, wm8804_acpi_match);
+#endif
 
 static struct i2c_driver wm8804_i2c_driver = {
 	.driver = {
 		.name = "wm8804",
 		.pm = &wm8804_pm,
-		.of_match_table = wm8804_of_match,
+		.of_match_table = of_match_ptr(wm8804_of_match),
+		.acpi_match_table = ACPI_PTR(wm8804_acpi_match),
 	},
 	.probe = wm8804_i2c_probe,
 	.remove = wm8804_i2c_remove,
-- 
2.17.1


Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1E8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AEE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFhW701T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AEE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbeJEXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbeJEXRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BAF72147D;
        Fri,  5 Oct 2018 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756259;
        bh=sq+5z8/F0NlZ8vUz1E5tKUIFWF3Do+U2+n5rd29uWzo=;
        h=From:To:Cc:Subject:Date:From;
        b=lFhW701TLWh6jldOW1XOIoD1fRp/fxUcNZUCteHZxQxvTAzWhH474i2F72hsU/1kA
         TVj4SfBdSn+bjZYBLHe22Ug2rLC6dx7hIMFoXN2undPOkRpFjITG73mbfiWS9Kpn6Y
         CbAD37iTc52CltixVM/y4X3S+3DkLT+11+tAOTH8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 01/11] ASoC: wm8804: Add ACPI support
Date:   Fri,  5 Oct 2018 12:17:26 -0400
Message-Id: <20181005161736.20765-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
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


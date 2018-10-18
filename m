Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA97ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C19214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwKvMm42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C19214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeJSCGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbeJSCGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58E321479;
        Thu, 18 Oct 2018 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885886;
        bh=e/CYVGV6ZD0ZOVoUerqdgP1jOjGKTcumOlmCRp1UVl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwKvMm427oy1UnGFBkGGvScVOundTTgMx7eqsohYq2GtnsoUfKgyDGToARJbl6b3G
         dBfKHG1hlEdw70RtmrKKUQAD59vvnw6AgyemUuw9ycZ0OYYwZfrtpJPk8kOpqdJ70b
         QkPQPUsyUVZtnc5LMGbgGEVGzoTP3wQdo+6ekFTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 01/48] ASoC: wm8804: Add ACPI support
Date:   Thu, 18 Oct 2018 19:54:36 +0200
Message-Id: <20181018175427.528206364@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wm8804-i2c.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/wm8804-i2c.c
+++ b/sound/soc/codecs/wm8804-i2c.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/acpi.h>
 
 #include "wm8804.h"
 
@@ -40,17 +41,29 @@ static const struct i2c_device_id wm8804
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



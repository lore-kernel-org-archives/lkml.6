Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D833CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914AC244E2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914AC244E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031304AbeGAR2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:28:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031355AbeGAQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:36:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0849FACC;
        Sun,  1 Jul 2018 16:36:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH 4.17 013/220] platform/chrome: cros_ec_lpc: do not try DMI match when ACPI device found
Date:   Sun,  1 Jul 2018 18:20:37 +0200
Message-Id: <20180701160908.910774417@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit b410b1226620b6c959f1e9c87529acd058e90caf upstream.

Older models of Chromebooks did not describe the LPC EC in their ACPI
tables; starting with Strago-based devices Google is using GOOG0004 device
to describe EC LPC.

DMI-based match is fragile and does not work reliably, especially when
using custom firmware. It is also not needed when we can locate the right
ACPI device, so let's stop bailing out when DMI does not match but the
right ACPI device is present.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/chrome/cros_ec_lpc.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -435,7 +435,13 @@ static int __init cros_ec_lpc_init(void)
 	int ret;
 	acpi_status status;
 
-	if (!dmi_check_system(cros_ec_lpc_dmi_table)) {
+	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
+				  &cros_ec_lpc_acpi_device_found, NULL);
+	if (ACPI_FAILURE(status))
+		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
+
+	if (!cros_ec_lpc_acpi_device_found &&
+	    !dmi_check_system(cros_ec_lpc_dmi_table)) {
 		pr_err(DRV_NAME ": unsupported system.\n");
 		return -ENODEV;
 	}
@@ -450,11 +456,6 @@ static int __init cros_ec_lpc_init(void)
 		return ret;
 	}
 
-	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
-				  &cros_ec_lpc_acpi_device_found, NULL);
-	if (ACPI_FAILURE(status))
-		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
-
 	if (!cros_ec_lpc_acpi_device_found) {
 		/* Register the device, and it'll get hooked up automatically */
 		ret = platform_device_register(&cros_ec_lpc_device);



Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8423C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C2720656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297744;
	bh=JhfSwboZdpuvsOvXhI8nKdlgUhktKbWCpGx0BWh+20k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PWMGQhrchnRKX+4Ou8g7aRgG93DU2Kjev2PW0NoD9ngQByckltVO5CFC/wrzrvbPQ
	 h6jHyVdr7/G61+9PmfxafWRTHUNPfz90M/BcrXswNBFq6jUd+iwOVYDv3e2mQTORAU
	 D5saf49S4MXagFQatJkQv7irLkyJ56cOHvG4rGvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbeLTJWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731295AbeLTJWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB7C20656;
        Thu, 20 Dec 2018 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297736;
        bh=JhfSwboZdpuvsOvXhI8nKdlgUhktKbWCpGx0BWh+20k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMFCQ5m5k5k+LJFFJ/WCzJeqybcz28t5AvFuxotYktAxRlgvxjPp2ZP1O6lhGnf6O
         W0Wul89m31/7mk6N2A/9+d/VcCR0cTRJbxWrXNUmcXepXOZjRNMzdiVEZ4ZBpcSwjb
         9ER7PYOv7hvMKlTHCbpQ9S+19EZAxCWPfhrv+b4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 37/40] i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI device node
Date:   Thu, 20 Dec 2018 10:18:49 +0100
Message-Id: <20181220085827.927070896@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0544ee4b1ad574aec3b6379af5f5cdee42840971 ]

Some AMD based HP laptops have a SMB0001 ACPI device node which does not
define any methods.

This leads to the following error in dmesg:

[    5.222731] cmi: probe of SMB0001:00 failed with error -5

This commit makes acpi_smbus_cmi_add() return -ENODEV instead in this case
silencing the error. In case of a failure of the i2c_add_adapter() call
this commit now propagates the error from that call instead of -EIO.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-scmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index efefcfa24a4c..d2178f701b41 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -364,6 +364,7 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
 {
 	struct acpi_smbus_cmi *smbus_cmi;
 	const struct acpi_device_id *id;
+	int ret;
 
 	smbus_cmi = kzalloc(sizeof(struct acpi_smbus_cmi), GFP_KERNEL);
 	if (!smbus_cmi)
@@ -385,8 +386,10 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
 	acpi_walk_namespace(ACPI_TYPE_METHOD, smbus_cmi->handle, 1,
 			    acpi_smbus_cmi_query_methods, NULL, smbus_cmi, NULL);
 
-	if (smbus_cmi->cap_info == 0)
+	if (smbus_cmi->cap_info == 0) {
+		ret = -ENODEV;
 		goto err;
+	}
 
 	snprintf(smbus_cmi->adapter.name, sizeof(smbus_cmi->adapter.name),
 		"SMBus CMI adapter %s",
@@ -397,7 +400,8 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
 	smbus_cmi->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus_cmi->adapter.dev.parent = &device->dev;
 
-	if (i2c_add_adapter(&smbus_cmi->adapter)) {
+	ret = i2c_add_adapter(&smbus_cmi->adapter);
+	if (ret) {
 		dev_err(&device->dev, "Couldn't register adapter!\n");
 		goto err;
 	}
@@ -407,7 +411,7 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
 err:
 	kfree(smbus_cmi);
 	device->driver_data = NULL;
-	return -EIO;
+	return ret;
 }
 
 static int acpi_smbus_cmi_remove(struct acpi_device *device)
-- 
2.19.1




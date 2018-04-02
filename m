Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeDBMZu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 08:25:50 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39231 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeDBMZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 08:25:47 -0400
X-Google-Smtp-Source: AIpwx4+2eJyo/o7QYk6sJoFMznzyLZCVVpbesi761xoaj8mbEq1erc8Fd7hXzdd0TvwiOCt+DACKNg==
From: Jason Andryuk <jandryuk@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: benjamin.tissoires@redhat.com, andyrtr@archlinux.org,
        aduggan@synaptics.com, Jason Andryuk <jandryuk@gmail.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: i801: blacklist Host Notify on HP EliteBook G3 850
Date: Mon,  2 Apr 2018 08:25:36 -0400
Message-Id: <20180402122536.5083-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
hangs while plugged in if Linux enables the Host Notify features of
i2c-i801.  The cold boot hang depends on how the system boots.  It does
not hang on UEFI Grub text boot or legacy Grub text boot.  But it does
hang on legacy Grub graphical boot and Intel Boot Agent PXE text boot.
Booting unplugged is not affected.

Disabling the Host Notify feature with disable_feature=0x20 works around
the bug, so automatically do so based on DMI information.

More information can be found here:
https://www.spinics.net/lists/linux-i2c/msg33938.html

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
I only added my machine to the blacklist, since it's the only one I've
tested.  More systems can be added when identified and tested.

 drivers/i2c/busses/i2c-i801.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 692b34125866..2ff10c41ccad 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1042,6 +1042,24 @@ static const struct pci_device_id i801_ids[] = {
 MODULE_DEVICE_TABLE(pci, i801_ids);
 
 #if defined CONFIG_X86 && defined CONFIG_DMI
+static const struct dmi_system_id host_notify_dmi_blacklist[] = {
+	{
+		.ident = "HP EliteBook G3 850",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 850 G3"),
+		},
+	},
+};
+
+static void blacklist_features(struct i801_priv *priv) {
+	if (dmi_check_system(host_notify_dmi_blacklist)) {
+		dev_warn(&priv->pci_dev->dev,
+			 "SMBus Host Notify disabled on this system");
+		priv->features &= ~FEATURE_HOST_NOTIFY;
+	}
+}
+
 static unsigned char apanel_addr;
 
 /* Scan the system ROM for the signature "FJKEYINF" */
@@ -1159,6 +1177,7 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
 #else
 static void __init input_apanel_init(void) {}
 static void i801_probe_optional_slaves(struct i801_priv *priv) {}
+static void blacklist_features(struct i801_priv *priv) {}
 #endif	/* CONFIG_X86 && CONFIG_DMI */
 
 #if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
@@ -1562,6 +1581,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 				   i801_feature_names[i]);
 	}
 	priv->features &= ~disable_features;
+	blacklist_features(priv);
 
 	err = pcim_enable_device(dev);
 	if (err) {
-- 
2.14.3

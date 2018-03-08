Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeCHRiS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:38:18 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34364 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbeCHRiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:38:16 -0500
X-Google-Smtp-Source: AG47ELuYEKwDjci1GoLnnRUAfUecg0qpNZ2iE7lMan6uyXUEEDNREhjGzIzAaMEkRWdiQKpm+einlA==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/3] mfd: rave-sp: Add code to print firmware versions
Date: Thu,  8 Mar 2018 09:37:54 -0800
Message-Id: <20180308173756.13787-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code that would query and print out bootloader and application
firmware version info.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]:

	- Removed unused deving from the middle of 'struct rave_status'

[v1] https://lkml.kernel.org/r/20180226150739.13457-1-andrew.smirnov@gmail.com

 drivers/mfd/rave-sp.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index c8173de5653a..be243678a61e 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -160,6 +160,8 @@ struct rave_sp_variant {
  * @variant:			Device variant specific information
  * @event_notifier_list:	Input event notification chain
  *
+ * @part_number_firmware:	Firmware version
+ * @part_number_bootloader:	Bootloader version
  */
 struct rave_sp {
 	struct serdev_device *serdev;
@@ -171,8 +173,40 @@ struct rave_sp {
 
 	const struct rave_sp_variant *variant;
 	struct blocking_notifier_head event_notifier_list;
+
+	const char *part_number_firmware;
+	const char *part_number_bootloader;
 };
 
+struct rave_sp_version {
+	u8     hardware;
+	__le16 major;
+	u8     minor;
+	u8     letter[2];
+} __packed;
+
+struct rave_sp_status {
+	struct rave_sp_version bootloader_version;
+	struct rave_sp_version firmware_version;
+	u16 rdu_eeprom_flag;
+	u16 dds_eeprom_flag;
+	u8  pic_flag;
+	u8  orientation;
+	u32 etc;
+	s16 temp[2];
+	u8  backlight_current[3];
+	u8  dip_switch;
+	u8  host_interrupt;
+	u16 voltage_28;
+	u8  i2c_device_status;
+	u8  power_status;
+	u8  general_status;
+	u8  deprecated1;
+	u8  power_led_status;
+	u8  deprecated2;
+	u8  periph_power_shutoff;
+} __packed;
+
 static bool rave_sp_id_is_event(u8 code)
 {
 	return (code & 0xF0) == RAVE_SP_EVNT_BASE;
@@ -609,6 +643,52 @@ static int rave_sp_default_cmd_translate(enum rave_sp_command command)
 	}
 }
 
+static const char *devm_rave_sp_version(struct device *dev,
+					struct rave_sp_version *version)
+{
+	/*
+	 * NOTE: The format string below uses %02d to display u16
+	 * intentionally for the sake of backwards compatibility with
+	 * legacy software.
+	 */
+	return devm_kasprintf(dev, GFP_KERNEL, "%02d%02d%02d.%c%c\n",
+			      version->hardware,
+			      le16_to_cpu(version->major),
+			      version->minor,
+			      version->letter[0],
+			      version->letter[1]);
+}
+
+static int rave_sp_get_status(struct rave_sp *sp)
+{
+	struct device *dev = &sp->serdev->dev;
+	u8 cmd[] = {
+		[0] = RAVE_SP_CMD_STATUS,
+		[1] = 0
+	};
+	struct rave_sp_status status;
+	const char *version;
+	int ret;
+
+	ret = rave_sp_exec(sp, cmd, sizeof(cmd), &status, sizeof(status));
+	if (ret)
+		return ret;
+
+	version = devm_rave_sp_version(dev, &status.firmware_version);
+	if (!version)
+		return -ENOMEM;
+
+	sp->part_number_firmware = version;
+
+	version = devm_rave_sp_version(dev, &status.bootloader_version);
+	if (!version)
+		return -ENOMEM;
+
+	sp->part_number_bootloader = version;
+
+	return 0;
+}
+
 static const struct rave_sp_checksum rave_sp_checksum_8b2c = {
 	.length     = 1,
 	.subroutine = csum_8b2c,
@@ -657,6 +737,7 @@ static const struct serdev_device_ops rave_sp_serdev_device_ops = {
 static int rave_sp_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
+	const char *unknown = "unknown\n";
 	struct rave_sp *sp;
 	u32 baud;
 	int ret;
@@ -689,6 +770,20 @@ static int rave_sp_probe(struct serdev_device *serdev)
 
 	serdev_device_set_baudrate(serdev, baud);
 
+	ret = rave_sp_get_status(sp);
+	if (ret) {
+		dev_warn(dev, "Failed to get firmware status: %d\n", ret);
+		sp->part_number_firmware   = unknown;
+		sp->part_number_bootloader = unknown;
+	}
+
+	/*
+	 * Those strings already have a \n embedded, so there's no
+	 * need to have one in format string.
+	 */
+	dev_info(dev, "Firmware version: %s",   sp->part_number_firmware);
+	dev_info(dev, "Bootloader version: %s", sp->part_number_bootloader);
+
 	return devm_of_platform_populate(dev);
 }
 
-- 
2.14.3

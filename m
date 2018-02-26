Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeBZPH4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:07:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36534 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754306AbeBZPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:07:53 -0500
X-Google-Smtp-Source: AH8x224O8p9xccp6CjYDAUtsddGCmFsA90NSCQ+PmOkG0A/zx0qa7gk7fgyyHH/RG+2vKrq+kKS6pw==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] mfd: rave-sp: Add code to print firmware versions
Date: Mon, 26 Feb 2018 07:07:37 -0800
Message-Id: <20180226150739.13457-1-andrew.smirnov@gmail.com>
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
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Lee:

The reason 'part_number_firmware' and 'part_number_firmware' are a
part of struct rave_sp is because there exists another patch on top of
this one that exposes those fields via sysfs. The latter patch is not
currently being upstreamed (might be in the future), so if keeping
this arrangement is too ugly, let me know, and I'll get rid of those
fields in 'rave_sp'.

Thanks,
Andrey Smirnov


 drivers/mfd/rave-sp.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index c8173de5653a..9e4c83ff2aec 100644
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
@@ -171,8 +173,42 @@ struct rave_sp {
 
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
+#define RAVE_SP_STATUS_GS_FIRMWARE_MODE	BIT(1)
+
+	u8  deprecated1;
+	u8  power_led_status;
+	u8  deprecated2;
+	u8  periph_power_shutoff;
+} __packed;
+
 static bool rave_sp_id_is_event(u8 code)
 {
 	return (code & 0xF0) == RAVE_SP_EVNT_BASE;
@@ -609,6 +645,52 @@ static int rave_sp_default_cmd_translate(enum rave_sp_command command)
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
@@ -657,6 +739,7 @@ static const struct serdev_device_ops rave_sp_serdev_device_ops = {
 static int rave_sp_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
+	const char *unknown = "unknown\n";
 	struct rave_sp *sp;
 	u32 baud;
 	int ret;
@@ -689,6 +772,20 @@ static int rave_sp_probe(struct serdev_device *serdev)
 
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeDCRIS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:08:18 -0400
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:58504 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeDCRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:08:16 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i8042: Enable MUX on Sony VAIO VGN-CS series to fix touchpad
Date: Tue,  3 Apr 2018 19:08:10 +0200
Message-Id: <20180403170810.32005-1-linux@rainbow-software.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touch sensor buttons on Sony VAIO VGN-CS series laptops (e.g.
VGN-CS31S) are a separate PS/2 device. As the MUX is disabled for all
VAIO machines by the nomux blacklist, the data from touch sensor
buttons and touchpad are combined. The protocol used by the buttons is
probably similar to the touchpad protocol (both are Synaptics) so both
devices get enabled. The controller combines the data, creating a mess
which results in random button clicks, touchpad stopping working and
lost sync error messages:
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 4
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: issuing reconnect request

Add a new i8042_dmi_forcemux_table whitelist with VGN-CS.
With MUX enabled, touch sensor buttons are detected as separate device
(and left disabled as there's currently no driver), fixing all touchpad
problems.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 6cbbdc6e9687..56644c74828c 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -530,6 +530,20 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 	{ }
 };
 
+static const struct dmi_system_id __initconst i8042_dmi_forcemux_table[] = {
+	{
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+	},
+	{ }
+};
+
 /*
  * On some Asus laptops, just running self tests cause problems.
  */
@@ -1163,6 +1177,9 @@ static int __init i8042_platform_init(void)
 	if (dmi_check_system(i8042_dmi_nomux_table))
 		i8042_nomux = true;
 
+	if (dmi_check_system(i8042_dmi_forcemux_table))
+		i8042_nomux = false;
+
 	if (dmi_check_system(i8042_dmi_notimeout_table))
 		i8042_notimeout = true;
 
-- 
Ondrej Zary

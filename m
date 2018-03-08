Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935156AbeCHJKm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:10:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46094 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755461AbeCHJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:10:38 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: mjg59@srcf.ucam.org, pali.rohar@gmail.com, dvhart@infradead.org,
        andy@infradead.org, mario.limonciello@dell.com, tiwai@suse.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/3] platform/x86: dell-*: Add interface for switchable graphics status query
Date: Thu,  8 Mar 2018 17:10:22 +0800
Message-Id: <20180308091023.9061-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180308091023.9061-1-kai.heng.feng@canonical.com>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Dell platforms, there's a BIOS option "Enable Switchable
Graphics". This information is useful if we want to do different things
based on this value, e.g. disable unused audio controller that comes
with the discrete graphics.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2: Mario suggested to squash the HDA part into the same series.
    Forgot to put dell_switchable_gfx_enabled() into header, so put it
    here.

 drivers/platform/x86/dell-laptop.c | 23 +++++++++++++++++++++++
 drivers/platform/x86/dell-smbios.c |  2 ++
 drivers/platform/x86/dell-smbios.h |  2 ++
 include/linux/dell-common.h        |  1 +
 4 files changed, 28 insertions(+)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 8ba820e6c3d0..3f6fc07b8cf2 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2116,6 +2116,29 @@ int dell_micmute_led_set(int state)
 }
 EXPORT_SYMBOL_GPL(dell_micmute_led_set);
 
+int dell_switchable_gfx_enabled(bool *enabled)
+{
+	struct calling_interface_buffer buffer;
+	struct calling_interface_token *token;
+	int ret;
+
+	*enabled = false;
+
+	token = dell_smbios_find_token(SWITCHABLE_GRAPHICS_ENABLE);
+	if (!token)
+		return -ENODEV;
+
+	dell_fill_request(&buffer, token->location, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
+	if (ret)
+		return ret;
+
+	*enabled = !!buffer.output[1];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dell_switchable_gfx_enabled);
+
 static int __init dell_init(void)
 {
 	struct calling_interface_token *token;
diff --git a/drivers/platform/x86/dell-smbios.c b/drivers/platform/x86/dell-smbios.c
index 8541cde4cb7d..ca38b9d9dcf4 100644
--- a/drivers/platform/x86/dell-smbios.c
+++ b/drivers/platform/x86/dell-smbios.c
@@ -86,6 +86,8 @@ struct token_range {
 static struct token_range token_whitelist[] = {
 	/* used by userspace: fwupdate */
 	{CAP_SYS_ADMIN,	CAPSULE_EN_TOKEN,	CAPSULE_DIS_TOKEN},
+	/* can indicate to userspace Switchable Graphics enable status */
+	{CAP_SYS_ADMIN,	SWITCHABLE_GRAPHICS_ENABLE,	SWITCHABLE_GRAPHICS_DISABLE},
 	/* can indicate to userspace that WMI is needed */
 	{0x0000,	WSMT_EN_TOKEN,		WSMT_DIS_TOKEN}
 };
diff --git a/drivers/platform/x86/dell-smbios.h b/drivers/platform/x86/dell-smbios.h
index 138d478d9adc..b012d4abd239 100644
--- a/drivers/platform/x86/dell-smbios.h
+++ b/drivers/platform/x86/dell-smbios.h
@@ -37,6 +37,8 @@
 #define KBD_LED_AUTO_100_TOKEN	0x02F6
 #define GLOBAL_MIC_MUTE_ENABLE	0x0364
 #define GLOBAL_MIC_MUTE_DISABLE	0x0365
+#define SWITCHABLE_GRAPHICS_ENABLE	0x037A
+#define SWITCHABLE_GRAPHICS_DISABLE	0x037B
 
 struct notifier_block;
 
diff --git a/include/linux/dell-common.h b/include/linux/dell-common.h
index 37e4b614dd74..4435c5717388 100644
--- a/include/linux/dell-common.h
+++ b/include/linux/dell-common.h
@@ -3,5 +3,6 @@
 #define __DELL_COMMON_H__
 
 int dell_micmute_led_set(int on);
+int dell_switchable_gfx_enabled(bool *enabled);
 
 #endif
-- 
2.15.1

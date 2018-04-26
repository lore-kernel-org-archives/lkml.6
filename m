Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZofBj9q9EyIpO31rBuMNu9QgB7awJVx3celTNVxmpOOyPJpNMdaIpJKHZ474Lk/wEp9amMo
ARC-Seal: i=1; a=rsa-sha256; t=1524744416; cv=none;
        d=google.com; s=arc-20160816;
        b=Q79kWPc2YikKlKNUrH3F/pXx2QTsK0/6acTKRotrfsuOgB1QFHx7Y9OZ17DH0zsCtJ
         hlqYgUt3EkIHLjGM6qovJXH+cs4AULYtH/5/U+ffzQy9wExo20uv9InBBLP0PRQXPsJi
         dpPGuBwoAT1HrKGYVBAthuVm8hOZ/01zOOX+eQVErqX6kddKJ1UBMdD1h3FLexREa0+Z
         3mAVKwJ1nf6MaLtaYz9rBUjwgjn/8szn1cG18ED/PDHzFld2iQOUG41nfanHhkKF921m
         oWFsYFqIOpAXopFj5VWxUqTL35gC5FGzq75mbSPqBnenwyRz4pgw/tN2pFvJgkpeZ7JK
         100g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=K3QNLsmtpyx4Kz22wWz7pz1vN6KJ1XzzUAGtyqV73yM=;
        b=MC40+i54Lvi8UEaLrndZBvyvZCDMC2RGRnY2NVrkE+oUZdJwvRwT6vpJiSu2w7w/x2
         dSpnz4ZO02QrQUy29nH0UHJf+vZlET5rF4EsrGQJvJIMlSKXTiluitp51KI/exT73HLI
         KhxHUcq3xb4OLl0wnR379bSLp/vBUtD9gUM9X8gj4tDG/lTqRMHtMGSSXFBSe3q4mEWz
         5V8hhvI7pjrMCBA8xr/6J4OE3LQmGXLiLWfp+FVU4HF2FO1IbJF4cLImjxB24QknKqUO
         OV22o0jKpPEYkRb3pG5D5MphnHt4ysUvRUoY5yRcorbe2vqaL6s1p8kWNIj2ZmSitGgj
         /j5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	dmitry.torokhov@gmail.com,
	mfuzzey@parkeon.com,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	nbroeking@me.com,
	bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>,
	Kees Cook <keescook@chromium.org>,
	x86@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] platform/x86: touchscreen_dmi: Add EFI embedded firmware info support
Date: Thu, 26 Apr 2018 14:06:36 +0200
Message-Id: <20180426120637.21258-5-hdegoede@redhat.com>
In-Reply-To: <20180426120637.21258-1-hdegoede@redhat.com>
References: <20180426120637.21258-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598810401828339398?=
X-GMAIL-MSGID: =?utf-8?q?1598810401828339398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sofar we have been unable to get permission from the vendors to put the
firmware for touchscreens listed in touchscreen_dmi in linux-firmware.

Some of the tablets with such a touchscreen have a touchscreen driver, and
thus a copy of the firmware, as part of their EFI code.

This commit adds the necessary info for the new EFI embedded-firmware code
to extract these firmwares, making the touchscreen work OOTB without the
user needing to manually add the firmware.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/firmware/efi/embedded-firmware.c |  3 +++
 drivers/platform/x86/Kconfig             |  1 +
 drivers/platform/x86/touchscreen_dmi.c   | 26 +++++++++++++++++++++++-
 include/linux/efi_embedded_fw.h          |  2 ++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/efi/embedded-firmware.c
index ef6282945307..bbc6d218a82d 100644
--- a/drivers/firmware/efi/embedded-firmware.c
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -23,6 +23,9 @@ struct embedded_fw {
 static LIST_HEAD(found_fw_list);
 
 static const struct dmi_system_id * const embedded_fw_table[] = {
+#ifdef CONFIG_TOUCHSCREEN_DMI
+	touchscreen_dmi_table,
+#endif
 	NULL
 };
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7ff206e5edfe..cc4d95459190 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1199,6 +1199,7 @@ config INTEL_TURBO_MAX_3
 config TOUCHSCREEN_DMI
 	bool "DMI based touchscreen configuration info"
 	depends on ACPI && DMI && I2C=y && TOUCHSCREEN_SILEAD
+	select EFI_EMBEDDED_FIRMWARE if EFI
 	---help---
 	  Certain ACPI based tablets with e.g. Silead or Chipone touchscreens
 	  do not have enough data in ACPI tables for the touchscreen driver to
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 87fc839b28f7..6488cd50ba79 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -15,12 +15,15 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/efi_embedded_fw.h>
 #include <linux/i2c.h>
 #include <linux/notifier.h>
 #include <linux/property.h>
 #include <linux/string.h>
 
 struct ts_dmi_data {
+	/* The EFI embedded-fw code expects this to be the first member! */
+	struct efi_embedded_fw_desc embedded_fw;
 	const char *acpi_name;
 	const struct property_entry *properties;
 };
@@ -31,10 +34,17 @@ static const struct property_entry cube_iwork8_air_props[] = {
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
 	{ }
 };
 
 static const struct ts_dmi_data cube_iwork8_air_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3670-cube-iwork8-air.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 38808,
+		.crc	= 0xfecde51f,
+	},
 	.acpi_name	= "MSSL1680:00",
 	.properties	= cube_iwork8_air_props,
 };
@@ -119,10 +129,17 @@ static const struct property_entry pipo_w2s_props[] = {
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name",
 			      "gsl1680-pipo-w2s.fw"),
+	PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
 	{ }
 };
 
 static const struct ts_dmi_data pipo_w2s_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl1680-pipo-w2s.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 39072,
+		.crc	= 0x28d5dc6c,
+	},
 	.acpi_name	= "MSSL1680:00",
 	.properties	= pipo_w2s_props,
 };
@@ -162,10 +179,17 @@ static const struct property_entry chuwi_hi8_pro_props[] = {
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-pro.fw"),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
 	{ }
 };
 
 static const struct ts_dmi_data chuwi_hi8_pro_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3680-chuwi-hi8-pro.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 39864,
+		.crc	= 0xfe2bedba,
+	},
 	.acpi_name	= "MSSL1680:00",
 	.properties	= chuwi_hi8_pro_props,
 };
@@ -277,7 +301,7 @@ static const struct ts_dmi_data teclast_x3_plus_data = {
 	.properties	= teclast_x3_plus_props,
 };
 
-static const struct dmi_system_id touchscreen_dmi_table[] = {
+const struct dmi_system_id touchscreen_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
 		.driver_data = (void *)&cube_iwork8_air_data,
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_fw.h
index 0f7d4df3f57a..4c8cfe38ec02 100644
--- a/include/linux/efi_embedded_fw.h
+++ b/include/linux/efi_embedded_fw.h
@@ -20,6 +20,8 @@ struct efi_embedded_fw_desc {
 	u32 crc;
 };
 
+extern const struct dmi_system_id touchscreen_dmi_table[];
+
 int efi_get_embedded_fw(const char *name, void **dat, size_t *sz, size_t msize);
 
 #endif
-- 
2.17.0

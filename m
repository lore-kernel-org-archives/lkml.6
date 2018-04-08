Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4+TVOMGtSPa5xkKB4A/zhUt2htnKYpgtw/ckF6GBRgs0hqWW0aiHsHbz3lu59RDfQTFNpjO
ARC-Seal: i=1; a=rsa-sha256; t=1523208406; cv=none;
        d=google.com; s=arc-20160816;
        b=r+oSTfc+NF5O/JDc6bQpPwI24dyentBEiIHIdVkTMXSCMVTXqbQcQTllvR7nYinRTF
         qu30kFX7suuDlfUW8JaqvVNUsKBqw/6riVOgtEXW/Eua0C+10BdewrnB1i7SdTxiHPWK
         N8rkwVPBFt3PMZNJr78O9k0h08hHoTcFFgKne+VnZfqL5Ik7GOVlmeyIjfHExlK7WcYO
         +0e5ymwK9RNiWQzaysmwxivqxuUEsBKlhcauE21y42jYCux5OFzlt6puC9EoW+G3sq7g
         BajKK6l25rfPMYP9AMIDI/w2QeO5F6PN3IvYVIuVwc5RBDRuYvKGsBALDmzvqp//njaA
         yITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=LxxgdEq15Vaq4ncMLqShukuiVLnSB35xYN2Nv0kuSaw=;
        b=gXzuejVgEAUuxlRHwBtQezmnw5indxfmvbWEBj+7kZHdldepd84WaI63mVzFpOtJXU
         wmMP2rXC5A+wEnr3AAQt7SK22Z9Ha1NVqnVkwbMiIp/fURJDCNLmKUNIIbMyr2YcGMTt
         AM1VRGbgQifXdWKqFB6M+b9nM7LT52sJnLaLhW5Ex90aEkOZ7af+FpqGCUW6U78P2OH6
         2CFgrqglNF4HoLg2u7aud4KRQT9nSWvuALoGnU/6VKcZzCqYLY3EwM+YEFVZsdZ66wyD
         n5s51Zi1oCtcMPWTb3ECY1PqSIDgbxDtYRqNjPaH2cmhDib+sMwsnNF580fvRAkaacvM
         LPLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
	keescook@chromium.org,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	nbroeking@me.com,
	bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>,
	x86@kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 1/5] efi: Export boot-services code and data as debugfs-blobs
Date: Sun,  8 Apr 2018 19:26:32 +0200
Message-Id: <20180408172636.13926-2-hdegoede@redhat.com>
In-Reply-To: <20180408172636.13926-1-hdegoede@redhat.com>
References: <20180408172636.13926-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199777602363676?=
X-GMAIL-MSGID: =?utf-8?q?1597199777602363676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes it is useful to be able to dump the efi boot-services code and
data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
but only if efi=debug is passed on the kernel-commandline as this requires
not freeing those memory-regions, which costs 20+ MB of RAM.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Do not call pr_err on debugfs call failures
---
 arch/x86/platform/efi/quirks.c |  4 +++
 drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 5b513ccffde4..0f968c7bcfec 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -374,6 +374,10 @@ void __init efi_free_boot_services(void)
 	int num_entries = 0;
 	void *new, *new_md;
 
+	/* Keep all regions for /sys/kernel/debug/efi */
+	if (efi_enabled(EFI_DBG))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index cd42f66a7c85..10c896e8b82b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -18,6 +18,7 @@
 #include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/of.h>
@@ -316,6 +317,55 @@ static __init int efivar_ssdt_load(void)
 static inline int efivar_ssdt_load(void) { return 0; }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+
+#define EFI_DEBUGFS_MAX_BLOBS 32
+
+static struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
+
+static void __init efi_debugfs_init(void)
+{
+	struct dentry *efi_debugfs;
+	efi_memory_desc_t *md;
+	char name[32];
+	int type_count[EFI_BOOT_SERVICES_DATA + 1] = {};
+	int i = 0;
+
+	efi_debugfs = debugfs_create_dir("efi", NULL);
+	if (IS_ERR_OR_NULL(efi_debugfs))
+		return;
+
+	for_each_efi_memory_desc(md) {
+		switch (md->type) {
+		case EFI_BOOT_SERVICES_CODE:
+			snprintf(name, sizeof(name), "boot_services_code%d",
+				 type_count[md->type]++);
+			break;
+		case EFI_BOOT_SERVICES_DATA:
+			snprintf(name, sizeof(name), "boot_services_data%d",
+				 type_count[md->type]++);
+			break;
+		default:
+			continue;
+		}
+
+		debugfs_blob[i].size = md->num_pages << EFI_PAGE_SHIFT;
+		debugfs_blob[i].data = memremap(md->phys_addr,
+						debugfs_blob[i].size,
+						MEMREMAP_WB);
+		if (!debugfs_blob[i].data)
+			continue;
+
+		debugfs_create_blob(name, 0400, efi_debugfs, &debugfs_blob[i]);
+		i++;
+		if (i == EFI_DEBUGFS_MAX_BLOBS)
+			break;
+	}
+}
+#else
+static inline void efi_debugfs_init(void) {}
+#endif
+
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted with
@@ -360,6 +410,9 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
 
+	if (efi_enabled(EFI_DBG))
+		efi_debugfs_init();
+
 	return 0;
 
 err_remove_group:
-- 
2.17.0

Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4+Dth63Yg/2BX8BxGFS7QX0AdnuFTrEUmGGJcWaXijMke1UUc8M8/nM3lTymm3KEspC4N5R
ARC-Seal: i=1; a=rsa-sha256; t=1522498788; cv=none;
        d=google.com; s=arc-20160816;
        b=Mve0xMSiqji6ZkhbRrsP0E86sBow6rvBZgeVEfoPGI6zvl0cIxMIFHYAzGS0woiUFa
         i47QzpyOPY4Aq0Gij9y0DlQsDAcxZlv4x05kdABHlfnXjxq8xTwvKj1b1h9ahGR/v8ZK
         DNaUvUWJGT3T+Djs5oOhFXvCj/CntbM6jrYhPbCxTDmoMHroVQR5BY1o3v4GRbd5iWhp
         kYKK5DBH61+Qdz4PRMNaiTGX7mInJgwvoeAbWCg+od3Vv3opqqM/5qIaufI8H+ko4fh1
         ibC6rGfhzCh1aowQhWjht1W8XNV3phT/Y0W2MYIxAGj0hiSE8D+2FTUg5SROU0cVBvNV
         AEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Zx2RZPAyt5y+3y3koZ3/YzMiwiFiJEuo29sXS6pbv0g=;
        b=hXUi5e5ea4dnGSolp2fEx45cXNXZsxLkmxIdryw8GIBMhGMcitggnP6vpyNdrxaN/f
         SS7ZRNGWHMqVixeEc4kDmsvgZ+6Qph27mxW1AL42Oo16qI/HKSUYBJCfUCJMEqhL6KyB
         Iryng15evlPvuQfLWifCS0Y50Qh1mesfnSKXn+MACsUE4m1VoEQrOqEYudkc6OdL7xv+
         SWnLHIAp7fRdazqTpxDaVO8GC8QN+Cp4iHjVeFEejP4aGlaQFvYUx1ZBLlyJVKTNFNUR
         oF5xZA8cqgk8Oh+VWXSSLrKouWetgtoxC4n4k3i+2squDSl7R6DbB32mMGhV7QxMAAcO
         4Vkw==
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
	linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>,
	x86@kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 1/2] efi: Export boot-services code and data as debugfs-blobs
Date: Sat, 31 Mar 2018 14:19:43 +0200
Message-Id: <20180331121944.8618-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455689779545050?=
X-GMAIL-MSGID: =?utf-8?q?1596455689779545050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes it is useful to be able to dump the efi boot-services code and
data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
but only if efi=debug is passed on the kernel-commandline as this requires
not freeing those memory-regions, which costs 20+ MB of RAM.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/platform/efi/quirks.c |  4 +++
 drivers/firmware/efi/efi.c     | 57 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index cd42f66a7c85..fddc5f706fd2 100644
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
@@ -316,6 +317,59 @@ static __init int efivar_ssdt_load(void)
 static inline int efivar_ssdt_load(void) { return 0; }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+
+#define EFI_DEBUGFS_MAX_BLOBS 32
+
+struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
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
+	if (IS_ERR_OR_NULL(efi_debugfs)) {
+		pr_warn("Could not create efi debugfs entry\n");
+		return;
+	}
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
+		if (!debugfs_blob[i].data) {
+			pr_warn("Error mapping %s\n", name);
+			continue;
+		}
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
@@ -360,6 +414,9 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
 
+	if (efi_enabled(EFI_DBG))
+		efi_debugfs_init();
+
 	return 0;
 
 err_remove_group:
-- 
2.17.0.rc2

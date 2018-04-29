Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZress647ArL/Qd8tzVWMvttgsbFQOW2NGabB5RQV8SY+EKsfCw56gxFWUMqxMoJy2004mC1
ARC-Seal: i=1; a=rsa-sha256; t=1524994567; cv=none;
        d=google.com; s=arc-20160816;
        b=ckKp+xmtdKc1IpJ/OYGZxg+zccb3BEyhZvnssn7xVo3EBbzti+Jw+q3QD74k0DX1dn
         bwZLLAQkvhZOua77ZVyI4Jvx6zSMTZG0KXjyz4Ye4RJ590fcXTuixI/Wxeis25y34nle
         VJoFiz0vP3yhlFrOvmBcELcPdanGqv81v8Pkxqzyqlt2YDmcQhDspKk2sVvbIf2adBeN
         MDsP4AAqH4nF3XaKPDnCyn3OSE9xylJXDdb9Sjtqj0PM7jq6TPKuo/+3ymyyfoZuDFTQ
         HNnbbG3z1D3u+L1V/vAm4HRXiZVSK902e+RI31Pizcdtb/JuxbU+kJP7xo2ULeA65rNs
         Z9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=LU8SCkGX1IgCJT4MxzFtvM+oDC30b6qeM7bTmeNAoA0=;
        b=pv+iW3voBvBV5hofS1/AEudHasv53C/ciiEJls/gG8tGVESOO/p7vcC9zbRuqrbsNU
         /rdlRxQw1UGrv/RSOLVmZfB1B+TADY9ajdHU9DJW5obQveAFA0uIV5BVBnDm6SIcp6mg
         ptEAsg3nRr59ietZZQCBFAarEuTTA63gmDDXYpvRIyPrYZuOg8oGmdJ/MBSaYWrTIlaS
         JWX+92kKM94EOr8kml6uLSkP21FXkJgYhy/7nYiO7tCWIG6H1MRzw05iitY1WK+L9erP
         RkQ/HvUqagT7GCGOU2HDsHNknS/38VIZg+spEPWa0cEqVqNYiZd1q8tgSKALLjukjnbo
         g+ug==
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
Subject: [PATCH v5 1/5] efi: Export boot-services code and data as debugfs-blobs
Date: Sun, 29 Apr 2018 11:35:54 +0200
Message-Id: <20180429093558.5411-2-hdegoede@redhat.com>
In-Reply-To: <20180429093558.5411-1-hdegoede@redhat.com>
References: <20180429093558.5411-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072704056960898?=
X-GMAIL-MSGID: =?utf-8?q?1599072704056960898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes it is useful to be able to dump the efi boot-services code and
data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
but only if efi=debug is passed on the kernel-commandline as this requires
not freeing those memory-regions, which costs 20+ MB of RAM.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
-Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

Changes in v4:
-Add new EFI_BOOT_SERVICES flag and use it to determine if the boot-services
 memory segments are available (and thus if it makes sense to register the
 debugfs bits for them)

Changes in v2:
-Do not call pr_err on debugfs call failures
---
 arch/x86/platform/efi/efi.c    |  1 +
 arch/x86/platform/efi/quirks.c |  4 +++
 drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
 include/linux/efi.h            |  1 +
 4 files changed, 59 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9061babfbc83..82bbbbf0836d 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -208,6 +208,7 @@ int __init efi_memblock_x86_reserve_range(void)
 	     efi.memmap.desc_version);
 
 	memblock_reserve(pmap, efi.memmap.nr_map * efi.memmap.desc_size);
+	set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
 
 	return 0;
 }
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..16bdb9e3b343 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -376,6 +376,10 @@ void __init efi_free_boot_services(void)
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
index 232f4915223b..1590e4d6a857 100644
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
@@ -325,6 +326,55 @@ static __init int efivar_ssdt_load(void)
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
@@ -369,6 +419,9 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
 
+	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
+		efi_debugfs_init();
+
 	return 0;
 
 err_remove_group:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f1b7d68ac460..791088360c1e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1144,6 +1144,7 @@ extern int __init efi_setup_pcdp_console(char *);
 #define EFI_DBG			8	/* Print additional debug info at runtime */
 #define EFI_NX_PE_DATA		9	/* Can runtime data regions be mapped non-executable? */
 #define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
+#define EFI_PRESERVE_BS_REGIONS	11	/* Are EFI boot-services memory segments available? */
 
 #ifdef CONFIG_EFI
 /*
-- 
2.17.0

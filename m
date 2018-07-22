Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA2920874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA2920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbeGVQTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:19:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeGVQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:19:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFMC0G3458448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:22:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFMCcd3458445;
        Sun, 22 Jul 2018 08:22:12 -0700
Date:   Sun, 22 Jul 2018 08:22:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lukas Wunner <tipbot@zytor.com>
Message-ID: <tip-c4db9c1e8c70bc60e392da8a485bcfb035d559c2@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        lukas@wunner.de, ard.biesheuvel@linaro.org, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: lukas@wunner.de, andriy.shevchenko@linux.intel.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          hdegoede@redhat.com, mingo@kernel.org, ard.biesheuvel@linaro.org,
          hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org
In-Reply-To: <20180720014726.24031-7-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-7-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Deduplicate efi_open_volume()
Git-Commit-ID: c4db9c1e8c70bc60e392da8a485bcfb035d559c2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c4db9c1e8c70bc60e392da8a485bcfb035d559c2
Gitweb:     https://git.kernel.org/tip/c4db9c1e8c70bc60e392da8a485bcfb035d559c2
Author:     Lukas Wunner <lukas@wunner.de>
AuthorDate: Fri, 20 Jul 2018 10:47:23 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:43 +0200

efi: Deduplicate efi_open_volume()

There's one ARM, one x86_32 and one x86_64 version of efi_open_volume()
which can be folded into a single shared version by masking their
differences with the efi_call_proto() macro introduced by commit:

  3552fdf29f01 ("efi: Allow bitness-agnostic protocol calls").

To be able to dereference the device_handle attribute from the
efi_loaded_image_t table in an arch- and bitness-agnostic manner,
introduce the efi_table_attr() macro (which already exists for x86)
to arm and arm64.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-7-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/efi.h                     |  3 ++
 arch/arm64/include/asm/efi.h                   |  3 ++
 arch/x86/boot/compressed/eboot.c               | 63 --------------------------
 drivers/firmware/efi/libstub/arm-stub.c        | 25 ----------
 drivers/firmware/efi/libstub/efi-stub-helper.c | 31 ++++++++++++-
 drivers/firmware/efi/libstub/efistub.h         |  3 --
 include/linux/efi.h                            | 10 ++++
 7 files changed, 45 insertions(+), 93 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 17f1f1a814ff..38badaae8d9d 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -58,6 +58,9 @@ void efi_virtmap_unload(void);
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
 #define efi_is_64bit()			(false)
 
+#define efi_table_attr(table, attr, instance)				\
+	((table##_t *)instance)->attr
+
 #define efi_call_proto(protocol, f, instance, ...)			\
 	((protocol##_t *)instance)->f(instance, ##__VA_ARGS__)
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 192d791f1103..7ed320895d1f 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -87,6 +87,9 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
 #define efi_is_64bit()			(true)
 
+#define efi_table_attr(table, attr, instance)				\
+	((table##_t *)instance)->attr
+
 #define efi_call_proto(protocol, f, instance, ...)			\
 	((protocol##_t *)instance)->f(instance, ##__VA_ARGS__)
 
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 92b573fd239c..915c64edbe8e 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -41,69 +41,6 @@ static void setup_boot_services##bits(struct efi_config *c)		\
 BOOT_SERVICES(32);
 BOOT_SERVICES(64);
 
-static inline efi_status_t __open_volume32(void *__image, void **__fh)
-{
-	efi_file_io_interface_t *io;
-	efi_loaded_image_32_t *image = __image;
-	efi_file_handle_32_t *fh;
-	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
-	efi_status_t status;
-	void *handle = (void *)(unsigned long)image->device_handle;
-	unsigned long func;
-
-	status = efi_call_early(handle_protocol, handle,
-				&fs_proto, (void **)&io);
-	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to handle fs_proto\n");
-		return status;
-	}
-
-	func = (unsigned long)io->open_volume;
-	status = efi_early->call(func, io, &fh);
-	if (status != EFI_SUCCESS)
-		efi_printk(sys_table, "Failed to open volume\n");
-
-	*__fh = fh;
-
-	return status;
-}
-
-static inline efi_status_t __open_volume64(void *__image, void **__fh)
-{
-	efi_file_io_interface_t *io;
-	efi_loaded_image_64_t *image = __image;
-	efi_file_handle_64_t *fh;
-	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
-	efi_status_t status;
-	void *handle = (void *)(unsigned long)image->device_handle;
-	unsigned long func;
-
-	status = efi_call_early(handle_protocol, handle,
-				&fs_proto, (void **)&io);
-	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to handle fs_proto\n");
-		return status;
-	}
-
-	func = (unsigned long)io->open_volume;
-	status = efi_early->call(func, io, &fh);
-	if (status != EFI_SUCCESS)
-		efi_printk(sys_table, "Failed to open volume\n");
-
-	*__fh = fh;
-
-	return status;
-}
-
-efi_status_t
-efi_open_volume(efi_system_table_t *sys_table, void *__image, void **__fh)
-{
-	if (efi_early->is64)
-		return __open_volume64(__image, __fh);
-
-	return __open_volume32(__image, __fh);
-}
-
 void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
 {
 	efi_call_proto(efi_simple_text_output_protocol, output_string,
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index c98b1856fc3d..6920033de6d4 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -40,31 +40,6 @@
 
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 
-efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
-			     void *__image, void **__fh)
-{
-	efi_file_io_interface_t *io;
-	efi_loaded_image_t *image = __image;
-	efi_file_handle_t *fh;
-	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
-	efi_status_t status;
-	void *handle = (void *)(unsigned long)image->device_handle;
-
-	status = sys_table_arg->boottime->handle_protocol(handle,
-				 &fs_proto, (void **)&io);
-	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table_arg, "Failed to handle fs_proto\n");
-		return status;
-	}
-
-	status = io->open_volume(io, &fh);
-	if (status != EFI_SUCCESS)
-		efi_printk(sys_table_arg, "Failed to open volume\n");
-
-	*__fh = fh;
-	return status;
-}
-
 void efi_char16_printk(efi_system_table_t *sys_table_arg,
 			      efi_char16_t *str)
 {
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 50a9cab5a834..e94975f4655b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -413,6 +413,34 @@ static efi_status_t efi_file_close(void *handle)
 	return efi_call_proto(efi_file_handle, close, handle);
 }
 
+static efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
+				    efi_loaded_image_t *image,
+				    efi_file_handle_t **__fh)
+{
+	efi_file_io_interface_t *io;
+	efi_file_handle_t *fh;
+	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
+	efi_status_t status;
+	void *handle = (void *)(unsigned long)efi_table_attr(efi_loaded_image,
+							     device_handle,
+							     image);
+
+	status = efi_call_early(handle_protocol, handle,
+				&fs_proto, (void **)&io);
+	if (status != EFI_SUCCESS) {
+		efi_printk(sys_table_arg, "Failed to handle fs_proto\n");
+		return status;
+	}
+
+	status = efi_call_proto(efi_file_io_interface, open_volume, io, &fh);
+	if (status != EFI_SUCCESS)
+		efi_printk(sys_table_arg, "Failed to open volume\n");
+	else
+		*__fh = fh;
+
+	return status;
+}
+
 /*
  * Parse the ASCII string 'cmdline' for EFI options, denoted by the efi=
  * option, e.g. efi=nochunk.
@@ -563,8 +591,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 
 		/* Only open the volume once. */
 		if (!i) {
-			status = efi_open_volume(sys_table_arg, image,
-						 (void **)&fh);
+			status = efi_open_volume(sys_table_arg, image, &fh);
 			if (status != EFI_SUCCESS)
 				goto free_files;
 		}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index f59564b72ddc..32799cf039ef 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -36,9 +36,6 @@ extern int __pure is_quiet(void);
 
 void efi_char16_printk(efi_system_table_t *, efi_char16_t *);
 
-efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg, void *__image,
-			     void **__fh);
-
 unsigned long get_dram_base(efi_system_table_t *sys_table_arg);
 
 efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e190652f5ef9..401e4b254e30 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -894,6 +894,16 @@ typedef struct _efi_file_handle {
 	void *flush;
 } efi_file_handle_t;
 
+typedef struct {
+	u64 revision;
+	u32 open_volume;
+} efi_file_io_interface_32_t;
+
+typedef struct {
+	u64 revision;
+	u64 open_volume;
+} efi_file_io_interface_64_t;
+
 typedef struct _efi_file_io_interface {
 	u64 revision;
 	int (*open_volume)(struct _efi_file_io_interface *,

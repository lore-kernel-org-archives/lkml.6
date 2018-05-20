Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeETI21 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:28:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeETI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:28:26 -0400
Date: Sun, 20 May 2018 10:28:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] efi fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805201021110.1599@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

Two EFI fixes:

   - Use explicitely sized type for the romimage pointer in the 32bit EFI
     protocol struct so a 64bit kernel does not expand it to 64bit. Ditto
     for the 64bit struct to avoid the reverse issue on 32bit kernels.

  - Handle randomized tex offset correctly in the ARM64 EFI stub to avoid
    unaligned data resulting in stack corruption and other hard to diagnose
    wreckage.

Thanks,

	tglx

------------------>
Ard Biesheuvel (1):
      efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode

Mark Rutland (1):
      efi/libstub/arm64: Handle randomized TEXT_OFFSET


 arch/x86/boot/compressed/eboot.c          |  6 ++++--
 drivers/firmware/efi/libstub/arm64-stub.c | 10 ++++++++++
 include/linux/efi.h                       |  8 ++++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 47d3efff6805..09f36c0d9d4f 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -163,7 +163,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32 *pci, struct pci_setup_rom **__rom)
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
@@ -269,7 +270,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64 *pci, struct pci_setup_rom **__rom)
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index b9bd827caa22..1b4d465cc5d9 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -97,6 +97,16 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 		u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
 			     (phys_seed >> 32) & mask : TEXT_OFFSET;
 
+		/*
+		 * With CONFIG_RANDOMIZE_TEXT_OFFSET=y, TEXT_OFFSET may not
+		 * be a multiple of EFI_KIMG_ALIGN, and we must ensure that
+		 * we preserve the misalignment of 'offset' relative to
+		 * EFI_KIMG_ALIGN so that statically allocated objects whose
+		 * alignment exceeds PAGE_SIZE appear correctly aligned in
+		 * memory.
+		 */
+		offset |= TEXT_OFFSET % EFI_KIMG_ALIGN;
+
 		/*
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f1b7d68ac460..3016d8c456bc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -395,8 +395,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
 
 typedef struct {
@@ -415,8 +415,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
 
 typedef struct {

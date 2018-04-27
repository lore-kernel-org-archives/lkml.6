Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759423AbeD0VfU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:35:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759329AbeD0VfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:35:18 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] efi: Ignore unrealistically large option roms
Date: Fri, 27 Apr 2018 23:35:09 +0200
Message-Id: <20180427213509.20385-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_efi_pci() tries to save a copy of each PCI option ROM as this may
be necessary for the device driver for the PCI device to have access too.

On some systems the efi_pci_io_protocol_64's romimage and romsize fields
contain invalid data, which looks a bit like pointers pointing back into
other EFI code or data. Interpreting these pointers as romsize leads to
a very large value and if we then try to alloc this amount of memory to
save a copy the alloc call fails.

This leads to a "Failed to alloc mem for rom" error being printed on the
EFI console for each PCI device.

This commit avoids the printing of these errors, by checking romsize
before doing the alloc and if it is larger then 256M silently ignore the
ROM fields instead of trying to alloc mem and fail.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add the check to both __setup_efi_pci32 and __setup_efi_pci64 instead of
 only to __setup_efi_pci64, some CHT devices which need this still use a
 32 bit UEFI
---
 arch/x86/boot/compressed/eboot.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 47d3efff6805..6d3257a459c8 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -122,7 +122,13 @@ __setup_efi_pci32(efi_pci_io_protocol_32 *pci, struct pci_setup_rom **__rom)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	if (!pci->romimage || !pci->romsize)
+	/*
+	 * Some firmwares contain EFI function pointers at the place where the
+	 * romimage and romsize fields are supposed to be. Typically the EFI
+	 * code is mapped at high addresses, translating to an unrealistically
+	 * large romsize. We reject any roms over 256M in size to catch this.
+	 */
+	if (!pci->romimage || !pci->romsize || pci->romsize > 0x10000000)
 		return EFI_INVALID_PARAMETER;
 
 	size = pci->romsize + sizeof(*rom);
@@ -230,7 +236,13 @@ __setup_efi_pci64(efi_pci_io_protocol_64 *pci, struct pci_setup_rom **__rom)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	if (!pci->romimage || !pci->romsize)
+	/*
+	 * Some firmwares contain EFI function pointers at the place where the
+	 * romimage and romsize fields are supposed to be. Typically the EFI
+	 * code is mapped at high addresses, translating to an unrealistically
+	 * large romsize. We reject any roms over 256M in size to catch this.
+	 */
+	if (!pci->romimage || !pci->romsize || pci->romsize > 0x10000000)
 		return EFI_INVALID_PARAMETER;
 
 	size = pci->romsize + sizeof(*rom);
-- 
2.16.2

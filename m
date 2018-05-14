Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeENHuy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:50:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeENHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:50:52 -0400
Date: Mon, 14 May 2018 00:50:23 -0700
From: tip-bot for Hans de Goede <tipbot@zytor.com>
Message-ID: <tip-1de3a1be8a9345fd0c7d9bb1009b21afe6b6b10f@git.kernel.org>
Cc: matt@codeblueprint.co.uk, torvalds@linux-foundation.org,
        hdegoede@redhat.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org
Reply-To: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, hdegoede@redhat.com,
        torvalds@linux-foundation.org, matt@codeblueprint.co.uk
In-Reply-To: <20180504060003.19618-16-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-16-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Ignore unrealistically large option ROMs
Git-Commit-ID: 1de3a1be8a9345fd0c7d9bb1009b21afe6b6b10f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1de3a1be8a9345fd0c7d9bb1009b21afe6b6b10f
Gitweb:     https://git.kernel.org/tip/1de3a1be8a9345fd0c7d9bb1009b21afe6b6b10f
Author:     Hans de Goede <hdegoede@redhat.com>
AuthorDate: Fri, 4 May 2018 08:00:01 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:49 +0200

efi/x86: Ignore unrealistically large option ROMs

setup_efi_pci() tries to save a copy of each PCI option ROM as this may
be necessary for the device driver for the PCI device to have access too.

On some systems the efi_pci_io_protocol's romimage and romsize fields
contain invalid data, which looks a bit like pointers pointing back into
other EFI code or data. Interpreting these pointers as romsize leads to
a very large value and if we then try to alloc this amount of memory to
save a copy the alloc call fails.

This leads to a "Failed to alloc mem for rom" error being printed on the
EFI console for each PCI device.

This commit avoids the printing of these errors, by checking romsize before
doing the alloc and if it is larger then the EFI spec limit of 16 MiB
silently ignore the ROM fields instead of trying to alloc mem and fail.

Tested-by: Hans de Goede <hdegoede@redhat.com>
[ardb: deduplicate 32/64 bit changes, use SZ_16M symbolic constant]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-16-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index dadf32312082..a8a8642d2b0b 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -123,10 +123,17 @@ __setup_efi_pci(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	if (status != EFI_SUCCESS)
 		return status;
 
+	/*
+	 * Some firmware images contain EFI function pointers at the place where the
+	 * romimage and romsize fields are supposed to be. Typically the EFI
+	 * code is mapped at high addresses, translating to an unrealistically
+	 * large romsize. The UEFI spec limits the size of option ROMs to 16
+	 * MiB so we reject any ROMs over 16 MiB in size to catch this.
+	 */
 	romimage = (void *)(unsigned long)efi_table_attr(efi_pci_io_protocol,
 							 romimage, pci);
 	romsize = efi_table_attr(efi_pci_io_protocol, romsize, pci);
-	if (!romimage || !romsize)
+	if (!romimage || !romsize || romsize > SZ_16M)
 		return EFI_INVALID_PARAMETER;
 
 	size = romsize + sizeof(*rom);

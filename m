Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A3AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1C208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C1C208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbeGKL02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:26:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39583 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeGKL02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:26:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6BBLufm3506348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 11 Jul 2018 04:21:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6BBLtoO3506343;
        Wed, 11 Jul 2018 04:21:55 -0700
Date:   Wed, 11 Jul 2018 04:21:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-e296701800f30d260a66f8aa1971b5b1bc3d2f81@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        hdegoede@redhat.com, matt@codeblueprint.co.uk, hpa@zytor.com,
        linux-kernel@lebenslange-mailadresse.de, tglx@linutronix.de,
        peterz@infradead.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
          peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@lebenslange-mailadresse.de,
          matt@codeblueprint.co.uk, hdegoede@redhat.com, mingo@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <20180711090235.9327-2-ard.biesheuvel@linaro.org>
References: <20180711090235.9327-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/x86: Fix mixed mode reboot loop by removing
 pointless call to PciIo->Attributes()
Git-Commit-ID: e296701800f30d260a66f8aa1971b5b1bc3d2f81
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

Commit-ID:  e296701800f30d260a66f8aa1971b5b1bc3d2f81
Gitweb:     https://git.kernel.org/tip/e296701800f30d260a66f8aa1971b5b1bc3d2f81
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 11 Jul 2018 11:02:35 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 11 Jul 2018 13:15:21 +0200

efi/x86: Fix mixed mode reboot loop by removing pointless call to PciIo->Attributes()

Hans de Goede reported that his mixed EFI mode Bay Trail tablet
would not boot at all any more, but enter a reboot loop without
any logs printed by the kernel.

Unbreak 64-bit Linux/x86 on 32-bit UEFI:

When it was first introduced, the EFI stub code that copies the
contents of PCI option ROMs originally only intended to do so if
the EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM attribute was *not* set.

The reason was that the UEFI spec permits PCI option ROM images
to be provided by the platform directly, rather than via the ROM
BAR, and in this case, the OS can only access them at runtime if
they are preserved at boot time by copying them from the areas
described by PciIo->RomImage and PciIo->RomSize.

However, it implemented this check erroneously, as can be seen in
commit:

  dd5fc854de5fd ("EFI: Stash ROMs if they're not in the PCI BAR")

which introduced:

    if (!attributes & EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM)
            continue;

and given that the numeric value of EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM
is 0x4000, this condition never becomes true, and so the option ROMs
were copied unconditionally.

This was spotted and 'fixed' by commit:

  886d751a2ea99a160 ("x86, efi: correct precedence of operators in setup_efi_pci")

but inadvertently inverted the logic at the same time, defeating
the purpose of the code, since it now only preserves option ROM
images that can be read from the ROM BAR as well.

Unsurprisingly, this broke some systems, and so the check was removed
entirely in the following commit:

  739701888f5d ("x86, efi: remove attribute check from setup_efi_pci")

It is debatable whether this check should have been included in the
first place, since the option ROM image provided to the UEFI driver by
the firmware may be different from the one that is actually present in
the card's flash ROM, and so whatever PciIo->RomImage points at should
be preferred regardless of whether the attribute is set.

As this was the only use of the attributes field, we can remove
the call to PciIo->Attributes() entirely, which is especially
nice because its prototype involves uint64_t type by-value
arguments which the EFI mixed mode has trouble dealing with.

Any mixed mode system with PCI is likely to be affected.

Tested-by: Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180711090235.9327-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index e57665b4ba1c..e98522ea6f09 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -114,18 +114,12 @@ __setup_efi_pci(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	struct pci_setup_rom *rom = NULL;
 	efi_status_t status;
 	unsigned long size;
-	uint64_t attributes, romsize;
+	uint64_t romsize;
 	void *romimage;
 
-	status = efi_call_proto(efi_pci_io_protocol, attributes, pci,
-				EfiPciIoAttributeOperationGet, 0ULL,
-				&attributes);
-	if (status != EFI_SUCCESS)
-		return status;
-
 	/*
-	 * Some firmware images contain EFI function pointers at the place where the
-	 * romimage and romsize fields are supposed to be. Typically the EFI
+	 * Some firmware images contain EFI function pointers at the place where
+	 * the romimage and romsize fields are supposed to be. Typically the EFI
 	 * code is mapped at high addresses, translating to an unrealistically
 	 * large romsize. The UEFI spec limits the size of option ROMs to 16
 	 * MiB so we reject any ROMs over 16 MiB in size to catch this.

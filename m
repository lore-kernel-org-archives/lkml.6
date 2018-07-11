Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85029C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F4620020
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tkz9Oax9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F4620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeGKJGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:06:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35377 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbeGKJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:06:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so8098134wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1+MiTcjlOOPmNGd8vzzwOHp7KxdoXoZzDJ83zJl9Ps=;
        b=Tkz9Oax9WQgrqkCmqcnLMK3oszC3KI+g9BDmy0LIHWq3O453e5BXcvCvCDJ2A+iP63
         UtxSdVQthB51jMTIkyc3veXe+CjMyOxumqixgytyoLaRad7H16Pehx+20kZu6kZaFWP5
         omUiQVfpDDHzcvFN7xZ7osPjZCSFHVw6E1cVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B1+MiTcjlOOPmNGd8vzzwOHp7KxdoXoZzDJ83zJl9Ps=;
        b=PLkga24zKsatcELxdyNcq70baAez0mjWfbDxIY12tZfk5rgW+onbZKU/9sigZcxFS5
         PDcnumtMdW1BFB5JmQiBQsP2u5eWivhFQakz0V6iB1kmBuJPT8GmLHSSDJ2GyjJWWqbw
         +08LRgJYE11dlbg/mabpjl0zJitdeFZyv84Uh/MVuz4ytLZDe/W6Ag7oYWXkBGUmLWR+
         xX14TaFuXVlfnt0J457eNEJ+1jxpfr5jZRPKGYGAr0nrz0XCDNjhSgz+nQzqKUcxGCLK
         akDjikWhy6YPcC/ChhAv8b7QNCEJSpZ1PboAawHwnep3e1jWQckyuRDzvd8PvPGRaw7e
         Dz3g==
X-Gm-Message-State: AOUpUlGNu+B6fOtd1qSZsCCXNkUS+ezpEK98hONFpoP9dsu4JDWMv1OC
        oKtrk0IAlhGTK9HkhD272TAvU5+oLrc=
X-Google-Smtp-Source: AAOMgpf2mfolTEWWJjNf5ZjEbd5gwKO/1VYS1ohsBtEgCTRDDQ/aC3nucQMbEjT1iyjmeczigSAp1g==
X-Received: by 2002:adf:a691:: with SMTP id t17-v6mr4270797wrc.57.1531299767394;
        Wed, 11 Jul 2018 02:02:47 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id y203-v6sm2327953wme.42.2018.07.11.02.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:02:46 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] efi/x86: remove pointless call to PciIo->Attributes()
Date:   Wed, 11 Jul 2018 11:02:35 +0200
Message-Id: <20180711090235.9327-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
References: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it was first introduced, the EFI stub code that copies the
contents of PCI option ROMs originally only intended to do so if
the EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM attribute was *not* set.

The reason was that the UEFI spec permits PCI option ROM images
to be provided by the platform directly, rather than via the ROM
BAR, and in this case, the OS can only access them at runtime if
they are preserved at boot time by copying them from the areas
described by PciIo->RomImage and PciIo->RomSize.

However, it implemented this check erroneously, as can be seen in
commit dd5fc854de5fd ("EFI: Stash ROMs if they're not in the PCI
BAR"):

    if (!attributes & EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM)
            continue;

and given that the numeric value of EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM
is 0x4000, this condition never becomes true, and so the option ROMs
were copied unconditionally.

This was spotted and 'fixed' by commit 886d751a2ea99a160
("x86, efi: correct precedence of operators in setup_efi_pci"),
but inadvertently inverted the logic at the same time, defeating
the purpose of the code, since it now only preserves option ROM
images that can be read from the ROM BAR as well.

Unsurprisingly, this broke some systems, and so the check was removed
entirely in commit 739701888f5d ("x86, efi: remove attribute check
from setup_efi_pci").

It is debatable whether this check should have been included in the
first place, since the option ROM image provided to the UEFI driver by
the firmware may be different from the one that is actually present in
the card's flash ROM, and so whatever PciIo->RomImage points at should
be preferred regardless of whether the attribute is set.

As this was the only use of the attributes field, we can remove
the call to PciIo->Attributes() entirely, which is especially
nice because its prototype involves uint64_t type by-value
arguments which the EFI mixed mode has trouble dealing with.

Tested-by: Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.17.1


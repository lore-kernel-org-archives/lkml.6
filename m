Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35CBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224F2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KetIWsL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A224F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeGTCdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43738 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGTCdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so5364533pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1HwyUAnJF2NFfT/pD4cNVn1pcnD0HmMCE+nI0tO3hM=;
        b=KetIWsL8Xgtgvr4CU0JJOsTlhb0wTqV8abhmvPA5nzD1Tk4HfA8YQ6ZeTPtFiZpR3v
         CKp3dJA+Pw8Dry6lRGssaheA9D/r/w3P2qh7/HyawCFbHchMubVypTQBJTML3btVrXug
         XfOF0cjcLi0ScdTFFQL2b+EuWSnNRvDfIaxiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b1HwyUAnJF2NFfT/pD4cNVn1pcnD0HmMCE+nI0tO3hM=;
        b=Iwg5DUF1M/R/lcnQQ6SVjRPS6taXBVFwP6Gafpsu32FKJ3EMRzPV3ALFl3xT3F+8cF
         aCJzggkRPpVhdRSq2x9Mt94mR8OeMMypC9YROByATGzP/h/+JOO5PP+BYIp/P/YI+kwN
         Ybrl0CVCVmMFB4lJygIsewv5wE3x6AUNmXtgh37pCkM4NOhc+znYvjbCRqyO+ke5/+6s
         mppVYAxArYldYySvD8ekwwBtpnj8bulNZhsC+D1LqmODOJ9tf2KmOsQNBsowAa4GaRFb
         gxu8OMarX1mVorvv4yWSFGHU4rGeMZhxy/5PRCyx4so7Sf6g7a8hv4/9qI+/o0gvgsRO
         3Vqg==
X-Gm-Message-State: AOUpUlEm9rMlcHjO1YNHVVVeQzoc/4ryXuf9PS4O/A48Li1AyGV9v3uh
        JetNxE+TxV8Hg5WKzhd6drf1xw==
X-Google-Smtp-Source: AAOMgpdyEUEVRiVSAGplcv2FqKPXuyvX65R2VeGEe1/k0Sh5g/a0AQBbUSehyANM1au4OwTpF/BiZA==
X-Received: by 2002:a62:d98f:: with SMTP id b15-v6mr107430pfl.1.1532051272160;
        Thu, 19 Jul 2018 18:47:52 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:47:51 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/9] efi/x86: merge setup_efi_pci32 and setup_efi_pci64 routines
Date:   Fri, 20 Jul 2018 10:47:19 +0900
Message-Id: <20180720014726.24031-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging the 32-bit and 64-bit versions of the code that invokes
the PCI I/O protocol methods to preserve PCI ROM images in commit

  2c3625cb9fa2 ("efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() ...")

there are still separate code paths for 32-bit and 64-bit, where the only
difference is the size of a EFI_HANDLE. So let's parameterize a single
implementation for that difference only, and get rid of the two copies of
the code.

While at it, rename __setup_efi_pci() to preserve_pci_rom_image() to
better reflect its purpose.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/eboot.c | 123 ++++++++-----------------------
 1 file changed, 32 insertions(+), 91 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 9f6813493945..c72550783c16 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -111,7 +111,7 @@ void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
 }
 
 static efi_status_t
-__setup_efi_pci(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
+preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
 	struct pci_setup_rom *rom = NULL;
 	efi_status_t status;
@@ -181,92 +181,6 @@ __setup_efi_pci(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	return status;
 }
 
-static void
-setup_efi_pci32(struct boot_params *params, void **pci_handle, unsigned long size)
-{
-	efi_pci_io_protocol_t *pci = NULL;
-	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
-	u32 *handles = (u32 *)(unsigned long)pci_handle;
-	efi_status_t status;
-	unsigned long nr_pci;
-	struct setup_data *data;
-	int i;
-
-	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
-
-	while (data && data->next)
-		data = (struct setup_data *)(unsigned long)data->next;
-
-	nr_pci = size / sizeof(u32);
-	for (i = 0; i < nr_pci; i++) {
-		struct pci_setup_rom *rom = NULL;
-		u32 h = handles[i];
-
-		status = efi_call_early(handle_protocol, h,
-					&pci_proto, (void **)&pci);
-
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (!pci)
-			continue;
-
-		status = __setup_efi_pci(pci, &rom);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (data)
-			data->next = (unsigned long)rom;
-		else
-			params->hdr.setup_data = (unsigned long)rom;
-
-		data = (struct setup_data *)rom;
-	}
-}
-
-static void
-setup_efi_pci64(struct boot_params *params, void **pci_handle, unsigned long size)
-{
-	efi_pci_io_protocol_t *pci = NULL;
-	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
-	u64 *handles = (u64 *)(unsigned long)pci_handle;
-	efi_status_t status;
-	unsigned long nr_pci;
-	struct setup_data *data;
-	int i;
-
-	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
-
-	while (data && data->next)
-		data = (struct setup_data *)(unsigned long)data->next;
-
-	nr_pci = size / sizeof(u64);
-	for (i = 0; i < nr_pci; i++) {
-		struct pci_setup_rom *rom = NULL;
-		u64 h = handles[i];
-
-		status = efi_call_early(handle_protocol, h,
-					&pci_proto, (void **)&pci);
-
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (!pci)
-			continue;
-
-		status = __setup_efi_pci(pci, &rom);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (data)
-			data->next = (unsigned long)rom;
-		else
-			params->hdr.setup_data = (unsigned long)rom;
-
-		data = (struct setup_data *)rom;
-	}
-}
-
 /*
  * There's no way to return an informative status from this function,
  * because any analysis (and printing of error messages) needs to be
@@ -282,6 +196,9 @@ static void setup_efi_pci(struct boot_params *params)
 	void **pci_handle = NULL;
 	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
 	unsigned long size = 0;
+	unsigned long nr_pci;
+	struct setup_data *data;
+	int i;
 
 	status = efi_call_early(locate_handle,
 				EFI_LOCATE_BY_PROTOCOL,
@@ -305,10 +222,34 @@ static void setup_efi_pci(struct boot_params *params)
 	if (status != EFI_SUCCESS)
 		goto free_handle;
 
-	if (efi_early->is64)
-		setup_efi_pci64(params, pci_handle, size);
-	else
-		setup_efi_pci32(params, pci_handle, size);
+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
+
+	while (data && data->next)
+		data = (struct setup_data *)(unsigned long)data->next;
+
+	nr_pci = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
+	for (i = 0; i < nr_pci; i++) {
+		efi_pci_io_protocol_t *pci = NULL;
+		struct pci_setup_rom *rom;
+
+		status = efi_call_early(handle_protocol,
+					efi_is_64bit() ? ((u64 *)pci_handle)[i]
+						       : ((u32 *)pci_handle)[i],
+					&pci_proto, (void **)&pci);
+		if (status != EFI_SUCCESS || !pci)
+			continue;
+
+		status = preserve_pci_rom_image(pci, &rom);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		if (data)
+			data->next = (unsigned long)rom;
+		else
+			params->hdr.setup_data = (unsigned long)rom;
+
+		data = (struct setup_data *)rom;
+	}
 
 free_handle:
 	efi_call_early(free_pool, pci_handle);
-- 
2.17.1


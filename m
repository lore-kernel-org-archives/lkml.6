Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B75ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282C42084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PG+R2Cyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282C42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeGTCds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46109 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGTCds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so5353447pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yumR4lvkykhvrfnsDUe6tO0L5ayyApzQLDr9GgxXvqY=;
        b=PG+R2CyxyKHJpZJKGfFin7HqTVC7Dbr3WvpbJ4UBquLOJ+mI1eEowR4b9zEap0M8so
         i5Nz7eKshwZmXjXWuv/iRxdawD9llNTFUbZHQQx1V7tdo+pGWmZhOFv4C1Ym6KMYDuM3
         OPU3vXWnoJioX3uSFAWgZ+us99ZcnOAb1DnJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yumR4lvkykhvrfnsDUe6tO0L5ayyApzQLDr9GgxXvqY=;
        b=plHOODWfNzPgVbKqAd2Og0Q/xkCRUVI2s3zPXgymKd4O6nw12J+tGg8oHJY7xG8C7v
         GfCnSOLkdJvYDWWMc0PEk4CkFmviHYguzW1klLa3R1OWKdPSCiYVm3OMdQmsvqk9JgG1
         ZV5FuAKP5VnctTQpdzPq0Sp3D4JCt3ceh6bimrCqP/r+opfKLy+JUQ8yCRQ6Bnj71KNA
         huXsd+PzW+xpYG7rzpy35SHobuge1w0Xy5Nz9DLluNNFtWNL0/xTyekc/lvRkeJ/vh1x
         5qLqU1C60Fe2BXGJFaD/IU3Pwxjkt9vhnh7C1c2zxp2W3Vmnt0D0h800xXrUqh/Hr2+S
         i6lw==
X-Gm-Message-State: AOUpUlG/VSksSeIO9XmEurhifvp0vW1jAOzSWCXGltHa2bfmPKjFJVCf
        jJDNx2pWlHGDLKXWKcTkeLiCfm3vg4M=
X-Google-Smtp-Source: AAOMgpckPpwf8fNkkpUJ8fTb+29zHbzQFyChKTv9lFpICb6RMQIQ+YpBqFvX5SiTutUEkDs9zn99xQ==
X-Received: by 2002:a63:1403:: with SMTP id u3-v6mr95955pgl.13.1532051277236;
        Thu, 19 Jul 2018 18:47:57 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:47:56 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4/9] efi/x86: merge 32-bit and 64-bit UGA draw protocol setup routines
Date:   Fri, 20 Jul 2018 10:47:21 +0900
Message-Id: <20180720014726.24031-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two versions of setup_uga##() are mostly identical, with the
exception of the size of EFI_HANDLE. So let's merge the two, and
pull the implementation into the calling function setup_uga().

Note that the 32-bit version was only mixed-mode safe by accident:
it only calls the get_mode() method of the UGA draw protocol, which
happens to be the first member, and so truncating the 64-bit void* at
offset 0 to 32 bits happens to produce the correct value. But let's
not rely on that, and use the proper API instead.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/eboot.c | 111 ++++++++-----------------------
 1 file changed, 26 insertions(+), 85 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 011d5c289449..ac8e442db71f 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -318,81 +318,54 @@ static void setup_quirks(struct boot_params *boot_params)
 	}
 }
 
+/*
+ * See if we have Universal Graphics Adapter (UGA) protocol
+ */
 static efi_status_t
-setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
+setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 {
+	efi_status_t status;
+	u32 width, height;
+	void **uga_handle = NULL;
 	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
-	u32 *handles = (u32 *)uga_handle;
-	efi_status_t status = EFI_INVALID_PARAMETER;
 	int i;
 
-	first_uga = NULL;
-	nr_ugas = size / sizeof(u32);
-	for (i = 0; i < nr_ugas; i++) {
-		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
-		u32 w, h, depth, refresh;
-		void *pciio;
-		u32 handle = handles[i];
-
-		status = efi_call_early(handle_protocol, handle,
-					&uga_proto, (void **)&uga);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
-
-		status = efi_early->call((unsigned long)uga->get_mode, uga,
-					 &w, &h, &depth, &refresh);
-		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
-			*width = w;
-			*height = h;
-
-			/*
-			 * Once we've found a UGA supporting PCIIO,
-			 * don't bother looking any further.
-			 */
-			if (pciio)
-				break;
-
-			first_uga = uga;
-		}
-	}
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
+				size, (void **)&uga_handle);
+	if (status != EFI_SUCCESS)
+		return status;
 
-	return status;
-}
+	status = efi_call_early(locate_handle,
+				EFI_LOCATE_BY_PROTOCOL,
+				uga_proto, NULL, &size, uga_handle);
+	if (status != EFI_SUCCESS)
+		goto free_handle;
 
-static efi_status_t
-setup_uga64(void **uga_handle, unsigned long size, u32 *width, u32 *height)
-{
-	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
-	unsigned long nr_ugas;
-	u64 *handles = (u64 *)uga_handle;
-	efi_status_t status = EFI_INVALID_PARAMETER;
-	int i;
+	height = 0;
+	width = 0;
 
 	first_uga = NULL;
-	nr_ugas = size / sizeof(u64);
+	nr_ugas = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
 	for (i = 0; i < nr_ugas; i++) {
 		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
 		u32 w, h, depth, refresh;
 		void *pciio;
-		u64 handle = handles[i];
+		unsigned long handle = efi_is_64bit() ? ((u64 *)uga_handle)[i]
+						      : ((u32 *)uga_handle)[i];
 
 		status = efi_call_early(handle_protocol, handle,
-					&uga_proto, (void **)&uga);
+					uga_proto, (void **)&uga);
 		if (status != EFI_SUCCESS)
 			continue;
 
 		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
 
-		status = efi_early->call((unsigned long)uga->get_mode, uga,
-					 &w, &h, &depth, &refresh);
+		status = efi_call_proto(efi_uga_draw_protocol, get_mode, uga,
+					&w, &h, &depth, &refresh);
 		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
-			*width = w;
-			*height = h;
+			width = w;
+			height = h;
 
 			/*
 			 * Once we've found a UGA supporting PCIIO,
@@ -405,38 +378,6 @@ setup_uga64(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 		}
 	}
 
-	return status;
-}
-
-/*
- * See if we have Universal Graphics Adapter (UGA) protocol
- */
-static efi_status_t
-setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
-{
-	efi_status_t status;
-	u32 width, height;
-	void **uga_handle = NULL;
-
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				size, (void **)&uga_handle);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	status = efi_call_early(locate_handle,
-				EFI_LOCATE_BY_PROTOCOL,
-				uga_proto, NULL, &size, uga_handle);
-	if (status != EFI_SUCCESS)
-		goto free_handle;
-
-	height = 0;
-	width = 0;
-
-	if (efi_early->is64)
-		status = setup_uga64(uga_handle, size, &width, &height);
-	else
-		status = setup_uga32(uga_handle, size, &width, &height);
-
 	if (!width && !height)
 		goto free_handle;
 
-- 
2.17.1


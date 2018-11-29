Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D2C07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4AF2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcC5p86o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4AF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbeK3ES4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:18:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34606 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeK3ESz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:18:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so2695273wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XsSaaAOivGZ+SMEV1HNl9ikqQLGcv3idzYmN9Jqzt5c=;
        b=dcC5p86oeYdf0PuJPXvTl+IxGk6KAwIaDC40VblPUnrv10ctKWv/QPjA56MPMCwhOv
         hU199FHB3jis9/WVya/WmQqBCO4nYRQ0d2+pgQaDLnMuyyFK65YmLI6S88u29mjMQv0v
         U/k1IirkxTFV43Pui5b9993IyZqHYQTQnwNGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsSaaAOivGZ+SMEV1HNl9ikqQLGcv3idzYmN9Jqzt5c=;
        b=pfEsFMj8AOPug4reYWcDmezZSJQz1leSA7xgFe/g/DAEj1QBfTmEgQ2jYE6MBixP4o
         bg5fZPOhqC6rZi9vfij49ow7Zrsi2qt9oERPlunWI9DXdB3dIQGD2/5EXw2q+7zqJZLa
         fjLejl4cEYYNMLD33FDy+whKNhXEzUJBH9+RbjSUvnic56Ms8E5gfjEsTzA3bc0xECvM
         V6qb/4keZXAe4KJsmNhyE6CYEgQOhO6Ws/soq/FYLtlr28DErfT8OCI7HCOjuWJpts/x
         sTF7073zIo9xrf7LfRoEF6oDai1+aNTjcQepPtubKr2chw/VwJVtboaxvKMCSp2QryxE
         Ev5w==
X-Gm-Message-State: AA+aEWZY0KUhrIAGNovzSZaNv8PnI2xFpC6XUI4VbEu8UOgwkQult45q
        EGi43M5wX7jswav9ngierv1cAA==
X-Google-Smtp-Source: AFSGD/X1jDhdQr43eGz+cQ9IOtvDpCobJJuO5C5jlYLNe+j8axw6bEloe9zFHnffEgJX+frMrPm+8A==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr2063343wrh.317.1543511568971;
        Thu, 29 Nov 2018 09:12:48 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:48 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH 01/11] x86/efi: Allocate e820 buffer before calling efi_exit_boot_service
Date:   Thu, 29 Nov 2018 18:12:20 +0100
Message-Id: <20181129171230.18699-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Snowberg <eric.snowberg@oracle.com>

Commit d64934019f6c ("x86/efi: Use efi_exit_boot_services()")
introduced a regression on systems with large memory maps
causing them to hang on boot. The first "goto get_map" that was removed
from exit_boot insured there was enough room for the memory map when
efi_call_early(exit_boot_services) was called. This happens when
(nr_desc > ARRAY_SIZE(params->e820_table).

Chain of events:
  exit_boot()
    efi_exit_boot_services()
      efi_get_memory_map <- at this point the mm can't grow over 8 desc
      priv_func()
        exit_boot_func()
          allocate_e820ext() <- new mm grows over 8 desc from e820 alloc
      efi_call_early(exit_boot_services) <- mm key doesn't match so retry
      efi_call_early(get_memory_map) <- not enough room for new mm
      system hangs

This patch allocates the e820 buffer before calling efi_exit_boot_services
and fixes the regression.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/eboot.c | 65 ++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 8b4c5e001157..f7bad07bb251 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -1,3 +1,4 @@
+
 /* -----------------------------------------------------------------------
  *
  *   Copyright 2011 Intel Corporation; author Matt Fleming
@@ -634,37 +635,54 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 	return status;
 }
 
+static efi_status_t allocate_e820(struct boot_params *params,
+				  struct setup_data **e820ext,
+				  u32 *e820ext_size)
+{
+	unsigned long map_size, desc_size, buff_size;
+	struct efi_boot_memmap boot_map;
+	efi_memory_desc_t *map;
+	efi_status_t status;
+	__u32 nr_desc;
+
+	boot_map.map =		&map;
+	boot_map.map_size =	&map_size;
+	boot_map.desc_size =	&desc_size;
+	boot_map.desc_ver =	NULL;
+	boot_map.key_ptr =	NULL;
+	boot_map.buff_size =	&buff_size;
+
+	status = efi_get_memory_map(sys_table, &boot_map);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	nr_desc = buff_size / desc_size;
+
+	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
+		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
+
+		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
+		if (status != EFI_SUCCESS)
+			return status;
+	}
+
+	return EFI_SUCCESS;
+}
+
 struct exit_boot_struct {
 	struct boot_params	*boot_params;
 	struct efi_info		*efi;
-	struct setup_data	*e820ext;
-	__u32			e820ext_size;
 };
 
 static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 				   struct efi_boot_memmap *map,
 				   void *priv)
 {
-	static bool first = true;
 	const char *signature;
 	__u32 nr_desc;
 	efi_status_t status;
 	struct exit_boot_struct *p = priv;
 
-	if (first) {
-		nr_desc = *map->buff_size / *map->desc_size;
-		if (nr_desc > ARRAY_SIZE(p->boot_params->e820_table)) {
-			u32 nr_e820ext = nr_desc -
-					ARRAY_SIZE(p->boot_params->e820_table);
-
-			status = alloc_e820ext(nr_e820ext, &p->e820ext,
-					       &p->e820ext_size);
-			if (status != EFI_SUCCESS)
-				return status;
-		}
-		first = false;
-	}
-
 	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
 				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
@@ -687,8 +705,8 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 {
 	unsigned long map_sz, key, desc_size, buff_size;
 	efi_memory_desc_t *mem_map;
-	struct setup_data *e820ext;
-	__u32 e820ext_size;
+	struct setup_data *e820ext = NULL;
+	__u32 e820ext_size = 0;
 	efi_status_t status;
 	__u32 desc_version;
 	struct efi_boot_memmap map;
@@ -702,8 +720,10 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	map.buff_size		= &buff_size;
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
-	priv.e820ext		= NULL;
-	priv.e820ext_size	= 0;
+
+	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
+	if (status != EFI_SUCCESS)
+		return status;
 
 	/* Might as well exit boot services now */
 	status = efi_exit_boot_services(sys_table, handle, &map, &priv,
@@ -711,9 +731,6 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	e820ext			= priv.e820ext;
-	e820ext_size		= priv.e820ext_size;
-
 	/* Historic? */
 	boot_params->alt_mem_k	= 32 * 1024;
 
-- 
2.19.1


Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C740ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1F62084E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOWDBkn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1F62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGTCd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39311 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbeGTCd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:56 -0400
Received: by mail-pl0-f65.google.com with SMTP id p23-v6so4436817plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yoyda7tE3ZXI3EzTFdmwpnsA+ke28+fu6v2r36tSZn8=;
        b=hOWDBkn7y1xbe8J1W1daJ6z79VPwpPGerpyrLjU6bBVAJYHVdZo3nFX0s7Lj2+XzAh
         0H+1URxvT+qUKXhZ+C9XqMJhNBVk5nBDxJnGdZdUpWaEmGN3cJk5NzBx10Yy1RuGZncl
         W8BZEyk7jgGNgqW96n9kq1XtthXOOoVkc0gi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yoyda7tE3ZXI3EzTFdmwpnsA+ke28+fu6v2r36tSZn8=;
        b=sH/Z2MpD4IwoRwmWxAcS5/rcq3REtfbuEEMNENlv23ibddO5ix7jt7Xi5kHeJ/ODe/
         SvR82zX20Js+P9vj7vNhAYjkrriQEOOVx8oVECM1chs+cdK7AZ32z7VUoO31FmeZIvPh
         +Wcw4kEiaXYZu+dEOP+HIxxgmn7Qv05HjUs285RqIky8eJEdCsQf6BnXX1t9EcX2MoKO
         qnqYCgGsX2S5Vq7egYpUxPiP7xbhILUjfiynfkZIS10e0rLIgkrbLEm8PUXEkkUozAnE
         RZBqx1KBbIBDVrdrrVges3aGarHs5EYRr+Uy3hVaul/7dm819oXQRGzhUiqXn0A88H7L
         +/cQ==
X-Gm-Message-State: AOUpUlGeSzJrZC08iV9cIi8WgqnLqJzJMkkGfhGVge+kp8QjVsOu1nn2
        PCtCAm87RFlP7rTw0gUz0o+dRg==
X-Google-Smtp-Source: AAOMgpferItsCB88HXZw3GayId5y7wkglTpUek4l2f6bI68mGJzPopU7SXN8uE3zTvU4OphTfksRlQ==
X-Received: by 2002:a17:902:8309:: with SMTP id bd9-v6mr68116plb.321.1532051285127;
        Thu, 19 Jul 2018 18:48:05 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:48:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 7/9] efi/x86: replace references to efi_early->is64 with efi_is_64bit()
Date:   Fri, 20 Jul 2018 10:47:24 +0900
Message-Id: <20180720014726.24031-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of places in the x86 EFI stub code where we select
between 32-bit and 64-bit versions of the support routines based on
the value of efi_early->is64. Referencing that field directly is a
bad idea, since it prevents the compiler from inferring that this
field can never be true on a 32-bit build, and can only become false
on a 64-bit build if support for mixed mode is compiled in. This
results in dead code to be retained in the uncompressed part of the
kernel image, which is wasteful.

So switch to the efi_is_64bit() helper, which will resolve to a
constant boolean unless building for 64-bit with mixed mode support.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/eboot.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 915c64edbe8e..1458b1700fc7 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -404,7 +404,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		return NULL;
 
-	if (efi_early->is64)
+	if (efi_is_64bit())
 		setup_boot_services64(efi_early);
 	else
 		setup_boot_services32(efi_early);
@@ -639,7 +639,6 @@ struct exit_boot_struct {
 	struct efi_info		*efi;
 	struct setup_data	*e820ext;
 	__u32			e820ext_size;
-	bool			is64;
 };
 
 static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
@@ -666,7 +665,8 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 		first = false;
 	}
 
-	signature = p->is64 ? EFI64_LOADER_SIGNATURE : EFI32_LOADER_SIGNATURE;
+	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
+				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
 
 	p->efi->efi_systab		= (unsigned long)sys_table_arg;
@@ -683,8 +683,7 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 	return EFI_SUCCESS;
 }
 
-static efi_status_t exit_boot(struct boot_params *boot_params,
-			      void *handle, bool is64)
+static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 {
 	unsigned long map_sz, key, desc_size, buff_size;
 	efi_memory_desc_t *mem_map;
@@ -705,7 +704,6 @@ static efi_status_t exit_boot(struct boot_params *boot_params,
 	priv.efi		= &boot_params->efi_info;
 	priv.e820ext		= NULL;
 	priv.e820ext_size	= 0;
-	priv.is64		= is64;
 
 	/* Might as well exit boot services now */
 	status = efi_exit_boot_services(sys_table, handle, &map, &priv,
@@ -740,13 +738,11 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	struct desc_struct *desc;
 	void *handle;
 	efi_system_table_t *_table;
-	bool is64;
 
 	efi_early = c;
 
 	_table = (efi_system_table_t *)(unsigned long)efi_early->table;
 	handle = (void *)(unsigned long)efi_early->image_handle;
-	is64 = efi_early->is64;
 
 	sys_table = _table;
 
@@ -754,7 +750,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
 
-	if (is64)
+	if (efi_is_64bit())
 		setup_boot_services64(efi_early);
 	else
 		setup_boot_services32(efi_early);
@@ -810,7 +806,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 		hdr->code32_start = bzimage_addr;
 	}
 
-	status = exit_boot(boot_params, handle, is64);
+	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "exit_boot() failed!\n");
 		goto fail;
-- 
2.17.1


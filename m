Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84716C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514EC22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrKpp9DK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514EC22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbeKOEAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:00:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40151 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbeKOEAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:00:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so7700490pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5g/w6IYjjrc1ur3xQUnZUzYfp3xOHO2eoNh7QjFs/U8=;
        b=MrKpp9DKH5DVuMf8JhGmxTgjqkfLlM95C5KSSjf8vnCZ9vtDaRQhVbk0gKrxhUY3lB
         LoQH4pvAeuJSeXnhGHW93lD8g1K73BYk+COEGaBZJbmiOPeUlWI1tuBhvspI7BuuYVQ0
         5kn6J9uKxmROHwQqBO5gtX7hIc704F1drXjyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5g/w6IYjjrc1ur3xQUnZUzYfp3xOHO2eoNh7QjFs/U8=;
        b=W3nuHHnaPX7G5H/tYq4Qr/LeiJt+5dGA99ZmH2lYYG5VcnDHmZSzsvN5E4WeQcXShB
         gKWIimpI4nqxx74WqQ3We3xizLxjxReNahknRxGzmwKXumsRnOU/20IdVnBoY25G/D7W
         9DqSKvq+k8NYDzkXIb9Fsig/lONirxInBwNpfXwZvYY6NYNkQL4p/57It9Nu/KxZkF7c
         R+vM+euHG9UG9aIFiAPPAB97A3sxr4Z3AOqltSj7AiTLIkbzIE/l0mJAFj0E+s3fEhAr
         5yLsBUj2A3orQma+nJbdL9e7JSWF7pWRAOFP2pgccICBW+5ekOJczp3JwmatpHIojLcB
         VDXQ==
X-Gm-Message-State: AGRZ1gKsYD8P3GrTuiMnB/6Ra2LqvkVi1hUAPsRkIOJ3e8Q/Gyk9uMc6
        pMeP17zVoYMMB3FTfX95MG3THYctwKoBqA==
X-Google-Smtp-Source: AJdET5d3r4lxbWNRdYiFGAlSVfyz7yQiL2cEvjurIXUy8BZHiRcHYHidfPri064cRfzCqTJC0sQpoA==
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr2646680pgl.71.1542218159419;
        Wed, 14 Nov 2018 09:55:59 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id i2-v6sm21301738pgq.35.2018.11.14.09.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:55:58 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] efi: arm: revert deferred unmap of early memmap mapping
Date:   Wed, 14 Nov 2018 09:55:41 -0800
Message-Id: <20181114175544.12860-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory
map longer for BGRT") deferred the unmap of the early mapping of the
UEFI memory map to accommodate the ACPI BGRT code, which looks up the
memory type that backs the BGRT table to validate it against the
requirements of the UEFI spec.

Unfortunately, this causes problems on ARM, which does not permit
early mappings to persist after paging_init() is called, resulting
in a WARN() splat. Since we don't support the BGRT table on ARM anway,
let's revert ARM to the old behaviour, which is to take down the
early mapping at the end of efi_init().

Fixes: 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory ...")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c    | 4 ++++
 drivers/firmware/efi/arm-runtime.c | 2 +-
 drivers/firmware/efi/memmap.c      | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 388a929baf95..1a6a77df8a5e 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -265,6 +265,10 @@ void __init efi_init(void)
 				    (params.mmap & ~PAGE_MASK)));
 
 	init_screen_info();
+
+	/* ARM does not permit early mappings to persist across paging_init() */
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_memmap_unmap();
 }
 
 static int __init register_gop_device(void)
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 922cfb813109..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -110,7 +110,7 @@ static int __init arm_enable_runtime_services(void)
 {
 	u64 mapsize;
 
-	if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
+	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
 		return 0;
 	}
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index fa2904fb841f..38b686c67b17 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -118,6 +118,9 @@ int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 
 void __init efi_memmap_unmap(void)
 {
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	if (!efi.memmap.late) {
 		unsigned long size;
 
-- 
2.17.1


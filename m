Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CFEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C50208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVO9AxUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C50208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeGIAH2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:07:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46242 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeGIAH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:07:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so12307688pfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6svwEjRZKw/fRIHWE4svwtkCI66G0b2U5AUFtaL5oWI=;
        b=aVO9AxUa84C7u9yYJC2JIvknxGTWlFrP3nLGGLmn+vzBj9YBWrAOxTM3jsnL1Npp45
         nNvzR39Yp4ZU9xrjRqBSrzxSNm2k4yNEGNYwuJI2rfY41LNeYPZmhUNQ1IQL9X6YSnIx
         Kkm+cULSU/ki+V+IMYVjDzPDNC7q/dTFxCowg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6svwEjRZKw/fRIHWE4svwtkCI66G0b2U5AUFtaL5oWI=;
        b=TKvcE3FLdgUSI3/FuIRaM6YHoGk6r1HlUYUkOHf4YR4Z7dA7ABLIJmp7YWjMqIewev
         dZAcK/xab5SjMNjYDAulmJqBtihiGGicqYu7+nP5ClXHqXcPrhrWPn9qeVUdxi0VORrp
         wtOjJs6wkbkXtUuou0I4YTHm6ZWub/rLwslMjj4EGVKqFTvun1MOXMQDlQf81o5ocN2v
         toH0ZCLTeNkt4d48mfQ1n0IL1y5fkSA6jIdhWDvh1xKyp8jvoqjChjvks1llXiGRQc0H
         46WbT++TlJGtJTtslvtzsH9np9qN8AUx8ewNn0rvOv+kCdzzFRLbyDKVaYUKSN9aBIXH
         dMFQ==
X-Gm-Message-State: APt69E2fWowYWZ6QmeRCzBPkkgOyaTyW6/duDquK37m7wQ/kCGijaZlU
        HKk85+w76gXBjhIocq4cuyp6TN8IhV8=
X-Google-Smtp-Source: AAOMgpdYYQZd9apQeHM4MdlsPHvAAqr/DoySKRhr1O0bOOssE4odMTGCTh2w1loz+WKHm6eRrySeqQ==
X-Received: by 2002:a62:e30c:: with SMTP id g12-v6mr19139845pfh.25.1531094846860;
        Sun, 08 Jul 2018 17:07:26 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id j5-v6sm24598310pfc.56.2018.07.08.17.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 17:07:26 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 2/3] efi/arm: map UEFI memory map even w/o runtime services enabled
Date:   Mon,  9 Jul 2018 09:07:49 +0900
Message-Id: <20180709000750.22172-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709000750.22172-1-takahiro.akashi@linaro.org>
References: <20180709000750.22172-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under the current implementation, UEFI memory map will be mapped and made
available in virtual mappings only if runtime services are enabled.
But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
to create mappings of ACPI tables using memory attributes described in
UEFI memory map.
See the following commit:
    arm64: acpi: fix alignment fault in accessing ACPI tables

So, as a first step, arm_enter_runtime_services() is modified, alongside
Ard's patch[1], so that UEFI memory map will not be freed even if
efi=noruntime.

[1] https://marc.info/?l=linux-efi&m=152930773507524&w=2

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 59a8c0ec94d5..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -117,6 +117,13 @@ static int __init arm_enable_runtime_services(void)
 
 	efi_memmap_unmap();
 
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return 0;
+	}
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
@@ -129,13 +136,6 @@ static int __init arm_enable_runtime_services(void)
 
 	pr_info("Remapping and enabling EFI services.\n");
 
-	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
-
-	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
-		pr_err("Failed to remap EFI memory map\n");
-		return -ENOMEM;
-	}
-
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
 		return -ENOMEM;
-- 
2.17.0


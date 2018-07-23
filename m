Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B63ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB9420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoWFjrqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB9420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbeGWC6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 22:58:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33462 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbeGWC6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 22:58:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so11060990pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 18:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GtIoJieKMHTN394dMOednMEC4qx4H0+B96ztFdyM5HA=;
        b=AoWFjrqTENdZ9sLR9tvk1DXtMK9FYxuVEAVx/sMtK6DtxQQP0xrnHfemjwcM4cMMNk
         GCBLIkc+Vmd6T8VbZxCOrxbZpA3z0bYgz+SzuGUilDfWEtTsBCyvrj1zo1j4cBD/2JtH
         XwlZXgHsekdRhkURfYmzIZ3JQpB832BHynTqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GtIoJieKMHTN394dMOednMEC4qx4H0+B96ztFdyM5HA=;
        b=eGpXIxNW+oVYhhnTY6QgGgLXcXfvp+3qplrmdRWyZEy6dq7cTpzozLa08TO3P5Ylvg
         EXCpd73aYWwpTo8WDMN2o5BXw2JxmD0ANP+Znqg+HgOYwrT2pAMjdnS8jHz+ruO+jDjd
         3Xacp/R9VB3ElU6SA4eJU1zhiqnJCLwrA8W43+S87T0qzyQQvttxG9qkSNHp7f3hhdsy
         3YO9TTv6RHdQSP3h1nt1x4zjH4nmr/4vZc4o6qqS4FkPkD0+nT617jk5mNMls+ZX+prY
         qSWSJzO0dscZhqAAjYOuZ6wZPmlf3yecSoNbEyIVnKBHfIIWJ2G9fTslRiQlD4bjmeDR
         ErZQ==
X-Gm-Message-State: AOUpUlEGbRjmnb3PHkipL26RlOKJ1Jy2WXs33/StUg+KYuwchKtww7gn
        ebdsO233XBbZKBtg9sQqu0i0JA==
X-Google-Smtp-Source: AAOMgpfn7SiEA5UlKYRa4N3WBHYhBXi7Jeb1Cz5AYzBjJQraGUylWAveqkruQzCpcyPtp3v0wHEeng==
X-Received: by 2002:a62:b40c:: with SMTP id h12-v6mr11414833pfn.18.1532311185039;
        Sun, 22 Jul 2018 18:59:45 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id a134-v6sm8384082pfa.158.2018.07.22.18.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 18:59:44 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 4/5] efi/arm: map UEFI memory map even w/o runtime services enabled
Date:   Mon, 23 Jul 2018 10:57:31 +0900
Message-Id: <20180723015732.24252-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723015732.24252-1-takahiro.akashi@linaro.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
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
2.18.0


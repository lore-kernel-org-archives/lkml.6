Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F427C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7592086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7592086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeIHVKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 17:10:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60908 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIHVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 17:10:22 -0400
Received: from [222.129.43.208] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1fyg1e-0004Q5-Dt; Sat, 08 Sep 2018 16:23:59 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     ard.biesheuvel@linaro.org, tglx@linutronix.de, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaron.ma@canonical.com
Subject: [PATCH] x86/efi: earlyprintk - Add 64bit efi fb address support
Date:   Sun,  9 Sep 2018 00:23:48 +0800
Message-Id: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI GOP uses 64-bit frame buffer address in some BIOS.
Add 64bit address support in efi earlyprintk.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 arch/x86/platform/efi/early_printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 5fdacb322ceb..c0ae25f59acd 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -32,6 +32,8 @@ static __init int early_efi_map_fb(void)
 		return 0;
 
 	base = boot_params.screen_info.lfb_base;
+	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
 	size = boot_params.screen_info.lfb_size;
 	efi_fb = ioremap(base, size);
 
@@ -49,6 +51,8 @@ static __ref void *early_efi_map(unsigned long start, unsigned long len)
 	unsigned long base;
 
 	base = boot_params.screen_info.lfb_base;
+	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
 
 	if (efi_fb)
 		return (efi_fb + start);
-- 
2.17.1


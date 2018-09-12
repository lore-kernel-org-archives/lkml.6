Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333A9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A122087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A122087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeILXGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:06:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50369 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeILXGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:06:02 -0400
Received: from [114.245.38.229] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1g09R4-0000B4-Ed; Wed, 12 Sep 2018 18:00:19 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     ard.biesheuvel@linaro.org, tglx@linutronix.de, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaron.ma@canonical.com
Subject: [PATCH v2] x86/efi: earlyprintk - Add 64bit efi fb address support
Date:   Thu, 13 Sep 2018 02:00:08 +0800
Message-Id: <1536775208-8064-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
References: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI GOP uses 64-bit frame buffer address in some BIOS.
Add 64bit address support in efi earlyprintk.

V2:
Fix type of address.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 arch/x86/platform/efi/early_printk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 5fdacb322ceb..7476b3b097e1 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -26,12 +26,14 @@ static bool early_efi_keep;
  */
 static __init int early_efi_map_fb(void)
 {
-	unsigned long base, size;
+	u64 base, size;
 
 	if (!early_efi_keep)
 		return 0;
 
 	base = boot_params.screen_info.lfb_base;
+	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
 	size = boot_params.screen_info.lfb_size;
 	efi_fb = ioremap(base, size);
 
@@ -46,9 +48,11 @@ early_initcall(early_efi_map_fb);
  */
 static __ref void *early_efi_map(unsigned long start, unsigned long len)
 {
-	unsigned long base;
+	u64 base;
 
 	base = boot_params.screen_info.lfb_base;
+	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
 
 	if (efi_fb)
 		return (efi_fb + start);
-- 
2.17.1


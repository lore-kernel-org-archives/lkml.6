Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755262AbeCHIC0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:02:26 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46382 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755181AbeCHICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:02:23 -0500
X-Google-Smtp-Source: AG47ELsTiYBRWM/1FqvWfGr1eECvDe0CD2SYvmcn+N2ZUw/UWEqkRD2L6LX1IQ1eirEWLuOSOEWeSg==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Colin Ian King <colin.king@canonical.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] efi: make const array 'apple' static
Date: Thu,  8 Mar 2018 08:00:20 +0000
Message-Id: <20180308080020.22828-13-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only array 'buf' on the stack but instead
make it static. Makes the object code smaller by 64 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   9264	      1	     16	   9281	   2441	arch/x86/boot/compressed/eboot.o

After:
   text	   data	    bss	    dec	    hex	filename
   9200	      1	     16	   9217	   2401	arch/x86/boot/compressed/eboot.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/eboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 886a9115af62..f2251c1c9853 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -423,7 +423,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 
 static void setup_quirks(struct boot_params *boot_params)
 {
-	efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
+	static efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor, sys_table);
 
-- 
2.15.1

Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242120839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nJgCjgii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4242120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeHaML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:11:58 -0400
Received: from 8bytes.org ([81.169.241.247]:42468 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeHaML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:11:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0DD7F547; Fri, 31 Aug 2018 10:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1535702743; bh=vLoRkaJdKJCXD11zyWabW3UsuWT2ChqDpsIge41oVic=;
        h=From:To:Cc:Subject:Date:From;
        b=nJgCjgiip0vUO/x2ucTXXx98c8qVFj5HUBHPa+2LHdxXg9HGGt2A1YpYAblNUW6Wc
         jbzu3J6Mx0siRYJx589UhegC5k7oXQ0xQmy0vvOkY12xYE9OIJonUN5mfA/NSHKZvb
         lEJXCAGVUzTwq4+X6BNDWRh/iJZ1x8h9bAMIRzWTY93I7pG44QIt+0FBbu2JR1xU9i
         N+lLvqYyOUEepGFEOSTn4teEGrzpAmKP0ohhsN4tuyx/9z8W5edugkCx0QukgQxxbO
         LT3Vgz+4dUKAn3RSp429RlMsCJSHaYFPB0HzAhuyKAqIoGkqQYFNPN1lVBao056nor
         K52BlWENEkjnw==
From:   Joerg Roedel <joro@8bytes.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, hpa@zytor.com, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/efi: Load fixmap GDT in efi_call_phys_epilog()
Date:   Fri, 31 Aug 2018 10:05:38 +0200
Message-Id: <1535702738-10971-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

When PTI is enabled on x86-32 the kernel uses the GDT mapped
in the fixmap for the simple reason that this address is
also mapped for user-space.

The efi_call_phys_prolog()/efi_call_phys_epilog() wrappers
change the GDT to call EFI runtime services and switch back
to the kernel GDT when they return. But the switch-back uses
the writable GDT, not the fixmap GDT.

When that happened and and the CPU returns to user-space it
switches to the user %cr3 and tries to restore user segment
registers. This fails because the writable GDT is not mapped
in the user page-table, and without a GDT the fault handlers
also can't be launched. The result is a triple fault and
reboot of the machine.

Fix that by restoring the GDT back to the fixmap GDT which
is also mapped in the user page-table.

Fixes: 7757d607c6b3 x86/pti: ('Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32')
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/platform/efi/efi_32.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 324b9332..05ca142 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -85,14 +85,10 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
 {
-	struct desc_ptr gdt_descr;
-
-	gdt_descr.address = (unsigned long)get_cpu_gdt_rw(0);
-	gdt_descr.size = GDT_SIZE - 1;
-	load_gdt(&gdt_descr);
-
 	load_cr3(save_pgd);
 	__flush_tlb_all();
+
+	load_fixmap_gdt(0);
 }
 
 void __init efi_runtime_update_mappings(void)
-- 
2.7.4


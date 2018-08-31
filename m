Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C7F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C7F2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeHaT51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:57:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeHaT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:57:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7VFmnUq2205992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Aug 2018 08:48:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7VFmmaZ2205989;
        Fri, 31 Aug 2018 08:48:48 -0700
Date:   Fri, 31 Aug 2018 08:48:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-eeb89e2bb1ac45b0836d4170e97a988c3a746c62@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
        linux@roeck-us.net, ak@linux.intel.com, dave.hansen@intel.com,
        mhocko@suse.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, jroedel@suse.de, pavel@ucw.cz
Reply-To: mhocko@suse.com, hpa@zytor.com, ard.biesheuvel@linaro.org,
          torvalds@linux-foundation.org, dave.hansen@intel.com,
          ak@linux.intel.com, linux@roeck-us.net, mingo@kernel.org,
          pavel@ucw.cz, jroedel@suse.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <1535702738-10971-1-git-send-email-joro@8bytes.org>
References: <1535702738-10971-1-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/efi: Load fixmap GDT in efi_call_phys_epilog()
Git-Commit-ID: eeb89e2bb1ac45b0836d4170e97a988c3a746c62
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  eeb89e2bb1ac45b0836d4170e97a988c3a746c62
Gitweb:     https://git.kernel.org/tip/eeb89e2bb1ac45b0836d4170e97a988c3a746c62
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 31 Aug 2018 10:05:38 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 31 Aug 2018 17:45:54 +0200

x86/efi: Load fixmap GDT in efi_call_phys_epilog()

When PTI is enabled on x86-32 the kernel uses the GDT mapped in the fixmap
for the simple reason that this address is also mapped for user-space.

The efi_call_phys_prolog()/efi_call_phys_epilog() wrappers change the GDT
to call EFI runtime services and switch back to the kernel GDT when they
return. But the switch-back uses the writable GDT, not the fixmap GDT.

When that happened and and the CPU returns to user-space it switches to the
user %cr3 and tries to restore user segment registers. This fails because
the writable GDT is not mapped in the user page-table, and without a GDT
the fault handlers also can't be launched. The result is a triple fault and
reboot of the machine.

Fix that by restoring the GDT back to the fixmap GDT which is also mapped
in the user page-table.

Fixes: 7757d607c6b3 x86/pti: ('Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32')
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: hpa@zytor.com
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/1535702738-10971-1-git-send-email-joro@8bytes.org

---
 arch/x86/platform/efi/efi_32.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 324b93328b37..05ca14222463 100644
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

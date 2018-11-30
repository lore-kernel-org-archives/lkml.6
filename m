Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA11C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EE52146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EE52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeK3VIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:08:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49603 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK3VIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:08:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9wdp53261961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:58:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9wd9F3261958;
        Fri, 30 Nov 2018 01:58:39 -0800
Date:   Fri, 30 Nov 2018 01:58:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth Prakhya <tipbot@zytor.com>
Message-ID: <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
Cc:     hdegoede@redhat.com, mingo@kernel.org, bp@alien8.de,
        marc.zyngier@arm.com, eric.snowberg@oracle.com,
        sai.praneeth.prakhya@intel.com, hpa@zytor.com,
        julien.thierry@arm.com, arend.vanspriel@broadcom.com,
        bhsharma@redhat.com, dave.hansen@intel.com, peterz@infradead.org,
        ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
        jonathanh@nvidia.com, joe@perches.com, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        zhuyifei1999@gmail.com, sedat.dilek@gmail.com, tglx@linutronix.de,
        natechancellor@gmail.com
Reply-To: bp@alien8.de, marc.zyngier@arm.com, eric.snowberg@oracle.com,
          hdegoede@redhat.com, mingo@kernel.org, dave.hansen@intel.com,
          peterz@infradead.org, hpa@zytor.com,
          sai.praneeth.prakhya@intel.com, arend.vanspriel@broadcom.com,
          julien.thierry@arm.com, bhsharma@redhat.com,
          jonathanh@nvidia.com, joe@perches.com, matt@codeblueprint.co.uk,
          ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
          natechancellor@gmail.com, luto@kernel.org,
          linux-kernel@vger.kernel.org, sedat.dilek@gmail.com,
          zhuyifei1999@gmail.com, tglx@linutronix.de
In-Reply-To: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
Git-Commit-ID: 08cfb38f3ef49cfd1bba11a00401451606477d80
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

Commit-ID:  08cfb38f3ef49cfd1bba11a00401451606477d80
Gitweb:     https://git.kernel.org/tip/08cfb38f3ef49cfd1bba11a00401451606477d80
Author:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
AuthorDate: Thu, 29 Nov 2018 18:12:24 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:10:30 +0100

x86/efi: Unmap EFI boot services code/data regions from efi_pgd

efi_free_boot_services(), as the name suggests, frees EFI boot services
code/data regions but forgets to unmap these regions from efi_pgd. This
means that any code that's running in efi_pgd address space (e.g:
any EFI runtime service) would still be able to access these regions but
the contents of these regions would have long been over written by
someone else. So, it's important to unmap these regions. Hence,
introduce efi_unmap_pages() to unmap these regions from efi_pgd.

After unmapping EFI boot services code/data regions, any illegal access
by buggy firmware to these regions would result in page fault which will
be handled by EFI specific fault handler.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 95e77a667ba5..09e811b9da26 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -369,6 +369,24 @@ void __init efi_reserve_boot_services(void)
 	}
 }
 
+/*
+ * Apart from having VA mappings for EFI boot services code/data regions,
+ * (duplicate) 1:1 mappings were also created as a quirk for buggy firmware. So,
+ * unmap both 1:1 and VA mappings.
+ */
+static void __init efi_unmap_pages(efi_memory_desc_t *md)
+{
+	pgd_t *pgd = efi_mm.pgd;
+	u64 pa = md->phys_addr;
+	u64 va = md->virt_addr;
+
+	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
+		pr_err("Failed to unmap 1:1 mapping for 0x%llx\n", pa);
+
+	if (kernel_unmap_pages_in_pgd(pgd, va, md->num_pages))
+		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
+}
+
 void __init efi_free_boot_services(void)
 {
 	phys_addr_t new_phys, new_size;
@@ -393,6 +411,13 @@ void __init efi_free_boot_services(void)
 			continue;
 		}
 
+		/*
+		 * Before calling set_virtual_address_map(), EFI boot services
+		 * code/data regions were mapped as a quirk for buggy firmware.
+		 * Unmap them from efi_pgd before freeing them up.
+		 */
+		efi_unmap_pages(md);
+
 		/*
 		 * Nasty quirk: if all sub-1MB memory is used for boot
 		 * services, we can get here without having allocated the

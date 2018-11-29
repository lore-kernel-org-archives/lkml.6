Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392ABC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3B120863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IggHAJei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3B120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbeK3ETB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35048 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbeK3ETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so2696142wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iTHNAMi/B7M59UNr1H/N7bE0xz4z3gfTlAxn3XU6zk=;
        b=IggHAJei/HY1eekMT9MKvSsKn2ZhjsFwMEfCojcv0lIodqCRBUHbdO8IqfqEPCge5c
         XqAVKSQE6Jc7+/UASrkQRlFwrIyPAziUKerwEFvHVV/ff5prnWM9DOFcWDDch0Xu7hlb
         PvTEJ6tDpRrmrFGOtTXlBs3p87E9yD9WX8CGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iTHNAMi/B7M59UNr1H/N7bE0xz4z3gfTlAxn3XU6zk=;
        b=IFPPzr+WoiYPpuel8giaExXcONCLYWWAi48CdhVsbNmj+n5pHCvK4+cNSQVnTt31Cp
         Ycv2MBpdLe0zArQeSMhCwfRbOSG1lAbxCAeEaLR7pFn55LyxLBgmoKLo+9EG0a4D+CxC
         Xp1VQNNF44gHSDTBmquwv/86ze6/H7jESvakZTB9UgJ6MJXjedqx2ZxgY0GBQQeQzlo6
         nITG5QlFSarNcIlEgl+MRv3eVD/Qo9u92cQn1y4kHEWnwbR4rtzObbOEkZLpWeF5yS37
         B55Kd3ty2QoUxWcmbkTfFgn706Kx5K8E/ESJIDZOQq5HZd64RzZHIq+eegpB3BeJ57m9
         EWUQ==
X-Gm-Message-State: AA+aEWYa4mbP2GVZod5P5r4YNBo9w3txoM/vNfKIxg3jOSnWUaSQLjyr
        Jaf5/YWqzrOer5fCDvKvBp2jSg==
X-Google-Smtp-Source: AFSGD/UtLDkMHc5HoaZecxiqbpX5WWCFPebCteGp3tJbQc8pykCjasUtQfc+3ZX4DGY1KSKu21e1Mw==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr2256654wrf.164.1543511574762;
        Thu, 29 Nov 2018 09:12:54 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:53 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH 04/11] x86/mm/pageattr: Introduce helper function to unmap EFI boot services
Date:   Thu, 29 Nov 2018 18:12:23 +0100
Message-Id: <20181129171230.18699-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Ideally, after kernel assumes control of the platform, firmware
shouldn't access EFI boot services code/data regions. But, it's noticed
that this is not so true in many x86 platforms. Hence, during boot,
kernel reserves EFI boot services code/data regions [1] and maps [2]
them to efi_pgd so that call to set_virtual_address_map() doesn't fail.
After returning from set_virtual_address_map(), kernel frees the
reserved regions [3] but they still remain mapped. Hence, introduce
kernel_unmap_pages_in_pgd() which will later be used to unmap EFI boot
services code/data regions.

While at it modify kernel_map_pages_in_pgd() by
1. Adding __init modifier because it's always used *only* during boot.
2. Add a warning if it's used after SMP is initialized because it uses
   __flush_tlb_all() which flushes mappings only on current CPU.

Unmapping EFI boot services code/data regions will result in clearing
PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already
handled by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.

[1] efi_reserve_boot_services()
[2] efi_map_region() -> __map_region() -> kernel_map_pages_in_pgd()
[3] efi_free_boot_services()

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/pgtable_types.h |  8 ++++--
 arch/x86/mm/pageattr.c               | 40 ++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 106b7d0e2dae..d6ff0bbdb394 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -564,8 +564,12 @@ extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 				    unsigned int *level);
 extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
-extern int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
-				   unsigned numpages, unsigned long page_flags);
+extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
+					  unsigned long address,
+					  unsigned numpages,
+					  unsigned long page_flags);
+extern int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
+					    unsigned long numpages);
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_DEFS_H */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index db7a10082238..bac35001d896 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2338,8 +2338,8 @@ bool kernel_page_present(struct page *page)
 
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
-			    unsigned numpages, unsigned long page_flags)
+int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
+				   unsigned numpages, unsigned long page_flags)
 {
 	int retval = -EINVAL;
 
@@ -2353,6 +2353,8 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.flags = 0,
 	};
 
+	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
+
 	if (!(__supported_pte_mask & _PAGE_NX))
 		goto out;
 
@@ -2374,6 +2376,40 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 	return retval;
 }
 
+/*
+ * __flush_tlb_all() flushes mappings only on current CPU and hence this
+ * function shouldn't be used in an SMP environment. Presently, it's used only
+ * during boot (way before smp_init()) by EFI subsystem and hence is ok.
+ */
+int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
+				     unsigned long numpages)
+{
+	int retval;
+
+	/*
+	 * The typical sequence for unmapping is to find a pte through
+	 * lookup_address_in_pgd() (ideally, it should never return NULL because
+	 * the address is already mapped) and change it's protections. As pfn is
+	 * the *target* of a mapping, it's not useful while unmapping.
+	 */
+	struct cpa_data cpa = {
+		.vaddr		= &address,
+		.pfn		= 0,
+		.pgd		= pgd,
+		.numpages	= numpages,
+		.mask_set	= __pgprot(0),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.flags		= 0,
+	};
+
+	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
+
+	retval = __change_page_attr_set_clr(&cpa, 0);
+	__flush_tlb_all();
+
+	return retval;
+}
+
 /*
  * The testcases use internal knowledge of the implementation that shouldn't
  * be exposed to the rest of the kernel. Include these directly here.
-- 
2.19.1


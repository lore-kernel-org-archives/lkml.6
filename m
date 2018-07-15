Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898782087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898782087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeGPAE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:04:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeGPAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:04:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNdrbB923011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:39:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNdrTF923004;
        Sun, 15 Jul 2018 16:39:53 -0700
Date:   Sun, 15 Jul 2018 16:39:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-7e1550b8f2081cccdfa9f1cf1e54cbc4d720af7f@git.kernel.org>
Cc:     lersek@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        ard.biesheuvel@linaro.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        pjones@redhat.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, ard.biesheuvel@linaro.org,
          peterz@infradead.org, lersek@redhat.com, mingo@kernel.org,
          pjones@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <20180711094040.12506-8-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-8-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Drop type and attribute checks in
 efi_mem_desc_lookup()
Git-Commit-ID: 7e1550b8f2081cccdfa9f1cf1e54cbc4d720af7f
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

Commit-ID:  7e1550b8f2081cccdfa9f1cf1e54cbc4d720af7f
Gitweb:     https://git.kernel.org/tip/7e1550b8f2081cccdfa9f1cf1e54cbc4d720af7f
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 11 Jul 2018 11:40:39 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:43:12 +0200

efi: Drop type and attribute checks in efi_mem_desc_lookup()

The current implementation of efi_mem_desc_lookup() includes the
following check on the memory descriptor it returns:

    if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
        md->type != EFI_BOOT_SERVICES_DATA &&
        md->type != EFI_RUNTIME_SERVICES_DATA) {
            continue;
    }

This means that only EfiBootServicesData or EfiRuntimeServicesData
regions are considered, or any other region type provided that it
has the EFI_MEMORY_RUNTIME attribute set.

Given what the name of the function implies, and the fact that any
physical address can be described in the UEFI memory map only a single
time, it does not make sense to impose this condition in the body of the
loop, but instead, should be imposed by the caller depending on the value
that is returned to it.

Two such callers exist at the moment:

- The BGRT code when running on x86, via efi_mem_reserve() and
  efi_arch_mem_reserve(). In this case, the region is already known to
  be EfiBootServicesData, and so the check is redundant.

- The ESRT handling code which introduced this function, which calls it
  both directly from efi_esrt_init() and again via efi_mem_reserve() and
  efi_arch_mem_reserve() [on x86].

So let's move this check into the callers instead. This preserves the
current behavior both for BGRT and ESRT handling, and allows the lookup
routine to be reused by other [upcoming] users that don't have this
limitation.

In the ESRT case, keep the entire condition, so that platforms that
deviate from the UEFI spec and use something other than
EfiBootServicesData for the ESRT table will keep working as before.

For x86's efi_arch_mem_reserve() implementation, limit the type to
EfiBootServicesData, since it is the only type the reservation code
expects to operate on in the first place.

While we're at it, drop the __init annotation so that drivers can use it
as well.

Tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180711094040.12506-8-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 3 ++-
 drivers/firmware/efi/efi.c     | 8 +-------
 drivers/firmware/efi/esrt.c    | 5 ++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 6af39dc40325..844d31cb8a0c 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -248,7 +248,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md)) {
+	if (efi_mem_desc_lookup(addr, &md) ||
+	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1379a375dfa8..d8a33a781a57 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -402,7 +402,7 @@ subsys_initcall(efisubsys_init);
  * and if so, populate the supplied memory descriptor with the appropriate
  * data.
  */
-int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
+int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 {
 	efi_memory_desc_t *md;
 
@@ -420,12 +420,6 @@ int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 		u64 size;
 		u64 end;
 
-		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
-		    md->type != EFI_BOOT_SERVICES_DATA &&
-		    md->type != EFI_RUNTIME_SERVICES_DATA) {
-			continue;
-		}
-
 		size = md->num_pages << EFI_PAGE_SHIFT;
 		end = md->phys_addr + size;
 		if (phys_addr >= md->phys_addr && phys_addr < end) {
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 1ab80e06e7c5..375a77c1c6e5 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -250,7 +250,10 @@ void __init efi_esrt_init(void)
 		return;
 
 	rc = efi_mem_desc_lookup(efi.esrt, &md);
-	if (rc < 0) {
+	if (rc < 0 ||
+	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
+	     md.type != EFI_BOOT_SERVICES_DATA &&
+	     md.type != EFI_RUNTIME_SERVICES_DATA)) {
 		pr_warn("ESRT header is not in the memory map.\n");
 		return;
 	}

Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07879C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB357204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB357204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeK3VKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:10:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeK3VKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:10:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAUA0NgA3262398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 02:00:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAUA0Mc03262395;
        Fri, 30 Nov 2018 02:00:22 -0800
Date:   Fri, 30 Nov 2018 02:00:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-5f0b0ecf043a5319e729c11a53bc8294df12dab3@git.kernel.org>
Cc:     natechancellor@gmail.com, arend.vanspriel@broadcom.com,
        hdegoede@redhat.com, marc.zyngier@arm.com,
        matt@codeblueprint.co.uk, sedat.dilek@gmail.com,
        sai.praneeth.prakhya@intel.com, peterz@infradead.org,
        julien.thierry@arm.com, zhuyifei1999@gmail.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jonathanh@nvidia.com, bp@alien8.de,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        joe@perches.com, tglx@linutronix.de, bhsharma@redhat.com,
        eric.snowberg@oracle.com, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: jonathanh@nvidia.com, ard.biesheuvel@linaro.org, luto@kernel.org,
          dave.hansen@intel.com, tglx@linutronix.de, joe@perches.com,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          eric.snowberg@oracle.com, bhsharma@redhat.com, mingo@kernel.org,
          hpa@zytor.com, torvalds@linux-foundation.org,
          natechancellor@gmail.com, hdegoede@redhat.com,
          arend.vanspriel@broadcom.com, matt@codeblueprint.co.uk,
          marc.zyngier@arm.com, sedat.dilek@gmail.com,
          julien.thierry@arm.com, peterz@infradead.org,
          zhuyifei1999@gmail.com, sai.praneeth.prakhya@intel.com
In-Reply-To: <20181129171230.18699-10-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-10-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Permit multiple entries in persistent
 memreserve data structure
Git-Commit-ID: 5f0b0ecf043a5319e729c11a53bc8294df12dab3
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

Commit-ID:  5f0b0ecf043a5319e729c11a53bc8294df12dab3
Gitweb:     https://git.kernel.org/tip/5f0b0ecf043a5319e729c11a53bc8294df12dab3
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 29 Nov 2018 18:12:28 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:10:31 +0100

efi: Permit multiple entries in persistent memreserve data structure

In preparation of updating efi_mem_reserve_persistent() to cause less
fragmentation when dealing with many persistent reservations, update
the struct definition and the code that handles it currently so it
can describe an arbitrary number of reservations using a single linked
list entry. The actual optimization will be implemented in a subsequent
patch.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-10-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c              | 39 +++++++++++++++++++++++----------
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 include/linux/efi.h                     | 13 ++++++++---
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 415849bab233..80b11521627a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -602,21 +602,33 @@ int __init efi_apply_persistent_mem_reservations(void)
 
 		while (prsv) {
 			struct linux_efi_memreserve *rsv;
-
-			/* reserve the entry itself */
-			memblock_reserve(prsv, sizeof(*rsv));
-
-			rsv = early_memremap(prsv, sizeof(*rsv));
-			if (rsv == NULL) {
+			u8 *p;
+			int i;
+
+			/*
+			 * Just map a full page: that is what we will get
+			 * anyway, and it permits us to map the entire entry
+			 * before knowing its size.
+			 */
+			p = early_memremap(ALIGN_DOWN(prsv, PAGE_SIZE),
+					   PAGE_SIZE);
+			if (p == NULL) {
 				pr_err("Could not map UEFI memreserve entry!\n");
 				return -ENOMEM;
 			}
 
-			if (rsv->size)
-				memblock_reserve(rsv->base, rsv->size);
+			rsv = (void *)(p + prsv % PAGE_SIZE);
+
+			/* reserve the entry itself */
+			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
+
+			for (i = 0; i < atomic_read(&rsv->count); i++) {
+				memblock_reserve(rsv->entry[i].base,
+						 rsv->entry[i].size);
+			}
 
 			prsv = rsv->next;
-			early_memunmap(rsv, sizeof(*rsv));
+			early_memunmap(p, PAGE_SIZE);
 		}
 	}
 
@@ -985,6 +997,7 @@ static int __init efi_memreserve_map_root(void)
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
+	int rsvsize = EFI_MEMRESERVE_SIZE(1);
 	int rc;
 
 	if (efi_memreserve_root == (void *)ULONG_MAX)
@@ -996,12 +1009,14 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			return rc;
 	}
 
-	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
+	rsv = kmalloc(rsvsize, GFP_ATOMIC);
 	if (!rsv)
 		return -ENOMEM;
 
-	rsv->base = addr;
-	rsv->size = size;
+	rsv->size = 1;
+	atomic_set(&rsv->count, 1);
+	rsv->entry[0].base = addr;
+	rsv->entry[0].size = size;
 
 	spin_lock(&efi_mem_reserve_persistent_lock);
 	rsv->next = efi_memreserve_root->next;
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 3d36142cf812..9e20159ea5f5 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -86,8 +86,8 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	}
 
 	rsv->next = 0;
-	rsv->base = 0;
 	rsv->size = 0;
+	atomic_set(&rsv->count, 0);
 
 	status = efi_call_early(install_configuration_table,
 				&memreserve_table_guid,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2b3b33c83b05..4f27640fdcdc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1712,9 +1712,16 @@ extern struct efi_runtime_work efi_rts_work;
 extern struct workqueue_struct *efi_rts_wq;
 
 struct linux_efi_memreserve {
-	phys_addr_t	next;
-	phys_addr_t	base;
-	phys_addr_t	size;
+	int		size;			// allocated size of the array
+	atomic_t	count;			// number of entries used
+	phys_addr_t	next;			// pa of next struct instance
+	struct {
+		phys_addr_t	base;
+		phys_addr_t	size;
+	} entry[0];
 };
 
+#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
+	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
+
 #endif /* _LINUX_EFI_H */

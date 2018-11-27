Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F2021104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F2021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeK1A3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:29:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeK1A3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:29:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wARDUsdm1884439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Nov 2018 05:30:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wARDUsGJ1884436;
        Tue, 27 Nov 2018 05:30:54 -0800
Date:   Tue, 27 Nov 2018 05:30:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-976b489120cdab2b1b3a41ffa14661db43d58190@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        tglx@linutronix.de, jglauber@cavium.com, peterz@infradead.org,
        john.garry@huawei.com, marc.zyngier@arm.com, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: marc.zyngier@arm.com, jglauber@cavium.com, john.garry@huawei.com,
          peterz@infradead.org, tglx@linutronix.de,
          ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20181123215132.7951-2-ard.biesheuvel@linaro.org>
References: <20181123215132.7951-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi: Prevent GICv3 WARN() by mapping the
 memreserve table before first use
Git-Commit-ID: 976b489120cdab2b1b3a41ffa14661db43d58190
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

Commit-ID:  976b489120cdab2b1b3a41ffa14661db43d58190
Gitweb:     https://git.kernel.org/tip/976b489120cdab2b1b3a41ffa14661db43d58190
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 23 Nov 2018 22:51:32 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 27 Nov 2018 13:50:20 +0100

efi: Prevent GICv3 WARN() by mapping the memreserve table before first use

Mapping the MEMRESERVE EFI configuration table from an early initcall
is too late: the GICv3 ITS code that creates persistent reservations
for the boot CPU's LPI tables is invoked from init_IRQ(), which runs
much earlier than the handling of the initcalls. This results in a
WARN() splat because the LPI tables cannot be reserved persistently,
which will result in silent memory corruption after a kexec reboot.

So instead, invoke the initialization performed by the initcall from
efi_mem_reserve_persistent() itself as well, but keep the initcall so
that the init is guaranteed to have been called before SMP boot.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Jan Glauber <jglauber@cavium.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 63eb322d89c8 ("efi: Permit calling efi_mem_reserve_persistent() ...")
Link: http://lkml.kernel.org/r/20181123215132.7951-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fad7c62cfc0e..415849bab233 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -969,13 +969,33 @@ bool efi_is_table_address(unsigned long phys_addr)
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
 static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
-int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
+static int __init efi_memreserve_map_root(void)
+{
+	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
+		return -ENODEV;
+
+	efi_memreserve_root = memremap(efi.mem_reserve,
+				       sizeof(*efi_memreserve_root),
+				       MEMREMAP_WB);
+	if (WARN_ON_ONCE(!efi_memreserve_root))
+		return -ENOMEM;
+	return 0;
+}
+
+int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
+	int rc;
 
-	if (!efi_memreserve_root)
+	if (efi_memreserve_root == (void *)ULONG_MAX)
 		return -ENODEV;
 
+	if (!efi_memreserve_root) {
+		rc = efi_memreserve_map_root();
+		if (rc)
+			return rc;
+	}
+
 	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
 	if (!rsv)
 		return -ENOMEM;
@@ -993,14 +1013,10 @@ int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 
 static int __init efi_memreserve_root_init(void)
 {
-	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
-		return -ENODEV;
-
-	efi_memreserve_root = memremap(efi.mem_reserve,
-				       sizeof(*efi_memreserve_root),
-				       MEMREMAP_WB);
-	if (!efi_memreserve_root)
-		return -ENOMEM;
+	if (efi_memreserve_root)
+		return 0;
+	if (efi_memreserve_map_root())
+		efi_memreserve_root = (void *)ULONG_MAX;
 	return 0;
 }
 early_initcall(efi_memreserve_root_init);

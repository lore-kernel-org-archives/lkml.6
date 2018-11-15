Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0D622419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0D622419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbeKOTTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:19:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKOTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:19:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAF9CG0S739061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Nov 2018 01:12:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAF9CGsW739058;
        Thu, 15 Nov 2018 01:12:16 -0800
Date:   Thu, 15 Nov 2018 01:12:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-63eb322d89c8505af9b4a3d703e85e42281ebaa0@git.kernel.org>
Cc:     hpa@zytor.com, ard.biesheuvel@linaro.org, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
          ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20181114175544.12860-6-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-6-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi: Permit calling efi_mem_reserve_persistent()
 from atomic context
Git-Commit-ID: 63eb322d89c8505af9b4a3d703e85e42281ebaa0
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

Commit-ID:  63eb322d89c8505af9b4a3d703e85e42281ebaa0
Gitweb:     https://git.kernel.org/tip/63eb322d89c8505af9b4a3d703e85e42281ebaa0
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 14 Nov 2018 09:55:44 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Nov 2018 10:04:47 +0100

efi: Permit calling efi_mem_reserve_persistent() from atomic context

Currently, efi_mem_reserve_persistent() may not be called from atomic
context, since both the kmalloc() call and the memremap() call may
sleep.

The kmalloc() call is easy enough to fix, but the memremap() call
needs to be moved into an init hook since we cannot control the
memory allocation behavior of memremap() at the call site.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181114175544.12860-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 72a4da76d274..fad7c62cfc0e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -967,36 +967,43 @@ bool efi_is_table_address(unsigned long phys_addr)
 }
 
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
+static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
 int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
-	struct linux_efi_memreserve *rsv, *parent;
+	struct linux_efi_memreserve *rsv;
 
-	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
+	if (!efi_memreserve_root)
 		return -ENODEV;
 
-	rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
+	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
 	if (!rsv)
 		return -ENOMEM;
 
-	parent = memremap(efi.mem_reserve, sizeof(*rsv), MEMREMAP_WB);
-	if (!parent) {
-		kfree(rsv);
-		return -ENOMEM;
-	}
-
 	rsv->base = addr;
 	rsv->size = size;
 
 	spin_lock(&efi_mem_reserve_persistent_lock);
-	rsv->next = parent->next;
-	parent->next = __pa(rsv);
+	rsv->next = efi_memreserve_root->next;
+	efi_memreserve_root->next = __pa(rsv);
 	spin_unlock(&efi_mem_reserve_persistent_lock);
 
-	memunmap(parent);
+	return 0;
+}
 
+static int __init efi_memreserve_root_init(void)
+{
+	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
+		return -ENODEV;
+
+	efi_memreserve_root = memremap(efi.mem_reserve,
+				       sizeof(*efi_memreserve_root),
+				       MEMREMAP_WB);
+	if (!efi_memreserve_root)
+		return -ENOMEM;
 	return 0;
 }
+early_initcall(efi_memreserve_root_init);
 
 #ifdef CONFIG_KEXEC
 static int update_efi_random_seed(struct notifier_block *nb,

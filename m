Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75768C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2791B2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuMkgBsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2791B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeKQVHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:07:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeKQVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:07:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id v18-v6so27308918wrt.8;
        Sat, 17 Nov 2018 02:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uoKVHB6+fZHnF744bCqKknIbIzIFYCfnxWBOU+19guY=;
        b=fuMkgBsLzOtxS2pYacpZHq0gYYRliYPk1mXT9DEaHRxlxvCuXP8sFTvPyoRj9npg2T
         B2xtqPQjwHtVn/PWJrZVle5SMnBcJndvt5Q5dwouBPZ5DdJCBKrrGhNiHVb2PgATRuqr
         k/rmougctp3TqQPG8gA+l0XU+AQldS0UecTtcbeDuZV01Uvt+AO9mx8l8+1wxc83kqHc
         c61KYk9oxQz4QPPVrqAviFVhY09SanROvrZKNDoG3WmGkNobT5gY95+bk7LQsI3lUgwV
         CslO4RF7QPzPByHLoZ6Bo7Ns1vx29ShrixTIx4BZOxe/OCeB6qtl3ysoT2sDW2NQAW3W
         qtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=uoKVHB6+fZHnF744bCqKknIbIzIFYCfnxWBOU+19guY=;
        b=o1dOEcrD24Pvpao8PWnUnFlMSqvMNAo611HuijIQsqzMHGCWi0/Q8Yge4u7i6XnEB+
         p96AIKTjvUfGW5/xZcJeddi49lPNR6eCiG+id/4HtLBvSPWIkXUA9N/LDG2GFlDClFJv
         749W8F7RX/oGVx5QCqQVKgqTXh5p2jrBmZPUAl/R1fsqKwgpmP1MV3nMnIZJl0thKjj9
         oXawUbpHhQNEzo++eGYUB3U7GqNBUMSQhpoRRUXegx9VHEipRZRB7DeYkIwTZPXemNlq
         LdbYtPIk6X++/X/RQC9qylURv8hTMSYGrn9NbkaSEiVSAWxqkap2Ed9fuEGZqYAZbx+G
         7I2g==
X-Gm-Message-State: AGRZ1gI5jj8BOzgISm5bzis6gvWdtIdsStgELcG+IYsIcGLU41lAIiBv
        TuZrBH98i/b8eCBcqQm8ebY=
X-Google-Smtp-Source: AJdET5fp5N/+CYU35gpeLJ6kqZ0jRA2ve+RnZj2kj6rwEDAMdBBlbO7uUTNCtyLI3VRyY/mVYirkcw==
X-Received: by 2002:a5d:684f:: with SMTP id o15-v6mr12505999wrw.186.1542451878491;
        Sat, 17 Nov 2018 02:51:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e66-v6sm51313401wmf.40.2018.11.17.02.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 02:51:17 -0800 (PST)
Date:   Sat, 17 Nov 2018 11:51:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fixes
Message-ID: <20181117105115.GA11134@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 63eb322d89c8505af9b4a3d703e85e42281ebaa0 efi: Permit calling efi_mem_reserve_persistent() from atomic context

Misc fixes: two warning splat fixes, a leak fix and persistent memory 
allocation fixes for ARM.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (4):
      efi/arm: Revert deferred unmap of early memmap mapping
      efi/arm/libstub: Pack FDT after populating it
      efi/arm: Defer persistent reservations until after paging_init()
      efi: Permit calling efi_mem_reserve_persistent() from atomic context

Waiman Long (1):
      efi: Fix debugobjects warning on 'efi_rts_work'


 arch/arm64/kernel/setup.c               |  1 +
 drivers/firmware/efi/arm-init.c         |  4 ++++
 drivers/firmware/efi/arm-runtime.c      |  2 +-
 drivers/firmware/efi/efi.c              | 35 ++++++++++++++++++++++-----------
 drivers/firmware/efi/libstub/arm-stub.c |  3 +++
 drivers/firmware/efi/libstub/fdt.c      |  4 ++++
 drivers/firmware/efi/memmap.c           |  3 +++
 drivers/firmware/efi/runtime-wrappers.c |  2 +-
 include/linux/efi.h                     |  7 +++++++
 9 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 953e316521fc..f4fc1e0544b7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,6 +313,7 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
+	efi_apply_persistent_mem_reservations();
 
 	acpi_table_upgrade();
 
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 388a929baf95..1a6a77df8a5e 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -265,6 +265,10 @@ void __init efi_init(void)
 				    (params.mmap & ~PAGE_MASK)));
 
 	init_screen_info();
+
+	/* ARM does not permit early mappings to persist across paging_init() */
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_memmap_unmap();
 }
 
 static int __init register_gop_device(void)
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 922cfb813109..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -110,7 +110,7 @@ static int __init arm_enable_runtime_services(void)
 {
 	u64 mapsize;
 
-	if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
+	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
 		return 0;
 	}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 249eb70691b0..fad7c62cfc0e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -592,7 +592,11 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
+	return 0;
+}
 
+int __init efi_apply_persistent_mem_reservations(void)
+{
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
@@ -963,36 +967,43 @@ bool efi_is_table_address(unsigned long phys_addr)
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
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 30ac0c975f8a..3d36142cf812 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -75,6 +75,9 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
+	if (IS_ENABLED(CONFIG_ARM))
+		return;
+
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 8830fa601e45..0c0d2312f4a8 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -158,6 +158,10 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 			return efi_status;
 		}
 	}
+
+	/* shrink the FDT back to its minimum size */
+	fdt_pack(fdt);
+
 	return EFI_SUCCESS;
 
 fdt_set_fail:
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index fa2904fb841f..38b686c67b17 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -118,6 +118,9 @@ int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 
 void __init efi_memmap_unmap(void)
 {
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	if (!efi.memmap.late) {
 		unsigned long size;
 
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index a19d845bdb06..8903b9ccfc2b 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -67,7 +67,7 @@ struct efi_runtime_work efi_rts_work;
 	}								\
 									\
 	init_completion(&efi_rts_work.efi_rts_comp);			\
-	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
+	INIT_WORK(&efi_rts_work.work, efi_call_rts);			\
 	efi_rts_work.arg1 = _arg1;					\
 	efi_rts_work.arg2 = _arg2;					\
 	efi_rts_work.arg3 = _arg3;					\
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 845174e113ce..100ce4a4aff6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1167,6 +1167,8 @@ static inline bool efi_enabled(int feature)
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
 
 extern bool efi_is_table_address(unsigned long phys_addr);
+
+extern int efi_apply_persistent_mem_reservations(void);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1185,6 +1187,11 @@ static inline bool efi_is_table_address(unsigned long phys_addr)
 {
 	return false;
 }
+
+static inline int efi_apply_persistent_mem_reservations(void)
+{
+	return 0;
+}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);

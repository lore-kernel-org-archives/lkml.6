Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B369BC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF1822419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4UHeMEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF1822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbeKOEAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:00:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45133 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732981AbeKOEAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:00:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so7688059pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wgQ6lhA7RkEviiHkwSDj/bCPpNPjF7ngHY8ighWmwmU=;
        b=a4UHeMEIcEfzBqqcqd4pUkBF9vuauDlV2NEaWs78ydREPZ79oDz8FfibpMYXeslbSj
         ancDmlMg3dM+9a+cWz2jhfj7h93DmNKU0COq3wRXsh+m9J+pSMmBt0IF+4qeGiRp/Mh7
         /aHI060CNmHiJXTnuLAOnrzLVveApFqf7aA6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wgQ6lhA7RkEviiHkwSDj/bCPpNPjF7ngHY8ighWmwmU=;
        b=eUki05OwvbUMuiyeklkTnkQ/J8Xu83swQS1R1NtSVzCg4OziXwuDR5CtXaK/Xo/lEZ
         Jpxi9WmVUcOjKp1rpQbK+ipdthsSVovO7lU+ZVO+4eh/2rq9vQr2eii7DHnKjJW0haGp
         LB0/NuD8KQq65iajqCItzkX2G4Js5vNpcfI5WoRyWCI30Y88ERpqN6IS00oB11HvknVt
         XWJhpGfAj8t+InCVuP7yi1X6iKjYdJojSsRyhQjgwgKUeH/nKa3HCMl1WjMKD/rxDYfL
         v1XSZW7EkpnVQc6Ekkoo0JUBBh/4ZXZou/P0Sx9Y6hu+MjbjoqtG7m5J8XqZRsR+rqvE
         5YCg==
X-Gm-Message-State: AGRZ1gJA6YczhLJQCzq3hXA+37Y3kbTV7ulFoRrBI3jtOmUhPPXJ5T1s
        wmWbBHHoqsEi5m1pfsHOoFKkfg==
X-Google-Smtp-Source: AJdET5c50OTCeag6KFT0/oxdth2rDXaremMD5A3UyWN+bwELaYDwKOfujbqqiSrRQAkowmhSlUlknw==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr2648383pga.202.1542218163043;
        Wed, 14 Nov 2018 09:56:03 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id i2-v6sm21301738pgq.35.2018.11.14.09.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:56:00 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] efi/arm: defer persistent reservations until after paging_init()
Date:   Wed, 14 Nov 2018 09:55:43 -0800
Message-Id: <20181114175544.12860-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new memory EFI reservation feature we introduced to allow memory
reservations to persist across kexec may trigger an unbounded number
of calls to memblock_reserve(). The memblock subsystem can deal with
this fine, but not before memblock resizing is enabled, which we can
only do after paging_init(), when the memory we reallocate the array
into is actually mapped.

So break out the memreserve table processing into a separate routine
and call it after paging_init() on arm64. On ARM, because of limited
reviewing bandwidth of the maintainer, we cannot currently fix this,
so instead, disable the EFI persistent memreserve entirely on ARM so
we can fix it later.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/setup.c               | 1 +
 drivers/firmware/efi/efi.c              | 4 ++++
 drivers/firmware/efi/libstub/arm-stub.c | 3 +++
 include/linux/efi.h                     | 7 +++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 953e316521fc..f4fc1e0544b7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,6 +313,7 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
+	efi_apply_persistent_mem_reservations();
 
 	acpi_table_upgrade();
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 249eb70691b0..72a4da76d274 100644
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
-- 
2.17.1


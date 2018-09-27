Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD222157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXYpuvfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD222157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeI0PIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34548 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeI0PII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id z4-v6so286808wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffkuDpNBfwdcvOz+/QFFGB2qN+kuprFwPCetGXqXDvo=;
        b=NXYpuvfjVfvGDfKvcFzsqhfoZxbZh6uUyiF4tlEMs6UaniHzdsbXtC8B5wk1uDhj98
         TQHp0JQrnCffiOTjDSjABSrHPhxtkbX93pvOd/liNxZtzbGLFivKuWpNnyo+XOLWfaWL
         fjc7qvSq5h98gKpG/Db2iG1jt+xScVrAfOFBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffkuDpNBfwdcvOz+/QFFGB2qN+kuprFwPCetGXqXDvo=;
        b=Ed79JRI+9Eqroa0SPVZKJ/2mpaPi/uemGIJo1dxRGwiHJMLaOo9a7gthilUBGrg2RR
         cxql1IJDnehJaQIB3nlO1S591IK8nQOTaMgogkDwOLiPo6nwB5MxNFDvunrjBUoZZ7WS
         vM4R5KiZ0VTYLNT9iCsWLaiNONatawvF7HrUY5VA91MVHi/Q9qrCl0KDO5xwBNBi54fk
         QaLMTtiXQJ5tuPVU2F6/mBrvPjVr93JhINp1vaiQ7fk0P8lze1C3zJAZACJSQP7lK3zK
         QbGbumC26pDAqP0uS3gO5f1CnRR87pgfjl4AuchVl5q1Ql6hHPKS11jgxtxlJNaTW4u5
         DZxQ==
X-Gm-Message-State: ABuFfogcPawbxZroVfAGFgQpYNoc+jQABJ7w8b7eVJaUfC3WyJ5EScPd
        Dt41Be/79BxqstvkusRJg4lmYXWEx1M=
X-Google-Smtp-Source: ACcGV62fQwn6btLZXgIuPYAgAUUjT1D+Ga3c/TBRXnnbKg3s+ye5sxFlTPQ+MLjlb8p/ndYwiyCsnQ==
X-Received: by 2002:adf:9244:: with SMTP id 62-v6mr757724wrj.130.1538038257358;
        Thu, 27 Sep 2018 01:50:57 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:50:56 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 01/11] efi: honour memory reservations passed via a linux specific config table
Date:   Thu, 27 Sep 2018 10:50:28 +0200
Message-Id: <20180927085039.8391-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow the OS to reserve memory persistently across a
kexec, introduce a Linux-specific UEFI configuration table that
points to the head of a linked list in memory, allowing each kernel
to add list items describing memory regions that the next kernel
should treat as reserved.

This is useful, e.g., for GICv3 based ARM systems that cannot disable
DMA access to the LPI tables, forcing them to reuse the same memory
region again after a kexec reboot.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 27 ++++++++++++++++++++++++++-
 include/linux/efi.h        |  8 ++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 2a29dd9c986d..688132ac8a0a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -52,7 +52,8 @@ struct efi __read_mostly efi = {
 	.properties_table	= EFI_INVALID_TABLE_ADDR,
 	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
 	.rng_seed		= EFI_INVALID_TABLE_ADDR,
-	.tpm_log		= EFI_INVALID_TABLE_ADDR
+	.tpm_log		= EFI_INVALID_TABLE_ADDR,
+	.mem_reserve		= EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
 
@@ -484,6 +485,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table},
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
+	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
 	{NULL_GUID, NULL, NULL},
 };
 
@@ -591,6 +593,29 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 		early_memunmap(tbl, sizeof(*tbl));
 	}
 
+	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
+		unsigned long prsv = efi.mem_reserve;
+
+		while (prsv) {
+			struct linux_efi_memreserve *rsv;
+
+			/* reserve the entry itself */
+			memblock_reserve(prsv, sizeof(*rsv));
+
+			rsv = early_memremap(prsv, sizeof(*rsv));
+			if (rsv == NULL) {
+				pr_err("Could not map UEFI memreserve entry!\n");
+				return -ENOMEM;
+			}
+
+			if (rsv->size)
+				memblock_reserve(rsv->base, rsv->size);
+
+			prsv = rsv->next;
+			early_memunmap(rsv, sizeof(*rsv));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 401e4b254e30..a5cb580472c5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -672,6 +672,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
+#define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 
 typedef struct {
 	efi_guid_t guid;
@@ -957,6 +958,7 @@ extern struct efi {
 	unsigned long mem_attr_table;	/* memory attributes table */
 	unsigned long rng_seed;		/* UEFI firmware random seed */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
+	unsigned long mem_reserve;	/* Linux EFI memreserve table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
 	efi_get_wakeup_time_t *get_wakeup_time;
@@ -1662,4 +1664,10 @@ extern int efi_tpm_eventlog_init(void);
 /* Workqueue to queue EFI Runtime Services */
 extern struct workqueue_struct *efi_rts_wq;
 
+struct linux_efi_memreserve {
+	phys_addr_t	next;
+	phys_addr_t	base;
+	phys_addr_t	size;
+};
+
 #endif /* _LINUX_EFI_H */
-- 
2.18.0


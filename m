Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1915EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEB32157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ji+Retyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEB32157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeI0PIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46022 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeI0PIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id m16so1627449wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pliM0wAhEQbP7B2f//HIg7uUcfNbBN60CgcLvrL/TbY=;
        b=Ji+RetyvGrM4kppR1BHBn9jBPUwbfAU9gkrn7EX19XHyKQlRz6DO6xiwEGj8pMihfV
         ouVzVT4iEDQmICj+j0fDYb3BrF0KxfpM0Nd+LlDgCMfLDtgccC1Az25bz088U6nsF1t4
         OJZc9pz4892orsoD1Xirg/GDdwX89C9KKc7rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pliM0wAhEQbP7B2f//HIg7uUcfNbBN60CgcLvrL/TbY=;
        b=kUo2MMjZWbRXrOamAVOpNvBiDXsEDJdpj22s+tKX3wNZNXXRRA6I9aU3wXJkFSj3q8
         Q9oT2iaugYAWbEUhRazJF/j/3SeyLG5CjLdbi7/EWnRzWSuKisn0WFGjBockZD5XUbfe
         OkvibK7RzI5noV0dFT7JystVCCsRSgTiXBV+RZbffmuBiKoBvgxqxQXHuxftEIKFosj0
         dQCKZ0X1fabmtUc0hiuoRlb7GStlwQf0DQShU0MQrcB2NzbW1v1lQDumj+WmAb3GvO/h
         Wydg54e4bFHnwFaYl96tBuKPcGDnEO1SOcAE5uGB1JcX+CKm8ZsgyuSKCWlUXSwgUD8p
         UtPQ==
X-Gm-Message-State: ABuFfojOA5YKY4VP4B8NBLoL1SslE6AqLWLPqnFKluy/GSM9JjBgmBJc
        hDJNpViZsGp/CE4xCjxrRXD/9F91rJA=
X-Google-Smtp-Source: ACcGV60sCIb31feA4b8tZ3N9+J32V7D/J9dBrK9aq4KYHjJcze91uIVzCSoDZpNtAMLp7smt2fUwUg==
X-Received: by 2002:adf:a185:: with SMTP id u5-v6mr8316031wru.50.1538038258916;
        Thu, 27 Sep 2018 01:50:58 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:50:58 -0700 (PDT)
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
Subject: [PATCH 02/11] efi/arm: libstub: add a root memreserve config table
Date:   Thu, 27 Sep 2018 10:50:29 +0200
Message-Id: <20180927085039.8391-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Installing UEFI configuration tables can only be done before calling
ExitBootServices(), so if we want to use the new MEMRESRVE config table
from the kernel proper, we need to install a dummy entry from the stub.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 6920033de6d4..30ac0c975f8a 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -69,6 +69,31 @@ static struct screen_info *setup_graphics(efi_system_table_t *sys_table_arg)
 	return si;
 }
 
+void install_memreserve_table(efi_system_table_t *sys_table_arg)
+{
+	struct linux_efi_memreserve *rsv;
+	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
+	efi_status_t status;
+
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
+				(void **)&rsv);
+	if (status != EFI_SUCCESS) {
+		pr_efi_err(sys_table_arg, "Failed to allocate memreserve entry!\n");
+		return;
+	}
+
+	rsv->next = 0;
+	rsv->base = 0;
+	rsv->size = 0;
+
+	status = efi_call_early(install_configuration_table,
+				&memreserve_table_guid,
+				rsv);
+	if (status != EFI_SUCCESS)
+		pr_efi_err(sys_table_arg, "Failed to install memreserve config table!\n");
+}
+
+
 /*
  * This function handles the architcture specific differences between arm and
  * arm64 regarding where the kernel image must be loaded and any memory that
@@ -235,6 +260,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 		}
 	}
 
+	install_memreserve_table(sys_table);
+
 	new_fdt_addr = fdt_addr;
 	status = allocate_new_fdt_and_exit_boot(sys_table, handle,
 				&new_fdt_addr, efi_get_max_fdt_addr(dram_base),
-- 
2.18.0


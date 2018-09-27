Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DD8C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB3A2157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bovG80Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB3A2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeI0PIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51165 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeI0PIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so5032584wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f8rCgirc+Q/Pjj+hezpx+WshLqF7c604zeE4cCjQ4cU=;
        b=bovG80CmbjL84b5Zsj4eHC7ELIy3ILRfjn7nny+sOwsD9OQLDif7BtAPKn1cmccbAj
         CD313OwFymTWeSWL4w7q/j8EPuOxM2JEzK63Mk76d/1b7GDHa3zPkBDuVJf17EC+OFX1
         fFHfqSiPqdljW9o7Gi73hRRYpGRCiY3yNMjSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f8rCgirc+Q/Pjj+hezpx+WshLqF7c604zeE4cCjQ4cU=;
        b=XTQcimw5kNk6u5OZEtZWjL+W99Vq6h0pXcNrWc4R8On50FTTi1hHX4TizunOhplKDX
         UzxxOM/whaGOgqTD7raUW/5wK2noGkcWvQMw8faOljpS4mPQbRSMmSmlpE25kjy3o70y
         GhsULyG7f9tbvkNIaYh9xH/y1aRNvp5mCtj1tX+DsLGQW6wA95BkghEyT+UUYVIzSooW
         4MVK4ZADJPKK3DgkS3JeK7cPsTKnnnhPn7ILChGLxXQj3DSBHwMOJJMuyWPprJgMsAzX
         hPMp1ra9oi7mo2H0NV53IYugUWYBemCpgihtvyQTRLBoDy1ZE8maYB3CH/drExkH0ogF
         cP3g==
X-Gm-Message-State: ABuFfoipX+e/XYTl5AcZROtsphrv783+0mwfP4+7zzM1Z8HW73CeC07o
        eDUZ/laSjCAgJ8sYjjktHh7WujUPk9g=
X-Google-Smtp-Source: ACcGV63ptguOmZMBM9fmPQ7yNyQRaoh6Vx1ktDY1sm98Gm70juebu/aT4B0SRbzByL0DeyjZfNccPQ==
X-Received: by 2002:a1c:8a55:: with SMTP id m82-v6mr6884527wmd.70.1538038260353;
        Thu, 27 Sep 2018 01:51:00 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:50:59 -0700 (PDT)
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
Subject: [PATCH 03/11] efi: add API to reserve memory persistently across kexec reboot
Date:   Thu, 27 Sep 2018 10:50:30 +0200
Message-Id: <20180927085039.8391-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel plumbing to reserve memory regions persistently on a EFI
system by adding entries to the MEMRESERVE linked list.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/efi.h        |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 688132ac8a0a..249eb70691b0 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -962,6 +962,38 @@ bool efi_is_table_address(unsigned long phys_addr)
 	return false;
 }
 
+static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
+
+int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
+{
+	struct linux_efi_memreserve *rsv, *parent;
+
+	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
+		return -ENODEV;
+
+	rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
+	if (!rsv)
+		return -ENOMEM;
+
+	parent = memremap(efi.mem_reserve, sizeof(*rsv), MEMREMAP_WB);
+	if (!parent) {
+		kfree(rsv);
+		return -ENOMEM;
+	}
+
+	rsv->base = addr;
+	rsv->size = size;
+
+	spin_lock(&efi_mem_reserve_persistent_lock);
+	rsv->next = parent->next;
+	parent->next = __pa(rsv);
+	spin_unlock(&efi_mem_reserve_persistent_lock);
+
+	memunmap(parent);
+
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC
 static int update_efi_random_seed(struct notifier_block *nb,
 				  unsigned long code, void *unused)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a5cb580472c5..22e4de9d3700 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1043,6 +1043,7 @@ extern int __init efi_uart_console_only (void);
 extern u64 efi_mem_desc_end(efi_memory_desc_t *md);
 extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
 extern void efi_mem_reserve(phys_addr_t addr, u64 size);
+extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 		struct resource *data_resource, struct resource *bss_resource);
 extern void efi_reserve_boot_services(void);
-- 
2.18.0


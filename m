Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C6C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A6822419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ML1/RI8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A6822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbeKOEAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:00:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42552 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbeKOEAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:00:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so3808126pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y5+MZn1DLLZ77dFsQDhm0oDAc8e59ns2BiFEM+0UUsQ=;
        b=ML1/RI8+lYgh8Lfbu5JQi/zaKuBY8GRTmrtpTLQ3eqqnjJGfyDNJ4ny/6/e6aNYtTF
         jbCMPs80U71EVjWOc/3PeyqPP/va0oh8Tb7gsIP9FeEO4svIb+21EpfBGNQn1a5vq3d4
         seANI8GpvQBuJESY+0dGsY4LyJy7jrQlFrh2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y5+MZn1DLLZ77dFsQDhm0oDAc8e59ns2BiFEM+0UUsQ=;
        b=sk5Tm0Y4jb89KrfuNTkT6MXE8myqJBbQV/4LX4YLEaq41vOTbro0osJzRzEQJyA8vP
         ek5HsN/LtIEviuP9bcirvLtZk+RupSM9RzbL6PlpmPnkRvL6KiBqzf1nZhCyq9zKwfqm
         DozFS9CE/8r5RskBPqXWs41EnpHzu4lJsqa2+OMqlNXqxJygizm10G+d/QgIUa4A3z2Y
         hrnNN6znlbgm2cmWROEskoJlZAPLT0tqpT6bDurTdbz5mIWtXUNqkQnFPLP0ASXEdmrS
         1DmjpEHHi3rmVoEushLpllCTZVMwFEUpK5KSZbJ89Tp8VO6ZY8WGsg+K1SFeHxxitEBK
         MV4g==
X-Gm-Message-State: AGRZ1gJnJ9+AkkMfP+KJCfAziGDPtEqOqE2z3kKKRn5viHP2RoBkHPpM
        6eUx0qLl/6fMJAbGcisn5zw4ug==
X-Google-Smtp-Source: AJdET5eSM79VYTe8Mze8VsPiWhD5Dj/JtLXG9H/r3z+bPTxbEz0lAtZ6EwkoGPjgR2Vh4+EnX5IFmA==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr2669319pge.126.1542218164233;
        Wed, 14 Nov 2018 09:56:04 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id i2-v6sm21301738pgq.35.2018.11.14.09.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:56:03 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] efi: permit calling efi_mem_reserve_persistent from atomic context
Date:   Wed, 14 Nov 2018 09:55:44 -0800
Message-Id: <20181114175544.12860-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, efi_mem_reserve_persistent() may not be called from atomic
context, since both the kmalloc() call and the memremap() call may
sleep.

The kmalloc() call is easy enough to fix, but the memremap() call
needs to be moved into an init hook since we cannot control the
memory allocation behavior of memremap() at the call site.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.17.1


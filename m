Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F77C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F184B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7DUpP4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F184B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKXIh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:37:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52734 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeKXIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:37:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so12984099wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 13:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W51HG0Lxfj8hmeAjp5UD3KHRJNXkfwyS/LGkmmGi2iw=;
        b=Q7DUpP4maIDsTi3GnnRS5E0x8eGYjYHwlLQmg9fJ2ATPxPm09TeY8Vah7t3U83GEEW
         0tkL+iy5yWupXcaz7hN8WSZr1Iy3aR+qNuVpXCu+jXHlMwtGtj/SBrD/l1h8WZDMCMJF
         qs/UVXbW6diIH/48kbhPHXP9CY5Hu05lWmYEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W51HG0Lxfj8hmeAjp5UD3KHRJNXkfwyS/LGkmmGi2iw=;
        b=CkX+sOVADGpSqg4e4XqwyJ5y2VS+ervBJAwyRUZApWREpf8xiiFvBXO/eu7Iyb+uqf
         e1GWxTB76LNJsXowB+IayqCFQhon4D8OAC6wPf/BfjjdYI/gtn3oUDLZW97ZtRAI5bBJ
         hH34JOl1UtWWAiThLZF0/tn5aq+tdPdfHFNNX9YgFrrxH4NZzy2p9e4aPx/RJ/Y0gDZC
         4iypZwU4805pIF+vV8de2V0IMBZaz9JynGZ/IlHLeZtvfR1PsSMsKlj6Ve1do1eTpkCL
         gf3LKrOWwHUPZJX7uSckxSktGaruRR/wMwSPZP+1HbL24nK2lRq240c/cbJCn+xE7U9T
         anng==
X-Gm-Message-State: AA+aEWapeq6YRIqoh8R+pOn5Y2Je52w+d79QSNwbp192hZ+JmP0YUCtU
        k56EfpdoklS5BtjN4sLRyjRhoA==
X-Google-Smtp-Source: AFSGD/WDzMBOLkuR+ojg5sj1exCOfGwZLoFhi4EI0NQJxOJYUYk+OTouYqBwqa5lKAXLYQWe1Bvg0w==
X-Received: by 2002:a1c:110b:: with SMTP id 11mr14956485wmr.83.1543009914392;
        Fri, 23 Nov 2018 13:51:54 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:6913:f64b:5e59:5ba5])
        by smtp.gmail.com with ESMTPSA id z12sm14529178wrh.35.2018.11.23.13.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 13:51:53 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] efi: prevent GICv3 WARN() by mapping memreserve table before first use
Date:   Fri, 23 Nov 2018 22:51:32 +0100
Message-Id: <20181123215132.7951-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123215132.7951-1-ard.biesheuvel@linaro.org>
References: <20181123215132.7951-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping the MEMRESERVE EFI configuration table from an early initcall
is too late: the GICv3 ITS code that creates persistent reservations
for the boot CPU's LPI tables is invoked from init_IRQ(), which runs
much earlier than the handling of the initcalls. This results in a
WARN() splat because the LPI tables cannot be reserved persistently,
which will result in silent memory corruption after a kexec reboot.

So instead, invoke the initialization performed by the initcall from
efi_mem_reserve_persistent() itself as well, but keep the initcall so
that the init is guaranteed to have been called before SMP boot.

Fixes: 63eb322d89c8 ("efi: Permit calling efi_mem_reserve_persistent() ...")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Jan Glauber <jglauber@cavium.com>
Tested-by: John Garry <john.garry@huawei.com>
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
-- 
2.19.1


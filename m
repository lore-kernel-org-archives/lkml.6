Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF9ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8FE20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yip7eRnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8FE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeKIDl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:41:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39414 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeKIDl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:41:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so22242672wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfIX9iEACWNMz8bi3SaGHe0/ZcpEQEQ5sjogqCaKPQc=;
        b=Yip7eRnOLlLQEF7ZU4z6209Jqz6gMnpNLfInKPLrlZJy9pdV2f2jem15HOEAffxpjN
         8A5FmJd9GUhgpCqAeHRhl3ZCWBbXlsCgfnls9ZCL9JgmZfQuaJRRjZN5S/Fnbjdkyqjc
         PZRwXjg25SinSdQwtKzwSkDqwvWV3Lj4011VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfIX9iEACWNMz8bi3SaGHe0/ZcpEQEQ5sjogqCaKPQc=;
        b=hPowVRuZv87xwImtrflREdC6oJOtl60PdGaNGPeFPqXGMx43Z0/N35VsTwU0mwrX8+
         Q+wtnwxakA8Y18LJekWNpFQH14uguevYVmYbT9daK4RSsF8VkesEyooNBrrXVrayXetg
         5jm7uvL7uaC+Sr+W0DdtkXSazwMo/o8wIdhvz8Or1mhIGP4ACVVlNNxTg/wSutxQZXns
         /6sBnwyr74WyQC5CkhYYs57UFmn4Cpxhz+J8kNOm3e75m/+7DDbw5seUYzZFm8Kwh5tl
         kqhVS1Q2fwz74Cv6udJlsRY8zlprz8gsojMQhldLtIen6QYqvLydTnsvqUOkLp3j9AV+
         R0Ew==
X-Gm-Message-State: AGRZ1gLTRdxcalRVD1u7NjU4j0zSVaPqnTBbiI8EqGmogx55mdzTXrV/
        LOhypEMNEBSvu+lK1ZMFdxePIw==
X-Google-Smtp-Source: AJdET5cZah7SML2Xhfux1z2lM4JXvHVCmTcuUx1MQnsF4mO0XIolwML3ZHaZJoNp68f6R7TaybXiAA==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr4893245wrq.86.1541700317376;
        Thu, 08 Nov 2018 10:05:17 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:744a:cf78:9aaa:a66d])
        by smtp.gmail.com with ESMTPSA id m16-v6sm6792902wmd.35.2018.11.08.10.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 10:05:16 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, cai@gmx.us,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, will.deacon@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] efi: permit calling efi_mem_reserve_persistent from atomic context
Date:   Thu,  8 Nov 2018 19:05:11 +0100
Message-Id: <20181108180511.30239-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 249eb70691b0..cfc876e0b67b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -963,36 +963,43 @@ bool efi_is_table_address(unsigned long phys_addr)
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
2.19.1


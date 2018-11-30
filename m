Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A86C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69E92081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4tgf/gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69E92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeK3R3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:29:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK3R3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:29:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so910044wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Kna3U93ZB3oSHU40ihrZKqox5X7cZSwqAaMfGNEbP74=;
        b=L4tgf/gwIvadaAd20MptzhTRvpe5H8y9RKwJuu9H34skmHIr8vFEB56Dr6CR1auHSH
         HOFhXfhmPAwzweJfw0SPVdXeVhBx/+p9yKSI5bg8JoxMgELlL6LX8P+p/YyJhjfjSpSs
         v0Hia1J6w5yJOeguWcGsc+jyriOONyOQZASFKttSWP66A+wjmWWgzO8AK8s92NHFn5/K
         NMKsCrmLT8u2TMXbHKN6h4qxyJZwOmLIELdnW+LQPR5F1gPGgR++O7QlMueAiR8NmVFN
         Xyw6xKL2CudT71XDobq6HEejoEhJ2Dh6WIsKRnThgy+nyrA5lOgRrNT2y3l1lZJ8o4M1
         hYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Kna3U93ZB3oSHU40ihrZKqox5X7cZSwqAaMfGNEbP74=;
        b=DvY6+LuBQJp9oMExOsyibyVolwNWaU5qGftmuA9uI3McuxY9gypYocHqJ2rC7l+CDO
         AR2Awery0xvJKDy4WIFjiAO3/0XsjVYR7rfGxSzgFqkupmAb4WoCwUOnq6Np9dca1x6o
         cIlbMQ4K2v57xo4vu5P4eoNsfRVaQj0CFendUcBQ3dgCr7vrDP0Qecy2tlHDU2Ttwjo7
         nE0250bnZjC46sG0WglV3LIelMr6mbjqriSyuke5wRRwRwDzbHC4EFvcdIFzYaQYIt6w
         yeA6KJ4qf4L+MONNHudPoua6Y1qjcILoIY9iyzKDI/y+y06fdO9TFS0VfdOPEi90HKxn
         H6Xg==
X-Gm-Message-State: AA+aEWYSJxU4cBtOLmuuO/MgFnO0bDd3mPz62nVklIPcVD1I2W8v+Dz4
        NV/SZJY61w155vUINIqzOhK1TKfg
X-Google-Smtp-Source: AFSGD/XoErT/F0e7rWLX17QXmX9OJ5qcgy2CoMt1SAS9me1/7pYuy7OOyTBSI7Og6ZyEsRLF5YhkEA==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr4126548wmb.30.1543558865193;
        Thu, 29 Nov 2018 22:21:05 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v6sm4620872wro.57.2018.11.29.22.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 22:21:04 -0800 (PST)
Date:   Fri, 30 Nov 2018 07:21:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fix
Message-ID: <20181130062102.GA51809@gmail.com>
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

   # HEAD: 976b489120cdab2b1b3a41ffa14661db43d58190 efi: Prevent GICv3 WARN() by mapping the memreserve table before first use

An arm64 warning fix.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      efi: Prevent GICv3 WARN() by mapping the memreserve table before first use


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

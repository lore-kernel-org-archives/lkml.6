Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1BBC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593292087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Zgngd4Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfAGQLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:11:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40355 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfAGQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:11:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so353320plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZaKrDnHRaJTR4IomjvSGKZD1Tygses0EL569fMSHM94=;
        b=Zgngd4Gp1H53m2Qe2zWQk2wO398PgVsT+ZHTKDh2XRITX1i06Er7yGFYAiP+zpw5FU
         Q/Kh0e6hxjZoyhW2SaLvccSWEkEcqSvbtNgL5kAOkOLiDZJJzqjrCoMwisjTvCo/SEkg
         FdXFLX0HKo2GPFosJVUGacQgbw1M77h9a5nj8L7OJlt0g7+oz++zZM8Z8XU4EIOx4jVB
         dP6sCPCe2aaGQOw8o2TeT4ckoUeG4rRDT/hHO4vfyfLW7VbtpxhIYm3tN6bHymNdufd7
         XIxAUFy3gI9QLnGPsHGmZAcp0qtdGaayFfgv9f66X1htuvACphEbwLW89litgLS9Rzuy
         /kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZaKrDnHRaJTR4IomjvSGKZD1Tygses0EL569fMSHM94=;
        b=TjyID1UbpnWULMVtiVRQ4xxfqNzMyNJo2MPh28bnZ9WhCW+Ab/drNZN9DHTJ5LIxnV
         k2U/Sw5hzVVsUOjvuYE9QfAeEHO6q6enXV1mv3Qf4WGmI8EPm4TqjgGVM/sUrSMWZgDw
         0qPmdR6/BdRC5CeC8SNv9X0kN4N9RngjdSpXAtX54oj5JgRntedTybHPx6uATPY+d5nZ
         Tg8paNMAgeZQGn4MMDmGgHh+FZqA0ScIFJpdr6JVFagXIOQozcripAacIXI5P0mue9Gx
         Dr+meYcUXKreg/LaQngxcSRKbVIcbORaS/+xsWqGAPR9Tax+DYJ3nKzFxxjrpqOMOeG9
         ph5Q==
X-Gm-Message-State: AJcUukeXFAighenrBF/NFnhgENiioiid2OrSb2mBW/LN9TOtejTDHAhm
        8rqEphKbrXb3aroxrxI7n6PZKA==
X-Google-Smtp-Source: ALg8bN6j4G8Z+93Wuqw2y7pZioxENiinBLcR0tTRLcPEkAa/SDw2F7eM50llrZ7maSEFpoYcWvt3ZQ==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr62838655plt.106.1546877473820;
        Mon, 07 Jan 2019 08:11:13 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.214])
        by smtp.gmail.com with ESMTPSA id a10sm93243512pfi.138.2019.01.07.08.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:11:13 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 1/5] RISC-V: Move free_initrd_mem() to kernel/setup.c
Date:   Mon,  7 Jan 2019 21:40:43 +0530
Message-Id: <20190107161047.10516-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107161047.10516-1-anup@brainfault.org>
References: <20190107161047.10516-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

We move free_initrd_mem() to kernel/setup.c so that all initrd
related functions are in one place.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/setup.c | 4 ++++
 arch/riscv/mm/init.c      | 7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index fc8006a042eb..64646d0b4d53 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -96,6 +96,10 @@ static void __init setup_initrd(void)
 	initrd_start = 0;
 	initrd_end = 0;
 }
+
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1d9bfaff60bc..f354486f9b78 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
-#include <linux/initrd.h>
 #include <linux/swap.h>
 #include <linux/sizes.h>
 
@@ -63,9 +62,3 @@ void free_initmem(void)
 {
 	free_initmem_default(0);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
-- 
2.17.1


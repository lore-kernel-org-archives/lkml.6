Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E300720C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Snk1cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E300720C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeHVNTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:19:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43155 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeHVNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:19:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so688315pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxGVGj0JUmnI5zJN3wDw2g+ZjPDsQRcTLZy5X8SjOlQ=;
        b=N8Snk1czgjI4TwkGmJSijYZlwr0cjMcjegJL65iMLfVMdcaQwiR2gdkdak4Ou4+UDF
         zUXss+Ky9IOtCY11N57+rIcI17iY/gqHLNQD0DyXuVl1ez1/7VJnql2+GIYxuzNdklQ2
         oFlN9LiYelipCwJ2c/tc/hfzsDJNZrlPrGZL2KsImI+roiIWPQlsFVWWRjHzOHTS6zUZ
         imGQVzBkSM0h0SYZIUNRnrrMMaHVItwvstSDesKcSr4K6Pkci77rrbLckVolGcFJc+7R
         tETBscm9B6GhjLuyN4+MWUkwTIEzFYzZtiUgeVmE6HdDVEDWeI1CDKCHscWKYWNYwgeH
         0qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bxGVGj0JUmnI5zJN3wDw2g+ZjPDsQRcTLZy5X8SjOlQ=;
        b=KCFkj/hpjjzlkTufZBs3YUx0uicZIImqLYZIpsNx+ImGpVrVG1T5C5+BtHQqMTM8bz
         4ebpsF4v5++cfq+puL882f42B2SUKvp+hIZNObArS0QTRybZLbIfwk0XNo+cfhTclhRc
         c5x5Vn66wR7n4oEavQqPsC5AnpawiiQv/eYUeBiaSqAPDuWr9SdrixdeQDoSgENlTv6n
         ue5fTcHGSHgiDXny3mp33C/Q3kRtGalvognMnsftJXoLB7uEVy1SBPu511f3lkC9+TeY
         v43TtTFPU51WPgIm9B3/uljoqNJc4vUypQXkk56R2zdC9nYd1TU+USO2WBc66EnxYAJm
         P3VA==
X-Gm-Message-State: AOUpUlFOWOj46W93SXVEybCfDSAK9Bz0E9gsKGh9cfV9nmq7Hsmy5sAF
        P7u8aDBan0lG6YuXec7JfM0cvCK7
X-Google-Smtp-Source: AA+uWPwfzp5traUUybQuKMK1Z2qcsZJvd84/7Q+GGoZ2M9oedXpgdTBeLYHDBoZI1NFjUDsf6N15BQ==
X-Received: by 2002:a63:e841:: with SMTP id a1-v6mr24363555pgk.126.1534931695873;
        Wed, 22 Aug 2018 02:54:55 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id z20-v6sm3126105pfd.99.2018.08.22.02.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:55 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 6/6] arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.
Date:   Wed, 22 Aug 2018 17:54:32 +0800
Message-Id: <20180822095432.12125-7-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the idmap_pg_dir/tramp_pg_dir/reserved_ttbr0/swapper_pg_dir to
the rodata section. When the kernel is initialized, the
idmap_pg_dir, tramp_pg_dir and reserved_ttbr0 will not change. And
it's safe to move them to rodata section.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2446911f4262..142528a23b44 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -64,8 +64,13 @@ jiffies = jiffies_64;
 	*(.entry.tramp.text)				\
 	. = ALIGN(PAGE_SIZE);				\
 	__entry_tramp_text_end = .;
+
+#define TRAMP_PG_TABLE					\
+	tramp_pg_dir = .;				\
+	. += PAGE_SIZE;
 #else
 #define TRAMP_TEXT
+#define TRAMP_PG_TABLE
 #endif
 
 #define INIT_PG_TABLES					\
@@ -74,6 +79,24 @@ jiffies = jiffies_64;
 	. += SWAPPER_DIR_SIZE;                          \
 	init_pg_end = .;
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+#define RESERVED_PG_TABLE				\
+	reserved_ttbr0 = .;				\
+	. += RESERVED_TTBR0_SIZE;
+#else
+#define RESERVED_PG_TABLE
+#endif
+
+#define KERNEL_PG_TABLES				\
+	. = ALIGN(PAGE_SIZE);                           \
+	idmap_pg_dir = .;				\
+	. += IDMAP_DIR_SIZE;				\
+	TRAMP_PG_TABLE					\
+	RESERVED_PG_TABLE				\
+	swapper_pg_dir = .;				\
+	. += PAGE_SIZE;					\
+	swapper_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -143,6 +166,7 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
 	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
 	NOTES
+	KERNEL_PG_TABLES
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
@@ -224,21 +248,6 @@ SECTIONS
 	BSS_SECTION(0, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
-#ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
-#endif
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
-- 
2.17.1


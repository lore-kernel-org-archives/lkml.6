Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C808EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7993321480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV7ELI3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7993321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeHVNS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:18:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36095 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeHVNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:18:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17-v6so702049pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nGermj8+sJwPauBc9HZkgjRIgnvyjhqzrkyWK3pSIV0=;
        b=rV7ELI3trNOJJ+Usz+AKPNLYCZ79i7porRjGkA4rLCAKvWNjgTyhFP9C468f4z0gqS
         vHdP4+ZD1ogDBsjIZhZm5c9Br4R4AeLCBDfOFRy/9Golsk976H+fysrAp+CHdD7mC3Ap
         UFGHJ6/1n9WvY4eLc0TQ3uOInk3jLgFvucd9WQljg8HMvqaHC7X4NpPDOfxfvprBHiP/
         0629ETb4y1CKTxT0nbskyPmX0GFTKGDF4R/Ydlc0MpKr+pQw9i6piy3OvC32bKz+2YLj
         t/5OgsWL3cRucmn9FkJHky9uHzb0LD9WmuOJPUYt0r4KqGrX1asE77ViLPMXm6nm31Pz
         v4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nGermj8+sJwPauBc9HZkgjRIgnvyjhqzrkyWK3pSIV0=;
        b=QCWTOws1dxA3Jejso5D7COBz68qGr3HXKh+qAVU5df0T3swlidyYDmMvFXujUanNhy
         It79UTOKpNbn4X0TSyAKpKLZKUKz/bdrjPUiwNaHnjWzE/tPq7vmlaVpfQyuIAY69lHS
         MPFCVxnTT3mcjHMTMaqiKFkwmPcvDJVeu/+5/m20QtpYA1ySZwZic1gaY6vmgDns1coB
         VFPbC+cc9Asuq5kEppNvhnVahqXEhujfTRtuGKtCXL+fCxf4LF3XYKarVCrMTftokROe
         538H6lzdx5zAYoe1+uMSc9cLIKnnikPzQ9qAScbcbx+fPN1WjW7RUURzK4sPp8hK0Fq3
         X5pQ==
X-Gm-Message-State: AOUpUlEJgaxIvlOBvEFBBnzKapFdIjv8MT2+7KxGyNr9nAHM27opN0dI
        Ie18/48ad8LSDbz3FGOi1+U=
X-Google-Smtp-Source: AA+uWPz+1CgboKZ5x/OxT/pWO6AObRXZlcuEFTXtD9NZIoEFEZvMC5jaXm/YBG/E6KvKahVhwiBfXg==
X-Received: by 2002:a62:be03:: with SMTP id l3-v6mr57028772pff.138.1534931685096;
        Wed, 22 Aug 2018 02:54:45 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id z20-v6sm3126105pfd.99.2018.08.22.02.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:44 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 1/6] arm64/mm: Introduce the init_pg_dir.
Date:   Wed, 22 Aug 2018 17:54:27 +0800
Message-Id: <20180822095432.12125-2-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the swapper_pg_dir read only, we will move it to the rodata
section. And force the kernel to set up the initial page table in
the init_pg_dir. After generating all levels page table, we copy
only the top level into the swapper_pg_dir during paging_init().

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 22 +++++++++++++++-------
 arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..eb363a915c0e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -456,6 +456,35 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	b.ne	9998b
 	.endm
 
+/*
+ * clear_page - clear one page
+ *
+ *	start:	page aligned virtual address
+ */
+	.macro clear_page, start:req
+9996:	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	tst	\start, #(PAGE_SIZE - 1)
+	b.ne	9996b
+	.endm
+
+/*
+ * clear_pages - clear contiguous pages
+ *
+ *	start, end: page aligend virtual addresses
+ */
+	.macro clear_pages, start:req, end:req
+	sub	\end, \end, \start
+	lsr	\end, \end, #(PAGE_SHIFT)
+9997:	cbz	\end, 9998f
+	clear_page \start
+	sub	\end, \end, #1
+	b	9997b
+9998:
+	.endm
+
 /*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..2c83a8c47e3f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -295,18 +295,21 @@ __create_page_tables:
 	sub	x1, x1, x0
 	bl	__inval_dcache_area
 
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+	bl	__inval_dcache_area
+
 	/*
 	 * Clear the idmap and swapper page tables.
 	 */
 	adrp	x0, idmap_pg_dir
 	adrp	x1, swapper_pg_end
-	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
+	clear_pages x0, x1
+
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	clear_pages x0, x1
 
 	mov	x7, SWAPPER_MM_MMUFLAGS
 
@@ -395,6 +398,11 @@ __create_page_tables:
 	dmb	sy
 	bl	__inval_dcache_area
 
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+	bl	__inval_dcache_area
+
 	ret	x28
 ENDPROC(__create_page_tables)
 	.ltorg
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 605d1b60469c..61d7cee3eaa6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -68,6 +68,12 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define INIT_PG_TABLES					\
+	. = ALIGN(PAGE_SIZE);                           \
+	init_pg_dir = .;                                \
+	. += SWAPPER_DIR_SIZE;                          \
+	init_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -161,6 +167,8 @@ SECTIONS
 	__inittext_end = .;
 	__initdata_begin = .;
 
+	INIT_PG_TABLES
+
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
-- 
2.17.1


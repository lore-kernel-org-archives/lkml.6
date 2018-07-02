Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F684C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FE2205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToF0cPYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FE2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965633AbeGBLSg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:18:36 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38320 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeGBLRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:17:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id d10-v6so7802751plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcw1PlOv/9gyu/Mnq84/eHJ9RxrRgO90E2yNOi4lvt4=;
        b=ToF0cPYMxwJltyjXw44wEdd4TxyFpJA6nNlmRfAitJDr+OKMl7DggtjQL5tpdwFpqs
         Nz2uA69fuiLgZpAT4U9tHlNYhTHKUBhglGajaj8uJkxRwtEnwloaWNiDpzriZkXRLrBc
         eMWA2iBgSJKR6gkrS+ZIo6VDJQwamlcPR4Z6uLWrGDeXtaK7EIe1YVcxRqHou25MP5lz
         B4gOnyG49IKxAEJ4lkrVju1XD29W8O/j0edtuE50OiNo3xT48C7IKsxgJqIL+lNPvrZ5
         81FPI1tbA06cfNZ8J2/IzON+VEgRw3IUYlAnuHLv3qKSxohAqRkiLupwMCs4xxgucD2e
         bEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hcw1PlOv/9gyu/Mnq84/eHJ9RxrRgO90E2yNOi4lvt4=;
        b=NWmkC+VxCJMCjZUudEI1tNOiB9S3iWdGpCBFieFgc4qDG9nlVr+LHa7qkUBEdyM30w
         iDp0NbltN17txKcS+V0gCFVX49qkohudyp+MHEaOW8FzKOMlst+0PHmO2P5uAxknIonm
         VmLDtegHCqN7osp5vne7gt1Bh3nvW9uF296mSKNHC4zIYDv03Tou8QkzTdmNCXmvsjLg
         jp6bYhDbuPlbiYkGqK4EpU/RheUNAQAbY1KZ4pWU4mJUcsFdqo1upiyWm8lOjSnEOPv4
         /NEa/vdfUOP9TcBRrJhw1fqPlxmsubsES+QGQP/GX7FeTAZwOD0/JpypWUVe19VkeA1l
         stAw==
X-Gm-Message-State: APt69E3iAcQIR5Hgm5DxApYzEZ9ZoEeF1k3Fe7dCmIJ17HPb0Yvd2CGf
        RN0uJeBexJchzRzM7+1fX2k=
X-Google-Smtp-Source: ADUXVKKWAxWVw/5o0HpR8bRsTPphnZv9l6ScGPZTUchJJooiUb8UwLlV0A08jCLg318uvl21VBNpFg==
X-Received: by 2002:a17:902:6f02:: with SMTP id w2-v6mr24895831plk.216.1530530251301;
        Mon, 02 Jul 2018 04:17:31 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id s2-v6sm11262150pfh.186.2018.07.02.04.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:17:30 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] arm64/mm: Make __enable_mmu() take the ttbr1 page as an argument
Date:   Mon,  2 Jul 2018 19:16:56 +0800
Message-Id: <20180702111659.25570-3-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702111659.25570-1-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __enable_mmu() take the physical address of the ttbr1 page as
an argument.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/head.S  | 5 ++++-
 arch/arm64/kernel/sleep.S | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3f99c59ba193..a1c7a4d3b9f3 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -718,6 +718,7 @@ secondary_startup:
 	 * Common entry point for secondary CPUs.
 	 */
 	bl	__cpu_setup			// initialise processor
+	adrp	x26, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =__secondary_switched
 	br	x8
@@ -760,6 +761,7 @@ ENDPROC(__secondary_switched)
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
+ *  x26 = TTBR1_EL1 value for turning on the MMU.
  *
  * Returns to the caller via x30/lr. This requires the caller to be covered
  * by the .idmap.text section.
@@ -774,7 +776,7 @@ ENTRY(__enable_mmu)
 	b.ne	__no_granule_support
 	update_early_cpu_boot_status 0, x1, x2
 	adrp	x1, idmap_pg_dir
-	adrp	x2, swapper_pg_dir
+	mov	x2, x26
 	phys_to_ttbr x3, x1
 	phys_to_ttbr x4, x2
 	msr	ttbr0_el1, x3			// load TTBR0
@@ -835,6 +837,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
+	adrp	x26, swapper_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index bebec8ef9372..3f2c7bf67a2c 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -101,6 +101,7 @@ ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
+	adrp	x26, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
-- 
2.17.1


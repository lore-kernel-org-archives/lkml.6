Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607A420842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498070;
	bh=cZEjMsv0a9fBzHaLUek698UUgzFvP3U3VV3rbi7ffH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jA2bSebtppIs5zJ3Ry2Trqc2nS2PelKna1VO0tiRYLFJbt+CcnfOqM/ngs6s1jFP6
	 wnnjizChBG3O3xLwsBmxfKWbB/Zm5BSmV3c6l3xvz/h/NQ5DkKcoek+rnLSdL1mZok
	 k1J6gKeMMI0clxUxlAfWfXXhKBRQ93WLuuCQXgK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbfBRNy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733176AbfBRNyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:54:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7D920842;
        Mon, 18 Feb 2019 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498064;
        bh=cZEjMsv0a9fBzHaLUek698UUgzFvP3U3VV3rbi7ffH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVO9oBzp5Ic6T88GU+KnS7VYji4gmMPTYWtH6QS0IheEFUZ9/5/ehlpMGAVFVJ1J2
         VGgcpIqvIRBkJfdAHgFd5fxk5BgoC+4nwrWpRiiKorOWm3mpNrTcHtN9GO/WMMlmJS
         3VqZbCZvnIE1iaVtEfqkbmFQqMI2LbgwX0Iegb+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/62] ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
Date:   Mon, 18 Feb 2019 14:43:18 +0100
Message-Id: <20190218133506.884592404@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit afaf6838f4bc896a711180b702b388b8cfa638fc upstream.

Introduce C and asm helpers to sanitize user address, taking the
address range they target into account.

Use asm helper for existing sanitization in __copy_from_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/assembler.h | 11 +++++++++++
 arch/arm/include/asm/uaccess.h   | 26 ++++++++++++++++++++++++++
 arch/arm/lib/copy_from_user.S    |  6 +-----
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index b17ee03d280b..88286dd483ff 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -467,6 +467,17 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+	.macro uaccess_mask_range_ptr, addr:req, size:req, limit:req, tmp:req
+#ifdef CONFIG_CPU_SPECTRE
+	sub	\tmp, \limit, #1
+	subs	\tmp, \tmp, \addr	@ tmp = limit - 1 - addr
+	addhs	\tmp, \tmp, #1		@ if (tmp >= 0) {
+	subhss	\tmp, \tmp, \size	@ tmp = limit - (addr + size) }
+	movlo	\addr, #0		@ if (tmp < 0) addr = NULL
+	csdb
+#endif
+	.endm
+
 	.macro	uaccess_disable, tmp, isb=1
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index cf50b030c62c..a5807b67ca8a 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -99,6 +99,32 @@ static inline void set_fs(mm_segment_t fs)
 #define __inttype(x) \
 	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
+/*
+ * Sanitise a uaccess pointer such that it becomes NULL if addr+size
+ * is above the current addr_limit.
+ */
+#define uaccess_mask_range_ptr(ptr, size)			\
+	((__typeof__(ptr))__uaccess_mask_range_ptr(ptr, size))
+static inline void __user *__uaccess_mask_range_ptr(const void __user *ptr,
+						    size_t size)
+{
+	void __user *safe_ptr = (void __user *)ptr;
+	unsigned long tmp;
+
+	asm volatile(
+	"	sub	%1, %3, #1\n"
+	"	subs	%1, %1, %0\n"
+	"	addhs	%1, %1, #1\n"
+	"	subhss	%1, %1, %2\n"
+	"	movlo	%0, #0\n"
+	: "+r" (safe_ptr), "=&r" (tmp)
+	: "r" (size), "r" (current_thread_info()->addr_limit)
+	: "cc");
+
+	csdb();
+	return safe_ptr;
+}
+
 /*
  * Single-value transfer routines.  They automatically use the right
  * size if we just have the right pointer type.  Note that the functions
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index a826df3d3814..6709a8d33963 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -93,11 +93,7 @@ ENTRY(arm_copy_from_user)
 #ifdef CONFIG_CPU_SPECTRE
 	get_thread_info r3
 	ldr	r3, [r3, #TI_ADDR_LIMIT]
-	adds	ip, r1, r2	@ ip=addr+size
-	sub	r3, r3, #1	@ addr_limit - 1
-	cmpcc	ip, r3		@ if (addr+size > addr_limit - 1)
-	movcs	r1, #0		@ addr = NULL
-	csdb
+	uaccess_mask_range_ptr r1, r2, r3, ip
 #endif
 
 #include "copy_template.S"
-- 
2.19.1




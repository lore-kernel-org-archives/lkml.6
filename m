Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8A8C468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7554720C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Z8rwWKqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7554720C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeGLILq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:11:46 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56386 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeGLILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:11:45 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w6C81cQi012716;
        Thu, 12 Jul 2018 17:01:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w6C81cQi012716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531382503;
        bh=xh77N21cq8p0dbTYcvt3+FJe0KgbUffxhLCzpU9y6ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8rwWKqhSGSawIXHARLwPA0P4ud6nBlM4NlLIGlQqFDlb7nKte6tIj6aFwg8Kc0SU
         GX9yGXCsvOHpVm5/Q4Dm8btptn/p8WDgb6GPpFSEexSr3II22eilNtC6UB2WHqV3MK
         UiEIr0Unx7shhHkedRclR+nTus8FN6+HdVWQTkJL1axweHK3eSUpuiIKPhss2Sx4Ve
         cMCnzvRrnGGAZVnw4e1OF6MuW/sSm2mtGv6F/LutHf5WVAUr+aSqt6aeXMZhSl5CCF
         gtwabutoyTyfxeB1fV68WEofZU4GHomIDdXQpLPTL0wusXuObSfuqcp/fPmnlGlUMg
         AW0hkYLZqRe2g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/6] kbuild: remove redundant LDFLAGS clearing in arch/*/Makefile
Date:   Thu, 12 Jul 2018 17:01:33 +0900
Message-Id: <1531382496-3719-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ce99d0bf312d ("kbuild: clear LDFLAGS in the top Makefile"),
the top-level Makefile caters to this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Makefile      | 3 ---
 arch/openrisc/Makefile | 1 -
 arch/riscv/Makefile    | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 62ebeae..e7d703d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,9 +10,6 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-# Ensure linker flags are correct
-LDFLAGS		:=
-
 LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 89076a6..70e06d3 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -19,7 +19,6 @@
 
 KBUILD_DEFCONFIG := or1ksim_defconfig
 
-LDFLAGS         :=
 OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=
 LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6d4a5f6c..2627e48 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -8,7 +8,6 @@
 # for more details.
 #
 
-LDFLAGS         :=
 OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux :=
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
-- 
2.7.4


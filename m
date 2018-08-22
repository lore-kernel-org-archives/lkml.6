Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DF7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D07214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GN5tIjY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D07214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeHVRQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:16:53 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:40546 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbeHVRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:16:53 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w7MDpROF020754;
        Wed, 22 Aug 2018 22:51:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w7MDpROF020754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534945888;
        bh=71T7VEr8TWf5H7TaCdI/1IrR0dzQDsooywK1qEO+Fv4=;
        h=From:To:Cc:Subject:Date:From;
        b=GN5tIjY9dyVnznvHNOH4GjvEjX8SFcTrKN0Sm6BaTjLxOOvtZZGG8KxIfBo1G0PwQ
         NkFZlCfET5iA/EDG8xVrxfWjQ6UbgIW5vm1sN71avVG9GJjo59z5CRyEuAWakm24eF
         YNbpECGUfT2ELIZHZCUjqMjEg7tqkRw7iOdmFOKOyTCVQ4PEJpG7Hxdgbdm5XHX255
         gIhxYvXeMb9olB0Zd6qeM+S32z1sguzGFRJsDj/wHBiDyohpr7Fbmjv8FgzmrUBRbf
         jA/nl0dWKmqYASN9l1vN9oX7ZECYExqea98cyS1g2ExHyCprF1k/I5U2OR4lPIXECh
         xlr4os71mDEBQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: test dead code/data elimination support in Kconfig
Date:   Wed, 22 Aug 2018 22:51:09 +0900
Message-Id: <1534945869-17117-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This config option should be enabled only when both the compiler and
the linker support necessary flags.  Add proper dependencies to Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile     | 8 ++------
 init/Kconfig | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 1289a01..2e2b009 100644
--- a/Makefile
+++ b/Makefile
@@ -790,8 +790,8 @@ KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-ffunction-sections,)
-KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-fdata-sections,)
+KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
+LDFLAGS_vmlinux += --gc-sections
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
@@ -857,10 +857,6 @@ LDFLAGS_BUILD_ID := $(call ld-option, --build-id)
 KBUILD_LDFLAGS_MODULE += $(LDFLAGS_BUILD_ID)
 LDFLAGS_vmlinux += $(LDFLAGS_BUILD_ID)
 
-ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-LDFLAGS_vmlinux	+= $(call ld-option, --gc-sections,)
-endif
-
 ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+= $(call ld-option, -X,)
 endif
diff --git a/init/Kconfig b/init/Kconfig
index 9bd50ba..21b8559 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1085,6 +1085,8 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	bool "Dead code and data elimination (EXPERIMENTAL)"
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	depends on EXPERT
+	depends on $(cc-option,-ffunction-sections -fdata-sections)
+	depends on $(ld-option,--gc-sections)
 	help
 	  Enable this if you want to do dead code and data elimination with
 	  the linker by compiling with -ffunction-sections -fdata-sections,
-- 
2.7.4


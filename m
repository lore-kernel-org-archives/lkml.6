Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A29F2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nsZ3SG07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A29F2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeHXMMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:12:02 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:19953 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeHXMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:12:02 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w7O8Xx37003689;
        Fri, 24 Aug 2018 17:33:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w7O8Xx37003689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535099640;
        bh=6OsoEPd0b5FwNp/w3Nb3ajYja/2+3jHAz6i2lUnqawI=;
        h=From:To:Cc:Subject:Date:From;
        b=nsZ3SG07JLB/R7MkKqR8yzYWnPgYopy8s09ZVJK9Kb9BSSyYXkgm2+3wl4GHHF3bl
         6AT2cxkgIEk6Y8+QmuowT/m/EDVMDZ5/TBqgidaucskn5xw3cODlfY9ccoONgr15eZ
         a1U8t2Mhoto5ArwHex2bC4aXPiAWYcBDTGhtsMgGmcHGqI1mjC+EErtp8HFTBaVLOh
         ct2JHDFoxOU1kSopQrFMxdzH+K+//gEzJ6FvKp3EzLu06C9zxjHRrsS4NDkggqvJXt
         ILIr99bhsi4e4IhaOUo78qesyAapx4jX0GIW9+wYuMq5XvIl12WhdNi4SEam0VrCLP
         Kwt1jNKiGXx4A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
Date:   Fri, 24 Aug 2018 17:33:53 +0900
Message-Id: <1535099634-29439-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This becomes much neater in Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/riscv/Kconfig  | 1 +
 arch/riscv/Makefile | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980..ed81df4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -112,6 +112,7 @@ config ARCH_RV32I
 config ARCH_RV64I
 	bool "RV64I"
 	select 64BIT
+	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 61ec424..33700e4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -25,8 +25,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
 
 	KBUILD_CFLAGS += -mabi=lp64
 	KBUILD_AFLAGS += -mabi=lp64
-	
-	KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
 
 	KBUILD_MARCH = rv64im
 	KBUILD_LDFLAGS += -melf64lriscv
-- 
2.7.4


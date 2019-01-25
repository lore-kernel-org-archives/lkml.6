Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F37C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43483218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bJFBt64K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfAYHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:18:42 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:38370 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:18:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0P7ITwf009505;
        Fri, 25 Jan 2019 16:18:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7ITwf009505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548400709;
        bh=XzsxAZHYqTAS12ivpw+HakzvG9opm9+thYMc7c7ckAc=;
        h=From:To:Cc:Subject:Date:From;
        b=bJFBt64Kae1qEdO7lwMdL5hSS0oEK5DJtp5SFkPn3SlLmsXbGUM2DoBIBoSNc6AxC
         xGGc71jnwkkH+q6XygzL52t0/StBBCJPmqjB2vyvRPmfqIJUt0pU5RZ84L/5Et+H+3
         GBy4m/eS1/2XtfxypDIzritPd1XUGqjVuJTs16K3hgq/mCwFZSfw4ZQGubGPFAjoUv
         1tha64TOxHum31Fy4c5RyEOAnZ1RJEsw1KvRzsvVIeTRMWZzAhCOz8gBqA/F1VerrL
         ULKp1cJfACl7JIMW7yj66mhtpHCOPX9wXeoeuabnqX5X1gQD9HJGvjxlKxZ4UZWsd+
         V57uaTugUk9kQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: prefix header search path with $(srctree)/
Date:   Fri, 25 Jan 2019 16:18:23 +0900
Message-Id: <1548400703-27945-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

I removed some header search paths because I was able to build ia64
without them.

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/ia64/sn/kernel/Makefile     | 2 +-
 arch/ia64/sn/kernel/sn2/Makefile | 2 --
 arch/ia64/sn/pci/Makefile        | 2 --
 arch/ia64/sn/pci/pcibr/Makefile  | 2 +-
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/sn/kernel/Makefile b/arch/ia64/sn/kernel/Makefile
index d27df1d..9c349dd 100644
--- a/arch/ia64/sn/kernel/Makefile
+++ b/arch/ia64/sn/kernel/Makefile
@@ -7,7 +7,7 @@
 # Copyright (C) 1999,2001-2006,2008 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
-ccflags-y := -Iarch/ia64/sn/include
+ccflags-y := -I $(srctree)/arch/ia64/sn/include
 
 obj-y				+= setup.o bte.o bte_error.o irq.o mca.o idle.o \
 				   huberror.o io_acpi_init.o io_common.o \
diff --git a/arch/ia64/sn/kernel/sn2/Makefile b/arch/ia64/sn/kernel/sn2/Makefile
index 3d09108..170bde4 100644
--- a/arch/ia64/sn/kernel/sn2/Makefile
+++ b/arch/ia64/sn/kernel/sn2/Makefile
@@ -9,7 +9,5 @@
 # sn2 specific kernel files
 #
 
-ccflags-y := -Iarch/ia64/sn/include
-
 obj-y += cache.o io.o ptc_deadlock.o sn2_smp.o sn_proc_fs.o \
 	 prominfo_proc.o timer.o timer_interrupt.o sn_hwperf.o
diff --git a/arch/ia64/sn/pci/Makefile b/arch/ia64/sn/pci/Makefile
index df2a901..321576b 100644
--- a/arch/ia64/sn/pci/Makefile
+++ b/arch/ia64/sn/pci/Makefile
@@ -7,6 +7,4 @@
 #
 # Makefile for the sn pci general routines.
 
-ccflags-y := -Iarch/ia64/sn/include
-
 obj-y := pci_dma.o tioca_provider.o tioce_provider.o pcibr/
diff --git a/arch/ia64/sn/pci/pcibr/Makefile b/arch/ia64/sn/pci/pcibr/Makefile
index 396bcae..712f6af 100644
--- a/arch/ia64/sn/pci/pcibr/Makefile
+++ b/arch/ia64/sn/pci/pcibr/Makefile
@@ -7,7 +7,7 @@
 #
 # Makefile for the sn2 io routines.
 
-ccflags-y := -Iarch/ia64/sn/include
+ccflags-y := -I $(srctree)/arch/ia64/sn/include
 
 obj-y				+=  pcibr_dma.o pcibr_reg.o \
 				    pcibr_ate.o pcibr_provider.o
-- 
2.7.4


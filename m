Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2077520859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NP5mofy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfAISPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:15:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37204 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfAISPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:15:44 -0500
Received: from zn.tnic (p200300EC2BEA1000C4F2EE9BAD61A815.dip0.t-ipconnect.de [IPv6:2003:ec:2bea:1000:c4f2:ee9b:ad61:a815])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 659DF1EC03E1;
        Wed,  9 Jan 2019 19:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547057742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=df85bnn9uk8ar1nKShxAtMsRY5oBW55molH4uDoEmlw=;
        b=NP5mofy9rDbPWsbtiN0hZyT07kVa9QrpFIAHiu1Edpmn+3wMcaGPx1v39RSYfqodvBfCAN
        4hjyQRuE8T3IFTyr8bGGM2asGC6yCCnn2vR9cQ6OhIqfp/ezBa5ouEBbLhUoldepVpgO0R
        /6xv/J+hE9eFVbNypYiDwjPjswzf5bE=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/build: Use the single-argument OUTPUT_FORMAT() linker script command
Date:   Wed,  9 Jan 2019 19:15:31 +0100
Message-Id: <20190109181531.27513-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The various x86 linker scripts use the three-argument linker script
command variant OUTPUT_FORMAT(DEFAULT, BIG, LITTLE) which specifies
three object file formats when the -EL and -EB linker command line
options are used. When -EB is specified, OUTPUT_FORMAT issues the BIG
object file format, when -EL, LITTLE, respectively, and when neither is
specified, DEFAULT.

However, those -E[LB] options are not used by arch/x86/ so switch to the
simple OUTPUT_FORMAT(BFDNAME) macro variant.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 +-
 arch/x86/boot/setup.ld                 | 2 +-
 arch/x86/kernel/vmlinux.lds.S          | 2 +-
 arch/x86/realmode/rm/realmode.lds.S    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index f491bbde8493..508cfa6828c5 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm-generic/vmlinux.lds.h>
 
-OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT)
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #undef i386
 
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 96a6c7563538..0149e41d42c2 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -3,7 +3,7 @@
  *
  * Linker script for the i386 setup code
  */
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ee3b5c7d662e..bad8c51fee6e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -31,7 +31,7 @@
 
 #undef i386     /* in case the preprocessor is a 32bit one */
 
-OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT)
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #ifdef CONFIG_X86_32
 OUTPUT_ARCH(i386)
diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index df8e11e26bc3..3bb980800c58 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -9,7 +9,7 @@
 
 #undef i386
 
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
 
 SECTIONS
-- 
2.19.1


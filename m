Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB2DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49503214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z6bJuGxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49503214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeKVFpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbeKVFp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49C8214DB;
        Wed, 21 Nov 2018 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827396;
        bh=poCMbXiJrQ4uG9xr6MwaNKcSBltcnDHUhWsLvNnKgo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6bJuGxC2W8t0qWvcIbd6u75WyfxRzSFOP/ZGVMBL6o+3wj/2mR2hKPxNwhryFvw5
         5NkfZ1VQ2oHdrl8pLTuPX5SqpOeTEYu/cqPLNTaxFM4eWw3uHB8HbvTfIJ+8AYQJXC
         mmBs3QfFei8sItZS2V/58wAYLQxTSCZ9Sm66oypk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeroen Hofstee <jeroen@myspectrum.nl>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 14/59] kbuild: fix asm-offset generation to work with clang
Date:   Wed, 21 Nov 2018 20:06:29 +0100
Message-Id: <20181121183508.815711811@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeroen Hofstee <jeroen@myspectrum.nl>

commit cf0c3e68aa81f992b0301f62e341b710d385bf68 upstream.

KBuild abuses the asm statement to write to a file and
clang chokes about these invalid asm statements. Hack it
even more by fooling this is actual valid asm code.

[masahiro:
 Import Jeroen's work for U-Boot:
 http://patchwork.ozlabs.org/patch/375026/
 Tweak sed script a little to avoid garbage '#' for GCC case, like
 #define NR_PAGEFLAGS 23 /* __NR_PAGEFLAGS       # */ ]

Signed-off-by: Jeroen Hofstee <jeroen@myspectrum.nl>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kbuild.h |    6 +++---
 scripts/Makefile.lib   |    8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

--- a/include/linux/kbuild.h
+++ b/include/linux/kbuild.h
@@ -2,14 +2,14 @@
 #define __LINUX_KBUILD_H
 
 #define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
 
-#define BLANK() asm volatile("\n->" : : )
+#define BLANK() asm volatile("\n.ascii \"->\"" : : )
 
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem))
 
 #define COMMENT(x) \
-	asm volatile("\n->#" x)
+	asm volatile("\n.ascii \"->#" x "\"")
 
 #endif
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -413,10 +413,14 @@ cmd_xzmisc = (cat $(filter-out FORCE,$^)
 # ---------------------------------------------------------------------------
 
 # Default sed regexp - multiline due to syntax constraints
+#
+# Use [:space:] because LLVM's integrated assembler inserts <tab> around
+# the .ascii directive whereas GCC keeps the <space> as-is.
 define sed-offsets
-	"/^->/{s:->#\(.*\):/* \1 */:; \
+	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
+	/^->/{s:->#\(.*\):/* \1 */:; \
 	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:->::; p;}"
+	s:->::; p;}'
 endef
 
 # Use filechk to avoid rebuilds when a header changes, but the resulting file



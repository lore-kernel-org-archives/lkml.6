Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59ACC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C22C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C22C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeJKFrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:47:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34070 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKFrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:47:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LMuHKKZiHjwZ; Thu, 11 Oct 2018 00:23:40 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2F771EC0104;
        Thu, 11 Oct 2018 00:23:39 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: Fail the build early when no lz4 present
Date:   Thu, 11 Oct 2018 00:23:33 +0200
Message-Id: <20181010222333.17794-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec057f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

When building randconfigs, the build fails at kernel compression stage
due to missing lz4 on the system but CONFIG_KERNEL_LZ4 has been selected
by randconfig. The result looks somethins like this:

    (cat arch/x86/boot/compressed/vmlinux.bin arch/x86/boot/compressed/vmlinux.relocs | lz4c -l -c1 stdin stdout && printf \334\141\301\001) > arch/x86/boot/compressed/vmlinux.bin.lz4 || (rm -f arch/x86/boot/compressed/vmlinux.bin.lz4 ; false)
  /bin/sh: 1: lz4c: not found
  make[2]: *** [arch/x86/boot/compressed/Makefile:143: arch/x86/boot/compressed/vmlinux.bin.lz4] Error 1
  make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
  make: *** [arch/x86/Makefile:290: bzImage] Error 2

Fail the build much earlier by checking for lz4c presence before doing
anything else.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index a0c32de80482..f91de649234b 100644
--- a/Makefile
+++ b/Makefile
@@ -788,6 +788,12 @@ KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
 endif
 
+ifdef CONFIG_KERNEL_LZ4
+ifeq ($(CONFIG_SHELL which lz4c),)
+$(error "lz4 tool not found on this system but CONFIG_KERNEL_LZ4 enabled")
+endif
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
-- 
2.19.0.271.gfe8321ec057f


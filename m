Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD1F208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pS/nCtT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD1F208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbeGaNTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:19:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6yVJFP9CFx+75YKCgg0hs1FzAPXGLbVNYODUu+7F7cI=; b=pS/nCtT3+/ZsYlMqvbYuFoxeZ
        vTH6p70jbU0KzTMLlf8bi2noYlRHKn9IishEEX333LYMS1Gam2xVr4XKFBxkrqK5VgVv1as12XXiK
        7DiIXQWvRmFE0X61M7xtHENLFo5kddQ6LWEJexNfqnaBdmOGKNulBRsneKdEu42D1HZRREAQttjH4
        l3odPQ7e3V/11BOl3M2Hgv0mpe/80/cmH5HodF/zQfhy4x5LkyQ8E8mwD7rz5w0TUVo14EuvRo7CK
        1IPBjZHF19L7vnQTeBttBKwehhqSVDZ4IWevn2j27BKkre8PIVN3cuj099e+/mktZ+tTZ0HFDUgnp
        NSQNv8TdA==;
Received: from 089144201224.atnat0010.highway.a1.net ([89.144.201.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkT09-0001ID-IR; Tue, 31 Jul 2018 11:39:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] um: stop abusing KBUILD_KCONFIG
Date:   Tue, 31 Jul 2018 13:39:26 +0200
Message-Id: <20180731113935.6105-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead create a arch/um/Kconfig file that just includes the actual
per-arch Kconfig file.  Note that we use HEADER_ARCH to find the
per-arch Kconfig file as that variable already includes the
normalization from i386 or x86_64 to x86.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig     | 3 +++
 arch/um/Makefile    | 4 +---
 arch/x86/um/Kconfig | 5 -----
 3 files changed, 4 insertions(+), 8 deletions(-)
 create mode 100644 arch/um/Kconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
new file mode 100644
index 000000000000..76b4a32c9f42
--- /dev/null
+++ b/arch/um/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+source "arch/$(HEADER_ARCH)/um/Kconfig"
diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8a0363..d427bfc6948f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -113,8 +113,6 @@ define archhelp
   echo '		   find in the kernel root.'
 endef
 
-KBUILD_KCONFIG := $(HOST_DIR)/um/Kconfig
-
 archheaders:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
 	            kbuild-file=$(HOST_DIR)/include/asm/Kbuild \
@@ -176,4 +174,4 @@ endef
 include/generated/user_constants.h: $(HOST_DIR)/um/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-export SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
+export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 9d529f22fd9d..7e509c83d80d 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-mainmenu "User Mode Linux/$(SUBARCH) $(KERNELVERSION) Kernel Configuration"
-
-comment "Compiler: $(CC_VERSION_TEXT)"
-
-source "scripts/Kconfig.include"
 
 source "arch/um/Kconfig.common"
 
-- 
2.18.0


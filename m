Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A28C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEAB208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3w9S9gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEAB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeGHPUK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:20:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbeGHPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kj4jnTgK38R0NfG4nbtNF08jDdRDrbrzHXMx1xpI9UM=; b=k3w9S9gs+AGJ3P4oIsr60CETx
        2cJ954US1XURpVi4qDZpCivKhNJG64h4UoYaB/1djB2hxRbrRr/e0SxTPmrYDd77Bj3OJPJD3wrYy
        rvaKjCw3arr8+TZcBHxb76WMg/EiFrggXOwrBNw6yXgNpqsqGbNx7oBfoUaw3qxLZyaCAgqxWzudS
        mKCBqTcO3XlGgMmpcURlIrZfmqDNrhJpTWOk8ISyvIF+alls2O1HsBxmWXCmCFCkF/SGEdT3zIPsd
        i6kvVNemngRM91Eqo8r57fj6bU9ftn40931NeiVB7S1pZuftzd0l0pntESExKtL5rwL0pxYcmCjMt
        VA1G1gEKA==;
Received: from ip-64-134-140-74.public.wayport.net ([64.134.140.74] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcBTp-0002lm-Lf; Sun, 08 Jul 2018 15:20:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] um: stop abusing KBUILD_KCONFIG
Date:   Sun,  8 Jul 2018 08:19:56 -0700
Message-Id: <20180708152004.21679-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708152004.21679-1-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead create a arch/um/Kconfig file that just includes the actual
per-arch Kconfig file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/Kconfig     | 3 +++
 arch/um/Makefile    | 2 --
 arch/x86/um/Kconfig | 5 -----
 3 files changed, 3 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/Kconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
new file mode 100644
index 000000000000..24607af202dc
--- /dev/null
+++ b/arch/um/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+source "arch/$(SUBARCH)/um/Kconfig"
diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8a0363..0207f6316d71 100644
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


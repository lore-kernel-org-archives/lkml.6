Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79411C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF826A1C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBF826A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935095AbeFZL5Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:57:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32810 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934836AbeFZL5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:57:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04A9620703; Tue, 26 Jun 2018 13:57:21 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D162B203D9;
        Tue, 26 Jun 2018 13:57:20 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/2] mips: generic: allow not building DTB in
Date:   Tue, 26 Jun 2018 13:57:12 +0200
Message-Id: <20180626115712.11643-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626115712.11643-1-alexandre.belloni@bootlin.com>
References: <20180626115712.11643-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow not building any DTB in the generic kernel so it gets smaller. This
is necessary for ocelot because it can be built as a legacy platform that
needs a built-in DTB and it can also handle a separate DTB once it is
updated with a more modern bootloader. In the latter case, it is preferable
to not include any DTB in the kernel image so it is smaller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v2:
 - rebased on v4.18-rc1

 arch/mips/Kconfig               | 1 -
 arch/mips/Makefile              | 2 +-
 arch/mips/generic/Kconfig       | 1 +
 arch/mips/generic/vmlinux.its.S | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3f9deec70b92..2cc43f51fa6f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -85,7 +85,6 @@ choice
 config MIPS_GENERIC
 	bool "Generic board-agnostic MIPS kernel"
 	select BOOT_RAW
-	select BUILTIN_DTB
 	select CEVT_R4K
 	select CLKSRC_MIPS_GIC
 	select COMMON_CLK
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e2122cca4ae2..5c5d491d736e 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -401,7 +401,7 @@ endif
 CLEAN_FILES += vmlinux.32 vmlinux.64
 
 # device-trees
-core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
+core-y += arch/mips/boot/dts/
 
 %.dtb %.dtb.S %.dtb.o: | scripts
 	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 08e33c6b2539..13692b84928e 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -3,6 +3,7 @@ if MIPS_GENERIC
 
 config LEGACY_BOARDS
 	bool
+	select BUILTIN_DTB
 	help
 	  Select this from your board if the board must use a legacy, non-UHI,
 	  boot protocol. This will cause the kernel to scan through the list of
diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
index 1a08438fd893..9c954f2ae561 100644
--- a/arch/mips/generic/vmlinux.its.S
+++ b/arch/mips/generic/vmlinux.its.S
@@ -21,6 +21,7 @@
 		};
 	};
 
+#if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	configurations {
 		default = "conf@default";
 
@@ -29,4 +30,5 @@
 			kernel = "kernel@0";
 		};
 	};
+#endif
 };
-- 
2.18.0


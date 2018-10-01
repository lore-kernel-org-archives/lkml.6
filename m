Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CAC0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420CC20645
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420CC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeJAWD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:03:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44088 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbeJAWD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:03:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id u74-v6so11501480oia.11;
        Mon, 01 Oct 2018 08:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VBSQfloLiFu+iV9ea+7Ay6RD8pIsDvaRlrrmBcR9emQ=;
        b=tyc0aCfNy7BElVlTwalV7ZYm6jy4xK8s0qmCMRI0Aydg1ZEhqbTYiaigMtALxIBbPQ
         hExnXQnrJwW/UvpapEYDsMrwQLrDLy9ZAoDU9knIC1+WKpAv4HYokHiyT9bTXC/tUYn1
         tXjb4aRLXb1Dnn1eirj8EbxZ6L0Pj/aqbs+CRcRliK+beb395c3syleQg2I9K1WGBQre
         FxOoIBP7bbSEdbz2OBQnkxYu+HltKY6RG0+krzRYhQJXMRraPwaN1szABkrVqlvHc2Ug
         81yu+yhMEjOaqQLf6SI0dTxUXNvyjG30O6IdSJUpp/k7likjAT/z0GMevDxfXiCj9N2G
         Kggg==
X-Gm-Message-State: ABuFfogNBDoVQSONyUAi9kKXg/5Uf8Hd8oalWrwfzEG14b2+8j0zTkwc
        5qs5nUHke4YXhJHizNtKRBJQKRfKIA==
X-Google-Smtp-Source: ACcGV61RL/bund2chaMjU1SSIPP545I7BSu4cxeLQLl/092b823MKDIMfxXoBzf6hAj6qXVDpGSYDw==
X-Received: by 2002:aca:e385:: with SMTP id a127-v6mr2895254oih.261.1538407537755;
        Mon, 01 Oct 2018 08:25:37 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:37 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH v4 3/9] nios2: use common rules to build built-in dtb
Date:   Mon,  1 Oct 2018 10:25:25 -0500
Message-Id: <20181001152531.3385-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the common build support for built-in dtb files just requires
adding a .dtb.o target to obj-y.

This has the side effect that CONFIG_NIOS2_DTB_SOURCE should now be just
the dts filename in arch/nios2/boot/dts/ directory. Before any path was
supported, but if you want to build in your dtb to the kernel, it should
be in the kernel tree.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/nios2/Makefile          |  6 ++----
 arch/nios2/boot/Makefile     | 14 --------------
 arch/nios2/boot/dts/Makefile |  2 ++
 arch/nios2/boot/linked_dtb.S | 19 -------------------
 4 files changed, 4 insertions(+), 37 deletions(-)
 delete mode 100644 arch/nios2/boot/linked_dtb.S

diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index 50eece1c6adb..db2e78fe65c7 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -49,16 +49,14 @@ BOOT_TARGETS = vmImage zImage
 PHONY += $(BOOT_TARGETS) install
 KBUILD_IMAGE := $(nios2-boot)/vmImage
 
-ifneq ($(CONFIG_NIOS2_DTB_SOURCE),"")
-	core-y	+= $(nios2-boot)/
-endif
+core-y	+= $(nios2-boot)/dts/
 
 all: vmImage
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(nios2-boot)
 
-%.dtb: | scripts
+%.dtb %.dtb.S %.dtb.o: | scripts
 	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts $(nios2-boot)/dts/$@
 
 dtbs:
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index 007586094dde..0b48f1bf086d 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -31,20 +31,6 @@ $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
 $(obj)/compressed/vmlinux: $(obj)/vmlinux.gz FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
-# Rule to build device tree blobs
-DTB_SRC := $(patsubst "%",%,$(CONFIG_NIOS2_DTB_SOURCE))
-
-# Make sure the generated dtb gets removed during clean
-extra-$(CONFIG_NIOS2_DTB_SOURCE_BOOL) += system.dtb
-
-$(obj)/system.dtb: $(DTB_SRC) FORCE
-	$(call cmd,dtc)
-
-# Ensure system.dtb exists
-$(obj)/linked_dtb.o: $(obj)/system.dtb
-
-obj-$(CONFIG_NIOS2_DTB_SOURCE_BOOL) += linked_dtb.o
-
 targets += $(dtb-y)
 
 $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
index f66554cd5c45..f6358e395b25 100644
--- a/arch/nios2/boot/dts/Makefile
+++ b/arch/nios2/boot/dts/Makefile
@@ -1 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+
+obj-y := $(patsubst "%.dts",%.dtb.o,$(CONFIG_NIOS2_DTB_SOURCE))
diff --git a/arch/nios2/boot/linked_dtb.S b/arch/nios2/boot/linked_dtb.S
deleted file mode 100644
index 071f922db338..000000000000
--- a/arch/nios2/boot/linked_dtb.S
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (C) 2011 Thomas Chou <thomas@wytron.com.tw>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-.section .dtb.init.rodata,"a"
-.incbin "arch/nios2/boot/system.dtb"
-- 
2.17.1


Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3025821884
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3025821884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeHVBRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:17:25 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46828 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHVBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:17:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so34749065oie.13;
        Tue, 21 Aug 2018 14:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VBSQfloLiFu+iV9ea+7Ay6RD8pIsDvaRlrrmBcR9emQ=;
        b=dEOK+SM2cBZLI42vE7JLUQoEqm1BCiZ1ibeimDg3Vf/VSVQHSTPFoFPfWYtDOVtW+K
         FnGbbe/0AJERwRyOw19zJXmrPl4HSYeUK+P0/15t+dX5EdXilOOr2SOxqV/mq+TYlgDX
         USKnpz/KNYNBek61eOWK8vCj8guZhYB80zGeaeu0yQdGUYoHGJOGKR7yOHYHZ1V6Tr7f
         oZnlpvDM1zHOQaPml0x/RyOdT+bJvOkz+Ap7A2rLMUb6/7xD4nwe6hPyBWFjGXv73Dml
         J7VoNXboOhd8jR3VwXoiNLBkau83FZYuB9RGbXyKhtakPD5SyorCFdp+eYDLoho+IoPY
         /a2A==
X-Gm-Message-State: APzg51BMH7XE4cMzW6RhUd1gfrzFSZst8EWcZ2gLuLShjDPe57nBFd8N
        APRs/OtB5QIQnHvpty90dZqrntI=
X-Google-Smtp-Source: ANB0VdYHvmkBHKjGqhv6UArsuppPbGWppgnFSzFE2QlEZWN819ANGZ53W+tpzCJ+NV2LnIpl3VeKIg==
X-Received: by 2002:aca:df55:: with SMTP id w82-v6mr1220105oig.355.1534888529298;
        Tue, 21 Aug 2018 14:55:29 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x126-v6sm18785332oig.15.2018.08.21.14.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:55:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: [PATCH 3/8] nios2: use common rules to build built-in dtb
Date:   Tue, 21 Aug 2018 16:55:19 -0500
Message-Id: <20180821215524.23040-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
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


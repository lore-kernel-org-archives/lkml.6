Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E8CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177772077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177772077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIFE0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:26:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36548 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeIFE0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:26:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so17144239oie.3;
        Wed, 05 Sep 2018 16:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XszpYR3Pg2yHk/dUeFNZuTdqkQwVqXBhOW/LwUpXPF4=;
        b=uW66OeYG2Co/zv0XVf96uzb8yO/eXrsaHEexapP2l/gP0BInQL7ZetATwy7l4U0F+9
         SX87MkxuBOUbzV8/8eHZbYRWQIZsWE62c6Q1uYqd5/39pRi/74WDY61pdXCY9XpL8RmA
         SRzmQt+z3tqIH/Qokd0ZvZxqFsVoMyZIC5nM7EDkG/APgcu4H9dwttuTSpIMbBBT+YRQ
         3VM7wevYuUifHunILnSVKqlnIzuXg9myihnJ9DeJlNdW8SBAPBN91GsKZQvNzb+rxyky
         c6OCIJMGHQ9D/eKOPcZnzg3kjilodVtGB8lDeyiBGb/vWPsZqvOIUWPrBETY1ZrRnbLS
         g7Pw==
X-Gm-Message-State: APzg51Buq8luXvHxk+EWkieJdXcSyAVu8eyjLAB0O8aIqHmQIvAVMIxX
        xYarNcqf9FFYMQswYO9YPvvh/4o=
X-Google-Smtp-Source: ANB0VdbNV+RAnEUcdydKT7lAt2z1NFlyaO1obUJJEy2dIL2wcRlhSBo64xtnzxEfp+p1VMWXbKmvIg==
X-Received: by 2002:aca:1802:: with SMTP id h2-v6mr88299oih.353.1536191612761;
        Wed, 05 Sep 2018 16:53:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH v2 3/9] nios2: use common rules to build built-in dtb
Date:   Wed,  5 Sep 2018 18:53:21 -0500
Message-Id: <20180905235327.5996-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
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
Please ack so I can take the whole series via the DT tree.

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

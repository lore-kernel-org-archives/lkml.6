Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C7CC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A7F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A7F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeIJT6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:58:38 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43522 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:58:38 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so40699689oib.10;
        Mon, 10 Sep 2018 08:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8cEA1yXkOtSkcSxK2WRBIl5IFgMaiOSbOBhvlAhints=;
        b=uX7je6fFDvxeHwoco840v+/fh919tn4dQ2gFbOkIv3o+6h7BamiPYMmIgHOLDjd5qY
         hlBn7oLw9mR/+HfgiMFQUBdWd1jdVlKVzAmo+mBMz61KItA7Refx+PblrQDvFwiWhINN
         LGcAewXMD1MhFuN3sw8f+zEAujBWU8qyW/RjZmtfW77Bc5lY70MhfehkDY8DXO/wJuFC
         IVKfpU8Tkq9hLJqCGuK95Gf8sg0GV6LJ0IYjWbYG2XKhb1bZdc4ORKRZP3mYWM0Lu8WG
         YB8Fde9tBePfu2cWA1GKqM2mDQDWF+Sj3PE2CNRv7Oqah+cMPjzyx5ziZK0n1ZgkXPCL
         xBoA==
X-Gm-Message-State: APzg51C+drMouvEVKrQciRfovo2ls5eYg34AIE8xdKtH0viu4DpguVUH
        j4nwWm6wYfeueXhXL1OLlOyIewE=
X-Google-Smtp-Source: ANB0VdbhOMUALECYQSS+u0wCYzEnzrjzPUZVTVkaEMj5BucPfAzkwqGsaY0f/W0mE0utoBQYJsfZxg==
X-Received: by 2002:aca:d0d7:: with SMTP id j84-v6mr23216114oiy.37.1536591846179;
        Mon, 10 Sep 2018 08:04:06 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm49465631oiy.2.2018.09.10.08.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:04:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/9] powerpc: build .dtb files in dts directory
Date:   Mon, 10 Sep 2018 10:03:55 -0500
Message-Id: <20180910150403.19476-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910150403.19476-1-robh@kernel.org>
References: <20180910150403.19476-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align powerpc with other architectures which build the dtb files in the
same directory as the dts files. This is also in line with most other
build targets which are located in the same directory as the source.
This move will help enable the 'dtbs' target which builds all the dtbs
regardless of kernel config.

This transition could break some scripts if they expect dtb files in the
old location.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Remove duplicate mpc5200 dtbs from image-y targets. The dtb target already
   comes from the cuImage.<platform> target.

 arch/powerpc/Makefile          |  2 +-
 arch/powerpc/boot/Makefile     | 55 ++++++++++++++++------------------
 arch/powerpc/boot/dts/Makefile |  1 +
 3 files changed, 28 insertions(+), 30 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/Makefile

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acba164a..53ea887eb34e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -294,7 +294,7 @@ bootwrapper_install:
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)

 %.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) $(build)=$(boot)/dts $(patsubst %,$(boot)/dts/%,$@)

 # Used to create 'merged defconfigs'
 # To use it $(call) it with the first argument as the base defconfig
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0fb96c26136f..bca5c23767df 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -304,9 +304,9 @@ image-$(CONFIG_PPC_ADDER875)		+= cuImage.adder875-uboot \
 					   dtbImage.adder875-redboot

 # Board ports in arch/powerpc/platform/52xx/Kconfig
-image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 lite5200.dtb
-image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200b lite5200b.dtb
-image-$(CONFIG_PPC_MEDIA5200)		+= cuImage.media5200 media5200.dtb
+image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200
+image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200b
+image-$(CONFIG_PPC_MEDIA5200)		+= cuImage.media5200

 # Board ports in arch/powerpc/platform/82xx/Kconfig
 image-$(CONFIG_MPC8272_ADS)		+= cuImage.mpc8272ads
@@ -381,11 +381,11 @@ $(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperb
 	$(call if_changed,wrap,$(subst $(obj)/zImage.,,$@))

 # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
-$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
-	$(call if_changed,wrap,$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
+	$(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
-	$(call if_changed,wrap,$*,,$(obj)/$*.dtb)
+$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
+	$(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb)

 # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
 # prefix
@@ -395,36 +395,33 @@ $(obj)/vmlinux.strip: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits) FORCE
 	$(call if_changed,wrap,uboot)

-$(obj)/uImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/uImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/uImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb)
+$(obj)/uImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb)

-$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/cuImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
+$(obj)/cuImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb)

-$(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/simpleImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/simpleImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb)
+$(obj)/simpleImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb)

-$(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/treeImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
+$(obj)/treeImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb)

-# Rule to build device tree blobs
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
-$(obj)/%.dtb: $(src)/dts/fsl/%.dts FORCE
-	$(call if_changed_dep,dtc)
+# Needed for the above targets to work with dts/fsl/ files
+$(obj)/dts/%.dtb: $(obj)/dts/fsl/%.dtb
+	@cp $< $@

 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/arch/powerpc/boot/dts/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
--
2.17.1

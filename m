Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A63C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E641E217FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E641E217FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHVBRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:17:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33620 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHVBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:17:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so34840087oip.0;
        Tue, 21 Aug 2018 14:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4S1daCR3ZtCuOBHquMDzc59uu6/EI9fyj4GqMNqOxDI=;
        b=AJYGoKU+I+hn4apu0alXSZm37Up5Oqj4F4OpifZg/lwey9B3rlRuL67x0kzXBBaQwh
         5hmQO83mrRtx/iomcWB/mB7y5VGh3Rh7U8u0XjgFNKYfyoozs2OtYzK8Lz9LDydhEdIZ
         2EAhg0wj5lEPFeFDgM4M9pwhC8bCkHFuErVjez9iOBjdaceQoxjMBpwHRg9OLsr1eaIO
         e87Av+Ow5XwQYK+Lra65OGu0T6I8diyZDcJS4n34TCqhdiXFdW2LPipu7lzIFzVck+2w
         hClDw8fA2HgudWfTK0GNHRT+/EQ1TxSUvb7nhDWwaskyh4pGvwRKpWXjIZjUO1cAVu7y
         ffRQ==
X-Gm-Message-State: APzg51AtFJ7vjDTStkt5CMJu02g22AUF5ef6JdpTe0JGEtb8lm7/g3Ia
        RvhIf2Re4TKs7w2OO5u3BSV13js=
X-Google-Smtp-Source: ANB0VdZUe3JBWnDAkOQ1g3soLJ4bThrNvTKhxx4ysqDpQYHprr0aqIYU/V0wvDGYFNAIrcG8HWig3A==
X-Received: by 2002:aca:e30b:: with SMTP id a11-v6mr1231757oih.303.1534888527354;
        Tue, 21 Aug 2018 14:55:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x126-v6sm18785332oig.15.2018.08.21.14.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:55:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc: build .dtb files in dts directory
Date:   Tue, 21 Aug 2018 16:55:17 -0500
Message-Id: <20180821215524.23040-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
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
 arch/powerpc/Makefile          |  2 +-
 arch/powerpc/boot/Makefile     | 49 ++++++++++++++++------------------
 arch/powerpc/boot/dts/Makefile |  1 +
 3 files changed, 25 insertions(+), 27 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/Makefile

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8397c7bd5880..9bacffa3b72e 100644
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
index 0fb96c26136f..b201d93e1725 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
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


Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD7AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA72204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA72204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeJAWEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:04:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38304 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbeJAWDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:03:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id h15-v6so13484104otj.5;
        Mon, 01 Oct 2018 08:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K0qpChji6w0LLSn0lM1GrJpAlsS+LmEXIOEhGGyEO8s=;
        b=PUf0J+3O5/hGDUWssrnjDqCUR1evHJr8kY/b1DeuBWKsAkHnaew1nGjuQ4YzyQipFO
         Fv6sDh7QpbsupN8qT5h9qO3vm1ce5zPzLfPdYjCQkBhmIvKix7gU5rmi5sbmCIv8MN+4
         8j+FMmheFW1+ov/0DlWiFemkunBKCs98auVtyDL+kpWhY7//LmsZstexlX3wPKeTqvcw
         qwG/0SkvEBxajbNfFMCWfCY4CR/Qcs+pX0wN+USD34wf8Wfc8iFhpYcD8ubrvoQ20crn
         RxmyEkmc0TKFKdhvHgv+HWKgeiC8iw8bEHv5FYDp2twIPXSrQ9KMcx5FHdA2XweaZmqW
         gWhg==
X-Gm-Message-State: ABuFfohAeclYeZOwRfP+DLtATXCvDjGlAHowSpgdrfUKBsJoqBu00xjZ
        BgrU+3A7r2SM+R77+vqV1ulBBFF8tw==
X-Google-Smtp-Source: ACcGV62NTIp2QT846//fWnNIjd4g3t93cOansO0u/0JN3eiIHDiUe3TPZ6mHpmgcuTn8g6O7RGxy6Q==
X-Received: by 2002:a9d:1566:: with SMTP id z35mr1502496otz.325.1538407535391;
        Mon, 01 Oct 2018 08:25:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/9] powerpc: build .dtb files in dts directory
Date:   Mon,  1 Oct 2018 10:25:23 -0500
Message-Id: <20181001152531.3385-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
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

PPC maintainers, really need you review/ack on this.

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

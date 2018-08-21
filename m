Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDCAC04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2951214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2951214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHVBRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:17:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37722 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeHVBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:17:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id p84-v6so453681oic.4;
        Tue, 21 Aug 2018 14:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FWWpu/rZ73LHeaOx/3FicCXTVC+bW2dp+6ooQF6mKYw=;
        b=ZQeBinZqWuOfV/bAIV7lrxp5WhDUKD6oQVbpr7WDC2By8ryFtDJpX9KWeG7IcwZaux
         bvdPvDelvP/cIX1UL+PgY3P5iZi6Q14tIuwSxXgtcIzxGLq9v8qMQuendpoHKsq9s6Lu
         B+8mJcpw6n4MGOTxiM3lOYJsVIlHAeNL2+x7ByaqeebYuA7zWu4yQXUcaZRQymMQuOy1
         SDBR//THPLTEy9Jwqwb6CGNYz+N3sjC1eK4rTAcHPjegJCYWd6pABR84nrEXy538kFMG
         HGoZhorGGIofPbVSy9fmN91Pf7YnyViJ94nW3PIW5HJCtmF841Ch0kg25Kkwj89gsbjw
         E8oQ==
X-Gm-Message-State: APzg51BfpjYvWBPVj54mjFyMFKezUpCXT9XCdF0qlg+Sl8LI8OQIAgel
        CDYqZhbdzBPO2B0lFL/nGXIjvkQ=
X-Google-Smtp-Source: ANB0Vda5hjko01JzCsveuUfDfTLeg7qXfIvP48SQatk8PqeJ5OOUFW50UMcDW/11jyb7dxqfVA4xoQ==
X-Received: by 2002:aca:2c83:: with SMTP id s125-v6mr1259570ois.103.1534888528339;
        Tue, 21 Aug 2018 14:55:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x126-v6sm18785332oig.15.2018.08.21.14.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:55:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: [PATCH 2/8] nios2: build .dtb files in dts directory
Date:   Tue, 21 Aug 2018 16:55:18 -0500
Message-Id: <20180821215524.23040-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align nios2 with other architectures which build the dtb files in the
same directory as the dts files. This is also in line with most other
build targets which are located in the same directory as the source.
This move will help enable the 'dtbs' target which builds all the dtbs
regardless of kernel config.

This transition could break some scripts if they expect dtb files in
the old location.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/nios2/Makefile          | 4 ++--
 arch/nios2/boot/Makefile     | 4 ----
 arch/nios2/boot/dts/Makefile | 1 +
 3 files changed, 3 insertions(+), 6 deletions(-)
 create mode 100644 arch/nios2/boot/dts/Makefile

diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index 8673a79dca9c..50eece1c6adb 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -59,10 +59,10 @@ archclean:
 	$(Q)$(MAKE) $(clean)=$(nios2-boot)
 
 %.dtb: | scripts
-	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
+	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts $(nios2-boot)/dts/$@
 
 dtbs:
-	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
+	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts
 
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index 2ba23a679732..007586094dde 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -47,10 +47,6 @@ obj-$(CONFIG_NIOS2_DTB_SOURCE_BOOL) += linked_dtb.o
 
 targets += $(dtb-y)
 
-# Rule to build device tree blobs with make command
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
 $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
 
 install:
diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/arch/nios2/boot/dts/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
-- 
2.17.1


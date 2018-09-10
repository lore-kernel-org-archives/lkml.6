Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A37720880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A37720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeIJT6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:58:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34164 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJT6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:58:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so40834807ois.1;
        Mon, 10 Sep 2018 08:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FWWpu/rZ73LHeaOx/3FicCXTVC+bW2dp+6ooQF6mKYw=;
        b=kefafvhJqGEs+89d7ZqLJgu5lk2d25tW2bOqjFoEcpgyiLVBmggCtOe2pJF9haQS17
         REvhNXEmVenIzUKAoleiLZuTWBYBTmhCJs6NSNtsWKIv++n9H3s0hzv17vycz/3d0ZtU
         F5M2kitc5Zj4fR3l3W6ooB/vn1AIBNSiSPS3KijU9qpxp45pKtHQh5O9OLPwtQbuC8qP
         BtF7cj0H5YPSYkIqxo2Zt9et+oYzcSdKQCrvwu/NrfHvD1VyY0qWR+zeplT3EicAsru3
         7IRPQDoD8rHT39uDt8M8axJ5/FOm0u8ZnU25at9fgyrUWjcztatqBchSHNN6AaARFTMC
         oOMg==
X-Gm-Message-State: APzg51AlIMC7HBQESJyiPBNheNn0q9y1doStBUVNh2X8QifozXns7RZ7
        QzqDmXle/crqWF/lqcekYXVrclA=
X-Google-Smtp-Source: ANB0VdZkgx4vj1Un+v9KlpsrSp23jJEBbz54PAKMPGmi1PbDkp05rj/Dmeu/uLjjL+V6AFAuECOnow==
X-Received: by 2002:aca:d0d7:: with SMTP id j84-v6mr23216316oiy.37.1536591848651;
        Mon, 10 Sep 2018 08:04:08 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm49465631oiy.2.2018.09.10.08.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:04:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: [PATCH v3 2/9] nios2: build .dtb files in dts directory
Date:   Mon, 10 Sep 2018 10:03:56 -0500
Message-Id: <20180910150403.19476-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910150403.19476-1-robh@kernel.org>
References: <20180910150403.19476-1-robh@kernel.org>
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


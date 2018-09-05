Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F73C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB40020857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB40020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeIFE0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:26:05 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37648 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeIFE0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:26:04 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so17149781oic.4;
        Wed, 05 Sep 2018 16:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=536qjisqbzf15CCnT+KJXbmbrcg6Ws7yKjBosjpRz50=;
        b=GWfpAX6iL0JFt+jkqJt3+C9VZE3B34ERc7JwRYR4T+cPd08nNgZbBTDxwujr3fN3RL
         ghCF0mnyyXEBZmsLhoqviIHHlBbx9lvV3/ZSP7eeMx0Zd8HbIXdtU1Fvv6oIpH9JfiyG
         2wITndv4PH3vtBQvNH74FzwIbf5UFa2qjZdc/UqoifR6OmIRnRmzvujpOEd3EslAS0/S
         TGVHYey0j8F0C5WgmReyBKUJr1tLV8kekRZiicpwwlJPS+UVybiO4SnVm6qrzhOEOfTW
         7ET+gf3uixisMSdr2BWBtc1YvAqSgb+Uh5zN3TiFkOQvGyZozKDbLukakdysyio+X1QT
         bZcA==
X-Gm-Message-State: APzg51D1oYJBUT4F4Qg8rPDFFrf6L20PCFGhs/1Ybwj5i8h8Y0G3ohP8
        gE0lnvGVkDcTzn4osDJSO5v+G0I=
X-Google-Smtp-Source: ANB0VdZhE/qjJ6TBx94TKVXAKYaUwp3F91MdMyMAUGIM/+Gtfk57gZlBGjo1S6+YfqRC9jwok+SeGA==
X-Received: by 2002:aca:2c02:: with SMTP id s2-v6mr100787ois.305.1536191611793;
        Wed, 05 Sep 2018 16:53:31 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH v2 2/9] nios2: build .dtb files in dts directory
Date:   Wed,  5 Sep 2018 18:53:20 -0500
Message-Id: <20180905235327.5996-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
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
Please ack so I can take the whole series via the DT tree.

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

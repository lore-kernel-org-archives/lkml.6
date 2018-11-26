Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0281C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5502089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPeLU5gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5502089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeKZVsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeKZVsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400D920817;
        Mon, 26 Nov 2018 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229691;
        bh=HA4bQlMHsebJhaXlfjcf0P0i6qwJeZg8/vqhFgkr6CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPeLU5gR3IZXKvVxbTHaRb79voVMzPdy/RIwIfIUy39TvbOfP+yzTucowjftyuvzj
         WPYk516TVhswRTiLQVhkuSYECDfb4p7x9OHcMIeC+gqdjQS4iaBI91pUja0+54/UDR
         mf2BWZFJXBPonB/hoMeaFpXKPUWC3e1YuAB5P0DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 08/70] kbuild: Consolidate header generation from ASM offset information
Date:   Mon, 26 Nov 2018 11:50:23 +0100
Message-Id: <20181126105047.696696838@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit ebf003f0cfb3705e60d40dedc3ec949176c741af upstream.

Largely redundant code is used in different places to generate C headers
from offset information extracted from assembly language output.
Consolidate the code in Makefile.lib and use this instead.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Kbuild                    |   25 -------------------------
 arch/ia64/kernel/Makefile |   26 ++------------------------
 scripts/Makefile.lib      |   28 ++++++++++++++++++++++++++++
 scripts/mod/Makefile      |   28 ++--------------------------
 4 files changed, 32 insertions(+), 75 deletions(-)

--- a/Kbuild
+++ b/Kbuild
@@ -6,31 +6,6 @@
 # 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
 # 4) Check for missing system calls
 
-# Default sed regexp - multiline due to syntax constraints
-define sed-y
-	"/^->/{s:->#\(.*\):/* \1 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:->::; p;}"
-endef
-
-# Use filechk to avoid rebuilds when a header changes, but the resulting file
-# does not
-define filechk_offsets
-	(set -e; \
-	 echo "#ifndef $2"; \
-	 echo "#define $2"; \
-	 echo "/*"; \
-	 echo " * DO NOT MODIFY."; \
-	 echo " *"; \
-	 echo " * This file was generated by Kbuild"; \
-	 echo " */"; \
-	 echo ""; \
-	 sed -ne $(sed-y); \
-	 echo ""; \
-	 echo "#endif" )
-endef
-
 #####
 # 1) Generate bounds.h
 
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -50,32 +50,10 @@ CFLAGS_traps.o  += -mfixed-range=f2-f5,f
 # The gate DSO image is built using a special linker script.
 include $(src)/Makefile.gate
 
-# Calculate NR_IRQ = max(IA64_NATIVE_NR_IRQS, XEN_NR_IRQS, ...) based on config
-define sed-y
-	"/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"
-endef
-quiet_cmd_nr_irqs = GEN     $@
-define cmd_nr_irqs
-	(set -e; \
-	 echo "#ifndef __ASM_NR_IRQS_H__"; \
-	 echo "#define __ASM_NR_IRQS_H__"; \
-	 echo "/*"; \
-	 echo " * DO NOT MODIFY."; \
-	 echo " *"; \
-	 echo " * This file was generated by Kbuild"; \
-	 echo " *"; \
-	 echo " */"; \
-	 echo ""; \
-	 sed -ne $(sed-y) $<; \
-	 echo ""; \
-	 echo "#endif" ) > $@
-endef
-
 # We use internal kbuild rules to avoid the "is up to date" message from make
 arch/$(SRCARCH)/kernel/nr-irqs.s: arch/$(SRCARCH)/kernel/nr-irqs.c
 	$(Q)mkdir -p $(dir $@)
 	$(call if_changed_dep,cc_s_c)
 
-include/generated/nr-irqs.h: arch/$(SRCARCH)/kernel/nr-irqs.s
-	$(Q)mkdir -p $(dir $@)
-	$(call cmd,nr_irqs)
+include/generated/nr-irqs.h: arch/$(SRCARCH)/kernel/nr-irqs.s FORCE
+	$(call filechk,offsets,__ASM_NR_IRQS_H__)
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -388,3 +388,31 @@ quiet_cmd_xzmisc = XZMISC  $@
 cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
 	xz --check=crc32 --lzma2=dict=1MiB) > $@ || \
 	(rm -f $@ ; false)
+
+# ASM offsets
+# ---------------------------------------------------------------------------
+
+# Default sed regexp - multiline due to syntax constraints
+define sed-offsets
+	"/^->/{s:->#\(.*\):/* \1 */:; \
+	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \
+	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
+	s:->::; p;}"
+endef
+
+# Use filechk to avoid rebuilds when a header changes, but the resulting file
+# does not
+define filechk_offsets
+	(set -e; \
+	 echo "#ifndef $2"; \
+	 echo "#define $2"; \
+	 echo "/*"; \
+	 echo " * DO NOT MODIFY."; \
+	 echo " *"; \
+	 echo " * This file was generated by Kbuild"; \
+	 echo " */"; \
+	 echo ""; \
+	 sed -ne $(sed-offsets); \
+	 echo ""; \
+	 echo "#endif" )
+endef
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -5,32 +5,8 @@ modpost-objs	:= modpost.o file2alias.o s
 
 devicetable-offsets-file := devicetable-offsets.h
 
-define sed-y
-	"/^->/{s:->#\(.*\):/* \1 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:->::; p;}"
-endef
-
-quiet_cmd_offsets = GEN     $@
-define cmd_offsets
-	(set -e; \
-	 echo "#ifndef __DEVICETABLE_OFFSETS_H__"; \
-	 echo "#define __DEVICETABLE_OFFSETS_H__"; \
-	 echo "/*"; \
-	 echo " * DO NOT MODIFY."; \
-	 echo " *"; \
-	 echo " * This file was generated by Kbuild"; \
-	 echo " *"; \
-	 echo " */"; \
-	 echo ""; \
-	 sed -ne $(sed-y) $<; \
-	 echo ""; \
-	 echo "#endif" ) > $@
-endef
-
-$(obj)/$(devicetable-offsets-file): $(obj)/devicetable-offsets.s
-	$(call if_changed,offsets)
+$(obj)/$(devicetable-offsets-file): $(obj)/devicetable-offsets.s FORCE
+	$(call filechk,offsets,__DEVICETABLE_OFFSETS_H__)
 
 targets += $(devicetable-offsets-file) devicetable-offsets.s
 



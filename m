Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ouhoLTi5GlsFRgAAmS7hNA
	; Fri, 08 Jun 2018 17:13:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6E0FB607E4; Fri,  8 Jun 2018 17:13:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HlpMIzZr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D188E60590;
	Fri,  8 Jun 2018 17:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D188E60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeFHRNh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:13:37 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:19847 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeFHRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:13:01 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w58HCbWE008555;
        Sat, 9 Jun 2018 02:12:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w58HCbWE008555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528477959;
        bh=3fLffJiYmwD8bzV7ahcnO+qtPUZUdR4W/9XZvG6Vxts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlpMIzZrH1qoHQJxIiXlbpgC8JD0mWn4HnynCvA1B+aMTnHlaQOy8Kmndx8KlsK14
         qZCCeDFPksGVALc6SVJPSihpHmsWuA+GYPtN/dszSlsgNB2gY41wwSleGtokW4jRm+
         0CGbIasK1nIVC5FG3SbMI/eWAlAXdUv49X+J2c95oGizMrADtJ9c5V6CsU0wiVZfMX
         OzrhhMtxIBb8ARLEiCfpgt834zH2ypRHOYrAnrLq4ExZW1V/WLprLxGd6Pbf+bDhBf
         Az2OypVeoRqO1CdZvqtM05N8IrBL10kh5ZJEMcuR7B2w4VJcEYjMHvtvFHXUGmInIS
         RikyHQrtuHxIg==
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 2/3] bpfilter: include bpfilter_umh in assembly instead of using objcopy
Date: Sat,  9 Jun 2018 02:12:09 +0900
Message-Id: <1528477930-7342-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use the troublesome ELF magic.  What is happening here is to
embed a user-space program into the kernel.  Simply wrap it in the
assembly with the '.incbin' directive.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 net/bpfilter/Makefile            | 15 ++-------------
 net/bpfilter/bpfilter_kern.c     | 11 +++++------
 net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
 3 files changed, 14 insertions(+), 19 deletions(-)
 create mode 100644 net/bpfilter/bpfilter_umh_blob.S

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index aafa720..39c6980 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -15,18 +15,7 @@ ifeq ($(CONFIG_BPFILTER_UMH), y)
 HOSTLDFLAGS += -static
 endif
 
-# a bit of elf magic to convert bpfilter_umh binary into a binary blob
-# inside bpfilter_umh.o elf file referenced by
-# _binary_net_bpfilter_bpfilter_umh_start symbol
-# which bpfilter_kern.c passes further into umh blob loader at run-time
-quiet_cmd_copy_umh = GEN $@
-      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
-      $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT) \
-      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
-      --rename-section .data=.init.rodata $< $@
-
-$(obj)/bpfilter_umh.o: $(obj)/bpfilter_umh
-	$(call cmd,copy_umh)
+$(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
 
 obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
-bpfilter-objs += bpfilter_kern.o bpfilter_umh.o
+bpfilter-objs += bpfilter_kern.o bpfilter_umh_blob.o
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index b13d058..fcc1a7c 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -10,11 +10,8 @@
 #include <linux/file.h>
 #include "msgfmt.h"
 
-#define UMH_start _binary_net_bpfilter_bpfilter_umh_start
-#define UMH_end _binary_net_bpfilter_bpfilter_umh_end
-
-extern char UMH_start;
-extern char UMH_end;
+extern char bpfilter_umh_start;
+extern char bpfilter_umh_end;
 
 static struct umh_info info;
 /* since ip_getsockopt() can run in parallel, serialize access to umh */
@@ -89,7 +86,9 @@ static int __init load_umh(void)
 	int err;
 
 	/* fork usermode process */
-	err = fork_usermode_blob(&UMH_start, &UMH_end - &UMH_start, &info);
+	err = fork_usermode_blob(&bpfilter_umh_end,
+				 &bpfilter_umh_end - &bpfilter_umh_start,
+				 &info);
 	if (err)
 		return err;
 	pr_info("Loaded bpfilter_umh pid %d\n", info.pid);
diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
new file mode 100644
index 0000000..40311d1
--- /dev/null
+++ b/net/bpfilter/bpfilter_umh_blob.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+	.section .init.rodata, "a"
+	.global bpfilter_umh_start
+bpfilter_umh_start:
+	.incbin "net/bpfilter/bpfilter_umh"
+	.global bpfilter_umh_end
+bpfilter_umh_end:
-- 
2.7.4

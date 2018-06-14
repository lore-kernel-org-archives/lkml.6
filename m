Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B618AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C592208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pkoJvsSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C592208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965578AbeFNOkc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:40:32 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:29290 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965709AbeFNOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:40:27 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w5EEdw8o010795;
        Thu, 14 Jun 2018 23:40:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w5EEdw8o010795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528987201;
        bh=tmTyhO6OIXehQWiorNqeVmCzDlr9Ni0o/0nc+xxAIbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkoJvsSFadrtbAU9Mq8tumtyp4drkxyk1y0sQLym7SkjsolgkVHPrOj4ccV+v5FUC
         uoOs9x1jU19OQ5Ybdhel62pwZ2xbXTEz+kk1+oZbJm4jkiQ24/8C/MKS0M4Kc/LgAO
         U4yIzx8B6AX6zkSOkCPohDpaAhylmQLTSNqtJ0At9+aBWXDpgeonELCjhBmVVigfz4
         fuG775k1Z8fjhxsau73VskDuhwwVuF3+GprEsV2PrBh0PctoTEXv9jRbYPQkd42mcZ
         4KtAFNozAeuSxW8qnsl3JAG/v0opiYHwrDe+URjbq4GFng+T/eG+LqPRWEMjtMGVAP
         9FBlsoZgEiNbQ==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexei Starovoitov <ast@fb.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 2/3] bpfilter: include bpfilter_umh in assembly instead of using objcopy
Date:   Thu, 14 Jun 2018 23:39:31 +0900
Message-Id: <1528987172-19810-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we want here is to embed a user-space program into the kernel.
Instead of the complex ELF magic, let's simply wrap it in the assembly
with the '.incbin' directive.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rebase

 net/bpfilter/Makefile            | 15 ++-------------
 net/bpfilter/bpfilter_kern.c     | 11 +++++------
 net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
 3 files changed, 14 insertions(+), 19 deletions(-)
 create mode 100644 net/bpfilter/bpfilter_umh_blob.S

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index e0bbe75..39c6980 100644
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
-      $(OBJCOPY) -I binary -O `$(OBJDUMP) -f $<|grep format|cut -d' ' -f8` \
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
index 0952257..6de3ae5 100644
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
@@ -93,7 +90,9 @@ static int __init load_umh(void)
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


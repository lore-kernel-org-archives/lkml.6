Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4FB58C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E24208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qSbj5Lyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E24208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965754AbeFNOkp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:40:45 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:29581 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965517AbeFNOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:40:40 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w5EEdw8p010795;
        Thu, 14 Jun 2018 23:40:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w5EEdw8p010795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528987202;
        bh=3wPVYxP/Exm0IGHbViIYakieZPwAPwX6dlVC33a42To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSbj5LyhPVrLZB9sYyDjeSrrmyaD/f4i+BGGP1rye8Vo0LBAzqqwoAc1cAOrCO6Mf
         3P9WQKGZh32xL35Q7FJacVcxfMoz0b6Ywe1ynSAirvoBp+WZhkar6jBA/ZRIUDZQwx
         W41s5eUM4HD0bmNqkkPVasLt2GUf5zv4MUnE6HULOlPesQMDEEyiUX5PNG9WBqu6x7
         FEcKKtPECqKfiWVYJiWz6J+oCOvLf7Cj3oArQ8gpW/lCPiqDsU7m8evTV/x4ydc2Lk
         /09QepPIfro9LlwSHbpw+uw4IWuPahnKiuPDz2w6J8c8IVeSHJz0oUqVS8W4Yhgxcp
         Eco5ztRUluf9g==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 3/3] bpfilter: check compiler capability in Kconfig
Date:   Thu, 14 Jun 2018 23:39:32 +0900
Message-Id: <1528987172-19810-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the brand-new syntax extension of Kconfig, we can directly
check the compiler capability in the configuration phase.

If the cc-can-link.sh fails, the BPFILTER_UMH is automatically
hidden by the dependency.

I deleted 'default n', which is no-op.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - newly added

 Makefile               | 5 -----
 net/Makefile           | 4 ----
 net/bpfilter/Kconfig   | 2 +-
 scripts/cc-can-link.sh | 2 +-
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 8a26b59..9ada673 100644
--- a/Makefile
+++ b/Makefile
@@ -507,11 +507,6 @@ ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLA
   KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
 endif
 
-ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/cc-can-link.sh $(CC)), y)
-  CC_CAN_LINK := y
-  export CC_CAN_LINK
-endif
-
 # The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
 # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
 # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
diff --git a/net/Makefile b/net/Makefile
index 13ec0d5..bdaf539 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -20,11 +20,7 @@ obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX)		+= unix/
 obj-$(CONFIG_NET)		+= ipv6/
-ifneq ($(CC_CAN_LINK),y)
-$(warning CC cannot link executables. Skipping bpfilter.)
-else
 obj-$(CONFIG_BPFILTER)		+= bpfilter/
-endif
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
 obj-$(CONFIG_BRIDGE)		+= bridge/
diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
index a948b07..76deb66 100644
--- a/net/bpfilter/Kconfig
+++ b/net/bpfilter/Kconfig
@@ -1,6 +1,5 @@
 menuconfig BPFILTER
 	bool "BPF based packet filtering framework (BPFILTER)"
-	default n
 	depends on NET && BPF && INET
 	help
 	  This builds experimental bpfilter framework that is aiming to
@@ -9,6 +8,7 @@ menuconfig BPFILTER
 if BPFILTER
 config BPFILTER_UMH
 	tristate "bpfilter kernel module with user mode helper"
+	depends on $(success,$(srctree)/scripts/cc-can-link.sh $(CC))
 	default m
 	help
 	  This builds bpfilter kernel module with embedded user mode helper
diff --git a/scripts/cc-can-link.sh b/scripts/cc-can-link.sh
index 208eb28..6efcead 100755
--- a/scripts/cc-can-link.sh
+++ b/scripts/cc-can-link.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-cat << "END" | $@ -x c - -o /dev/null >/dev/null 2>&1 && echo "y"
+cat << "END" | $@ -x c - -o /dev/null >/dev/null 2>&1
 #include <stdio.h>
 int main(void)
 {
-- 
2.7.4


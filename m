Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93DFC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA36264C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oa1cSiFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA36264C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935321AbeFZD5F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:57:05 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:60893 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934448AbeFZD5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:57:02 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5Q3tpaS000721;
        Tue, 26 Jun 2018 12:55:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5Q3tpaS000721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529985352;
        bh=vFqrl0yfN2D/Um8ZkgXnGPldzzwp/IOIYE5gV2wf3gg=;
        h=From:To:Cc:Subject:Date:From;
        b=oa1cSiFtGbo3xFcbkILHI44EH0caJc1yPYmv+b3UFX0hUfRhMLBc5TQJGKI/HM81d
         66MOoPWM0QCZHZm0JwJH9isI0l788nptAuRsUlmUUPnRLJT5GtkYPUFh7fdsLw0muG
         3efFkgw0mEyXWp0rE2rnAy7y39CWuBv/r2Lg6MPnqvfEQOpvSFJbRTs4jigvybi3Kj
         BCJc0wu2ZmdZK9c7NRR08SmuicpoIzTcHoMmBhRrxko9z8PuluWpxJaGJP+TV4ywP3
         c36ax+ldMl0E31C/GUpl/TjxpCcEV0xzP9gpq4C+e7NtQXj6ItLNn81Z6z3bV2fL/T
         BJvxvHvRtPQVQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Matteo Croce <mcroce@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [RESEND PATCH] bpfilter: check compiler capability in Kconfig
Date:   Tue, 26 Jun 2018 12:55:35 +0900
Message-Id: <1529985336-27522-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the brand-new syntax extension of Kconfig, we can directly
check the compiler capability in the configuration phase.

If the cc-can-link.sh fails, the BPFILTER_UMH is automatically
hidden by the dependency.

I also deleted 'default n', which is no-op.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile               | 5 -----
 net/Makefile           | 4 ----
 net/bpfilter/Kconfig   | 2 +-
 scripts/cc-can-link.sh | 2 +-
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index a6d4872..f71ea52 100644
--- a/Makefile
+++ b/Makefile
@@ -520,11 +520,6 @@ ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLA
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


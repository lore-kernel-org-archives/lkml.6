Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22ECC04AB9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 22:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E8821737
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 22:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R/vEll9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E8821737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeHSBpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 21:45:45 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:18937 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHSBpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 21:45:44 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7IMYsXk018092;
        Sun, 19 Aug 2018 07:34:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7IMYsXk018092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534631695;
        bh=ufLcNGeafJSDE3eBIFS0TDCthu1c1WbE5Cd2M4xU1VI=;
        h=From:To:Cc:Subject:Date:From;
        b=R/vEll9dPKpwp0APM/LM6KkPEVk5NOVuy1B6gZHVuqfG6S0aYB21Ixkow88loO6M4
         baVqNbV7py/xHxKKd60wwA2sJA/dZJeS4JtJsUg9D7qgGAQVnfpgPfVHVQxpRL5AYs
         bYK/fOTvW8m3igQTaSeaa4xqTXaugRasioLUEFMF3iZNsN6OtceEuUqNifIuHX/t81
         1bDly9AvL9oPkD3zR5SNrkocBKcDft8eAjrvehCm/q+qzDcx29Xw0Dh1NxOU0D7cB3
         dQbJp6kE5JaMSD9XUNnaML8ktYDAy0lrRA222WRgFqF9RVA+AzPKVVtQKhA0Mz8VF7
         lZ2zSjIPXJc/w==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] export.h: remove VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR()
Date:   Sun, 19 Aug 2018 07:34:47 +0900
Message-Id: <1534631687-18347-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the special case handling for Blackfin and Metag was removed by
commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
underscore"), VMLINUX_SYMBOL() is no-no.

Replace the remaining usages, then remove the definition of
VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR().

<asm-generic/vmlinux.lds.h> no longer needs to include <linux/export.h>.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 certs/system_certificates.S       | 16 ++++++++--------
 include/asm-generic/vmlinux.lds.h |  2 --
 include/linux/export.h            |  7 -------
 usr/initramfs_data.S              |  4 ++--
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 3918ff7..8f29058 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -5,8 +5,8 @@
 	__INITRODATA
 
 	.align 8
-	.globl VMLINUX_SYMBOL(system_certificate_list)
-VMLINUX_SYMBOL(system_certificate_list):
+	.globl system_certificate_list
+system_certificate_list:
 __cert_list_start:
 #ifdef CONFIG_MODULE_SIG
 	.incbin "certs/signing_key.x509"
@@ -15,21 +15,21 @@ __cert_list_start:
 __cert_list_end:
 
 #ifdef CONFIG_SYSTEM_EXTRA_CERTIFICATE
-	.globl VMLINUX_SYMBOL(system_extra_cert)
+	.globl system_extra_cert
 	.size system_extra_cert, CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE
-VMLINUX_SYMBOL(system_extra_cert):
+system_extra_cert:
 	.fill CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE, 1, 0
 
 	.align 4
-	.globl VMLINUX_SYMBOL(system_extra_cert_used)
-VMLINUX_SYMBOL(system_extra_cert_used):
+	.globl system_extra_cert_used
+system_extra_cert_used:
 	.int 0
 
 #endif /* CONFIG_SYSTEM_EXTRA_CERTIFICATE */
 
 	.align 8
-	.globl VMLINUX_SYMBOL(system_certificate_list_size)
-VMLINUX_SYMBOL(system_certificate_list_size):
+	.globl system_certificate_list_size
+system_certificate_list_size:
 #ifdef CONFIG_64BIT
 	.quad __cert_list_end - __cert_list_start
 #else
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f173b5f..7b75ff6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -54,8 +54,6 @@
 #define LOAD_OFFSET 0
 #endif
 
-#include <linux/export.h>
-
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
diff --git a/include/linux/export.h b/include/linux/export.h
index b768d6d..c363bde 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -10,13 +10,6 @@
  * hackers place grumpy comments in header files.
  */
 
-#define __VMLINUX_SYMBOL(x) x
-#define __VMLINUX_SYMBOL_STR(x) #x
-
-/* Indirect, so macros are expanded before pasting. */
-#define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
-#define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
-
 #ifndef __ASSEMBLY__
 struct kernel_symbol
 {
diff --git a/usr/initramfs_data.S b/usr/initramfs_data.S
index b28da79..d07648f 100644
--- a/usr/initramfs_data.S
+++ b/usr/initramfs_data.S
@@ -30,8 +30,8 @@ __irf_start:
 .incbin __stringify(INITRAMFS_IMAGE)
 __irf_end:
 .section .init.ramfs.info,"a"
-.globl VMLINUX_SYMBOL(__initramfs_size)
-VMLINUX_SYMBOL(__initramfs_size):
+.globl __initramfs_size
+__initramfs_size:
 #ifdef CONFIG_64BIT
 	.quad __irf_end - __irf_start
 #else
-- 
2.7.4


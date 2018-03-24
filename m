Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCXRpn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:45:43 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:36284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752704AbeCXRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:45:42 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3352:3876:3877:4321:4385:4605:5007:6114:6261:6642:6737:10004:10848:11026:11473:11658:11914:12043:12048:12296:12438:12533:12555:12895:13069:13311:13357:14096:14181:14384:14394:14721:21080:21451:21627:30012:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: cows11_4ea06453d7f19
X-Filterd-Recvd-Size: 2112
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 01/16] initrd: Add generic code path for common initrd unloading logic.
Date: Sat, 24 Mar 2018 13:44:43 -0400
Message-Id: <20180324174458.26423-2-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 init/initramfs.c | 7 +++++++
 usr/Kconfig      | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..de5ce873eb5a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+       free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+#endif
+
 static void __init free_initrd(void)
 {
 #ifdef CONFIG_KEXEC_CORE
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..fd79d4d6fa26 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
 	default ".lzma" if RD_LZMA
 	default ".bz2"  if RD_BZIP2
 	default ""
+
+# Arches can select this for a generic initrd unloading codepath
+config INITRAMFS_GENERIC_UNLOAD
+	bool
-- 
2.16.2

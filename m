Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B183CC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50AA20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uAQ+B47v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50AA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKUBgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:36:43 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:24496 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:36:43 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wAKF4dmo007142;
        Wed, 21 Nov 2018 00:04:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wAKF4dmo007142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542726280;
        bh=FEX7CPJ1IdIlEA+PQX4kbY3pAwX/D3w2IYYnEjF/3Xc=;
        h=From:To:Cc:Subject:Date:From;
        b=uAQ+B47veuLgovvtzP6eCcX3Htqj4ymm/elBhODUyKzCfmD2xoWIwQAQ2KQK1c2au
         m+U1HDGDczrjvn4PxoTNmzXnbtG2tRQRH4aikxJ/ueiT+vQwYJPB8QB9+LgtXQGcQt
         EzH0z/thPUHMTfsTWVrT2D9fX8hX1fzNVveSCKcxAW4ioywL5kw03Y1l1WS+fi0Uwc
         37ijQ/74jJzSSwZjxeKydyNUdcuNYIf4iM3FIQgGQvzvojXXKig5wZIC+JE2zNxlzh
         Sc9eAw/Q5S5BV1mnktlGrFivm5Mi1XiZ9Ys9g8nKJDjYnQG0HHzctZWEh9lk8YyG7C
         Dy+q0lxFidbNQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-doc@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH] kbuild: announce removal of SUBDIRS if used
Date:   Wed, 21 Nov 2018 00:04:18 +0900
Message-Id: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SUBDIRS has been kept as a backward compatibility since
commit ("[PATCH] kbuild: external module support") in 2002.

We do not need multiple ways to do the same thing, so I will remove
SUBDIRS after the Linux 5.3 release. I cleaned up in-tree code, and
updated the document so that nobody would try to use it.

Meanwhile, display the following warning if SUBDIRS is used.

Makefile:189: ================= WARNING ================
Makefile:190: 'SUBDIRS' will be removed after Linux 5.3
Makefile:191: Please use 'M=' or 'KBUILD_EXTMOD' instead
Makefile:192: ==========================================

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/kbuild.txt    | 7 +------
 Makefile                           | 4 ++++
 drivers/mtd/maps/scx200_docflash.c | 7 -------
 drivers/watchdog/scx200_wdt.c      | 7 -------
 samples/connector/Makefile         | 2 +-
 5 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
index 8390c36..c9e3d93 100644
--- a/Documentation/kbuild/kbuild.txt
+++ b/Documentation/kbuild/kbuild.txt
@@ -81,12 +81,7 @@ KBUILD_EXTMOD
 --------------------------------------------------
 Set the directory to look for the kernel source when building external
 modules.
-The directory can be specified in several ways:
-1) Use "M=..." on the command line
-2) Environment variable KBUILD_EXTMOD
-3) Environment variable SUBDIRS
-The possibilities are listed in the order they take precedence.
-Using "M=..." will always override the others.
+Setting "M=..." takes precedence over KBUILD_EXTMOD.
 
 KBUILD_OUTPUT
 --------------------------------------------------
diff --git a/Makefile b/Makefile
index 370d13b..57be5fb 100644
--- a/Makefile
+++ b/Makefile
@@ -186,6 +186,10 @@ endif
 # Old syntax make ... SUBDIRS=$PWD is still supported
 # Setting the environment variable KBUILD_EXTMOD take precedence
 ifdef SUBDIRS
+  $(warning ================= WARNING ================)
+  $(warning 'SUBDIRS' will be removed after Linux 5.3)
+  $(warning Please use 'M=' or 'KBUILD_EXTMOD' instead)
+  $(warning ==========================================)
   KBUILD_EXTMOD ?= $(SUBDIRS)
 endif
 
diff --git a/drivers/mtd/maps/scx200_docflash.c b/drivers/mtd/maps/scx200_docflash.c
index f1c1f73..7f1a0e6 100644
--- a/drivers/mtd/maps/scx200_docflash.c
+++ b/drivers/mtd/maps/scx200_docflash.c
@@ -216,10 +216,3 @@ static void __exit cleanup_scx200_docflash(void)
 
 module_init(init_scx200_docflash);
 module_exit(cleanup_scx200_docflash);
-
-/*
-    Local variables:
-        compile-command: "make -k -C ../../.. SUBDIRS=drivers/mtd/maps modules"
-        c-basic-offset: 8
-    End:
-*/
diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
index 836377c..ec4063e 100644
--- a/drivers/watchdog/scx200_wdt.c
+++ b/drivers/watchdog/scx200_wdt.c
@@ -262,10 +262,3 @@ static void __exit scx200_wdt_cleanup(void)
 
 module_init(scx200_wdt_init);
 module_exit(scx200_wdt_cleanup);
-
-/*
-    Local variables:
-	compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
-	c-basic-offset: 8
-    End:
-*/
diff --git a/samples/connector/Makefile b/samples/connector/Makefile
index fe3c854..6ad7162 100644
--- a/samples/connector/Makefile
+++ b/samples/connector/Makefile
@@ -14,4 +14,4 @@ HOSTCFLAGS_ucon.o += -I$(objtree)/usr/include
 all: modules
 
 modules clean:
-	$(MAKE) -C ../.. SUBDIRS=$(CURDIR) $@
+	$(MAKE) -C ../.. M=$(CURDIR) $@
-- 
2.7.4


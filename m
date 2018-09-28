Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D93C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5732172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GCvLOxuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5732172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeI1NN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:13:29 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:55053 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeI1NN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:13:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w8S6oBTF027595;
        Fri, 28 Sep 2018 15:50:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w8S6oBTF027595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538117412;
        bh=+jgLJg3F8cUQ4dmT7mf0GMqljUEbkw8vKA4jmhEStJI=;
        h=From:To:Cc:Subject:Date:From;
        b=GCvLOxuhpaTfpMm0kaXLvCOP7aOBsbLnqy6/63r2j8wJ70i6/0Sb9QXwLxBWIOn2P
         1AWLNUpzX8L0mOAJjhP0xvBouRk0+k4HFFPFFbRcbBw8F6SrZeprSi/ryTsgeXVMqe
         FegAv4iPjPOOUSsJj+kiQq+96+xT9hKVRPZMyKiEn2iJWWiLL2DTnxNgB1csCEceMI
         Vdzyb9fNwyznynN57Q6HPdR160V61jeb/jmTQvFr0t1SL2SA7+6z3dnPekBg5tzOuF
         R+w338tFD1wQXqutInZBfHZ6Hal0FLgYoq6PAEFqn7Z/7xTPcNhQ35VN3JW13E3+Uv
         k/uDDVpyX1GTg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] samples: run headers_install for host arch instead of target arch
Date:   Fri, 28 Sep 2018 15:49:48 +0900
Message-Id: <1538117388-11945-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some samples search headers in $(objtree)/usr/include, which is made
available by "make headers_install".  It is not kernel-space code but
host programs that need this header search path.

Commit 3fca1700c4c3 ("kbuild: make samples really depend on
headers_install") is wrong because it installs headers of the target
architecture.  Besides, UML fails to build with CONFIG_SAMPLES=y
because UML does not support headers_install.

Invoke "make headers_install" for the _host_ architecture in the
prepare stage.  Introduce CONFIG_HOST_HEADERS_INSTALL so that this
happens only for samples that need it.

I also removed 'Documentation/: headers_install', which I guess is
stale code.

Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Howells <dhowells@redhat.com>
---

 Makefile        | 8 ++++----
 samples/Kconfig | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 0c90c43..f04564c 100644
--- a/Makefile
+++ b/Makefile
@@ -1029,10 +1029,9 @@ ifdef CONFIG_GDB_SCRIPTS
 endif
 	+$(call if_changed,link-vmlinux)
 
-# Build samples along the rest of the kernel. This needs headers_install.
+# Build samples along the rest of the kernel.
 ifdef CONFIG_SAMPLES
 vmlinux-dirs += samples
-samples: headers_install
 endif
 
 # The actual objects are generated when descending,
@@ -1098,6 +1097,9 @@ archprepare: archheaders archscripts prepare1 scripts_basic
 
 prepare0: archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=.
+ifdef CONFIG_HOST_HEADERS_INSTALL
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(SUBARCH) headers_install
+endif
 
 # All the preparing..
 prepare: prepare0 prepare-objtool
@@ -1682,8 +1684,6 @@ endif
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
-# Make sure the latest headers are built for Documentation
-Documentation/ samples/: headers_install
 %/: prepare scripts FORCE
 	$(cmd_crmodverdir)
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
diff --git a/samples/Kconfig b/samples/Kconfig
index bd133ef..fcd6b7c 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -1,3 +1,6 @@
+config HOST_HEADERS_INSTALL
+	bool
+
 menuconfig SAMPLES
 	bool "Sample kernel code"
 	help
@@ -95,6 +98,7 @@ config SAMPLE_CONFIGFS
 config SAMPLE_CONNECTOR
 	tristate "Build connector sample -- loadable modules only"
 	depends on CONNECTOR && m
+	select HOST_HEADERS_INSTALL
 	help
 	  When enabled, this builds both a sample kernel module for
 	  the connector interface and a user space tool to communicate
@@ -104,6 +108,7 @@ config SAMPLE_CONNECTOR
 config SAMPLE_SECCOMP
 	tristate "Build seccomp sample code -- loadable modules only"
 	depends on SECCOMP_FILTER && m
+	select HOST_HEADERS_INSTALL
 	help
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
@@ -149,6 +154,7 @@ config SAMPLE_VFIO_MDEV_MBOCHS
 config SAMPLE_STATX
 	bool "Build example extended-stat using code"
 	depends on BROKEN
+	select HOST_HEADERS_INSTALL
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 
-- 
2.7.4


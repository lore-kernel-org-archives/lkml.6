Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF9EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634252170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ij1wXBsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634252170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeHTTE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:04:56 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:31339 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:04:56 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w7KFlQR4005997;
        Tue, 21 Aug 2018 00:47:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w7KFlQR4005997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534780047;
        bh=AssB2o4PwhUYh/pQhv8ezhCwShZXiJMfQFGSMqFsRf8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ij1wXBsI7hM+odlggzOKSo8NsHIJEotSMwhZzuaxKRTezsOUejPsdhPih14svUbgB
         nNaxot0UwW3GaGq1Rmtw70npT27XT9TFSTU6VNRYZLdUI5/mdihlTJ/zr1dVV/3yYT
         rtoUdmV9C0dWJL0tGvKcFZmI+cO/ZGBUPi/+1bZruhwQpQ9hYiVQzZ/D28O5ee74tk
         1LwLzS2T8fIegOyL9Oxxx5fIxUaHtVbAOvXkZqsqM2eYoOMyvZxopFLK015QacVEEi
         3erzRePaX+d08/i4Ou1khnh+X6/IeUj/NGEh1kMdKe+Yuz/uyJL7RyI1+0me4s+qt/
         H2ODzlCoUDcCw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        =?UTF-8?q?Bj=8F=A9=CCrn=20Forsman?= <bjorn.forsman@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, Michael Forney <forney@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: move gen_initramfs_list.sh from scripts/ to usr/
Date:   Tue, 21 Aug 2018 00:47:07 +0900
Message-Id: <1534780028-6479-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/gen_initramfs_list.sh is only invoked from usr/Makefile.
Move it so that all tools to create initramfs are self-contained
in the usr/ directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/early-userspace/README                 | 6 +++---
 Documentation/filesystems/ramfs-rootfs-initramfs.txt | 2 +-
 usr/Makefile                                         | 2 +-
 {scripts => usr}/gen_initramfs_list.sh               | 0
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename {scripts => usr}/gen_initramfs_list.sh (100%)

diff --git a/Documentation/early-userspace/README b/Documentation/early-userspace/README
index 2c00b07..1e10579 100644
--- a/Documentation/early-userspace/README
+++ b/Documentation/early-userspace/README
@@ -66,17 +66,17 @@ early userspace image can be built by an unprivileged user.
 
 As a technical note, when directories and files are specified, the
 entire CONFIG_INITRAMFS_SOURCE is passed to
-scripts/gen_initramfs_list.sh.  This means that CONFIG_INITRAMFS_SOURCE
+usr/gen_initramfs_list.sh.  This means that CONFIG_INITRAMFS_SOURCE
 can really be interpreted as any legal argument to
 gen_initramfs_list.sh.  If a directory is specified as an argument then
 the contents are scanned, uid/gid translation is performed, and
 usr/gen_init_cpio file directives are output.  If a directory is
-specified as an argument to scripts/gen_initramfs_list.sh then the
+specified as an argument to usr/gen_initramfs_list.sh then the
 contents of the file are simply copied to the output.  All of the output
 directives from directory scanning and file contents copying are
 processed by usr/gen_init_cpio.
 
-See also 'scripts/gen_initramfs_list.sh -h'.
+See also 'usr/gen_initramfs_list.sh -h'.
 
 Where's this all leading?
 =========================
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.txt b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
index b176928..79637d2 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.txt
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
@@ -164,7 +164,7 @@ Documentation/early-userspace/README for more details.)
 The kernel does not depend on external cpio tools.  If you specify a
 directory instead of a configuration file, the kernel's build infrastructure
 creates a configuration file from that directory (usr/Makefile calls
-scripts/gen_initramfs_list.sh), and proceeds to package up that directory
+usr/gen_initramfs_list.sh), and proceeds to package up that directory
 using the config file (by feeding it to usr/gen_init_cpio, which is created
 from usr/gen_init_cpio.c).  The kernel's build-time cpio creation code is
 entirely self-contained, and the kernel's boot-time extractor is also
diff --git a/usr/Makefile b/usr/Makefile
index 237a028..748f6a6 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -24,7 +24,7 @@ $(obj)/initramfs_data.o: $(obj)/$(datafile_y) FORCE
 # Generate the initramfs cpio archive
 
 hostprogs-y := gen_init_cpio
-initramfs   := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
+initramfs   := $(CONFIG_SHELL) $(srctree)/$(src)/gen_initramfs_list.sh
 ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
 			$(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
diff --git a/scripts/gen_initramfs_list.sh b/usr/gen_initramfs_list.sh
similarity index 100%
rename from scripts/gen_initramfs_list.sh
rename to usr/gen_initramfs_list.sh
-- 
2.7.4


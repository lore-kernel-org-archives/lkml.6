Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45752C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24562087A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24562087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeKESnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:43:43 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:34664 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKESnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:43:43 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id w9Qu1y00X3XaVaC019QuHn; Mon, 05 Nov 2018 10:24:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gJb7u-0001MD-HA; Mon, 05 Nov 2018 10:24:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gJaCb-0005Wl-Lr; Mon, 05 Nov 2018 09:25:41 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ubifs: CONFIG_UBIFS_FS_AUTHENTICATION should depend on UBIFS_FS
Date:   Mon,  5 Nov 2018 09:25:40 +0100
Message-Id: <20181105082540.21205-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding yet another dependency on UBIFS_FS, wrap the whole
block of ubifs config options in a single "if UBIFS_FS".

Fixes: d8a22773a12c6d78 ("ubifs: Enable authentication support")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/ubifs/Kconfig | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 529856fbccd0ee5f..3ee613361f4eeded 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -12,9 +12,10 @@ config UBIFS_FS
 	help
 	  UBIFS is a file system for flash devices which works on top of UBI.
 
+if UBIFS_FS
+
 config UBIFS_FS_ADVANCED_COMPR
 	bool "Advanced compression options"
-	depends on UBIFS_FS
 	help
 	  This option allows to explicitly choose which compressions, if any,
 	  are enabled in UBIFS. Removing compressors means inability to read
@@ -24,7 +25,6 @@ config UBIFS_FS_ADVANCED_COMPR
 
 config UBIFS_FS_LZO
 	bool "LZO compression support" if UBIFS_FS_ADVANCED_COMPR
-	depends on UBIFS_FS
 	default y
 	help
 	   LZO compressor is generally faster than zlib but compresses worse.
@@ -32,14 +32,12 @@ config UBIFS_FS_LZO
 
 config UBIFS_FS_ZLIB
 	bool "ZLIB compression support" if UBIFS_FS_ADVANCED_COMPR
-	depends on UBIFS_FS
 	default y
 	help
 	  Zlib compresses better than LZO but it is slower. Say 'Y' if unsure.
 
 config UBIFS_ATIME_SUPPORT
-	bool "Access time support" if UBIFS_FS
-	depends on UBIFS_FS
+	bool "Access time support"
 	default n
 	help
 	  Originally UBIFS did not support atime, because it looked like a bad idea due
@@ -54,7 +52,6 @@ config UBIFS_ATIME_SUPPORT
 
 config UBIFS_FS_XATTR
 	bool "UBIFS XATTR support"
-	depends on UBIFS_FS
 	default y
 	help
 	  Saying Y here includes support for extended attributes (xattrs).
@@ -65,7 +62,7 @@ config UBIFS_FS_XATTR
 
 config UBIFS_FS_ENCRYPTION
 	bool "UBIFS Encryption"
-	depends on UBIFS_FS && UBIFS_FS_XATTR && BLOCK
+	depends on UBIFS_FS_XATTR && BLOCK
 	select FS_ENCRYPTION
 	default n
 	help
@@ -76,7 +73,7 @@ config UBIFS_FS_ENCRYPTION
 
 config UBIFS_FS_SECURITY
 	bool "UBIFS Security Labels"
-	depends on UBIFS_FS && UBIFS_FS_XATTR
+	depends on UBIFS_FS_XATTR
 	default y
 	help
 	  Security labels provide an access control facility to support Linux
@@ -96,3 +93,5 @@ config UBIFS_FS_AUTHENTICATION
 	  If you say yes here you should also select a hashing algorithm such as
 	  sha256, these are not selected automatically since there are many
 	  different options.
+
+endif # UBIFS_FS
-- 
2.17.1


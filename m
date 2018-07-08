Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C1DC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AF0208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sAwnaJps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AF0208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeGHPWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:22:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbeGHPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zVi20fz98NyQKsXV93tBp1CoeQteAxBiyn4E8M0TYj4=; b=sAwnaJpsoh+h05KP4neuU3FfS
        kW5PY4gJ7bkbl2UwMqBnEJNPNHgWFMVDFfBELyX1qvOnGFUX8ZPR8b8XL4wOIgyiMu5wF3Rgl4Sca
        Trxk5Zqut88CalUaZ5qezIwiOpWw62P/BZ29FICFMGoqcq73Vv8HhdlTREXqcyu63TL84JYlV4++8
        xf7a6jlarSFKaOJj6qP0Xf0CnpyMXYf3gdutAhsLeas85BGoJYFJ9796mnU2BAHmU8qjuNMjii/OZ
        ZGKlrPCvdEevlcQQBT9Cdz3O1vkthMj0p4edopk9HFtWxv090xnleJeO+H/sb4wAc3+ediWMqLjWp
        ORB9g8Vcw==;
Received: from ip-64-134-140-74.public.wayport.net ([64.134.140.74] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcBTq-0002x4-TF; Sun, 08 Jul 2018 15:20:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] um: create a proper drivers Kconfig
Date:   Sun,  8 Jul 2018 08:19:58 -0700
Message-Id: <20180708152004.21679-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708152004.21679-1-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge arch/um/Kconfig.char and arch/um/Kconfig.net into a new
arch/um/drivers/Kconfig.  This fits the way Kconfig files are placed
elsewhere in the kernel tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/Kconfig                          |   4 +-
 arch/um/Kconfig.char                     | 124 ----------------------
 arch/um/{Kconfig.net => drivers/Kconfig} | 125 ++++++++++++++++++++++-
 3 files changed, 125 insertions(+), 128 deletions(-)
 delete mode 100644 arch/um/Kconfig.char
 rename arch/um/{Kconfig.net => drivers/Kconfig} (66%)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 1f605a7281cc..fc17718fbe0e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -194,14 +194,12 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-source "arch/um/Kconfig.char"
+source "arch/um/drivers/Kconfig"
 
 source "drivers/Kconfig"
 
 source "net/Kconfig"
 
-source "arch/um/Kconfig.net"
-
 source "fs/Kconfig"
 
 source "security/Kconfig"
diff --git a/arch/um/Kconfig.char b/arch/um/Kconfig.char
deleted file mode 100644
index f184bde7030e..000000000000
--- a/arch/um/Kconfig.char
+++ /dev/null
@@ -1,124 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-menu "UML Character Devices"
-
-config STDERR_CONSOLE
-	bool "stderr console"
-	default y
-	help
-	  console driver which dumps all printk messages to stderr.
-
-config SSL
-	bool "Virtual serial line"
-	help
-          The User-Mode Linux environment allows you to create virtual serial
-          lines on the UML that are usually made to show up on the host as
-          ttys or ptys.
-
-          See <http://user-mode-linux.sourceforge.net/old/input.html> for more
-          information and command line examples of how to use this facility.
-
-          Unless you have a specific reason for disabling this, say Y.
-
-config NULL_CHAN
-	bool "null channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to a device similar to /dev/null.  Data written to it disappears
-          and there is never any data to be read.
-
-config PORT_CHAN
-	bool "port channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to host portals.  They may be accessed with 'telnet <host>
-          <port number>'.  Any number of consoles and serial lines may be
-          attached to a single portal, although what UML device you get when
-          you telnet to that portal will be unpredictable.
-          It is safe to say 'Y' here.
-
-config PTY_CHAN
-	bool "pty channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to host pseudo-terminals.  Access to both traditional
-          pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
-          with this option.  The assignment of UML devices to host devices
-          will be announced in the kernel message log.
-          It is safe to say 'Y' here.
-
-config TTY_CHAN
-	bool "tty channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to host terminals.  Access to both virtual consoles
-          (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
-          /dev/pts/*) are controlled by this option.
-          It is safe to say 'Y' here.
-
-config XTERM_CHAN
-	bool "xterm channel support"
-	help
-          This option enables support for attaching UML consoles and serial
-          lines to xterms.  Each UML device so assigned will be brought up in
-          its own xterm.
-          It is safe to say 'Y' here.
-
-config NOCONFIG_CHAN
-	bool
-	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && NULL_CHAN)
-
-config CON_ZERO_CHAN
-	string "Default main console channel initialization"
-	default "fd:0,fd:1"
-	help
-          This is the string describing the channel to which the main console
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "fd:0,fd:1", which attaches the
-          main console to stdin and stdout.
-          It is safe to leave this unchanged.
-
-config CON_CHAN
-	string "Default console channel initialization"
-	default "xterm"
-	help
-          This is the string describing the channel to which all consoles
-          except the main console will be attached by default.  This value can
-          be overridden from the command line.  The default value is "xterm",
-          which brings them up in xterms.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have X or xterm available.
-
-config SSL_CHAN
-	string "Default serial line channel initialization"
-	default "pty"
-	help
-          This is the string describing the channel to which the serial lines
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "pty", which attaches them to
-          traditional pseudo-terminals.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have a set of /dev/pty* devices.
-
-config UML_SOUND
-	tristate "Sound support"
-	help
-          This option enables UML sound support.  If enabled, it will pull in
-          soundcore and the UML hostaudio relay, which acts as a intermediary
-          between the host's dsp and mixer devices and the UML sound system.
-          It is safe to say 'Y' here.
-
-config SOUND
-	tristate
-	default UML_SOUND
-
-config SOUND_OSS_CORE
-	bool
-	default UML_SOUND
-
-config HOSTAUDIO
-	tristate
-	default UML_SOUND
-
-endmenu
diff --git a/arch/um/Kconfig.net b/arch/um/drivers/Kconfig
similarity index 66%
rename from arch/um/Kconfig.net
rename to arch/um/drivers/Kconfig
index c390f3deb0dc..2b1aaf7755aa 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/drivers/Kconfig
@@ -1,5 +1,129 @@
 # SPDX-License-Identifier: GPL-2.0
 
+menu "UML Character Devices"
+
+config STDERR_CONSOLE
+	bool "stderr console"
+	default y
+	help
+	  console driver which dumps all printk messages to stderr.
+
+config SSL
+	bool "Virtual serial line"
+	help
+          The User-Mode Linux environment allows you to create virtual serial
+          lines on the UML that are usually made to show up on the host as
+          ttys or ptys.
+
+          See <http://user-mode-linux.sourceforge.net/old/input.html> for more
+          information and command line examples of how to use this facility.
+
+          Unless you have a specific reason for disabling this, say Y.
+
+config NULL_CHAN
+	bool "null channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to a device similar to /dev/null.  Data written to it disappears
+          and there is never any data to be read.
+
+config PORT_CHAN
+	bool "port channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to host portals.  They may be accessed with 'telnet <host>
+          <port number>'.  Any number of consoles and serial lines may be
+          attached to a single portal, although what UML device you get when
+          you telnet to that portal will be unpredictable.
+          It is safe to say 'Y' here.
+
+config PTY_CHAN
+	bool "pty channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to host pseudo-terminals.  Access to both traditional
+          pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
+          with this option.  The assignment of UML devices to host devices
+          will be announced in the kernel message log.
+          It is safe to say 'Y' here.
+
+config TTY_CHAN
+	bool "tty channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to host terminals.  Access to both virtual consoles
+          (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
+          /dev/pts/*) are controlled by this option.
+          It is safe to say 'Y' here.
+
+config XTERM_CHAN
+	bool "xterm channel support"
+	help
+          This option enables support for attaching UML consoles and serial
+          lines to xterms.  Each UML device so assigned will be brought up in
+          its own xterm.
+          It is safe to say 'Y' here.
+
+config NOCONFIG_CHAN
+	bool
+	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && NULL_CHAN)
+
+config CON_ZERO_CHAN
+	string "Default main console channel initialization"
+	default "fd:0,fd:1"
+	help
+          This is the string describing the channel to which the main console
+          will be attached by default.  This value can be overridden from the
+          command line.  The default value is "fd:0,fd:1", which attaches the
+          main console to stdin and stdout.
+          It is safe to leave this unchanged.
+
+config CON_CHAN
+	string "Default console channel initialization"
+	default "xterm"
+	help
+          This is the string describing the channel to which all consoles
+          except the main console will be attached by default.  This value can
+          be overridden from the command line.  The default value is "xterm",
+          which brings them up in xterms.
+          It is safe to leave this unchanged, although you may wish to change
+          this if you expect the UML that you build to be run in environments
+          which don't have X or xterm available.
+
+config SSL_CHAN
+	string "Default serial line channel initialization"
+	default "pty"
+	help
+          This is the string describing the channel to which the serial lines
+          will be attached by default.  This value can be overridden from the
+          command line.  The default value is "pty", which attaches them to
+          traditional pseudo-terminals.
+          It is safe to leave this unchanged, although you may wish to change
+          this if you expect the UML that you build to be run in environments
+          which don't have a set of /dev/pty* devices.
+
+config UML_SOUND
+	tristate "Sound support"
+	help
+          This option enables UML sound support.  If enabled, it will pull in
+          soundcore and the UML hostaudio relay, which acts as a intermediary
+          between the host's dsp and mixer devices and the UML sound system.
+          It is safe to say 'Y' here.
+
+config SOUND
+	tristate
+	default UML_SOUND
+
+config SOUND_OSS_CORE
+	bool
+	default UML_SOUND
+
+config HOSTAUDIO
+	tristate
+	default UML_SOUND
+
+endmenu
+
 menu "UML Network Devices"
 	depends on NET
 
@@ -211,4 +335,3 @@ config UML_NET_SLIRP
         Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
 
 endmenu
-
-- 
2.18.0


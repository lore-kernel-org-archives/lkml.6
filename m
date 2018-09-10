Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61883C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269232086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269232086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeIJJoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:44:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33722 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeIJJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:44:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fzEBY-0002aY-FO; Mon, 10 Sep 2018 04:52:28 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 5/8] make generic INIT_C_CC a bit more generic
Date:   Mon, 10 Sep 2018 05:52:24 +0100
Message-Id: <20180910045227.9895-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

turn it into an array initializer; then mips variant folds into
it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/include/asm/termios.h  |  9 ---------
 include/linux/termios_internal.h | 15 ++++++++++++++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index dbb62330b7a4..12bc56857bf1 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -12,13 +12,4 @@
 #include <linux/uaccess.h>
 #include <uapi/asm/termios.h>
 
-/*
- *	intr=^C		quit=^\		erase=del	kill=^U
- *	vmin=\1		vtime=\0	eol2=\0		swtc=\0
- *	start=^Q	stop=^S		susp=^Z		vdsusp=
- *	reprint=^R	discard=^U	werase=^W	lnext=^V
- *	eof=^D		eol=\0
- */
-#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
-
 #endif /* _ASM_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index a77fd8df783e..d25b9a9c2faf 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -12,7 +12,20 @@
 	reprint=^R	discard=^U	werase=^W	lnext=^V
 	eol2=\0
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC {		\
+	[VINTR] = 'C'-0x40,	\
+	[VQUIT] = '\\'-0x40,	\
+	[VERASE] = '\177',	\
+	[VKILL] = 'U'-0x40,	\
+	[VEOF] = 'D'-0x40,	\
+	[VSTART] = 'Q'-0x40,	\
+	[VSTOP] = 'S'-0x40,	\
+	[VSUSP] = 'Z'-0x40,	\
+	[VREPRINT] = 'R'-0x40,	\
+	[VDISCARD] = 'O'-0x40,	\
+	[VWERASE] = 'W'-0x40,	\
+	[VLNEXT] = 'V'-0x40,	\
+	[VMIN] = 1 }
 #endif
 
 #ifndef user_termio_to_kernel_termios
-- 
2.11.0


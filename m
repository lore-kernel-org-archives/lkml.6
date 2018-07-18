Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254FEECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D322075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D322075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeGRCq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:46:26 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:34244 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbeGRCq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:46:26 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffbvV-0007MC-Fd; Wed, 18 Jul 2018 04:10:52 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffbvV-0008Uw-5c; Wed, 18 Jul 2018 04:10:49 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 04:10:43 +0200
Message-Id: <20180718021044.32611-2-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718021044.32611-1-kilobyte@angband.pl>
References: <20180718020604.3u25omf5fxqvsy3q@angband.pl>
 <20180718021044.32611-1-kilobyte@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 2/3] vt: selection: handle storing of characters above U+FFFF
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those above U+10FFFF get replaced with U+FFFD.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/selection.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 34e7110f310d..69ca337d3220 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -116,8 +116,8 @@ static inline int atedge(const int p, int size_row)
 	return (!(p % size_row)	|| !((p + 2) % size_row));
 }
 
-/* stores the char in UTF8 and returns the number of bytes used (1-3) */
-static int store_utf8(u16 c, char *p)
+/* stores the char in UTF8 and returns the number of bytes used (1-4) */
+static int store_utf8(u32 c, char *p)
 {
 	if (c < 0x80) {
 		/*  0******* */
@@ -128,13 +128,26 @@ static int store_utf8(u16 c, char *p)
 		p[0] = 0xc0 | (c >> 6);
 		p[1] = 0x80 | (c & 0x3f);
 		return 2;
-    	} else {
+	} else if (c < 0x10000) {
 		/* 1110**** 10****** 10****** */
 		p[0] = 0xe0 | (c >> 12);
 		p[1] = 0x80 | ((c >> 6) & 0x3f);
 		p[2] = 0x80 | (c & 0x3f);
 		return 3;
-    	}
+	} else if (c < 0x110000) {
+		/* 11110*** 10****** 10****** 10****** */
+		p[0] = 0xf0 | (c >> 18);
+		p[1] = 0x80 | ((c >> 12) & 0x3f);
+		p[2] = 0x80 | ((c >> 6) & 0x3f);
+		p[3] = 0x80 | (c & 0x3f);
+		return 4;
+	} else {
+		/* outside Unicode, replace with U+FFFD */
+		p[0] = 0xef;
+		p[1] = 0xbf;
+		p[2] = 0xbd;
+		return 3;
+	}
 }
 
 /**
@@ -273,7 +286,7 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
 	sel_end = new_sel_end;
 
 	/* Allocate a new buffer before freeing the old one ... */
-	multiplier = use_unicode ? 3 : 1;  /* chars can take up to 3 bytes */
+	multiplier = use_unicode ? 4 : 1;  /* chars can take up to 4 bytes */
 	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, multiplier,
 			   GFP_KERNEL);
 	if (!bp) {
-- 
2.18.0


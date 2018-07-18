Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC85ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4A82075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4A82075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeGRCqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:46:30 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:34252 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbeGRCq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:46:28 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffbvW-0007ME-7t; Wed, 18 Jul 2018 04:10:54 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffbvV-0008Uz-T8; Wed, 18 Jul 2018 04:10:49 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 04:10:44 +0200
Message-Id: <20180718021044.32611-3-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718021044.32611-1-kilobyte@angband.pl>
References: <20180718020604.3u25omf5fxqvsy3q@angband.pl>
 <20180718021044.32611-1-kilobyte@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 3/3] vt: selection: take screen contents from uniscr if available
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This preserves whatever was written even if we can't currently display the
given glyph.  Mouse paste won't corrupt any character of wcwidth() == 1
anymore.

Note that for now uniscr doesn't get allocated until something reads
/dev/vcsuN for that console, making this code dormant for most users.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/selection.c | 11 +++++++----
 drivers/tty/vt/vt.c        | 10 ++++++++++
 include/linux/selection.h  |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 69ca337d3220..07496c711d7d 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -57,11 +57,13 @@ static inline void highlight_pointer(const int where)
 	complement_pos(sel_cons, where);
 }
 
-static u16
+static u32
 sel_pos(int n)
 {
+	if (use_unicode)
+		return screen_glyph_unicode(sel_cons, n / 2);
 	return inverse_translate(sel_cons, screen_glyph(sel_cons, n),
-				use_unicode);
+				0);
 }
 
 /**
@@ -90,7 +92,8 @@ static u32 inwordLut[]={
   0x07FFFFFE, /* lowercase         */
 };
 
-static inline int inword(const u16 c) {
+static inline int inword(const u32 c)
+{
 	return c > 0x7f || (( inwordLut[c>>5] >> (c & 0x1F) ) & 1);
 }
 
@@ -167,7 +170,7 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
 	struct tiocl_selection v;
 	char *bp, *obp;
 	int i, ps, pe, multiplier;
-	u16 c;
+	u32 c;
 	int mode;
 
 	poke_blanked_console();
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7fcb0ff2dccf..19da4c0b4b8e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4545,6 +4545,16 @@ u16 screen_glyph(struct vc_data *vc, int offset)
 }
 EXPORT_SYMBOL_GPL(screen_glyph);
 
+u32 screen_glyph_unicode(struct vc_data *vc, int n)
+{
+	struct uni_screen *uniscr = get_vc_uniscr(vc);
+
+	if (uniscr)
+		return uniscr->lines[n / vc->vc_cols][n % vc->vc_cols];
+	return inverse_translate(vc, screen_glyph(vc, n * 2), 1);
+}
+EXPORT_SYMBOL_GPL(screen_glyph_unicode);
+
 /* used by vcs - note the word offset */
 unsigned short *screen_pos(struct vc_data *vc, int w_offset, int viewed)
 {
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 067d2e99c79f..a8f5b97b216f 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -32,6 +32,7 @@ extern unsigned char default_blu[];
 
 extern unsigned short *screen_pos(struct vc_data *vc, int w_offset, int viewed);
 extern u16 screen_glyph(struct vc_data *vc, int offset);
+extern u32 screen_glyph_unicode(struct vc_data *vc, int offset);
 extern void complement_pos(struct vc_data *vc, int offset);
 extern void invert_screen(struct vc_data *vc, int offset, int count, int shift);
 
-- 
2.18.0


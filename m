Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0245C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804AF2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MkTwNdl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804AF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755411AbeFQTHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:07:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63272 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbeFQTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:07:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 227D2FC13D;
        Sun, 17 Jun 2018 15:07:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=a5Gh
        xUmqV6OkvOYBm2zqBNKyM2Q=; b=MkTwNdl6OWjxL7jZwYkxhcBwPULTE38WWWNg
        te/oGsH9UqiRfAuKUK2I1W+oBbuPDU0XatzpthvgSINB1WShsUPYYHEmUVH+RT/j
        mZbZPFFY6oLJ2lONS3qWA7t+6GBdCeLY8nGc4jwQwMFIJZubRtoX/QilK5kjj14L
        GSbmIRk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 199A0FC13C;
        Sun, 17 Jun 2018 15:07:10 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0C1BFC132;
        Sun, 17 Jun 2018 15:07:09 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id D05ED2DA0677;
        Sun, 17 Jun 2018 15:07:08 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] vt: unicode fallback for scrollback
Date:   Sun, 17 Jun 2018 15:07:05 -0400
Message-Id: <20180617190706.14614-4-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617190706.14614-1-nicolas.pitre@linaro.org>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
X-Pobox-Relay-ID: A265053A-7261-11E8-90DD-44CE1968708C-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently no provision for scrollback content in the core code,
leaving that to backend video drivers where this can be highly optimized.
There is currently no common method for those drivers to tell the core
what part of the scrollback is actually displayed and what size the
scrollback buffer is either. Because of that, the unicode screen buffer
has no provision for any scrollback.

At least we can provide backtranslated glyph values when the scrollback
is active which should be plenty good enough for now.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Dave Mielke <Dave@mielke.cc>
---
 drivers/tty/vt/vc_screen.c |  3 ++-
 drivers/tty/vt/vt.c        | 31 +++++++++++++++++++++++++++++--
 include/linux/selection.h  |  2 +-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 9c44252e52..2384ea85ff 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -311,7 +311,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			do {
 				if (nr > this_round/4)
 					nr = this_round/4;
-				vc_uniscr_copy_line(vc, con_buf0, row, col, nr);
+				vc_uniscr_copy_line(vc, con_buf0, viewed,
+						    row, col, nr);
 				con_buf0 += nr * 4;
 				this_round -= nr * 4;
 				row++;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 062ce6be79..2d14bb195d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -533,13 +533,40 @@ int vc_uniscr_check(struct vc_data *vc)
  * This must be preceded by a successful call to vc_uniscr_check() once
  * the console lock has been taken.
  */
-void vc_uniscr_copy_line(struct vc_data *vc, void *dest,
+void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
 			 unsigned int row, unsigned int col, unsigned int nr)
 {
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	int offset = row * vc->vc_size_row + col * 2;
+	unsigned long pos;
 
 	BUG_ON(!uniscr);
-	memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
+
+	pos = (unsigned long)screenpos(vc, offset, viewed);
+	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
+		/*
+		 * Desired position falls in the main screen buffer.
+		 * However the actual row/col might be different if
+		 * scrollback is active.
+		 */
+		row = (pos - vc->vc_origin) / vc->vc_size_row;
+		col = ((pos - vc->vc_origin) % vc->vc_size_row) / 2;
+		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
+	} else {
+		/*
+		 * Scrollback is active. For now let's simply backtranslate
+		 * the screen glyphs until the unicode screen buffer does
+		 * synchronize with console display drivers for a scrollback
+		 * buffer of its own.
+		 */
+		u16 *p = (u16 *)pos;
+		int mask = vc->vc_hi_font_mask | 0xff;
+		char32_t *uni_buf = dest;
+		while (nr--) {
+			u16 glyph = scr_readw(p++) & mask;
+			*uni_buf++ = inverse_translate(vc, glyph, true);
+		}
+	}
 }
 
 
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 2b34df9f1e..067d2e99c7 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -43,7 +43,7 @@ extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
 extern void vcs_scr_updated(struct vc_data *vc);
 
 extern int vc_uniscr_check(struct vc_data *vc);
-extern void vc_uniscr_copy_line(struct vc_data *vc, void *dest,
+extern void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
 				unsigned int row, unsigned int col,
 				unsigned int nr);
 
-- 
2.17.1


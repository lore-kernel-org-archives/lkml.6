Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC020693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DETh6Rmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEC020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeGRBiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:38:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59416 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbeGRBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:38:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEB91EDF45;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Z9a3
        /MBdtj9jXUeSkq/yeCQ5zso=; b=DETh6RmjmbiGozGx70xavXS/vISp7hoKMcdN
        SSwgrzVOGCWo7CcZ5AWuKRsm2iJhxFx9v6fMgndBJB/ez/WFVXMQkxjiRrLKLgN0
        aYPxt/w8MmjkxHZrv2uAthC8oSsILwzvJwzNd2Xtq0E4ow0oXgQ0myQ0veEf1xxV
        o/0aRKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE65CEDF43;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46200EDF3C;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 6E7DE2DA0674;
        Tue, 17 Jul 2018 21:02:44 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: [PATCH 2/3] vt: coherence validation code for the unicode screen buffer
Date:   Tue, 17 Jul 2018 21:02:41 -0400
Message-Id: <20180718010242.5254-3-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718010242.5254-1-nicolas.pitre@linaro.org>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org>
X-Pobox-Relay-ID: 47D0A818-8A26-11E8-8E70-063AD72159A7-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the unicode screen buffer matches the video screen content.
This is provided for debugging convenience and disabled by default.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vt.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 03e79f7787..331f175265 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -328,6 +328,8 @@ void schedule_console_callback(void)
 #define get_vc_uniscr(vc) vc->vc_uni_screen
 #endif
 
+#define VC_UNI_SCREEN_DEBUG 0
+
 typedef uint32_t char32_t;
 
 /*
@@ -571,6 +573,42 @@ void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
 	}
 }
 
+/* this is for validation and debugging only */
+static void vc_uniscr_debug_check(struct vc_data *vc)
+{
+	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	unsigned short *p;
+	int x, y, mask;
+
+	if (!VC_UNI_SCREEN_DEBUG || !uniscr)
+		return;
+
+	WARN_CONSOLE_UNLOCKED();
+
+	/*
+	 * Make sure our unicode screen translates into the same glyphs
+	 * as the actual screen. This is brutal indeed.
+	 */
+	p = (unsigned short *)vc->vc_origin;
+	mask = vc->vc_hi_font_mask | 0xff;
+	for (y = 0; y < vc->vc_rows; y++) {
+		char32_t *line = uniscr->lines[y];
+		for (x = 0; x < vc->vc_cols; x++) {
+			u16 glyph = scr_readw(p++) & mask;
+			char32_t uc = line[x];
+			int tc = conv_uni_to_pc(vc, uc);
+			if (tc == -4)
+				tc = conv_uni_to_pc(vc, 0xfffd);
+			if (tc == -4)
+				tc = conv_uni_to_pc(vc, '?');
+			if (tc != glyph)
+				pr_err_ratelimited(
+					"%s: mismatch at %d,%d: glyph=%#x tc=%#x\n",
+					__func__, x, y, glyph, tc);
+		}
+	}
+}
+
 
 static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		enum con_scroll dir, unsigned int nr)
@@ -2719,6 +2757,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 		do_con_trol(tty, vc, orig);
 	}
 	con_flush(vc, draw_from, draw_to, &draw_x);
+	vc_uniscr_debug_check(vc);
 	console_conditional_schedule();
 	console_unlock();
 	notify_update(vc);
-- 
2.17.1


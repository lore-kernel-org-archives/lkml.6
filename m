Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B93C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ABF2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RoISlc7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfAIDzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:55:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56242 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAIDzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:55:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9390F119303;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=efjSLXWMsEa9kIKOsVZ02niDE
        Ro=; b=RoISlc7JQddGZ45MNYdE176p9Ar+pIL8qhRyTKO0eEmDr4WiYVv39CQOf
        5jQp1V0CS/swp9JW/HN8f7pfKp88Cg/0Iw075poRKUPI6M2tliW/fMpGzPgUPR8m
        AsEyhYXYGKea+nn6bMyTR+XwHkrP2UajvkaTwUccc1USn01Jyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 892491192FF;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CBEF1192FC;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 3069F2DA0419;
        Tue,  8 Jan 2019 22:55:45 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] vt: make vt_console_print() compatible with the unicode screen buffer
Date:   Tue,  8 Jan 2019 22:54:59 -0500
Message-Id: <20190109035504.8413-2-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109035504.8413-1-nicolas.pitre@linaro.org>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7186B80C-13C2-11E9-83F5-70EFDD2159A7-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel messages are printed to the console, they appear blank on
the unicode screen. This is because vt_console_print() is lacking a call
to vc_uniscr_putc(). However the later function assumes vc->vc_x is
always up to date when called, which is not the case here as
vt_console_print() uses it to mark the beginning of the display update.

This patch reworks (and simplifies) vt_console_print() so that vc->vc_x
is always valid and keeps the start of display update in a local variable
instead, which finally allows for adding the missing vc_uniscr_putc()
call.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org # v4.19+
---
 drivers/tty/vt/vt.c | 47 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 41ec8e5010..b9004bd087 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2884,8 +2884,7 @@ static void vt_console_print(struct console *co, co=
nst char *b, unsigned count)
 	unsigned char c;
 	static DEFINE_SPINLOCK(printing_lock);
 	const ushort *start;
-	ushort cnt =3D 0;
-	ushort myx;
+	ushort start_x, cnt;
 	int kmsg_console;
=20
 	/* console busy or not yet initialized */
@@ -2898,10 +2897,6 @@ static void vt_console_print(struct console *co, c=
onst char *b, unsigned count)
 	if (kmsg_console && vc_cons_allocated(kmsg_console - 1))
 		vc =3D vc_cons[kmsg_console - 1].d;
=20
-	/* read `x' only after setting currcons properly (otherwise
-	   the `x' macro will read the x of the foreground console). */
-	myx =3D vc->vc_x;
-
 	if (!vc_cons_allocated(fg_console)) {
 		/* impossible */
 		/* printk("vt_console_print: tty %d not allocated ??\n", currcons+1); =
*/
@@ -2916,53 +2911,41 @@ static void vt_console_print(struct console *co, =
const char *b, unsigned count)
 		hide_cursor(vc);
=20
 	start =3D (ushort *)vc->vc_pos;
-
-	/* Contrived structure to try to emulate original need_wrap behaviour
-	 * Problems caused when we have need_wrap set on '\n' character */
+	start_x =3D vc->vc_x;
+	cnt =3D 0;
 	while (count--) {
 		c =3D *b++;
 		if (c =3D=3D 10 || c =3D=3D 13 || c =3D=3D 8 || vc->vc_need_wrap) {
-			if (cnt > 0) {
-				if (con_is_visible(vc))
-					vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
-				vc->vc_x +=3D cnt;
-				if (vc->vc_need_wrap)
-					vc->vc_x--;
-				cnt =3D 0;
-			}
+			if (cnt && con_is_visible(vc))
+				vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, start_x);
+			cnt =3D 0;
 			if (c =3D=3D 8) {		/* backspace */
 				bs(vc);
 				start =3D (ushort *)vc->vc_pos;
-				myx =3D vc->vc_x;
+				start_x =3D vc->vc_x;
 				continue;
 			}
 			if (c !=3D 13)
 				lf(vc);
 			cr(vc);
 			start =3D (ushort *)vc->vc_pos;
-			myx =3D vc->vc_x;
+			start_x =3D vc->vc_x;
 			if (c =3D=3D 10 || c =3D=3D 13)
 				continue;
 		}
+		vc_uniscr_putc(vc, c);
 		scr_writew((vc->vc_attr << 8) + c, (unsigned short *)vc->vc_pos);
 		notify_write(vc, c);
 		cnt++;
-		if (myx =3D=3D vc->vc_cols - 1) {
-			vc->vc_need_wrap =3D 1;
-			continue;
-		}
-		vc->vc_pos +=3D 2;
-		myx++;
-	}
-	if (cnt > 0) {
-		if (con_is_visible(vc))
-			vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
-		vc->vc_x +=3D cnt;
-		if (vc->vc_x =3D=3D vc->vc_cols) {
-			vc->vc_x--;
+		if (vc->vc_x =3D=3D vc->vc_cols - 1) {
 			vc->vc_need_wrap =3D 1;
+		} else {
+			vc->vc_pos +=3D 2;
+			vc->vc_x++;
 		}
 	}
+	if (cnt && con_is_visible(vc))
+		vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, start_x);
 	set_cursor(vc);
 	notify_update(vc);
=20
--=20
2.20.1


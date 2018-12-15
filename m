Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EC5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6892084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uchuujin.de header.i=@uchuujin.de header.b="kNFt8RCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeLOOkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:40:52 -0500
Received: from static.85-10-192-230.clients.your-server.de ([85.10.192.230]:58833
        "EHLO mxout.uchuujin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:40:51 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2018 09:40:50 EST
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
        id 73EA41430BAF0; Sat, 15 Dec 2018 15:35:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
        t=1544884530; bh=ktVaweSJBGbotv4bGWuEgtAOxgFdU0L9s5IYQMXXwAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNFt8RCJUzwE1kqN6IlFnng2FOiaBgHwC4IVbL+yr9oz8OrTYh3d3otUeWVutLg4g
         jcQT+xSMVasuZYLyMm0CZ5T/S1u8tTYpcpZceLlTdYuTexLx+cMwNvzojLrsrMctLh
         wdPJR7wjt6K7z9+7JChZSURHzuguv1xitQjoSoUMU9iDgtleStNNVhw9J9eqbwYutg
         f/E9HK/VFEjLtF/Nfd2JBoi5RRaIhbMCbR4jOzqdt1fbmJAKoTPxRlWKn+pf1YzPNi
         s0s7mNHYcrq9u8/YCbbEPSivHI1NTA7wwKZgN4pp8S76LiZW5+jGcm5RTmna8gopwo
         U/Mm518fCKj5w==
From:   Martin Hostettler <textshell@uchuujin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Egmont Koblinger <egmont@gmail.com>,
        Martin Hostettler <textshell@uchuujin.de>
Subject: [PATCH 1/4] vt: refactor vc_ques to allow of other private sequences.
Date:   Sat, 15 Dec 2018 15:34:20 +0100
Message-Id: <20181215143423.4556-2-textshell@uchuujin.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181215143423.4556-1-textshell@uchuujin.de>
References: <20181215143423.4556-1-textshell@uchuujin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc_ques keeps track if a csi sequence is a private DEC control
function beginning with '?'. Nowadays some private control functions
begin with '>' and '='. Switch the code to instead use a new 3-bit
vc_priv that allows for all private use parameter prefixes.

Signed-off-by: Martin Hostettler <textshell@uchuujin.de>
---
 drivers/tty/vt/vt.c            | 20 +++++++++++---------
 include/linux/console_struct.h |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 41ec8e5010f3..75826a97b0c3 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1341,6 +1341,8 @@ struct vc_data *vc_deallocate(unsigned int currcons)
  *	VT102 emulator
  */
 
+enum { EPecma = 0, EPdec, EPeq, EPgt, EPlt};
+
 #define set_kbd(vc, x)	vt_set_kbd_mode_bit((vc)->vc_num, (x))
 #define clr_kbd(vc, x)	vt_clr_kbd_mode_bit((vc)->vc_num, (x))
 #define is_kbd(vc, x)	vt_get_kbd_mode_bit((vc)->vc_num, (x))
@@ -1814,7 +1816,7 @@ static void set_mode(struct vc_data *vc, int on_off)
 	int i;
 
 	for (i = 0; i <= vc->vc_npar; i++)
-		if (vc->vc_ques) {
+		if (vc->vc_priv == EPdec) {
 			switch(vc->vc_par[i]) {	/* DEC private modes set/reset */
 			case 1:			/* Cursor keys send ^[Ox/^[[x */
 				if (on_off)
@@ -2030,7 +2032,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->vc_top		= 0;
 	vc->vc_bottom		= vc->vc_rows;
 	vc->vc_state		= ESnormal;
-	vc->vc_ques		= 0;
+	vc->vc_priv		= EPecma;
 	vc->vc_translate	= set_translate(LAT1_MAP, vc);
 	vc->vc_G0_charset	= LAT1_MAP;
 	vc->vc_G1_charset	= GRAF_MAP;
@@ -2233,8 +2235,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_state=ESfunckey;
 			return;
 		}
-		vc->vc_ques = (c == '?');
-		if (vc->vc_ques)
+		vc->vc_priv = (c == '?') ? EPdec : EPecma;
+		if (vc->vc_priv != EPecma)
 			return;
 	case ESgetpars:
 		if (c == ';' && vc->vc_npar < NPAR - 1) {
@@ -2254,7 +2256,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			set_mode(vc, 0);
 			return;
 		case 'c':
-			if (vc->vc_ques) {
+			if (vc->vc_priv == EPdec) {
 				if (vc->vc_par[0])
 					vc->vc_cursor_type = vc->vc_par[0] | (vc->vc_par[1] << 8) | (vc->vc_par[2] << 16);
 				else
@@ -2263,7 +2265,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			}
 			break;
 		case 'm':
-			if (vc->vc_ques) {
+			if (vc->vc_priv == EPdec) {
 				clear_selection();
 				if (vc->vc_par[0])
 					vc->vc_complement_mask = vc->vc_par[0] << 8 | vc->vc_par[1];
@@ -2273,7 +2275,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			}
 			break;
 		case 'n':
-			if (!vc->vc_ques) {
+			if (vc->vc_priv == EPecma) {
 				if (vc->vc_par[0] == 5)
 					status_report(tty);
 				else if (vc->vc_par[0] == 6)
@@ -2281,8 +2283,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			}
 			return;
 		}
-		if (vc->vc_ques) {
-			vc->vc_ques = 0;
+		if (vc->vc_priv != EPecma) {
+			vc->vc_priv = EPecma;
 			return;
 		}
 		switch(c) {
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index ab137f97ecbd..ed798e114663 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -119,7 +119,7 @@ struct vc_data {
 	unsigned int	vc_s_blink	: 1;
 	unsigned int	vc_s_reverse	: 1;
 	/* misc */
-	unsigned int	vc_ques		: 1;
+	unsigned int	vc_priv		: 3;
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
 	unsigned int	vc_report_mouse : 2;
-- 
2.11.0


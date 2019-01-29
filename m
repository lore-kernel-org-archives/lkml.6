Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF0C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D8020881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763619;
	bh=F4rmoACIa+t6IAwdwXHPiMuj8PxeQP8m55tVDQ/a8wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c51a3b7n8filT5eR/sYF6qZvPIHEpFHkALcGvCYxgRA99x5jsvlysHsk/DZJ/521v
	 gy8UlXG3ldQjVHXd+7lKX2o4BzrtLVFtZBKLUF/s9ALpGeRhbihfsJDdZSs0SgWaqh
	 1DCkt36PIMyapCMLR8fiH2w934AQBb3MZY3LVFgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfA2MG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbfA2Lkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408D820857;
        Tue, 29 Jan 2019 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762047;
        bh=F4rmoACIa+t6IAwdwXHPiMuj8PxeQP8m55tVDQ/a8wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQMCUUBuzSAwViBRBfuhBfk9eEzIQlLufVzjniqYMkKkI6jlEkBYwCoslekc+sb+O
         IuzyfCmfFKWJ5CtXnyeD/cK2e72eyHUCIa02eCc5/IN/c3yxbV3Qqda0+wRF1IpDQV
         K4aXA9q58BLuCjQjSnIpQKWKJve1Eno6T/U5UYNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.20 090/117] vt: make vt_console_print() compatible with the unicode screen buffer
Date:   Tue, 29 Jan 2019 12:35:41 +0100
Message-Id: <20190129113211.873375967@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 6609cff65c5b184ab889880ef5d41189611ea05f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |   47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2884,8 +2884,7 @@ static void vt_console_print(struct cons
 	unsigned char c;
 	static DEFINE_SPINLOCK(printing_lock);
 	const ushort *start;
-	ushort cnt = 0;
-	ushort myx;
+	ushort start_x, cnt;
 	int kmsg_console;
 
 	/* console busy or not yet initialized */
@@ -2898,10 +2897,6 @@ static void vt_console_print(struct cons
 	if (kmsg_console && vc_cons_allocated(kmsg_console - 1))
 		vc = vc_cons[kmsg_console - 1].d;
 
-	/* read `x' only after setting currcons properly (otherwise
-	   the `x' macro will read the x of the foreground console). */
-	myx = vc->vc_x;
-
 	if (!vc_cons_allocated(fg_console)) {
 		/* impossible */
 		/* printk("vt_console_print: tty %d not allocated ??\n", currcons+1); */
@@ -2916,53 +2911,41 @@ static void vt_console_print(struct cons
 		hide_cursor(vc);
 
 	start = (ushort *)vc->vc_pos;
-
-	/* Contrived structure to try to emulate original need_wrap behaviour
-	 * Problems caused when we have need_wrap set on '\n' character */
+	start_x = vc->vc_x;
+	cnt = 0;
 	while (count--) {
 		c = *b++;
 		if (c == 10 || c == 13 || c == 8 || vc->vc_need_wrap) {
-			if (cnt > 0) {
-				if (con_is_visible(vc))
-					vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
-				vc->vc_x += cnt;
-				if (vc->vc_need_wrap)
-					vc->vc_x--;
-				cnt = 0;
-			}
+			if (cnt && con_is_visible(vc))
+				vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, start_x);
+			cnt = 0;
 			if (c == 8) {		/* backspace */
 				bs(vc);
 				start = (ushort *)vc->vc_pos;
-				myx = vc->vc_x;
+				start_x = vc->vc_x;
 				continue;
 			}
 			if (c != 13)
 				lf(vc);
 			cr(vc);
 			start = (ushort *)vc->vc_pos;
-			myx = vc->vc_x;
+			start_x = vc->vc_x;
 			if (c == 10 || c == 13)
 				continue;
 		}
+		vc_uniscr_putc(vc, c);
 		scr_writew((vc->vc_attr << 8) + c, (unsigned short *)vc->vc_pos);
 		notify_write(vc, c);
 		cnt++;
-		if (myx == vc->vc_cols - 1) {
-			vc->vc_need_wrap = 1;
-			continue;
-		}
-		vc->vc_pos += 2;
-		myx++;
-	}
-	if (cnt > 0) {
-		if (con_is_visible(vc))
-			vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
-		vc->vc_x += cnt;
-		if (vc->vc_x == vc->vc_cols) {
-			vc->vc_x--;
+		if (vc->vc_x == vc->vc_cols - 1) {
 			vc->vc_need_wrap = 1;
+		} else {
+			vc->vc_pos += 2;
+			vc->vc_x++;
 		}
 	}
+	if (cnt && con_is_visible(vc))
+		vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, start_x);
 	set_cursor(vc);
 	notify_update(vc);
 



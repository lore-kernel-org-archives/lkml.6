Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D385C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30D20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="pGxeSDYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfBYQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:44:12 -0500
Received: from tomli.me ([153.92.126.73]:38580 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfBYQoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:44:11 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id c964809e;
        Mon, 25 Feb 2019 16:44:09 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:359c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 25 Feb 2019 16:44:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=hlS8cDsy0ZtAhqRb2guVC+lQrA61gX5oN+NrwC7dGl0=; b=pGxeSDYJTsadTHi5DkX1eVFJ01yZIxyKqcd/6mRlGb5FEQ0dQNygHqQszVYwIbSQiTKyTQcMaeyes93C6AvMPjYSFKklOhVSP3dpfoPFDkR7IX2A8Dc4M18Dpnal8z92/QaD84aiEWW4UjTrwuVgbOQVIe0i8I39pTFqPMrWteDDdUA0H29V20uhOyqC5pHYDh5UYkFwDmWaWyv/gik4jzaZcroMy8fSHPqBVgpxtHzRW0a+JY+R5IJVAIaXEbEiofbzvM6f29xpZc9fH0mPyP5vlgEuvRwZuNMX01gR1YyD0eW7OKb95XZgkSBumBJf6A0GduzrDsV8/GvFJHFiPw==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Yifeng Li <tomli@tomli.me>,
        Mike Frysinger <vapier@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [RFC 1/1] tty: vt.c: Fix TIOCL_BLANKSCREEN VT console blanking if blankinterval == 0
Date:   Tue, 26 Feb 2019 00:43:46 +0800
Message-Id: <20190225164346.1359-2-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225164346.1359-1-tomli@tomli.me>
References: <20190225164346.1359-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vt.c, "blank_state" will be initialized to "blank_normal_wait" in
con_init() if AND ONLY IF ("blankinterval" > 0). If "blankinterval" is 0,
"blank_state" will be "blank_off" (== 0), and a call to do_blank_screen()
will always abort. Even if a forced blanking is required from the user by
calling TIOCL_BLANKSCREEN, the console won't be blanked.

In this commit,  we introduce a 4th "blank_state" - "blank_normal_notimer",
it indicates the console can be blanked, but not automatically by a timer.
Then, we made a change to "con_init()" - if (blankinterval == 0),
"blank_state" will be set to "blank_normal_notimer" (we have similar
changes to "do_unblank_screen()" and "poke_blanked_console()"). Finally,
we change do_blank_screen() - now it will return if "blank_state" is
neither "blank_normal_wait" nor "blank_normal_notimer", thus allowing
the console to be blanked even if there's no timed autoblanking.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/tty/vt/vt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 41ec8e5010f3..ec84bc2868e1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -238,6 +238,7 @@ enum {
 	blank_off = 0,
 	blank_normal_wait,
 	blank_vesa_wait,
+	blank_normal_notimer, /* no auto blanking, only manual blanking */
 };
 
 /*
@@ -3334,6 +3335,8 @@ static int __init con_init(void)
 	if (blankinterval) {
 		blank_state = blank_normal_wait;
 		mod_timer(&console_timer, jiffies + (blankinterval * HZ));
+	} else {
+		blank_state = blank_normal_notimer;
 	}
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
@@ -4168,7 +4171,8 @@ void do_blank_screen(int entering_gfx)
 		return;
 	}
 
-	if (blank_state != blank_normal_wait)
+	if (blank_state != blank_normal_wait &&
+			blank_state != blank_normal_notimer)
 		return;
 	blank_state = blank_off;
 
@@ -4232,6 +4236,8 @@ void do_unblank_screen(int leaving_gfx)
 	if (blankinterval) {
 		mod_timer(&console_timer, jiffies + (blankinterval * HZ));
 		blank_state = blank_normal_wait;
+	} else {
+		blank_state = blank_normal_notimer;
 	}
 
 	console_blanked = 0;
@@ -4293,7 +4299,8 @@ void poke_blanked_console(void)
 	else if (blankinterval) {
 		mod_timer(&console_timer, jiffies + (blankinterval * HZ));
 		blank_state = blank_normal_wait;
-	}
+	} else if (!blankinterval)
+		blank_state = blank_normal_notimer;
 }
 
 /*
-- 
2.20.1


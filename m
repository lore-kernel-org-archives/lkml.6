Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F721C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD38D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="dUww9YyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfBZLle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:41:34 -0500
Received: from tomli.me ([153.92.126.73]:38888 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfBZLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:41:33 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id e4c6fc45;
        Tue, 26 Feb 2019 11:41:31 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Tue, 26 Feb 2019 11:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=21dfifi5EWqLxPxZJvLO1Up0ISeFMvI7zrCCkzbO5Yg=; b=dUww9YyAbmWlpvEk2IuiH0frcct0RJThtpHKUYYlscdpmqZT2HupTDf4nSvrRu+ch/c0fOrTM1JWkfZG0/yYTgM3rnEQ9nxAM3MSExgf784jWX5P+f8R2sbN7atWFGOCNbj+yW2bPc7hXJgk7w6zqS4kUIIUsgV/RGReEyzjQE9C4y2UUPGSQj04yFb37SxH0pxsTsHGt4BRXFxiuF5MtpYo9B3PeeNbh/7OoH+IiGZPNhvtRmyc8PV6NuTk+UyIyB9oX9y7UJjwkah9l8Y1ufVfNfBQ/Y7g191q4L7S0+OFIwGrNba+u0z6cprbDrpVRl8cf2NMSINYcz49fxCvXQ==
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
Subject: [PATCH] tty: vt.c: Fix TIOCL_BLANKSCREEN console blanking if blankinterval == 0
Date:   Tue, 26 Feb 2019 19:41:18 +0800
Message-Id: <20190226114118.28725-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
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

After Linux 4.12, blankinterval is 0 by default, which caused an unexpected
breakage of previously working "setterm -blank force". "blankinterval"
should not act like a kill switch for TIOCL_BLANKSCREEN.

My original proposal was adding a new "blank_normal_notimer" to indicate
manual console blanking via ioctl, however, it has been pointed out that
that fix was unnecessary, since do_blank_screen() is safe to reentry. To
fix it, we simply remove the "blank_state != blank_off" check. See Ref
for a detailed discussion.

Suggested-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Fixes: a4199f5e ("tty: Disable default console blanking interval")
Reference: https://lore.kernel.org/lkml/20190225164346.1359-1-tomli@tomli.me
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/tty/vt/vt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 41ec8e5010f3..279f5b2ac44a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4168,8 +4168,6 @@ void do_blank_screen(int entering_gfx)
 		return;
 	}
 
-	if (blank_state != blank_normal_wait)
-		return;
 	blank_state = blank_off;
 
 	/* don't blank graphics */
-- 
2.20.1


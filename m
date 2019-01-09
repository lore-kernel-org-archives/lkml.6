Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFB4206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FOWS+QmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfAIBRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:17:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43833 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbfAIBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:17:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so5920275eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 17:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7GCluurlGsNgRNuMYUB6olUhE0pXre9Ty8eA3twLOk=;
        b=FOWS+QmWNzU5oOcSAKYmqPvShE9/phlfUaxtL4r/ulsYAexmJi5WzE3heBG1D1I5Q1
         iV5YMsdvdRqPM09CyfqPiZm/s8RiwDD7qUv2AwCglP+GCrLNiUcgJY3CGLFMmn8/MBj3
         uDdOoZaiA49NcoYZ4m3Ek4tb+mM1GtBPKdwnMu1ei4+OkSiKe9xEaSY8oWQp/BfykFZB
         Aecn/GFg5cFOT85Pb7PZNpj8T2Nm5lilKVslTDRwX514K6WgA51ouwMNOkA+2jo6F+1U
         d+ghVeTBvDZToZgCrAQEZkzV44a8PubbT369VpUuvXhs1t4S1vEDxlkt3WCrbnXoPtow
         FfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7GCluurlGsNgRNuMYUB6olUhE0pXre9Ty8eA3twLOk=;
        b=fJ9f9SW34voRacxwIVZ/hJA5eHLsHB+fxNqqV06l9ZIlw2rkzcAM09gtkLZTh/sBae
         DbfkI5g3OuzcbMTW+mrwT+45pwbIfyQFWbtkgWUxBgjqT5ytMlZ4T7PTw6xkNiao3UkY
         5ErExmrUuHX+oz1DDkyfYY29OuzufSMg7D2Au8D5MAlK9JuWW20aI3XwxQFM0rjguiLz
         ZjI7nAmVgXznerwPb2FTb6Snekg1TTJzoWe3TkMfCsfenKaz22+jbmhwjINrDwzXCMi1
         3uYeUiw2eMIQjcJV18a361IgQUafjJ7skxDSAQZcHZYlmBDr2nS/Ztyx4utoj3IvOpop
         3Qtg==
X-Gm-Message-State: AJcUukeZqzm5miVQc/wxnF2Q7L32b4e2xViF6sV/h+f+EJuoRtMFzZhw
        NkzxtkupHBmqgXtqoajudxCanUJy46E=
X-Google-Smtp-Source: ALg8bN4jNxvAtbSTssHhzliyNmDvlHdm/JH9ILj2OPw2XM8Ux8TQ8F5jWciyHO6ShlN4RZKQ8cwo/g==
X-Received: by 2002:a50:86c2:: with SMTP id 2mr4094544edu.34.1546996661787;
        Tue, 08 Jan 2019 17:17:41 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p22-v6sm384323ejb.76.2019.01.08.17.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 17:17:41 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] tty: Don't hold ldisc lock in tty_reopen() if ldisc present
Date:   Wed,  9 Jan 2019 01:17:40 +0000
Message-Id: <20190109011740.13729-1-dima@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to get reference for ldisc during tty_reopen().
If ldisc present, we don't need to do tty_ldisc_reinit() and lock the
write side for line discipline semaphore.
Effectively, it optimizes fast-path for tty_reopen(), but more
importantly it won't interrupt ongoing IO on the tty as no ldisc change
is needed.
Fixes user-visible issue when tty_reopen() interrupted login process for
user with a long password, observed and reported by Lukas.

Fixes: c96cf923a98d ("tty: Don't block on IO when ldisc change is pending")
Fixes: 83d817f41070 ("tty: Hold tty_ldisc_lock() during tty_reopen()")
Cc: Jiri Slaby <jslaby@suse.com>
Reported-by: Lukas F. Hartmann <lukas@mntmn.com>
Tested-by: Lukas F. Hartmann <lukas@mntmn.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index bfe9ad85b362..23c6fd238422 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1256,7 +1256,8 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
-	int retval;
+	struct tty_ldisc *ld;
+	int retval = 0;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1268,13 +1269,18 @@ static int tty_reopen(struct tty_struct *tty)
 	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
 		return -EBUSY;
 
-	retval = tty_ldisc_lock(tty, 5 * HZ);
-	if (retval)
-		return retval;
+	ld = tty_ldisc_ref_wait(tty);
+	if (ld) {
+		tty_ldisc_deref(ld);
+	} else {
+		retval = tty_ldisc_lock(tty, 5 * HZ);
+		if (retval)
+			return retval;
 
-	if (!tty->ldisc)
-		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	tty_ldisc_unlock(tty);
+		if (!tty->ldisc)
+			retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+		tty_ldisc_unlock(tty);
+	}
 
 	if (retval == 0)
 		tty->count++;
-- 
2.20.1


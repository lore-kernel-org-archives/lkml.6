Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1775CC7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D799320876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D799320876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeJNX3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:29:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37308 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeJNX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:29:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cf-C8; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000PN-Pl; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Jiri Slaby" <jslaby@suse.com>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.13907349@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 197/366] tty: Don't call panic() at tty_ldisc_init()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 903f9db10f18f735e62ba447147b6c434b6af003 upstream.

syzbot is reporting kernel panic [1] triggered by memory allocation failure
at tty_ldisc_get() from tty_ldisc_init(). But since both tty_ldisc_get()
and caller of tty_ldisc_init() can cleanly handle errors, tty_ldisc_init()
does not need to call panic() when tty_ldisc_get() failed.

[1] https://syzkaller.appspot.com/bug?id=883431818e036ae6a9981156a64b821110f39187

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/tty_io.c    | 5 ++++-
 drivers/tty/tty_ldisc.c | 5 +++--
 include/linux/tty.h     | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3036,7 +3036,10 @@ struct tty_struct *alloc_tty_struct(stru
 
 	kref_init(&tty->kref);
 	tty->magic = TTY_MAGIC;
-	tty_ldisc_init(tty);
+	if (tty_ldisc_init(tty)) {
+		kfree(tty);
+		return NULL;
+	}
 	tty->session = NULL;
 	tty->pgrp = NULL;
 	mutex_init(&tty->legacy_mutex);
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -820,12 +820,13 @@ void tty_ldisc_release(struct tty_struct
  *	the tty structure is not completely set up when this call is made.
  */
 
-void tty_ldisc_init(struct tty_struct *tty)
+int tty_ldisc_init(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = tty_ldisc_get(tty, N_TTY);
 	if (IS_ERR(ld))
-		panic("n_tty: init_tty");
+		return PTR_ERR(ld);
 	tty->ldisc = ld;
+	return 0;
 }
 
 /**
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -556,7 +556,7 @@ extern int tty_unregister_ldisc(int disc
 extern int tty_set_ldisc(struct tty_struct *tty, int ldisc);
 extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty);
-extern void tty_ldisc_init(struct tty_struct *tty);
+extern int __must_check tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern void tty_ldisc_begin(void);
 


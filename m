Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8167AC7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA642077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA642077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeJNXnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:43:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35789 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbeJNXLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:46 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0004cj-NH; Sun, 14 Oct 2018 16:30:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000Sc-IO; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dmitry Vyukov" <dvyukov@google.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Peter Hurley" <peter@hurleysoftware.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Michal Hocko" <mhocko@suse.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Vegard Nossum" <vegard.nossum@gmail.com>,
        "One Thousand Gnomes" <gnomes@lxorguk.ukuu.org.uk>,
        "syzbot" <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.275311387@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 221/366] tty: Use __GFP_NOFAIL for tty_ldisc_get()
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

commit bcdd0ca8cb8730573afebcaae4138f8f4c8eaa20 upstream.

syzbot is reporting crashes triggered by memory allocation fault injection
at tty_ldisc_get() [1]. As an attempt to handle OOM in a graceful way, we
have tried commit 5362544bebe85071 ("tty: don't panic on OOM in
tty_set_ldisc()"). But we reverted that attempt by commit a8983d01f9b7d600
("Revert "tty: don't panic on OOM in tty_set_ldisc()"") due to reproducible
crash. We should spend resource for finding and fixing race condition bugs
rather than complicate error paths for 2 * sizeof(void *) bytes allocation
failure.

[1] https://syzkaller.appspot.com/bug?id=489d33fa386453859ead58ff5171d43772b13aa3

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/tty_ldisc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -171,12 +171,11 @@ static struct tty_ldisc *tty_ldisc_get(s
 			return ERR_CAST(ldops);
 	}
 
-	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL);
-	if (ld == NULL) {
-		put_ldops(ldops);
-		return ERR_PTR(-ENOMEM);
-	}
-
+	/*
+	 * There is no way to handle allocation failure of only 16 bytes.
+	 * Let's simplify error handling and save more memory.
+	 */
+	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL | __GFP_NOFAIL);
 	ld->ops = ldops;
 	ld->tty = tty;
 


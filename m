Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E5BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C1E20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C1E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeJNXPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:15:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36577 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728174AbeJNXPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:15:38 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cW-Ec; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000PG-Or; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Johannes Weiner" <hannes@cmpxchg.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jslaby@suse.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Alan Cox" <alan@llwyncelyn.cymru>,
        syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com,
        "Christoph Hellwig" <hch@lst.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.420448062@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 196/366] tty: Avoid possible error pointer
 dereference at tty_ldisc_restore().
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

commit 598c2d41ff44889dd8eced4f117403e472158d85 upstream.

syzbot is reporting crashes [1] triggered by memory allocation failure at
tty_ldisc_get() from tty_ldisc_restore(). While syzbot stops at WARN_ON()
due to panic_on_warn == true, panic_on_warn == false will after all trigger
an OOPS by dereferencing old->ops->num if IS_ERR(old) == true.

We can simplify tty_ldisc_restore() as three calls (old->ops->num, N_TTY,
N_NULL) to tty_ldisc_failto() in addition to avoiding possible error
pointer dereference.

If someone reports kernel panic triggered by forcing all memory allocations
for tty_ldisc_restore() to fail, we can consider adding __GFP_NOFAIL for
tty_ldisc_restore() case.

[1] https://syzkaller.appspot.com/bug?id=6ac359c61e71d22e06db7f8f88243feb11d927e7

Reported-by: syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: tty_name() requires a buffer]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/tty_ldisc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -510,19 +510,16 @@ static void tty_ldisc_restore(struct tty
 	char buf[64];
 
 	/* There is an outstanding reference here so this is safe */
-	old = tty_ldisc_get(tty, old->ops->num);
-	WARN_ON(IS_ERR(old));
-	tty->ldisc = old;
-	tty_set_termios_ldisc(tty, old->ops->num);
-	if (tty_ldisc_open(tty, old) < 0) {
-		tty_ldisc_put(old);
+	if (tty_ldisc_failto(tty, old->ops->num) < 0) {
+		const char *name = tty_name(tty, buf);
+
+		pr_warn("Falling back ldisc for %s.\n", name);
 		/* The traditional behaviour is to fall back to N_TTY, we
 		   want to avoid falling back to N_NULL unless we have no
 		   choice to avoid the risk of breaking anything */
 		if (tty_ldisc_failto(tty, N_TTY) < 0 &&
 		    tty_ldisc_failto(tty, N_NULL) < 0)
-			panic("Couldn't open N_NULL ldisc for %s.",
-			      tty_name(tty, buf));
+			panic("Couldn't open N_NULL ldisc for %s.", name);
 	}
 }
 


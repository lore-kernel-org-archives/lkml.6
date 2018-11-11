Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD09FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8729D2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8729D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeKLFzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51864 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbeKLFzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:19 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsv-0000l4-B8; Sun, 11 Nov 2018 19:59:05 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001eW-Tz; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Peter Hurley" <peter@hurleysoftware.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "syzbot" <syzbot+108696293d7a21ab688f@syzkaller.appspotmail.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.244395438@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 210/366] n_tty: Access echo_* variables carefully.
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit ebec3f8f5271139df618ebdf8427e24ba102ba94 upstream.

syzbot is reporting stalls at __process_echoes() [1]. This is because
since ldata->echo_commit < ldata->echo_tail becomes true for some reason,
the discard loop is serving as almost infinite loop. This patch tries to
avoid falling into ldata->echo_commit < ldata->echo_tail situation by
making access to echo_* variables more carefully.

Since reset_buffer_flags() is called without output_lock held, it should
not touch echo_* variables. And omit a call to reset_buffer_flags() from
n_tty_open() by using vzalloc().

Since add_echo_byte() is called without output_lock held, it needs memory
barrier between storing into echo_buf[] and incrementing echo_head counter.
echo_buf() needs corresponding memory barrier before reading echo_buf[].
Lack of handling the possibility of not-yet-stored multi-byte operation
might be the reason of falling into ldata->echo_commit < ldata->echo_tail
situation, for if I do WARN_ON(ldata->echo_commit == tail + 1) prior to
echo_buf(ldata, tail + 1), the WARN_ON() fires.

Also, explicitly masking with buffer for the former "while" loop, and
use ldata->echo_commit > tail for the latter "while" loop.

[1] https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+108696293d7a21ab688f@syzkaller.appspotmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/n_tty.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -146,6 +146,7 @@ static inline unsigned char *read_buf_ad
 
 static inline unsigned char echo_buf(struct n_tty_data *ldata, size_t i)
 {
+	smp_rmb(); /* Matches smp_wmb() in add_echo_byte(). */
 	return ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
 }
 
@@ -347,8 +348,6 @@ static inline void put_tty_queue(unsigne
 static void reset_buffer_flags(struct n_tty_data *ldata)
 {
 	ldata->read_head = ldata->canon_head = ldata->read_tail = 0;
-	ldata->echo_head = ldata->echo_tail = ldata->echo_commit = 0;
-	ldata->echo_mark = 0;
 	ldata->line_start = 0;
 
 	ldata->erasing = 0;
@@ -669,13 +668,20 @@ static size_t __process_echoes(struct tt
 	old_space = space = tty_write_room(tty);
 
 	tail = ldata->echo_tail;
-	while (ldata->echo_commit != tail) {
+	while (MASK(ldata->echo_commit) != MASK(tail)) {
 		c = echo_buf(ldata, tail);
 		if (c == ECHO_OP_START) {
 			unsigned char op;
 			int no_space_left = 0;
 
 			/*
+			 * Since add_echo_byte() is called without holding
+			 * output_lock, we might see only portion of multi-byte
+			 * operation.
+			 */
+			if (MASK(ldata->echo_commit) == MASK(tail + 1))
+				goto not_yet_stored;
+			/*
 			 * If the buffer byte is the start of a multi-byte
 			 * operation, get the next byte, which is either the
 			 * op code or a control character value.
@@ -686,6 +692,8 @@ static size_t __process_echoes(struct tt
 				unsigned int num_chars, num_bs;
 
 			case ECHO_OP_ERASE_TAB:
+				if (MASK(ldata->echo_commit) == MASK(tail + 2))
+					goto not_yet_stored;
 				num_chars = echo_buf(ldata, tail + 2);
 
 				/*
@@ -780,7 +788,8 @@ static size_t __process_echoes(struct tt
 	/* If the echo buffer is nearly full (so that the possibility exists
 	 * of echo overrun before the next commit), then discard enough
 	 * data at the tail to prevent a subsequent overrun */
-	while (ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
+	while (ldata->echo_commit > tail &&
+	       ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
 		if (echo_buf(ldata, tail) == ECHO_OP_START) {
 			if (echo_buf(ldata, tail + 1) == ECHO_OP_ERASE_TAB)
 				tail += 3;
@@ -790,6 +799,7 @@ static size_t __process_echoes(struct tt
 			tail++;
 	}
 
+ not_yet_stored:
 	ldata->echo_tail = tail;
 	return old_space - space;
 }
@@ -800,6 +810,7 @@ static void commit_echoes(struct tty_str
 	size_t nr, old, echoed;
 	size_t head;
 
+	mutex_lock(&ldata->output_lock);
 	head = ldata->echo_head;
 	ldata->echo_mark = head;
 	old = ldata->echo_commit - ldata->echo_tail;
@@ -808,10 +819,12 @@ static void commit_echoes(struct tty_str
 	 * is over the threshold (and try again each time another
 	 * block is accumulated) */
 	nr = head - ldata->echo_tail;
-	if (nr < ECHO_COMMIT_WATERMARK || (nr % ECHO_BLOCK > old % ECHO_BLOCK))
+	if (nr < ECHO_COMMIT_WATERMARK ||
+	    (nr % ECHO_BLOCK > old % ECHO_BLOCK)) {
+		mutex_unlock(&ldata->output_lock);
 		return;
+	}
 
-	mutex_lock(&ldata->output_lock);
 	ldata->echo_commit = head;
 	echoed = __process_echoes(tty);
 	mutex_unlock(&ldata->output_lock);
@@ -862,7 +875,9 @@ static void flush_echoes(struct tty_stru
 
 static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 {
-	*echo_buf_addr(ldata, ldata->echo_head++) = c;
+	*echo_buf_addr(ldata, ldata->echo_head) = c;
+	smp_wmb(); /* Matches smp_rmb() in echo_buf(). */
+	ldata->echo_head++;
 }
 
 /**
@@ -1928,31 +1943,22 @@ static int n_tty_open(struct tty_struct
 	struct n_tty_data *ldata;
 
 	/* Currently a malloc failure here can panic */
-	ldata = vmalloc(sizeof(*ldata));
+	ldata = vzalloc(sizeof(*ldata));
 	if (!ldata)
-		goto err;
+		return -ENOMEM;
 
 	ldata->overrun_time = jiffies;
 	mutex_init(&ldata->atomic_read_lock);
 	mutex_init(&ldata->output_lock);
 
 	tty->disc_data = ldata;
-	reset_buffer_flags(tty->disc_data);
-	ldata->column = 0;
-	ldata->canon_column = 0;
 	ldata->minimum_to_wake = 1;
-	ldata->num_overrun = 0;
-	ldata->no_room = 0;
-	ldata->lnext = 0;
 	tty->closing = 0;
 	/* indicate buffer work may resume */
 	clear_bit(TTY_LDISC_HALTED, &tty->flags);
 	n_tty_set_termios(tty, NULL);
 	tty_unthrottle(tty);
-
 	return 0;
-err:
-	return -ENOMEM;
 }
 
 static inline int input_available_p(struct tty_struct *tty, int poll)


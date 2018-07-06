Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87216C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40723208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40723208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934054AbeGFFuz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933976AbeGFFuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:52 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC6D9C8D;
        Fri,  6 Jul 2018 05:50:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+108696293d7a21ab688f@syzkaller.appspotmail.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 4.14 10/61] n_tty: Access echo_* variables carefully.
Date:   Fri,  6 Jul 2018 07:46:34 +0200
Message-Id: <20180706054712.724688177@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/n_tty.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -145,6 +145,7 @@ static inline unsigned char *read_buf_ad
 
 static inline unsigned char echo_buf(struct n_tty_data *ldata, size_t i)
 {
+	smp_rmb(); /* Matches smp_wmb() in add_echo_byte(). */
 	return ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
 }
 
@@ -320,9 +321,7 @@ static inline void put_tty_queue(unsigne
 static void reset_buffer_flags(struct n_tty_data *ldata)
 {
 	ldata->read_head = ldata->canon_head = ldata->read_tail = 0;
-	ldata->echo_head = ldata->echo_tail = ldata->echo_commit = 0;
 	ldata->commit_head = 0;
-	ldata->echo_mark = 0;
 	ldata->line_start = 0;
 
 	ldata->erasing = 0;
@@ -621,13 +620,20 @@ static size_t __process_echoes(struct tt
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
@@ -638,6 +644,8 @@ static size_t __process_echoes(struct tt
 				unsigned int num_chars, num_bs;
 
 			case ECHO_OP_ERASE_TAB:
+				if (MASK(ldata->echo_commit) == MASK(tail + 2))
+					goto not_yet_stored;
 				num_chars = echo_buf(ldata, tail + 2);
 
 				/*
@@ -732,7 +740,8 @@ static size_t __process_echoes(struct tt
 	/* If the echo buffer is nearly full (so that the possibility exists
 	 * of echo overrun before the next commit), then discard enough
 	 * data at the tail to prevent a subsequent overrun */
-	while (ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
+	while (ldata->echo_commit > tail &&
+	       ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
 		if (echo_buf(ldata, tail) == ECHO_OP_START) {
 			if (echo_buf(ldata, tail + 1) == ECHO_OP_ERASE_TAB)
 				tail += 3;
@@ -742,6 +751,7 @@ static size_t __process_echoes(struct tt
 			tail++;
 	}
 
+ not_yet_stored:
 	ldata->echo_tail = tail;
 	return old_space - space;
 }
@@ -752,6 +762,7 @@ static void commit_echoes(struct tty_str
 	size_t nr, old, echoed;
 	size_t head;
 
+	mutex_lock(&ldata->output_lock);
 	head = ldata->echo_head;
 	ldata->echo_mark = head;
 	old = ldata->echo_commit - ldata->echo_tail;
@@ -760,10 +771,12 @@ static void commit_echoes(struct tty_str
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
@@ -814,7 +827,9 @@ static void flush_echoes(struct tty_stru
 
 static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 {
-	*echo_buf_addr(ldata, ldata->echo_head++) = c;
+	*echo_buf_addr(ldata, ldata->echo_head) = c;
+	smp_wmb(); /* Matches smp_rmb() in echo_buf(). */
+	ldata->echo_head++;
 }
 
 /**
@@ -1883,30 +1898,21 @@ static int n_tty_open(struct tty_struct
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



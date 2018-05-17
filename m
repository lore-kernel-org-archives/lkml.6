Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeEQMUD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:20:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:30310 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:20:02 -0400
Subject: Re: INFO: rcu detected stall in n_tty_receive_char_special
To: gregkh@linuxfoundation.org, jslaby@suse.com,
        Peter Hurley <peter@hurleysoftware.com>
Cc: dvyukov@google.com,
        syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <883d24f7d4ccc52e19056928c5be@google.com>
 <001a113f8d5cab39bd0569e3482a@google.com>
 <93a0c663-bbcf-0779-5606-6eeda644f8b9@I-love.SAKURA.ne.jp>
 <e7a78d54-20c8-773d-e2aa-b6ad066a1fca@I-love.SAKURA.ne.jp>
 <9d6bf77a-0a00-19d7-19f7-53082f494e81@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <17752ce7-be26-7ae1-a5bd-6e5fff70fa9e@I-love.SAKURA.ne.jp>
Date: Thu, 17 May 2018 21:19:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9d6bf77a-0a00-19d7-19f7-53082f494e81@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

>From ada7279f7f034c5fd79fc04e1120069ea5f6cef2 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 17 May 2018 20:42:50 +0900
Subject: [PATCH] n_tty: Access echo_* variables carefully.

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

The echo_* variables are now updated with output_lock held. Thus, I guess
that ldata->echo_commit < ldata->echo_tail is no longer possible. But to
become more carefully, use ldata->echo_commit > ldata->echo_tail as
the preventive condition to continue the "while" loops.

[1] https://syzkaller.appspot.com/bug?id=3d7481a346958d9469bebbeb0537d5f056bdd6e8

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index cbe98bc..060ef91 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -90,9 +90,6 @@ struct n_tty_data {
 	size_t read_head;
 	size_t commit_head;
 	size_t canon_head;
-	size_t echo_head;
-	size_t echo_commit;
-	size_t echo_mark;
 	DECLARE_BITMAP(char_map, 256);
 
 	/* private to n_tty_receive_overrun (single-threaded) */
@@ -119,6 +116,9 @@ struct n_tty_data {
 	unsigned int column;
 	unsigned int canon_column;
 	size_t echo_tail;
+	size_t echo_head;
+	size_t echo_commit;
+	size_t echo_mark;
 
 	struct mutex atomic_read_lock;
 	struct mutex output_lock;
@@ -141,6 +141,7 @@ static inline unsigned char *read_buf_addr(struct n_tty_data *ldata, size_t i)
 
 static inline unsigned char echo_buf(struct n_tty_data *ldata, size_t i)
 {
+	smp_rmb(); /* Matches smp_wmb() in add_echo_byte(). */
 	return ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
 }
 
@@ -316,9 +317,7 @@ static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
 static void reset_buffer_flags(struct n_tty_data *ldata)
 {
 	ldata->read_head = ldata->canon_head = ldata->read_tail = 0;
-	ldata->echo_head = ldata->echo_tail = ldata->echo_commit = 0;
 	ldata->commit_head = 0;
-	ldata->echo_mark = 0;
 	ldata->line_start = 0;
 
 	ldata->erasing = 0;
@@ -617,13 +616,22 @@ static size_t __process_echoes(struct tty_struct *tty)
 	old_space = space = tty_write_room(tty);
 
 	tail = ldata->echo_tail;
-	while (ldata->echo_commit != tail) {
+	if (WARN_ON(ldata->echo_commit < tail))
+		return 0;
+	while (ldata->echo_commit > tail) {
 		c = echo_buf(ldata, tail);
 		if (c == ECHO_OP_START) {
 			unsigned char op;
 			int no_space_left = 0;
 
 			/*
+			 * Since add_echo_byte() is called without holding
+			 * output_lock, we might see only portion of multi-byte
+			 * operation.
+			 */
+			if (ldata->echo_commit == tail + 1)
+				goto not_yet_stored;
+			/*
 			 * If the buffer byte is the start of a multi-byte
 			 * operation, get the next byte, which is either the
 			 * op code or a control character value.
@@ -634,6 +642,8 @@ static size_t __process_echoes(struct tty_struct *tty)
 				unsigned int num_chars, num_bs;
 
 			case ECHO_OP_ERASE_TAB:
+				if (ldata->echo_commit == tail + 2)
+					goto not_yet_stored;
 				num_chars = echo_buf(ldata, tail + 2);
 
 				/*
@@ -728,7 +738,9 @@ static size_t __process_echoes(struct tty_struct *tty)
 	/* If the echo buffer is nearly full (so that the possibility exists
 	 * of echo overrun before the next commit), then discard enough
 	 * data at the tail to prevent a subsequent overrun */
-	while (ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
+	WARN_ON(ldata->echo_commit < tail);
+	while (ldata->echo_commit > tail &&
+	       ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
 		if (echo_buf(ldata, tail) == ECHO_OP_START) {
 			if (echo_buf(ldata, tail + 1) == ECHO_OP_ERASE_TAB)
 				tail += 3;
@@ -738,6 +750,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 			tail++;
 	}
 
+ not_yet_stored:
 	ldata->echo_tail = tail;
 	return old_space - space;
 }
@@ -748,6 +761,7 @@ static void commit_echoes(struct tty_struct *tty)
 	size_t nr, old, echoed;
 	size_t head;
 
+	mutex_lock(&ldata->output_lock);
 	head = ldata->echo_head;
 	ldata->echo_mark = head;
 	old = ldata->echo_commit - ldata->echo_tail;
@@ -756,10 +770,12 @@ static void commit_echoes(struct tty_struct *tty)
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
@@ -810,7 +826,9 @@ static void flush_echoes(struct tty_struct *tty)
 
 static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 {
-	*echo_buf_addr(ldata, ldata->echo_head++) = c;
+	*echo_buf_addr(ldata, ldata->echo_head) = c;
+	smp_wmb(); /* Matches smp_rmb() in echo_buf(). */
+	ldata->echo_head++;
 }
 
 /**
@@ -1878,30 +1896,21 @@ static int n_tty_open(struct tty_struct *tty)
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
-- 
1.8.3.1

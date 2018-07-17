Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53567ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3432146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3432146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQKrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:47:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63748 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeGQKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:47:15 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6HAF4Ue011638;
        Tue, 17 Jul 2018 19:15:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 17 Jul 2018 19:15:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6HAEt2t011538
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 17 Jul 2018 19:15:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] n_tty: Protect tty->disc_data using refcount.
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <001a113ed31a122ced0568cc6be1@google.com>
 <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
 <35d649ce-0c22-f839-aa4d-19733bf31a9c@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <83fdde07-2f8e-8d20-30a2-a8f0804a5044@I-love.SAKURA.ne.jp>
Date:   Tue, 17 Jul 2018 19:14:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <35d649ce-0c22-f839-aa4d-19733bf31a9c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From e8360c16fd07985686bcfb388364103f35a6523a Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 17 Jul 2018 16:43:32 +0900
Subject: [PATCH] n_tty: Protect tty->disc_data using refcount.

syzbot is reporting NULL pointer dereference at n_tty_set_termios() [1].
This is because ioctl(TIOCVHANGUP) versus ioctl(TCSETS) can race.

Since we don't want to introduce new locking dependency, this patch
converts "struct n_tty_data *ldata = tty->disc_data;" in individual
function into a function argument which follows "struct tty *", and
holds tty->disc_data at each "struct tty_ldisc_ops" hook using refcount
in order to ensure that memory which contains "struct n_tty_data" will
not be released while processing individual function.

What is the best return value for these "struct tty_ldisc_ops" hooks
when we hit this race is not clear. We might need to tweak some of them.

[1] https://syzkaller.appspot.com/bug?id=1e850009fca0b64ce49dc16499bda4f7de0ab1a5

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/n_tty.c | 503 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 308 insertions(+), 195 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4317422..fc0a4bf 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -122,6 +122,10 @@ struct n_tty_data {
 
 	struct mutex atomic_read_lock;
 	struct mutex output_lock;
+
+	/* Race protection. */
+	refcount_t users;
+	struct rcu_head rcu;
 };
 
 #define MASK(x) ((x) & (N_TTY_BUF_SIZE - 1))
@@ -152,10 +156,9 @@ static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 	return &ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
 }
 
-static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
-			    size_t tail, size_t n)
+static int tty_copy_to_user(struct tty_struct *tty, struct n_tty_data *ldata,
+			    void __user *to, size_t tail, size_t n)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	size_t size = N_TTY_BUF_SIZE - tail;
 	const void *from = read_buf_addr(ldata, tail);
 	int uncopied;
@@ -186,10 +189,8 @@ static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
  *		holds non-exclusive termios_rwsem
  */
 
-static void n_tty_kick_worker(struct tty_struct *tty)
+static void n_tty_kick_worker(struct tty_struct *tty, struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	/* Did the input worker stop? Restart it */
 	if (unlikely(ldata->no_room)) {
 		ldata->no_room = 0;
@@ -206,9 +207,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
 	}
 }
 
-static ssize_t chars_in_buffer(struct tty_struct *tty)
+static ssize_t chars_in_buffer(struct tty_struct *tty, struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	ssize_t n = 0;
 
 	if (!ldata->icanon)
@@ -233,10 +233,9 @@ static void n_tty_write_wakeup(struct tty_struct *tty)
 	kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
 }
 
-static void n_tty_check_throttle(struct tty_struct *tty)
+static void n_tty_check_throttle(struct tty_struct *tty,
+				 struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	/*
 	 * Check the remaining room for the input canonicalization
 	 * mode.  We don't want to throttle the driver if we're in
@@ -257,12 +256,13 @@ static void n_tty_check_throttle(struct tty_struct *tty)
 	__tty_set_flow_change(tty, 0);
 }
 
-static void n_tty_check_unthrottle(struct tty_struct *tty)
+static void n_tty_check_unthrottle(struct tty_struct *tty,
+				   struct n_tty_data *ldata)
 {
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY) {
-		if (chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
+		if (chars_in_buffer(tty, ldata) > TTY_THRESHOLD_UNTHROTTLE)
 			return;
-		n_tty_kick_worker(tty);
+		n_tty_kick_worker(tty, ldata);
 		tty_wakeup(tty->link);
 		return;
 	}
@@ -278,9 +278,9 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
 	while (1) {
 		int unthrottled;
 		tty_set_flow_change(tty, TTY_UNTHROTTLE_SAFE);
-		if (chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
+		if (chars_in_buffer(tty, ldata) > TTY_THRESHOLD_UNTHROTTLE)
 			break;
-		n_tty_kick_worker(tty);
+		n_tty_kick_worker(tty, ldata);
 		unthrottled = tty_unthrottle_safe(tty);
 		if (!unthrottled)
 			break;
@@ -353,11 +353,12 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
  *	Locking: ctrl_lock, exclusive termios_rwsem
  */
 
-static void n_tty_flush_buffer(struct tty_struct *tty)
+static void __n_tty_flush_buffer(struct tty_struct *tty,
+				 struct n_tty_data *ldata)
 {
 	down_write(&tty->termios_rwsem);
-	reset_buffer_flags(tty->disc_data);
-	n_tty_kick_worker(tty);
+	reset_buffer_flags(ldata);
+	n_tty_kick_worker(tty, ldata);
 
 	if (tty->link)
 		n_tty_packet_mode_flush(tty);
@@ -413,9 +414,9 @@ static inline int is_continuation(unsigned char c, struct tty_struct *tty)
  *		 the column state and space left in the buffer
  */
 
-static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
+static int do_output_char(unsigned char c, struct tty_struct *tty,
+			  struct n_tty_data *ldata, int space)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int	spaces;
 
 	if (!space)
@@ -488,15 +489,15 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
  *		  tty layer write lock)
  */
 
-static int process_output(unsigned char c, struct tty_struct *tty)
+static int process_output(unsigned char c, struct tty_struct *tty,
+			  struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int	space, retval;
 
 	mutex_lock(&ldata->output_lock);
 
 	space = tty_write_room(tty);
-	retval = do_output_char(c, tty, space);
+	retval = do_output_char(c, tty, ldata, space);
 
 	mutex_unlock(&ldata->output_lock);
 	if (retval < 0)
@@ -525,9 +526,9 @@ static int process_output(unsigned char c, struct tty_struct *tty)
  */
 
 static ssize_t process_output_block(struct tty_struct *tty,
+				    struct n_tty_data *ldata,
 				    const unsigned char *buf, unsigned int nr)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int	space;
 	int	i;
 	const unsigned char *cp;
@@ -608,9 +609,8 @@ static ssize_t process_output_block(struct tty_struct *tty,
  *	Locking: callers must hold output_lock
  */
 
-static size_t __process_echoes(struct tty_struct *tty)
+static size_t __process_echoes(struct tty_struct *tty, struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int	space, old_space;
 	size_t tail;
 	unsigned char c;
@@ -721,7 +721,8 @@ static size_t __process_echoes(struct tty_struct *tty)
 				break;
 		} else {
 			if (O_OPOST(tty)) {
-				int retval = do_output_char(c, tty, space);
+				int retval = do_output_char(c, tty, ldata,
+							    space);
 				if (retval < 0)
 					break;
 				space -= retval;
@@ -754,9 +755,8 @@ static size_t __process_echoes(struct tty_struct *tty)
 	return old_space - space;
 }
 
-static void commit_echoes(struct tty_struct *tty)
+static void commit_echoes(struct tty_struct *tty, struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	size_t nr, old, echoed;
 	size_t head;
 
@@ -776,16 +776,15 @@ static void commit_echoes(struct tty_struct *tty)
 	}
 
 	ldata->echo_commit = head;
-	echoed = __process_echoes(tty);
+	echoed = __process_echoes(tty, ldata);
 	mutex_unlock(&ldata->output_lock);
 
 	if (echoed && tty->ops->flush_chars)
 		tty->ops->flush_chars(tty);
 }
 
-static void process_echoes(struct tty_struct *tty)
+static void process_echoes(struct tty_struct *tty, struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	size_t echoed;
 
 	if (ldata->echo_mark == ldata->echo_tail)
@@ -793,7 +792,7 @@ static void process_echoes(struct tty_struct *tty)
 
 	mutex_lock(&ldata->output_lock);
 	ldata->echo_commit = ldata->echo_mark;
-	echoed = __process_echoes(tty);
+	echoed = __process_echoes(tty, ldata);
 	mutex_unlock(&ldata->output_lock);
 
 	if (echoed && tty->ops->flush_chars)
@@ -801,17 +800,15 @@ static void process_echoes(struct tty_struct *tty)
 }
 
 /* NB: echo_mark and echo_head should be equivalent here */
-static void flush_echoes(struct tty_struct *tty)
+static void flush_echoes(struct tty_struct *tty, struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if ((!L_ECHO(tty) && !L_ECHONL(tty)) ||
 	    ldata->echo_commit == ldata->echo_head)
 		return;
 
 	mutex_lock(&ldata->output_lock);
 	ldata->echo_commit = ldata->echo_head;
-	__process_echoes(tty);
+	__process_echoes(tty, ldata);
 	mutex_unlock(&ldata->output_lock);
 }
 
@@ -921,10 +918,9 @@ static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
  *	(where X is the letter representing the control char).
  */
 
-static void echo_char(unsigned char c, struct tty_struct *tty)
+static void echo_char(unsigned char c, struct tty_struct *tty,
+		      struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (c == ECHO_OP_START) {
 		add_echo_byte(ECHO_OP_START, ldata);
 		add_echo_byte(ECHO_OP_START, ldata);
@@ -961,9 +957,9 @@ static inline void finish_erasing(struct n_tty_data *ldata)
  *		caller holds non-exclusive termios_rwsem
  */
 
-static void eraser(unsigned char c, struct tty_struct *tty)
+static void eraser(unsigned char c, struct tty_struct *tty,
+		   struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	enum { ERASE, WERASE, KILL } kill_type;
 	size_t head;
 	size_t cnt;
@@ -985,7 +981,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		if (!L_ECHOK(tty) || !L_ECHOKE(tty) || !L_ECHOE(tty)) {
 			ldata->read_head = ldata->canon_head;
 			finish_erasing(ldata);
-			echo_char(KILL_CHAR(tty), tty);
+			echo_char(KILL_CHAR(tty), tty, ldata);
 			/* Add a newline if ECHOK is on and ECHOKE is off. */
 			if (L_ECHOK(tty))
 				echo_char_raw('\n', ldata);
@@ -1025,14 +1021,14 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 					ldata->erasing = 1;
 				}
 				/* if cnt > 1, output a multi-byte character */
-				echo_char(c, tty);
+				echo_char(c, tty, ldata);
 				while (--cnt > 0) {
 					head++;
 					echo_char_raw(read_buf(ldata, head), ldata);
 					echo_move_back_col(ldata);
 				}
 			} else if (kill_type == ERASE && !L_ECHOE(tty)) {
-				echo_char(ERASE_CHAR(tty), tty);
+				echo_char(ERASE_CHAR(tty), tty, ldata);
 			} else if (c == '\t') {
 				unsigned int num_chars = 0;
 				int after_tab = 0;
@@ -1103,10 +1099,8 @@ static void __isig(int sig, struct tty_struct *tty)
 	}
 }
 
-static void isig(int sig, struct tty_struct *tty)
+static void isig(int sig, struct tty_struct *tty, struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (L_NOFLSH(tty)) {
 		/* signal only */
 		__isig(sig, tty);
@@ -1127,7 +1121,7 @@ static void isig(int sig, struct tty_struct *tty)
 		tty_driver_flush_buffer(tty);
 
 		/* clear input buffer */
-		reset_buffer_flags(tty->disc_data);
+		reset_buffer_flags(ldata);
 
 		/* notify pty master of flush */
 		if (tty->link)
@@ -1151,14 +1145,13 @@ static void isig(int sig, struct tty_struct *tty)
  *	Note: may get exclusive termios_rwsem if flushing input buffer
  */
 
-static void n_tty_receive_break(struct tty_struct *tty)
+static void n_tty_receive_break(struct tty_struct *tty,
+				struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (I_IGNBRK(tty))
 		return;
 	if (I_BRKINT(tty)) {
-		isig(SIGINT, tty);
+		isig(SIGINT, tty, ldata);
 		return;
 	}
 	if (I_PARMRK(tty)) {
@@ -1181,10 +1174,9 @@ static void n_tty_receive_break(struct tty_struct *tty)
  *	private.
  */
 
-static void n_tty_receive_overrun(struct tty_struct *tty)
+static void n_tty_receive_overrun(struct tty_struct *tty,
+				  struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	ldata->num_overrun++;
 	if (time_after(jiffies, ldata->overrun_time + HZ) ||
 			time_after(ldata->overrun_time, jiffies)) {
@@ -1205,10 +1197,10 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
  *	n_tty_receive_buf()/producer path:
  *		caller holds non-exclusive termios_rwsem
  */
-static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_parity_error(struct tty_struct *tty,
+				       struct n_tty_data *ldata,
+				       unsigned char c)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (I_INPCK(tty)) {
 		if (I_IGNPAR(tty))
 			return;
@@ -1223,16 +1215,17 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 }
 
 static void
-n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
+n_tty_receive_signal_char(struct tty_struct *tty, struct n_tty_data *ldata,
+			  int signal, unsigned char c)
 {
-	isig(signal, tty);
+	isig(signal, tty, ldata);
 	if (I_IXON(tty))
 		start_tty(tty);
 	if (L_ECHO(tty)) {
-		echo_char(c, tty);
-		commit_echoes(tty);
+		echo_char(c, tty, ldata);
+		commit_echoes(tty, ldata);
 	} else
-		process_echoes(tty);
+		process_echoes(tty, ldata);
 	return;
 }
 
@@ -1253,14 +1246,13 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
  */
 
 static int
-n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
+n_tty_receive_char_special(struct tty_struct *tty, struct n_tty_data *ldata,
+			   unsigned char c)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (I_IXON(tty)) {
 		if (c == START_CHAR(tty)) {
 			start_tty(tty);
-			process_echoes(tty);
+			process_echoes(tty, ldata);
 			return 0;
 		}
 		if (c == STOP_CHAR(tty)) {
@@ -1271,20 +1263,20 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 
 	if (L_ISIG(tty)) {
 		if (c == INTR_CHAR(tty)) {
-			n_tty_receive_signal_char(tty, SIGINT, c);
+			n_tty_receive_signal_char(tty, ldata, SIGINT, c);
 			return 0;
 		} else if (c == QUIT_CHAR(tty)) {
-			n_tty_receive_signal_char(tty, SIGQUIT, c);
+			n_tty_receive_signal_char(tty, ldata, SIGQUIT, c);
 			return 0;
 		} else if (c == SUSP_CHAR(tty)) {
-			n_tty_receive_signal_char(tty, SIGTSTP, c);
+			n_tty_receive_signal_char(tty, ldata, SIGTSTP, c);
 			return 0;
 		}
 	}
 
 	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
 		start_tty(tty);
-		process_echoes(tty);
+		process_echoes(tty, ldata);
 	}
 
 	if (c == '\r') {
@@ -1298,8 +1290,8 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 	if (ldata->icanon) {
 		if (c == ERASE_CHAR(tty) || c == KILL_CHAR(tty) ||
 		    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
-			eraser(c, tty);
-			commit_echoes(tty);
+			eraser(c, tty, ldata);
+			commit_echoes(tty, ldata);
 			return 0;
 		}
 		if (c == LNEXT_CHAR(tty) && L_IEXTEN(tty)) {
@@ -1309,7 +1301,7 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 				if (L_ECHOCTL(tty)) {
 					echo_char_raw('^', ldata);
 					echo_char_raw('\b', ldata);
-					commit_echoes(tty);
+					commit_echoes(tty, ldata);
 				}
 			}
 			return 1;
@@ -1318,19 +1310,19 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 			size_t tail = ldata->canon_head;
 
 			finish_erasing(ldata);
-			echo_char(c, tty);
+			echo_char(c, tty, ldata);
 			echo_char_raw('\n', ldata);
 			while (MASK(tail) != MASK(ldata->read_head)) {
-				echo_char(read_buf(ldata, tail), tty);
+				echo_char(read_buf(ldata, tail), tty, ldata);
 				tail++;
 			}
-			commit_echoes(tty);
+			commit_echoes(tty, ldata);
 			return 0;
 		}
 		if (c == '\n') {
 			if (L_ECHO(tty) || L_ECHONL(tty)) {
 				echo_char_raw('\n', ldata);
-				commit_echoes(tty);
+				commit_echoes(tty, ldata);
 			}
 			goto handle_newline;
 		}
@@ -1347,8 +1339,8 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 				/* Record the column of first canon char. */
 				if (ldata->canon_head == ldata->read_head)
 					echo_set_canon_col(ldata);
-				echo_char(c, tty);
-				commit_echoes(tty);
+				echo_char(c, tty, ldata);
+				commit_echoes(tty, ldata);
 			}
 			/*
 			 * XXX does PARMRK doubling happen for
@@ -1375,9 +1367,9 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 			/* Record the column of first canon char. */
 			if (ldata->canon_head == ldata->read_head)
 				echo_set_canon_col(ldata);
-			echo_char(c, tty);
+			echo_char(c, tty, ldata);
 		}
-		commit_echoes(tty);
+		commit_echoes(tty, ldata);
 	}
 
 	/* PARMRK doubling check */
@@ -1389,21 +1381,20 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 }
 
 static inline void
-n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
+n_tty_receive_char_inline(struct tty_struct *tty, struct n_tty_data *ldata,
+			  unsigned char c)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
 		start_tty(tty);
-		process_echoes(tty);
+		process_echoes(tty, ldata);
 	}
 	if (L_ECHO(tty)) {
 		finish_erasing(ldata);
 		/* Record the column of first canon char. */
 		if (ldata->canon_head == ldata->read_head)
 			echo_set_canon_col(ldata);
-		echo_char(c, tty);
-		commit_echoes(tty);
+		echo_char(c, tty, ldata);
+		commit_echoes(tty, ldata);
 	}
 	/* PARMRK doubling check */
 	if (c == (unsigned char) '\377' && I_PARMRK(tty))
@@ -1411,32 +1402,34 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char(struct tty_struct *tty, struct n_tty_data *ldata,
+			       unsigned char c)
 {
-	n_tty_receive_char_inline(tty, c);
+	n_tty_receive_char_inline(tty, ldata, c);
 }
 
 static inline void
-n_tty_receive_char_fast(struct tty_struct *tty, unsigned char c)
+n_tty_receive_char_fast(struct tty_struct *tty, struct n_tty_data *ldata,
+			unsigned char c)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
 		start_tty(tty);
-		process_echoes(tty);
+		process_echoes(tty, ldata);
 	}
 	if (L_ECHO(tty)) {
 		finish_erasing(ldata);
 		/* Record the column of first canon char. */
 		if (ldata->canon_head == ldata->read_head)
 			echo_set_canon_col(ldata);
-		echo_char(c, tty);
-		commit_echoes(tty);
+		echo_char(c, tty, ldata);
+		commit_echoes(tty, ldata);
 	}
 	put_tty_queue(c, ldata);
 }
 
-static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char_closing(struct tty_struct *tty,
+				       struct n_tty_data *ldata,
+				       unsigned char c)
 {
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
@@ -1451,24 +1444,25 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
 			  c != SUSP_CHAR(tty))) {
 			start_tty(tty);
-			process_echoes(tty);
+			process_echoes(tty, ldata);
 		}
 	}
 }
 
 static void
-n_tty_receive_char_flagged(struct tty_struct *tty, unsigned char c, char flag)
+n_tty_receive_char_flagged(struct tty_struct *tty, struct n_tty_data *ldata,
+			   unsigned char c, char flag)
 {
 	switch (flag) {
 	case TTY_BREAK:
-		n_tty_receive_break(tty);
+		n_tty_receive_break(tty, ldata);
 		break;
 	case TTY_PARITY:
 	case TTY_FRAME:
-		n_tty_receive_parity_error(tty, c);
+		n_tty_receive_parity_error(tty, ldata, c);
 		break;
 	case TTY_OVERRUN:
-		n_tty_receive_overrun(tty);
+		n_tty_receive_overrun(tty, ldata);
 		break;
 	default:
 		tty_err(tty, "unknown flag %d\n", flag);
@@ -1477,26 +1471,24 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 }
 
 static void
-n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
+n_tty_receive_char_lnext(struct tty_struct *tty, struct n_tty_data *ldata,
+			 unsigned char c, char flag)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	ldata->lnext = 0;
 	if (likely(flag == TTY_NORMAL)) {
 		if (I_ISTRIP(tty))
 			c &= 0x7f;
 		if (I_IUCLC(tty) && L_IEXTEN(tty))
 			c = tolower(c);
-		n_tty_receive_char(tty, c);
+		n_tty_receive_char(tty, ldata, c);
 	} else
-		n_tty_receive_char_flagged(tty, c, flag);
+		n_tty_receive_char_flagged(tty, ldata, c, flag);
 }
 
 static void
-n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
-			   char *fp, int count)
+n_tty_receive_buf_real_raw(struct tty_struct *tty, struct n_tty_data *ldata,
+			   const unsigned char *cp, char *fp, int count)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, head;
 
 	head = ldata->read_head & (N_TTY_BUF_SIZE - 1);
@@ -1513,10 +1505,9 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 }
 
 static void
-n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
-		      char *fp, int count)
+n_tty_receive_buf_raw(struct tty_struct *tty, struct n_tty_data *ldata,
+		      const unsigned char *cp, char *fp, int count)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
 
 	while (count--) {
@@ -1525,13 +1516,13 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 		if (likely(flag == TTY_NORMAL))
 			put_tty_queue(*cp++, ldata);
 		else
-			n_tty_receive_char_flagged(tty, *cp++, flag);
+			n_tty_receive_char_flagged(tty, ldata, *cp++, flag);
 	}
 }
 
 static void
-n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
-			  char *fp, int count)
+n_tty_receive_buf_closing(struct tty_struct *tty, struct n_tty_data *ldata,
+			  const unsigned char *cp, char *fp, int count)
 {
 	char flag = TTY_NORMAL;
 
@@ -1539,15 +1530,14 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 		if (fp)
 			flag = *fp++;
 		if (likely(flag == TTY_NORMAL))
-			n_tty_receive_char_closing(tty, *cp++);
+			n_tty_receive_char_closing(tty, ldata, *cp++);
 	}
 }
 
 static void
-n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
-			  char *fp, int count)
+n_tty_receive_buf_standard(struct tty_struct *tty, struct n_tty_data *ldata,
+			   const unsigned char *cp, char *fp, int count)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
 
 	while (count--) {
@@ -1565,23 +1555,24 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 				continue;
 			}
 			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char_inline(tty, c);
-			else if (n_tty_receive_char_special(tty, c) && count) {
+				n_tty_receive_char_inline(tty, ldata, c);
+			else if (n_tty_receive_char_special(tty, ldata, c) &&
+				 count) {
 				if (fp)
 					flag = *fp++;
-				n_tty_receive_char_lnext(tty, *cp++, flag);
+				n_tty_receive_char_lnext(tty, ldata, *cp++,
+							 flag);
 				count--;
 			}
 		} else
-			n_tty_receive_char_flagged(tty, *cp++, flag);
+			n_tty_receive_char_flagged(tty, ldata, *cp++, flag);
 	}
 }
 
 static void
-n_tty_receive_buf_fast(struct tty_struct *tty, const unsigned char *cp,
-		       char *fp, int count)
+n_tty_receive_buf_fast(struct tty_struct *tty, struct n_tty_data *ldata,
+		       const unsigned char *cp, char *fp, int count)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
 
 	while (count--) {
@@ -1591,46 +1582,47 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 			unsigned char c = *cp++;
 
 			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char_fast(tty, c);
-			else if (n_tty_receive_char_special(tty, c) && count) {
+				n_tty_receive_char_fast(tty, ldata, c);
+			else if (n_tty_receive_char_special(tty, ldata, c) &&
+				 count) {
 				if (fp)
 					flag = *fp++;
-				n_tty_receive_char_lnext(tty, *cp++, flag);
+				n_tty_receive_char_lnext(tty, ldata, *cp++,
+							 flag);
 				count--;
 			}
 		} else
-			n_tty_receive_char_flagged(tty, *cp++, flag);
+			n_tty_receive_char_flagged(tty, ldata, *cp++, flag);
 	}
 }
 
-static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			  char *fp, int count)
+static void __receive_buf(struct tty_struct *tty, struct n_tty_data *ldata,
+			  const unsigned char *cp, char *fp, int count)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	bool preops = I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
 
 	if (ldata->real_raw)
-		n_tty_receive_buf_real_raw(tty, cp, fp, count);
+		n_tty_receive_buf_real_raw(tty, ldata, cp, fp, count);
 	else if (ldata->raw || (L_EXTPROC(tty) && !preops))
-		n_tty_receive_buf_raw(tty, cp, fp, count);
+		n_tty_receive_buf_raw(tty, ldata, cp, fp, count);
 	else if (tty->closing && !L_EXTPROC(tty))
-		n_tty_receive_buf_closing(tty, cp, fp, count);
+		n_tty_receive_buf_closing(tty, ldata, cp, fp, count);
 	else {
 		if (ldata->lnext) {
 			char flag = TTY_NORMAL;
 
 			if (fp)
 				flag = *fp++;
-			n_tty_receive_char_lnext(tty, *cp++, flag);
+			n_tty_receive_char_lnext(tty, ldata, *cp++, flag);
 			count--;
 		}
 
 		if (!preops && !I_PARMRK(tty))
-			n_tty_receive_buf_fast(tty, cp, fp, count);
+			n_tty_receive_buf_fast(tty, ldata, cp, fp, count);
 		else
-			n_tty_receive_buf_standard(tty, cp, fp, count);
+			n_tty_receive_buf_standard(tty, ldata, cp, fp, count);
 
-		flush_echoes(tty);
+		flush_echoes(tty, ldata);
 		if (tty->ops->flush_chars)
 			tty->ops->flush_chars(tty);
 	}
@@ -1681,10 +1673,9 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  *		publishes commit_head or canon_head
  */
 static int
-n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
-			 char *fp, int count, int flow)
+n_tty_receive_buf_common(struct tty_struct *tty, struct n_tty_data *ldata,
+			 const unsigned char *cp, char *fp, int count, int flow)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int room, n, rcvd = 0, overflow;
 
 	down_read(&tty->termios_rwsem);
@@ -1724,7 +1715,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 
 		/* ignore parity errors if handling overflow */
 		if (!overflow || !fp || *fp != TTY_PARITY)
-			__receive_buf(tty, cp, fp, n);
+			__receive_buf(tty, ldata, cp, fp, n);
 
 		cp += n;
 		if (fp)
@@ -1743,23 +1734,25 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			__tty_set_flow_change(tty, 0);
 		}
 	} else
-		n_tty_check_throttle(tty);
+		n_tty_check_throttle(tty, ldata);
 
 	up_read(&tty->termios_rwsem);
 
 	return rcvd;
 }
 
-static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
+static void __n_tty_receive_buf(struct tty_struct *tty,
+				struct n_tty_data *ldata,
+				const unsigned char *cp, char *fp, int count)
 {
-	n_tty_receive_buf_common(tty, cp, fp, count, 0);
+	n_tty_receive_buf_common(tty, ldata, cp, fp, count, 0);
 }
 
-static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
+static int __n_tty_receive_buf2(struct tty_struct *tty,
+				struct n_tty_data *ldata,
+				const unsigned char *cp, char *fp, int count)
 {
-	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
+	return n_tty_receive_buf_common(tty, ldata, cp, fp, count, 1);
 }
 
 /**
@@ -1776,10 +1769,9 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
  *	Locking: Caller holds tty->termios_rwsem
  */
 
-static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
+static void __n_tty_set_termios(struct tty_struct *tty,
+				struct n_tty_data *ldata, struct ktermios *old)
 {
-	struct n_tty_data *ldata = tty->disc_data;
-
 	if (!old || (old->c_lflag ^ tty->termios.c_lflag) & (ICANON | EXTPROC)) {
 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 		ldata->line_start = ldata->read_tail;
@@ -1852,7 +1844,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	 */
 	if (!I_IXON(tty) && old && (old->c_iflag & IXON) && !tty->flow_stopped) {
 		start_tty(tty);
-		process_echoes(tty);
+		process_echoes(tty, ldata);
 	}
 
 	/* The termios change make the tty ready for I/O */
@@ -1869,7 +1861,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  *	discipline change. The function will not be called while other
  *	ldisc methods are in progress.
  */
-
+static void put_n_tty(struct n_tty_data *ldata);
 static void n_tty_close(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1877,8 +1869,8 @@ static void n_tty_close(struct tty_struct *tty)
 	if (tty->link)
 		n_tty_packet_mode_flush(tty);
 
-	vfree(ldata);
 	tty->disc_data = NULL;
+	put_n_tty(ldata);
 }
 
 /**
@@ -1890,7 +1882,7 @@ static void n_tty_close(struct tty_struct *tty)
  *	other events will occur in parallel. No further open will occur
  *	until a close.
  */
-
+static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old);
 static int n_tty_open(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata;
@@ -1900,6 +1892,7 @@ static int n_tty_open(struct tty_struct *tty)
 	if (!ldata)
 		return -ENOMEM;
 
+	refcount_set(&ldata->users, 1);
 	ldata->overrun_time = jiffies;
 	mutex_init(&ldata->atomic_read_lock);
 	mutex_init(&ldata->output_lock);
@@ -1913,9 +1906,9 @@ static int n_tty_open(struct tty_struct *tty)
 	return 0;
 }
 
-static inline int input_available_p(struct tty_struct *tty, int poll)
+static inline int input_available_p(struct tty_struct *tty,
+				    struct n_tty_data *ldata, int poll)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
 
 	if (ldata->icanon && !L_EXTPROC(tty))
@@ -1944,12 +1937,10 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
  *		read_tail published
  */
 
-static int copy_from_read_buf(struct tty_struct *tty,
-				      unsigned char __user **b,
-				      size_t *nr)
+static int copy_from_read_buf(struct tty_struct *tty, struct n_tty_data *ldata,
+			      unsigned char __user **b, size_t *nr)
 
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int retval;
 	size_t n;
 	bool is_eof;
@@ -2000,10 +1991,9 @@ static int copy_from_read_buf(struct tty_struct *tty,
  */
 
 static int canon_copy_from_read_buf(struct tty_struct *tty,
-				    unsigned char __user **b,
-				    size_t *nr)
+				    struct n_tty_data *ldata,
+				    unsigned char __user **b, size_t *nr)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, size, more, c;
 	size_t eol;
 	size_t tail;
@@ -2043,7 +2033,7 @@ static int canon_copy_from_read_buf(struct tty_struct *tty,
 	n_tty_trace("%s: eol:%zu found:%d n:%zu c:%zu tail:%zu more:%zu\n",
 		    __func__, eol, found, n, c, tail, more);
 
-	ret = tty_copy_to_user(tty, *b, tail, n);
+	ret = tty_copy_to_user(tty, ldata, *b, tail, n);
 	if (ret)
 		return -EFAULT;
 	*b += n;
@@ -2113,10 +2103,10 @@ static int job_control(struct tty_struct *tty, struct file *file)
  *		publishes read_tail
  */
 
-static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
-			 unsigned char __user *buf, size_t nr)
+static ssize_t __n_tty_read(struct tty_struct *tty, struct n_tty_data *ldata,
+			    struct file *file, unsigned char __user *buf,
+			    size_t nr)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	unsigned char __user *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int c;
@@ -2178,11 +2168,11 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			break;
 		}
 
-		if (!input_available_p(tty, 0)) {
+		if (!input_available_p(tty, ldata, 0)) {
 			up_read(&tty->termios_rwsem);
 			tty_buffer_flush_work(tty->port);
 			down_read(&tty->termios_rwsem);
-			if (!input_available_p(tty, 0)) {
+			if (!input_available_p(tty, ldata, 0)) {
 				if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
 					retval = -EIO;
 					break;
@@ -2216,7 +2206,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		}
 
 		if (ldata->icanon && !L_EXTPROC(tty)) {
-			retval = canon_copy_from_read_buf(tty, &b, &nr);
+			retval = canon_copy_from_read_buf(tty, ldata, &b, &nr);
 			if (retval)
 				break;
 		} else {
@@ -2232,15 +2222,15 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 				nr--;
 			}
 
-			uncopied = copy_from_read_buf(tty, &b, &nr);
-			uncopied += copy_from_read_buf(tty, &b, &nr);
+			uncopied = copy_from_read_buf(tty, ldata, &b, &nr);
+			uncopied += copy_from_read_buf(tty, ldata, &b, &nr);
 			if (uncopied) {
 				retval = -EFAULT;
 				break;
 			}
 		}
 
-		n_tty_check_unthrottle(tty);
+		n_tty_check_unthrottle(tty, ldata);
 
 		if (b - buf >= minimum)
 			break;
@@ -2248,7 +2238,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			timeout = time;
 	}
 	if (tail != ldata->read_tail)
-		n_tty_kick_worker(tty);
+		n_tty_kick_worker(tty, ldata);
 	up_read(&tty->termios_rwsem);
 
 	remove_wait_queue(&tty->read_wait, &wait);
@@ -2282,8 +2272,9 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
  *		  lock themselves)
  */
 
-static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
-			   const unsigned char *buf, size_t nr)
+static ssize_t __n_tty_write(struct tty_struct *tty, struct n_tty_data *ldata,
+			     struct file *file, const unsigned char *buf,
+			     size_t nr)
 {
 	const unsigned char *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
@@ -2300,7 +2291,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	down_read(&tty->termios_rwsem);
 
 	/* Write out any echoed characters that are still pending */
-	process_echoes(tty);
+	process_echoes(tty, ldata);
 
 	add_wait_queue(&tty->write_wait, &wait);
 	while (1) {
@@ -2314,7 +2305,8 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 		}
 		if (O_OPOST(tty)) {
 			while (nr > 0) {
-				ssize_t num = process_output_block(tty, b, nr);
+				ssize_t num = process_output_block(tty, ldata,
+								   b, nr);
 				if (num < 0) {
 					if (num == -EAGAIN)
 						break;
@@ -2326,15 +2318,13 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 				if (nr == 0)
 					break;
 				c = *b;
-				if (process_output(c, tty) < 0)
+				if (process_output(c, tty, ldata) < 0)
 					break;
 				b++; nr--;
 			}
 			if (tty->ops->flush_chars)
 				tty->ops->flush_chars(tty);
 		} else {
-			struct n_tty_data *ldata = tty->disc_data;
-
 			while (nr > 0) {
 				mutex_lock(&ldata->output_lock);
 				c = tty->ops->write(tty, b, nr);
@@ -2383,18 +2373,18 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
  *	Called without the kernel lock held - fine
  */
 
-static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
-							poll_table *wait)
+static __poll_t __n_tty_poll(struct tty_struct *tty, struct n_tty_data *ldata,
+			     struct file *file, poll_table *wait)
 {
 	__poll_t mask = 0;
 
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
-	if (input_available_p(tty, 1))
+	if (input_available_p(tty, ldata, 1))
 		mask |= EPOLLIN | EPOLLRDNORM;
 	else {
 		tty_buffer_flush_work(tty->port);
-		if (input_available_p(tty, 1))
+		if (input_available_p(tty, ldata, 1))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
 	if (tty->packet && tty->link->ctrl_status)
@@ -2429,10 +2419,9 @@ static unsigned long inq_canon(struct n_tty_data *ldata)
 	return nr;
 }
 
-static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg)
+static int __n_tty_ioctl(struct tty_struct *tty, struct n_tty_data *ldata,
+			 struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	int retval;
 
 	switch (cmd) {
@@ -2451,6 +2440,130 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 	}
 }
 
+static struct n_tty_data *tryget_n_tty(struct tty_struct *tty)
+{
+	struct n_tty_data *ldata;
+	bool ret;
+
+	rcu_read_lock();
+	ldata = tty->disc_data;
+	ret = ldata && refcount_inc_not_zero(&ldata->users);
+	rcu_read_unlock();
+	if (ret)
+		return ldata;
+	return NULL;
+}
+
+static void free_n_tty(struct rcu_head *head)
+{
+	struct n_tty_data *ldata = container_of(head, struct n_tty_data, rcu);
+
+	vfree(ldata);
+}
+
+static void put_n_tty(struct n_tty_data *ldata)
+{
+	if (refcount_dec_and_test(&ldata->users))
+		call_rcu(&ldata->rcu, free_n_tty);
+}
+
+static void n_tty_flush_buffer(struct tty_struct *tty)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+
+	if (!ldata)
+		return;
+	__n_tty_flush_buffer(tty, ldata);
+	put_n_tty(ldata);
+}
+
+static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
+			  unsigned char __user *buf, size_t nr)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+	ssize_t retval;
+
+	if (!ldata)
+		return -EIO;
+	retval = __n_tty_read(tty, ldata, file, buf, nr);
+	put_n_tty(ldata);
+	return retval;
+}
+
+static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
+			   const unsigned char *buf, size_t nr)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+	ssize_t retval;
+
+	if (!ldata)
+		return -EIO;
+	retval = __n_tty_write(tty, ldata, file, buf, nr);
+	put_n_tty(ldata);
+	return retval;
+}
+
+static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+	int retval;
+
+	if (!ldata)
+		return -EIO;
+	retval = __n_tty_ioctl(tty, ldata, file, cmd, arg);
+	put_n_tty(ldata);
+	return retval;
+}
+
+static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+
+	if (!ldata)
+		return;
+	__n_tty_set_termios(tty, ldata, old);
+	put_n_tty(ldata);
+}
+
+static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
+			   poll_table *wait)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+	__poll_t retval;
+
+	if (!ldata) /* What value is most appropriate for this case? */
+		return POLLERR|POLLHUP;
+	retval = __n_tty_poll(tty, ldata, file, wait);
+	put_n_tty(ldata);
+	return retval;
+
+}
+
+static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+			      char *fp, int count)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+
+	if (!ldata)
+		return;
+	__n_tty_receive_buf(tty, ldata, cp, fp, count);
+	put_n_tty(ldata);
+}
+
+static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
+			      char *fp, int count)
+{
+	struct n_tty_data *ldata = tryget_n_tty(tty);
+	int retval;
+
+	if (!ldata)
+		return -EIO;
+	retval = __n_tty_receive_buf2(tty, ldata, cp, fp, count);
+	put_n_tty(ldata);
+	return retval;
+}
+
 static struct tty_ldisc_ops n_tty_ops = {
 	.magic           = TTY_LDISC_MAGIC,
 	.name            = "n_tty",
-- 
1.8.3.1



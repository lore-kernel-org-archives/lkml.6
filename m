Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100211; cv=none;
        d=google.com; s=arc-20160816;
        b=jkhAjwE8AFrTQP8/Uqrz8bzJBwD4fR0RjzobU6FvP2fxMjnTyXd0/nWX9CL8oXASJM
         WgxDmgzeNgv1EkvhSYosC+7FZ3I1Y1+2lCqYaaL/NUCpS3PtggGV57IsV4atJGew1gJp
         aYw8xu0BfT5YS+F7Xep5gEOQEuiiNSRpBHaLxiGPGmtPbXyZhCKZArbV9Uf5kgg7nAiu
         d7EOGqBHUK2lahdhdxyV+D7DVgpLJN9JfBv5z9hbG9WoTQ9CZpmTaiNVeiC0gOqI/MB7
         jOaORxq+KePXGw1yarD+o3Ce3iWbxxgRIL7FdpdCYeFmTNAv+kOljt8o8ebaLmrONapg
         YrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qOZJfLQ9RKZlBI+cfjMORT8Zm26ghIRtsA4lRvp0+jY=;
        b=m6MP0GhHoYgzItYTsH62c5SsRt/wzD+3sLrYLVxHvTvdTo0Hi9DrP6WNTu4ax9S9EV
         NSORqz/TTMoACbQWL7LD2N3p4pLoYkHK3TGX5aBBCBgut/X/4YBge1butac6EF+Bs37v
         T8CrcuC0G52Z5cak+SCV7IT8vX/DmJWoJ+YYAPnX3co8150OqGkAOzChuuaEgxJCGudE
         CesfZSkfC6/ShOXsIN1++81LX2EN/uvtq96W4EHodpk0fr01RApEMIaS0Dal3hwzzbWe
         6xEFE5+9abZ0RpTsFzuAZcA2iJilORYMkfEOSKqLqUSTifx8e4qDE6ZU/JUWY4epUZHv
         AGFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=umAtw1tW;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=umAtw1tW;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpjVC/qmBYYdBmK5MRm1lo5z3bI5OCo5O2QusjXYq+GynkvO34jGE+nBrRC5oGJv8wETqpC7g==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] tty: hvc: hvc_poll break hv read loop
Date: Tue,  1 May 2018 00:55:54 +1000
Message-Id: <20180430145558.4308-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183478554159921?=
X-GMAIL-MSGID: =?utf-8?q?1599183478554159921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid looping with the spinlock held while there is read data
being returned from the hv driver. Instead note if the entire
size returned by tty_buffer_request_room was read, and request
another read poll.

This limits the critical section lengths, and provides more
even service to other consoles in case there is a pathological
condition.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 88 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index fddb63322c67..745ac220fce8 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -592,7 +592,7 @@ static u32 timeout = MIN_TIMEOUT;
 int hvc_poll(struct hvc_struct *hp)
 {
 	struct tty_struct *tty;
-	int i, n, poll_mask = 0;
+	int i, n, count, poll_mask = 0;
 	char buf[N_INBUF] __ALIGNED__;
 	unsigned long flags;
 	int read_total = 0;
@@ -618,7 +618,7 @@ int hvc_poll(struct hvc_struct *hp)
 
 	/* Now check if we can get data (are we throttled ?) */
 	if (tty_throttled(tty))
-		goto throttled;
+		goto out;
 
 	/* If we aren't notifier driven and aren't throttled, we always
 	 * request a reschedule
@@ -627,56 +627,58 @@ int hvc_poll(struct hvc_struct *hp)
 		poll_mask |= HVC_POLL_READ;
 
 	/* Read data if any */
-	for (;;) {
-		int count = tty_buffer_request_room(&hp->port, N_INBUF);
 
-		/* If flip is full, just reschedule a later read */
-		if (count == 0) {
+	count = tty_buffer_request_room(&hp->port, N_INBUF);
+
+	/* If flip is full, just reschedule a later read */
+	if (count == 0) {
+		poll_mask |= HVC_POLL_READ;
+		goto out;
+	}
+
+	n = hp->ops->get_chars(hp->vtermno, buf, count);
+	if (n <= 0) {
+		/* Hangup the tty when disconnected from host */
+		if (n == -EPIPE) {
+			spin_unlock_irqrestore(&hp->lock, flags);
+			tty_hangup(tty);
+			spin_lock_irqsave(&hp->lock, flags);
+		} else if ( n == -EAGAIN ) {
+			/*
+			 * Some back-ends can only ensure a certain min
+			 * num of bytes read, which may be > 'count'.
+			 * Let the tty clear the flip buff to make room.
+			 */
 			poll_mask |= HVC_POLL_READ;
-			break;
 		}
+		goto out;
+	}
 
-		n = hp->ops->get_chars(hp->vtermno, buf, count);
-		if (n <= 0) {
-			/* Hangup the tty when disconnected from host */
-			if (n == -EPIPE) {
-				spin_unlock_irqrestore(&hp->lock, flags);
-				tty_hangup(tty);
-				spin_lock_irqsave(&hp->lock, flags);
-			} else if ( n == -EAGAIN ) {
-				/*
-				 * Some back-ends can only ensure a certain min
-				 * num of bytes read, which may be > 'count'.
-				 * Let the tty clear the flip buff to make room.
-				 */
-				poll_mask |= HVC_POLL_READ;
-			}
-			break;
-		}
-		for (i = 0; i < n; ++i) {
+	for (i = 0; i < n; ++i) {
 #ifdef CONFIG_MAGIC_SYSRQ
-			if (hp->index == hvc_console.index) {
-				/* Handle the SysRq Hack */
-				/* XXX should support a sequence */
-				if (buf[i] == '\x0f') {	/* ^O */
-					/* if ^O is pressed again, reset
-					 * sysrq_pressed and flip ^O char */
-					sysrq_pressed = !sysrq_pressed;
-					if (sysrq_pressed)
-						continue;
-				} else if (sysrq_pressed) {
-					handle_sysrq(buf[i]);
-					sysrq_pressed = 0;
+		if (hp->index == hvc_console.index) {
+			/* Handle the SysRq Hack */
+			/* XXX should support a sequence */
+			if (buf[i] == '\x0f') {	/* ^O */
+				/* if ^O is pressed again, reset
+				 * sysrq_pressed and flip ^O char */
+				sysrq_pressed = !sysrq_pressed;
+				if (sysrq_pressed)
 					continue;
-				}
+			} else if (sysrq_pressed) {
+				handle_sysrq(buf[i]);
+				sysrq_pressed = 0;
+				continue;
 			}
-#endif /* CONFIG_MAGIC_SYSRQ */
-			tty_insert_flip_char(&hp->port, buf[i], 0);
 		}
-
-		read_total += n;
+#endif /* CONFIG_MAGIC_SYSRQ */
+		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
- throttled:
+	if (n == count)
+		poll_mask |= HVC_POLL_READ;
+	read_total = n;
+
+ out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
 		hp->do_wakeup = 0;
-- 
2.17.0

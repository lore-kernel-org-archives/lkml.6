Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeBID2i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:28:38 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44358 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeBID2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:28:37 -0500
X-Google-Smtp-Source: AH8x224rrv9ndsBbblR5znM4Ygqi+bfe1K7g8PpWoT2CIUh0RjDoB2lafq+3l2q2k9Muzy56gAqaeA==
Date: Fri, 9 Feb 2018 12:28:30 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180209032830.GA689@jagdpanzerIV>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180208145307.GA485@tigerII.localdomain>
 <20180208164820.qsotvvywds6z6le4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208164820.qsotvvywds6z6le4@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/18 17:48), Petr Mladek wrote:
[..]
> > 
> > I need to do more "research" on this. I though about it some time ago,
> > and I think that waking up klogd _only_ when we don't have any pending
> > logbuf messages still can be pretty late. Can't it? We can spin in
> > console_unlock() printing loop for a long time, probably passing
> > console_sem ownership between CPUs, without waking up the log_wait waiter.
> > May be we can wake it up from the printing loop, outside of logbuf_lock,
> > and let klogd to compete for logbuf_lock with the printing CPU. Why do
> > we wake it up only when we are done pushing messages to a potentially
> > slow serial console?
> 
> I thought about this as well but I was lazy. You made me to do some
> archaeology. It seems that it worked this way basically from the beginning.
> I have a git tree with pre-git commits. The oldest printk changes are
> there from 2.1.113.
> 
> In 2.1.113, logd was weaken directly from printk():

Thanks!

Was going to do the same today. Will take a look.

[..]
> My opinion:
> 
> IMHO, it would make perfect sense to wake klogd earlier and it should
> be safe these days.
> 
> I am just slightly afraid of a potential contention on printk_lock.
> Consoles and klogd might delay each other. Another question is
> how to do so when console_unlock() is called with interrupts
> disabled (irq_work is queued on the same CPU). This is why
> I would suggest to do this change separately and not for 4.16.

By postponing klogd wakeup we don't really address logbuf_lock
contention. We have no guarantees that no new printk will come
while klogd is active. Besides, consoles don't really delay
klogd - I tend to ignore the impact of msg_print_text(), it should
be fast. We call console drivers outside of logbuf_lock scope, so
everything should fine (tm).


Another question - do we need to wake it up from console_unlock()?

Basically,
- if consoles are suspended, we also "suspend" user space klogd.
  Does it really make sense?

- if console_lock is acquired by a preemptible task and that task
  is getting scheduled out for a long time (OOM, etc) then we postpone
  user space logging for unknown period of time. First the console_lock
  will have to flush pending messages and only afterwards it will wakeup
  klogd. Does it really make sense?

- If current console_lock owner jumps to retry (new pending messages
  were appended to the logbuf) label, user space klogd wakeup is getting
  postponed even further.

So, the final question is - since there in only one legitimate way
(modulo user space writes to kmsg) to append new messages to the
logbuf, shall we put klogd wakeup there? IOW, to vprintk_emit().

Something like this:

---

 kernel/printk/printk.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index db4b9b8929eb..2c8992d54a59 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -423,6 +423,9 @@ static u32 log_next_idx;
 static u64 console_seq;
 static u32 console_idx;
 
+/* The last message seq klogd have seen */
+static u64 klogd_seen_seq;
+
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
 static u32 clear_idx;
@@ -1888,6 +1891,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
 
+	if (klogd_seen_seq != log_next_seq) {
+		klogd_seen_seq = log_next_seq;
+		wake_up_klogd();
+	}
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
@@ -2289,9 +2296,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
-	static u64 seen_seq;
 	unsigned long flags;
-	bool wake_klogd = false;
 	bool do_cond_resched, retry;
 
 	if (console_suspended) {
@@ -2335,11 +2340,6 @@ void console_unlock(void)
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
-		if (seen_seq != log_next_seq) {
-			wake_klogd = true;
-			seen_seq = log_next_seq;
-		}
-
 		if (console_seq < log_first_seq) {
 			len = sprintf(text, "** %u printk messages dropped **\n",
 				      (unsigned)(log_first_seq - console_seq));
@@ -2429,9 +2429,6 @@ void console_unlock(void)
 
 	if (retry && console_trylock())
 		goto again;
-
-	if (wake_klogd)
-		wake_up_klogd();
 }
 EXPORT_SYMBOL(console_unlock);
 
---

So, essentially, instead of:

- OK, there is a new kernel message. Let's first print it to all of the
  consoles (if !suspended and if can use console) and only afterwards let
  user space to read it and to, probably, persist it in syslog journal file.

and now we have

- OK, there is a new kernel message. Let's try to wakeup klogd so it
  probably can persist it in syslog journal file while, in parallel, we
  will print it to the consoles (if !suspended and if can use console).

Opinions?

> Note that we need Tejun's patch for-4.16 because it fixes a potential
> race introduced by the console waiter logic.

I understand it. I think I put my Reviewed-by on v1, maybe not...
Here it is

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

But can we may be come up with a more general solution? Like the one
that we discussed above. I've seen some user space klogd lost messages
reports recently. I assume it was partly caused by that very late
wakeup that we have.

	-ss

Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97207C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422EF2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422EF2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeIJTwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:35658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeIJTwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:52:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CCA75AC8D;
        Mon, 10 Sep 2018 14:57:49 +0000 (UTC)
Date:   Mon, 10 Sep 2018 16:57:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180910145747.emvfzv4mzlk5dfqk@pathway.suse.cz>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
 <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
 <20180907042132.GC2394@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907042132.GC2394@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-09-07 13:21:32, Sergey Senozhatsky wrote:
> On (09/06/18 16:28), Petr Mladek wrote:
> > On Thu 2018-09-06 16:29:40, Sergey Senozhatsky wrote:
> > > On (09/05/18 13:02), Petr Mladek wrote:
> > > > Note that the first registered console prints all messages
> > > > even without this flag.
> > > 
> > > Hmm, OK, interesting point.
> > > 
> > > I assumed that the first console usually has CON_PRINTBUFFER bit set.
> > > Or even a CON_PRINTBUFFER | CON_ANYTIME combo. E.g. 8250. It sort of
> > > makes sense to have CON_PRINTBUFFER for the first console. Any later
> > > consoles [e.g. fbcon, netcon] don't necessarily have CON_PRINTBUFFER.
> > > 
> > > And the first console has CON_PRINTBUFFER bit set. Well, just because
> > > it sounds reasonable. Those were the main assumptions behind my code
> > > snippet. Was any of those assumptions wrong?
> > 
> > This assumption makes sense. In fact, I was wrong. I thought that
> > console_seq/console_idx were not updated until the first console
> > was registered. But it is not the case.
> > 
> > It means that the hack with exclusive_console might be usable.
> 
> Yeah, it is a hack. But not as dirty as it might appear, I think. In some
> sense it's aligned with what we do for exlusive_consoles - we treat exclusive
> consoles specially. So specially that even if the system panics while we
> re-flush logbuf messages to a new exclusive console, we flush_on_panic() only
> to that exclusive console, ignoring the rest of them.

I consider this a bug. Another bug is that other consoles might miss
messages that appear while the older messages are being
replayed on exclusive_console.

AFAIK, nobody complains about it. But I not comfortable with reusing
this racy pattern even more ;-)


> Not sure if it's totally right. There can be a netcon, for instance,
> available, which will not see panic flush() because of a exclusive
> console:

Good catch.

> ---
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c036f128cdc3..ede29a7ba6db 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2545,6 +2545,7 @@ void console_flush_on_panic(void)
>  	 * ensure may_schedule is cleared.
>  	 */
>  	console_trylock();
> +	exclusive_console = NULL;

This is not be enough. It would cause replying old messages
on all consoles.

Most problems should probably be solved when we store console_seq
before setting exclusive_console. Then we could clear
exclusive_console when reaching the stored sequence number.

Can this be that simple? ;-)


> > I prefer the revert for now.
> 
> OK, agreed.
> IIRC I didn't see any upstream code which would have been fixed
> by the commit in question.

My proposal for 4.19:


From 46ceb577021c8899edd1977a52929b309a5ebf85 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 10 Sep 2018 15:52:06 +0200
Subject: [PATCH] Revert "printk: make sure to print log on console."

This reverts commit 375899cddcbb26881b03cb3fbdcfd600e4e67f4a.

The visibility of early messages did not longer take into account
"quiet", "debug", and "loglevel" early parameters.

It would be possible to invalidate and recompute LOG_NOCONS flag
for the affected messages. But it would be hairy.

Instead this patch just reverts the problematic commit. We could
come up with a better solution for the original problem. For example,
we could simplify the logic and just mark messages that should always
be visible or always invisible on the console.

Also this patch does not put back the unused LOG_NOCONS flag.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd6f8ed28e01..5fae295fcb75 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -351,7 +351,6 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  */
 
 enum log_flags {
-	LOG_NOCONS	= 1,	/* suppress print, do not print to console */
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
 	LOG_PREFIX	= 4,	/* text started with a prefix */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
@@ -1881,9 +1880,6 @@ int vprintk_store(int facility, int level,
 	if (dict)
 		lflags |= LOG_PREFIX|LOG_NEWLINE;
 
-	if (suppress_message_printing(level))
-		lflags |= LOG_NOCONS;
-
 	return log_output(facility, level, lflags,
 			  dict, dictlen, text, text_len);
 }
@@ -2368,10 +2364,11 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (msg->flags & LOG_NOCONS) {
+		if (suppress_message_printing(msg->level)) {
 			/*
-			 * Skip record if !ignore_loglevel, and
-			 * record has level above the console loglevel.
+			 * Skip record we have buffered and already printed
+			 * directly to the console when we received it, and
+			 * record that has level above the console loglevel.
 			 */
 			console_idx = log_next(console_idx);
 			console_seq++;
-- 
2.13.7


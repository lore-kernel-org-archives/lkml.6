Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B05C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4E420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfAOSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:54:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbfAOSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:54:40 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gjTr9-00034Z-Fh; Tue, 15 Jan 2019 19:54:35 +0100
Date:   Tue, 15 Jan 2019 19:54:33 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RT] printk: Shortcut out of waiter spinning on PREEMPT_RT
Message-ID: <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
References: <20190115123910.2b18df54@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115123910.2b18df54@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-15 12:39:10 [-0500], Steven Rostedt wrote:
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1742,6 +1742,13 @@ static int console_trylock_spinning(void)
>  	if (console_trylock())
>  		return 1;
>  
> +	/*
> +	 * The consoles are preemptable in PREEMPT_RT, which can cause
> +	 * spinning to deadlock.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> +		return 0;
> +
>  	printk_safe_enter_irqsave(flags);
>  
>  	raw_spin_lock(&console_owner_lock);

So my ("printk: Make rt aware") patch does:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6553508ff3889..d983c509f74a2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1617,6 +1617,7 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
        return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Special console_lock variants that help to reduce the risk of soft-lockups.
  * They allow to pass console_lock to another printk() call using a busy wait.
@@ -1757,6 +1758,15 @@ static int console_trylock_spinning(void)
        return 1;
 }
 
+#else
+
+static int console_trylock_spinning(void)
+{
+       return console_trylock();
+}
+
+#endif
+
 /*
  * Call the console drivers, asking them to write out
  * log_buf[start] to log_buf[end - 1].


So it never gets into the codepath where you try to avoid spinning.
Right?

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937126AbeE3HvL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:51:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43512 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934903AbeE3HvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:51:10 -0400
X-Google-Smtp-Source: ADUXVKLmgKrXL61Jc/g0YeYGfme4rhoLa9clond8aycfHHw7YzIWOR9tu/OnViA56ahaF4TaRzst1w==
Date: Wed, 30 May 2018 16:51:05 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: drop in_nmi check from
 printk_safe_flush_on_panic()
Message-ID: <20180530075105.GA12230@jagdpanzerIV>
References: <20180530070350.10131-1-sergey.senozhatsky@gmail.com>
 <20180530072419.jqoohtcvenlnym6h@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530072419.jqoohtcvenlnym6h@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/30/18 09:24), Petr Mladek wrote:
> Acked-by: Petr Mladek <pmladek@suse.com>

Thanks.

> Just to be sure. IMHO, it is not worth nominating this patch for
> stable. It is not a regression fix. I see it as a continuous
> improving of the handling in various corner cases. And I see this
> as a distant corner case.

Yep, agreed.

***

A random thought [not suggesting anything]:

Given that we call printk() before SMP stop and that some of
smp_send_stop() call printk(), may be we can switch panic()
to printk_safe() mode and return it back to normal printk()
mode right before printk_safe_flush_on_panic(). So all possible
printk()-s that can happen in between (printk_safe_enter()
printk_safe_exit()) will not access the logbuf spin lock, yet
we still will try to flush all per-CPU buffers a bit later.

It probably doesn't sound like a very good/solid idea, just
wondering what will people say.

Very schematically,

---

diff --git a/kernel/panic.c b/kernel/panic.c
index 42e487488554..98a0493a59d3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -148,6 +148,7 @@ void panic(const char *fmt, ...)
 	 * after setting panic_cpu) from invoking panic() again.
 	 */
 	local_irq_disable();
+	__printk_safe_enter();
 
 	/*
 	 * It's possible to come here directly from a panic-assertion and
@@ -217,6 +218,7 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	__printk_safe_exit();
 	/* Call flush even twice. It tries harder with a single online CPU */
 	printk_safe_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);

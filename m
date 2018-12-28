Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5298420675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999645;
	bh=Z4xfNlLmULtGAN+TsginbMDFo06leMZ2caV+hAWrhqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDg7IUe6vYOPVx7NCJVKBe9lAq/BNgukVrm4lId+hhcTLMp90y9oFgK48jwJAFqyb
	 kgTlpoXAXZhLApxcQ3h/4b8oDe40CLquMOWyQDDvJp8N7pYVbQxsfufjRQ8o3GXaJ8
	 yez8ZIgC/CZrr73JcEemVbfaRnsg91oz3otOhBLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeL1MUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:20:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731434AbeL1MQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3E8218FE;
        Fri, 28 Dec 2018 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999383;
        bh=Z4xfNlLmULtGAN+TsginbMDFo06leMZ2caV+hAWrhqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVnvuVLnGwDLsUoQsmVMTpHEhg0f3VpoDeKLxv5eGSx3NXns+iX7/gtjFRR/3CN4a
         QZz3bvbJxs/gJ7+v88shK6e63LiNs+OA8nBCMcAFXmX7MPf+viOtmnwa6p7LE21uwl
         Z13F3O//BXxxhOJbaNmaqQOFkexhOZaLbxq74Y4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4.14 28/36] panic: avoid deadlocks in re-entrant console drivers
Date:   Fri, 28 Dec 2018 12:52:44 +0100
Message-Id: <20181228113128.420053290@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

commit c7c3f05e341a9a2bd1a92993d4f996cfd6e7348e upstream.

>From printk()/serial console point of view panic() is special, because
it may force CPU to re-enter printk() or/and serial console driver.
Therefore, some of serial consoles drivers are re-entrant. E.g. 8250:

serial8250_console_write()
{
	if (port->sysrq)
		locked = 0;
	else if (oops_in_progress)
		locked = spin_trylock_irqsave(&port->lock, flags);
	else
		spin_lock_irqsave(&port->lock, flags);
	...
}

panic() does set oops_in_progress via bust_spinlocks(1), so in theory
we should be able to re-enter serial console driver from panic():

	CPU0
	<NMI>
	uart_console_write()
	serial8250_console_write()		// if (oops_in_progress)
						//    spin_trylock_irqsave()
	call_console_drivers()
	console_unlock()
	console_flush_on_panic()
	bust_spinlocks(1)			// oops_in_progress++
	panic()
	<NMI/>
	spin_lock_irqsave(&port->lock, flags)   // spin_lock_irqsave()
	serial8250_console_write()
	call_console_drivers()
	console_unlock()
	printk()
	...

However, this does not happen and we deadlock in serial console on
port->lock spinlock. And the problem is that console_flush_on_panic()
called after bust_spinlocks(0):

void panic(const char *fmt, ...)
{
	bust_spinlocks(1);
	...
	bust_spinlocks(0);
	console_flush_on_panic();
	...
}

bust_spinlocks(0) decrements oops_in_progress, so oops_in_progress
can go back to zero. Thus even re-entrant console drivers will simply
spin on port->lock spinlock. Given that port->lock may already be
locked either by a stopped CPU, or by the very same CPU we execute
panic() on (for instance, NMI panic() on printing CPU) the system
deadlocks and does not reboot.

Fix this by removing bust_spinlocks(0), so oops_in_progress is always
set in panic() now and, thus, re-entrant console drivers will trylock
the port->lock instead of spinning on it forever, when we call them
from console_flush_on_panic().

Link: http://lkml.kernel.org/r/20181025101036.6823-1-sergey.senozhatsky@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Wang <wonderfly@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: linux-serial@vger.kernel.org
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/panic.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -14,6 +14,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/kallsyms.h>
 #include <linux/notifier.h>
+#include <linux/vt_kern.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/ftrace.h>
@@ -230,7 +231,10 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-	bust_spinlocks(0);
+#ifdef CONFIG_VT
+	unblank_screen();
+#endif
+	console_unblank();
 
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in



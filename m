Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB27B214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfBLObu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:31:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbfBLOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:38 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4q-0005Af-Ja; Tue, 12 Feb 2019 15:30:24 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v1 18/25] console: add write_atomic interface
Date:   Tue, 12 Feb 2019 15:29:56 +0100
Message-Id: <20190212143003.48446-19-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a write_atomic callback to the console. This is an optional
function for console drivers. The function must be atomic (including
NMI safe) for writing to the console.

Console drivers must still implement the write callback. The
write_atomic callback will only be used for emergency messages.

Creating an NMI safe write_atomic that must synchronize with write
requires a careful implementation of the console driver. To aid with
the implementation, a set of console_atomic_* functions are provided:

    void console_atomic_lock(unsigned int *flags);
    void console_atomic_unlock(unsigned int flags);

These functions synchronize using the processor-reentrant cpu lock of
the printk buffer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  4 ++++
 kernel/printk/printk.c  | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 633fb741e871..13482565c08c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -145,6 +145,7 @@ static inline int con_debug_leave(void)
 struct console {
 	char	name[16];
 	void	(*write)(struct console *, const char *, unsigned);
+	void	(*write_atomic)(struct console *, const char *, unsigned);
 	int	(*read)(struct console *, char *, unsigned);
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
@@ -231,4 +232,7 @@ extern void console_init(void);
 void dummycon_register_output_notifier(struct notifier_block *nb);
 void dummycon_unregister_output_notifier(struct notifier_block *nb);
 
+extern void console_atomic_lock(unsigned int *flags);
+extern void console_atomic_unlock(unsigned int flags);
+
 #endif /* _LINUX_CONSOLE_H */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cde036d8487a..0ff7c3942464 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2984,3 +2984,15 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 #endif
+
+void console_atomic_lock(unsigned int *flags)
+{
+	prb_lock(&printk_cpulock, flags);
+}
+EXPORT_SYMBOL(console_atomic_lock);
+
+void console_atomic_unlock(unsigned int flags)
+{
+	prb_unlock(&printk_cpulock, flags);
+}
+EXPORT_SYMBOL(console_atomic_unlock);
-- 
2.11.0


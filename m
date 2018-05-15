Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeEOSen (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:34:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:27432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbeEOSeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:34:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="51088785"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] console: introduce ->exit() callback
Date: Tue, 15 May 2018 21:34:07 +0300
Message-Id: <20180515183409.78046-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some consoles might require special operations on unregistering. For example,
serial console, when registered in the kernel, keeps power on for entire time,
until it gets unregistered. For such cases to have a balance we would provide
->exit() callback.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/console.h | 1 +
 kernel/printk/printk.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index dfd6b0e97855..62c5b958b548 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -147,6 +147,7 @@ struct console {
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
+	void	(*exit)(struct console *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
 	short	flags;
 	short	index;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..a3170886f481 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2756,6 +2756,9 @@ int unregister_console(struct console *console)
 	if (console_drivers != NULL && console->flags & CON_CONSDEV)
 		console_drivers->flags |= CON_CONSDEV;
 
+	if (console->exit)
+		console->exit(console);
+
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
-- 
2.17.0

Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790F2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407DD2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbfAKQVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:21:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:40554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731300AbfAKQUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:20:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9454B024;
        Fri, 11 Jan 2019 16:20:50 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [RFC 3/3] sysrq: Warn about insufficient console_loglevel
Date:   Fri, 11 Jan 2019 17:20:38 +0100
Message-Id: <20190111162038.19771-4-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190111162038.19771-1-pmladek@suse.com>
References: <20190111162038.19771-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People are sometimes confused that they do not see any output
on the console when trying to get some debugging information
using SysRq.

The messages are filtered by the current console_loglevel.
It makes some sense because a very long output might cause
troubles with a slow console.

Fortunately, the console_loglevel can be increased by SysRq
as well. The only problem is that people do not know that
they should do so and how to do so.

This patch adds a message to help users. It is printed only
once and only when the loglevel is not sufficient.

There is also a need to export suppress_message_printing()
function.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/sysrq.c    | 26 ++++++++++++++++++++++++++
 include/linux/printk.h |  7 +++++++
 kernel/printk/printk.c |  7 +++----
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index fa0ce7dd9e24..e517113cecec 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -523,9 +523,33 @@ static void __sysrq_put_key_op(int key, struct sysrq_key_op *op_p)
                 sysrq_key_table[i] = op_p;
 }
 
+static void warn_console(bool console_suppressed,
+			 int orig_log_level,
+			 struct sysrq_key_op *op_p)
+{
+	static int warned;
+
+	if (warned)
+		return;
+
+	/* Do not warn when people are already setting loglevel via sysrq */
+	if (op_p->enable_mask & SYSRQ_ENABLE_LOG) {
+		warned = 1;
+		return;
+	}
+
+	if (console_suppressed) {
+		pr_info("Messages filtered by console_loglevel (%d)%s\n",
+			orig_log_level,
+			sysrq_on_mask(SYSRQ_ENABLE_LOG) ? ", try SysRq+7" : "");
+		warned = 1;
+	}
+}
+
 void __handle_sysrq(int key, bool check_mask)
 {
 	struct sysrq_key_op *op_p;
+	bool console_suppressed;
 	int orig_log_level;
 	int i;
 
@@ -537,6 +561,7 @@ void __handle_sysrq(int key, bool check_mask)
 	 * simply emit this at KERN_EMERG as that would change message
 	 * routing in the consumers of /proc/kmsg.
 	 */
+	console_suppressed = console_suppress_message(LOGLEVEL_INFO);
 	orig_log_level = console_loglevel;
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 
@@ -548,6 +573,7 @@ void __handle_sysrq(int key, bool check_mask)
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
+			warn_console(console_suppressed, orig_log_level, op_p);
 			console_loglevel = orig_log_level;
 			op_p->handler(key);
 		} else {
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a506ebb..917bd6ca784c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -193,6 +193,8 @@ devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write, void __user *buf,
 
 extern void wake_up_klogd(void);
 
+extern bool console_suppress_message(int level);
+
 char *log_buf_addr_get(void);
 u32 log_buf_len_get(void);
 void log_buf_vmcoreinfo_setup(void);
@@ -234,6 +236,11 @@ static inline void wake_up_klogd(void)
 {
 }
 
+static bool console_suppress_message(int)
+{
+	return false;
+}
+
 static inline char *log_buf_addr_get(void)
 {
 	return NULL;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d170374ceb..b37c3513d7d8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1164,7 +1164,7 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+bool console_suppress_message(int level)
 {
 	return (level >= console_loglevel && !ignore_loglevel);
 }
@@ -1198,7 +1198,7 @@ static void boot_delay_msec(int level)
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+		|| console_suppress_message(level)) {
 		return;
 	}
 
@@ -2025,7 +2025,6 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 			     bool time, char *buf, size_t size) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2363,7 +2362,7 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
+		if (console_suppress_message(msg->level)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
-- 
2.13.7


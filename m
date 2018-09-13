Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9AC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC0120861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC0120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeIMRnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:43:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbeIMRnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:43:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B0B7ADD8;
        Thu, 13 Sep 2018 12:34:14 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] printk: Do not miss new messages when replaying the log
Date:   Thu, 13 Sep 2018 14:34:06 +0200
Message-Id: <20180913123406.14378-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable "exclusive_console" is used to reply all existing messages
on a newly registered console. It is cleared when all messages are out.

The problem is that new messages might appear in the meantime. These
are then visible only on the exclusive console.

The obvious solution is to clear "exclusive_console" after we replay
all messages that were already proceed before we started the reply.

Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e30e5023511b..54dfc441a692 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -421,6 +421,7 @@ static u32 log_next_idx;
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u32 console_idx;
+static u64 exclusive_console_stop_seq;
 
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
@@ -2007,6 +2008,7 @@ static u64 syslog_seq;
 static u32 syslog_idx;
 static u64 console_seq;
 static u32 console_idx;
+static u64 exclusive_console_stop_seq;
 static u64 log_first_seq;
 static u32 log_first_idx;
 static u64 log_next_seq;
@@ -2373,6 +2375,12 @@ void console_unlock(void)
 			goto skip;
 		}
 
+		/* Output to all consoles once old messages replayed. */
+		if (unlikely(exclusive_console &&
+			     console_seq >= exclusive_console_stop_seq)) {
+			exclusive_console = NULL;
+		}
+
 		len += msg_print_text(msg,
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				text + len,
@@ -2415,10 +2423,6 @@ void console_unlock(void)
 
 	console_locked = 0;
 
-	/* Release the exclusive_console once it is used */
-	if (unlikely(exclusive_console))
-		exclusive_console = NULL;
-
 	raw_spin_unlock(&logbuf_lock);
 
 	up_console_sem();
@@ -2703,6 +2707,7 @@ void register_console(struct console *newcon)
 		 * the already-registered consoles.
 		 */
 		exclusive_console = newcon;
+		exclusive_console_stop_seq = console_seq;
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.13.7


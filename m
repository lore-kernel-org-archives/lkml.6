Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B75CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAD9208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAD9208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964929AbeFZMng (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:43:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38033 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932438AbeFZMnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:43:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B70BADFD;
        Tue, 26 Jun 2018 12:43:34 +0000 (UTC)
Date:   Tue, 26 Jun 2018 14:43:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Namit Gupta <gupta.namit@samsung.com>,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180626124332.62isabqkefpgqpgk@pathway.suse.cz>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
 <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
 <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
 <20180625103704.49811ec1@gandalf.local.home>
 <20180625144407.GB443@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625144407.GB443@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-06-25 23:44:07, Sergey Senozhatsky wrote:
> On (06/25/18 10:37), Steven Rostedt wrote:
> > 
> > Is IMHO rather ugly.
> 
> Either way works for me. So I'll leave it to you and Petr to decide :)
> 
> > And the original patch has one more advantage. If buf and clear are
> > both NULL/zero, we don't take any locks.
> 
> But we never use syslog_print_all(buf = NULL, clear = false). It's either
> NULL/true [move forward clear idx, do not copy to user], or !NULL/use defined
> value [copy to user, move or don't move clear idx forward]

Yup, I suggest the following version as a compromise. It has the code
duplication but I agree that it is negligible. Otherwise, it looks
cleaner.




From be6e161b3d75830e710c3ada56f5eeb615fae002 Mon Sep 17 00:00:00 2001
From: Namit Gupta <gupta.namit@samsung.com>
Date: Wed, 20 Jun 2018 19:26:19 +0530
Subject: [PATCH] printk: remove unnecessary kmalloc() from syslog during clear

When the request is only for clearing logs, there is no need for
allocation/deallocation. Only the indexes need to be reset and returned.

This patch implements this simple case separately. And syslog_print_all()
is always called with a valid buf and could use a more sane indentation.

Link: http://lkml.kernel.org/r/20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com
Cc: linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com
Cc: a.sahrawat@samsung.com
Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 111 ++++++++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 53 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..588f23c9c14f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1352,71 +1352,68 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 {
 	char *text;
 	int len = 0;
+	u64 next_seq;
+	u64 seq;
+	u32 idx;
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
 	logbuf_lock_irq();
-	if (buf) {
-		u64 next_seq;
-		u64 seq;
-		u32 idx;
+	/*
+	 * Find first record that fits, including all following records,
+	 * into the user-provided buffer for this dump.
+	 */
+	seq = clear_seq;
+	idx = clear_idx;
+	while (seq < log_next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
 
-		/*
-		 * Find first record that fits, including all following records,
-		 * into the user-provided buffer for this dump.
-		 */
-		seq = clear_seq;
-		idx = clear_idx;
-		while (seq < log_next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
-
-			len += msg_print_text(msg, true, NULL, 0);
-			idx = log_next(idx);
-			seq++;
-		}
+		len += msg_print_text(msg, true, NULL, 0);
+		idx = log_next(idx);
+		seq++;
+	}
 
-		/* move first record forward until length fits into the buffer */
-		seq = clear_seq;
-		idx = clear_idx;
-		while (len > size && seq < log_next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
+	/* move first record forward until length fits into the buffer */
+	seq = clear_seq;
+	idx = clear_idx;
+	while (len > size && seq < log_next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
 
-			len -= msg_print_text(msg, true, NULL, 0);
-			idx = log_next(idx);
-			seq++;
-		}
+		len -= msg_print_text(msg, true, NULL, 0);
+		idx = log_next(idx);
+		seq++;
+	}
 
-		/* last message fitting into this dump */
-		next_seq = log_next_seq;
+	/* last message fitting into this dump */
+	next_seq = log_next_seq;
 
-		len = 0;
-		while (len >= 0 && seq < next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
-			int textlen;
+	len = 0;
+	while (len >= 0 && seq < next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
+		int textlen;
 
-			textlen = msg_print_text(msg, true, text,
-						 LOG_LINE_MAX + PREFIX_MAX);
-			if (textlen < 0) {
-				len = textlen;
-				break;
-			}
-			idx = log_next(idx);
-			seq++;
+		textlen = msg_print_text(msg, true, text,
+					 LOG_LINE_MAX + PREFIX_MAX);
+		if (textlen < 0) {
+			len = textlen;
+			break;
+		}
+		idx = log_next(idx);
+		seq++;
 
-			logbuf_unlock_irq();
-			if (copy_to_user(buf + len, text, textlen))
-				len = -EFAULT;
-			else
-				len += textlen;
-			logbuf_lock_irq();
-
-			if (seq < log_first_seq) {
-				/* messages are gone, move to next one */
-				seq = log_first_seq;
-				idx = log_first_idx;
-			}
+		logbuf_unlock_irq();
+		if (copy_to_user(buf + len, text, textlen))
+			len = -EFAULT;
+		else
+			len += textlen;
+		logbuf_lock_irq();
+
+		if (seq < log_first_seq) {
+			/* messages are gone, move to next one */
+			seq = log_first_seq;
+			idx = log_first_idx;
 		}
 	}
 
@@ -1430,6 +1427,14 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	return len;
 }
 
+static void syslog_clear(void)
+{
+	logbuf_lock_irq();
+	clear_seq = log_next_seq;
+	clear_idx = log_next_idx;
+	logbuf_unlock_irq();
+}
+
 int do_syslog(int type, char __user *buf, int len, int source)
 {
 	bool clear = false;
@@ -1474,7 +1479,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Clear ring buffer */
 	case SYSLOG_ACTION_CLEAR:
-		syslog_print_all(NULL, 0, true);
+		syslog_clear();
 		break;
 	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_OFF:
-- 
2.13.7


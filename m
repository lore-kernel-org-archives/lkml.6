Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED03C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EC82537F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EC82537F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031834AbeGAQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:40:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031818AbeGAQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:39:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8E5F2ACC;
        Sun,  1 Jul 2018 16:39:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, dvyukov@google.com,
        syzkaller@googlegroups.com, fengguang.wu@intel.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4.17 039/220] printk: fix possible reuse of va_list variable
Date:   Sun,  1 Jul 2018 18:21:03 +0200
Message-Id: <20180701160909.962246295@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 988a35f8da1dec5a8cd2788054d1e717be61bf25 upstream.

I noticed that there is a possibility that printk_safe_log_store() causes
kernel oops because "args" parameter is passed to vsnprintf() again when
atomic_cmpxchg() detected that we raced. Fix this by using va_copy().

Link: http://lkml.kernel.org/r/201805112002.GIF21216.OFVHFOMLJtQFSO@I-love.SAKURA.ne.jp
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: dvyukov@google.com
Cc: syzkaller@googlegroups.com
Cc: fengguang.wu@intel.com
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 42a0bb3f71383b45 ("printk/nmi: generic solution for safe printk in NMI")
Cc: 4.7+ <stable@vger.kernel.org> # v4.7+
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/printk/printk_safe.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -82,6 +82,7 @@ static __printf(2, 0) int printk_safe_lo
 {
 	int add;
 	size_t len;
+	va_list ap;
 
 again:
 	len = atomic_read(&s->len);
@@ -100,7 +101,9 @@ again:
 	if (!len)
 		smp_rmb();
 
-	add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, args);
+	va_copy(ap, args);
+	add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, ap);
+	va_end(ap);
 	if (!add)
 		return 0;
 



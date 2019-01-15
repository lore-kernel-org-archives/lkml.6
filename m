Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C5EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BB20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbfAORjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:39:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbfAORjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:39:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B046F20656;
        Tue, 15 Jan 2019 17:39:12 +0000 (UTC)
Date:   Tue, 15 Jan 2019 12:39:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH RT] printk: Shortcut out of waiter spinning on PREEMPT_RT
Message-ID: <20190115123910.2b18df54@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

As the consoles are written with preemption enabled in PREEMPT_RT, we
must not have any task spinning waiting on them. Currently, the code
that would make the task spin is #ifdef out when PREEMPT_RT is
enabled, but why go through grabbing of the locks to see if an owner is
set, when it never will be?

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a43d07d4e043..1a61132deec1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1742,6 +1742,13 @@ static int console_trylock_spinning(void)
 	if (console_trylock())
 		return 1;
 
+	/*
+	 * The consoles are preemptable in PREEMPT_RT, which can cause
+	 * spinning to deadlock.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		return 0;
+
 	printk_safe_enter_irqsave(flags);
 
 	raw_spin_lock(&console_owner_lock);

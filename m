Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31957C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF793218FF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfAGTxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfAGTxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9471D2183F;
        Mon,  7 Jan 2019 19:53:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxo-0000JS-KW; Mon, 07 Jan 2019 14:53:32 -0500
Message-Id: <20190107195332.509917755@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:52:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        Jonathan Rajott <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH RT 05/13] sched/migrate_disable: Add export_symbol_gpl for __migrate_disabled
References: <20190107195252.599921907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c0f0dd3ced7abe307d8e89477dae2929e488ba6c ]

Jonathan reported that lttng/modules can't use __migrate_disabled().
This function is only used by sched/core itself and the tracing
infrastructure to report the migrate counter (lttng does probably the
same). Since the rework migrate_disable() it moved from sched.h to
preempt.h and is became an exported function instead of a "static
inline" due to the header recursion of preempt vs sched.

Since the compiler inlines the function for sched/core usage, add a
EXPORT_SYMBOL_GPL to allow the module/LTTNG usage.

Reported-by: Jonathan Rajott <jonathan.rajotte-julien@efficios.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ce950f24a7f..7c960cf07e7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1112,6 +1112,7 @@ int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
 }
+EXPORT_SYMBOL_GPL(__migrate_disabled);
 #endif
 
 static void __do_set_cpus_allowed_tail(struct task_struct *p,
-- 
2.19.2



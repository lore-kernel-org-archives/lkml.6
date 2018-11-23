Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32536C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0229D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0229D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502343AbeKWSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:18:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502329AbeKWSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:18:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAN7Xp2P4112169
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 23:33:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAN7Xpgj4112166;
        Thu, 22 Nov 2018 23:33:51 -0800
Date:   Thu, 22 Nov 2018 23:33:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-09d3f015d1e1b4fee7e9bbdcf54201d239393391@git.kernel.org>
Cc:     eranian@google.com, tglx@linutronix.de, mingo@kernel.org,
        akpm@linux-foundation.org, hpa@zytor.com,
        torvalds@linux-foundation.org, namhyung@kernel.org,
        jolsa@redhat.com, andrea.parri@amarulasolutions.com,
        paulmck@linux.vnet.ibm.com, acme@redhat.com, oleg@redhat.com,
        vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, vincent.weaver@maine.edu, acme@redhat.com,
          oleg@redhat.com, paulmck@linux.vnet.ibm.com,
          andrea.parri@amarulasolutions.com, jolsa@redhat.com,
          torvalds@linux-foundation.org, namhyung@kernel.org,
          hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org,
          eranian@google.com, tglx@linutronix.de
In-Reply-To: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
References: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] uprobes: Fix handle_swbp() vs. unregister() +
 register() race once more
Git-Commit-ID: 09d3f015d1e1b4fee7e9bbdcf54201d239393391
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  09d3f015d1e1b4fee7e9bbdcf54201d239393391
Gitweb:     https://git.kernel.org/tip/09d3f015d1e1b4fee7e9bbdcf54201d239393391
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Thu, 22 Nov 2018 17:10:31 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Nov 2018 08:31:19 +0100

uprobes: Fix handle_swbp() vs. unregister() + register() race once more

Commit:

  142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")

added the UPROBE_COPY_INSN flag, and corresponding smp_wmb() and smp_rmb()
memory barriers, to ensure that handle_swbp() uses fully-initialized
uprobes only.

However, the smp_rmb() is mis-placed: this barrier should be placed
after handle_swbp() has tested for the flag, thus guaranteeing that
(program-order) subsequent loads from the uprobe can see the initial
stores performed by prepare_uprobe().

Move the smp_rmb() accordingly.  Also amend the comments associated
to the two memory barriers to indicate their actual locations.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: stable@kernel.org
Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")
Link: http://lkml.kernel.org/r/20181122161031.15179-1-andrea.parri@amarulasolutions.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/uprobes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 96d4bee83489..322e97bbb437 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -829,7 +829,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
@@ -2178,10 +2178,18 @@ static void handle_swbp(struct pt_regs *regs)
 	 * After we hit the bp, _unregister + _register can install the
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
-	smp_rmb(); /* pairs with wmb() in install_breakpoint() */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
 		goto out;
 
+	/*
+	 * Pairs with the smp_wmb() in prepare_uprobe().
+	 *
+	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
+	 * we must also see the stores to &uprobe->arch performed by the
+	 * prepare_uprobe() call.
+	 */
+	smp_rmb();
+
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
 		goto out;

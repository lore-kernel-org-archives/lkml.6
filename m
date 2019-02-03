Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4691C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4522082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfBCO3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:29:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55430 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729970AbfBCOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:31 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdJ-0006Ji-Vg; Sun, 03 Feb 2019 14:20:30 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0007Go-Rl; Sun, 03 Feb 2019 14:49:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Andrea Parri" <andrea.parri@amarulasolutions.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Vince Weaver" <vincent.weaver@maine.edu>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.760278032@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 223/305] uprobes: Fix handle_swbp() vs. unregister()
 + register() race once more
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Parri <andrea.parri@amarulasolutions.com>

commit 09d3f015d1e1b4fee7e9bbdcf54201d239393391 upstream.

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
Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")
Link: http://lkml.kernel.org/r/20181122161031.15179-1-andrea.parri@amarulasolutions.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/events/uprobes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -610,7 +610,7 @@ static int prepare_uprobe(struct uprobe
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
@@ -1858,10 +1858,18 @@ static void handle_swbp(struct pt_regs *
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


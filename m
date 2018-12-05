Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF8C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB9320878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDc4QaAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB9320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeLEJo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeLEJoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:44:54 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87367208E7;
        Wed,  5 Dec 2018 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003093;
        bh=k3m4FbzSpMwzlFQPy+D37AqWNc1svZXeT65y/k+HLS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oDc4QaAndugsXjYAetmoxy/biqb5R1cv1qYc4BFeKfvP5rgaeevt93tYSHpCSlWBN
         2+Mamt0BYABkGN+CapGrzFTX9FBPnGKICLMwQBPnvHgaVpHU1+/Cv7aJENf1vzWhNB
         xb4E201yGBzsVAiwPLf8ZLSIxf2RyadJp7TKkexQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, stable@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 27/69] uprobes: Fix handle_swbp() vs. unregister() + register() race once more
Date:   Wed,  5 Dec 2018 04:42:05 -0500
Message-Id: <20181205094247.6556-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

[ Upstream commit 09d3f015d1e1b4fee7e9bbdcf54201d239393391 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/uprobes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 267f6ef91d97..01941cffa9c2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -616,7 +616,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
@@ -1910,10 +1910,18 @@ static void handle_swbp(struct pt_regs *regs)
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
-- 
2.17.1


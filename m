Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A25AC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C523F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C523F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeILL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:58:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeILL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:58:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8C6rVl62538682
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Sep 2018 23:53:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8C6rV7P2538679;
        Tue, 11 Sep 2018 23:53:31 -0700
Date:   Tue, 11 Sep 2018 23:53:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-819319fc93461c07b9cdb3064f154bd8cfd48172@git.kernel.org>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        anil.s.keshavamurthy@intel.com, hpa@zytor.com,
        naveen.n.rao@linux.vnet.ibm.com, mhiramat@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          anil.s.keshavamurthy@intel.com, davem@davemloft.net,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          naveen.n.rao@linux.vnet.ibm.com, mhiramat@kernel.org,
          hpa@zytor.com
In-Reply-To: <153666124040.21306.14150398706331307654.stgit@devbox>
References: <153666124040.21306.14150398706331307654.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Return error if we fail to reuse kprobe
 instead of BUG_ON()
Git-Commit-ID: 819319fc93461c07b9cdb3064f154bd8cfd48172
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

Commit-ID:  819319fc93461c07b9cdb3064f154bd8cfd48172
Gitweb:     https://git.kernel.org/tip/819319fc93461c07b9cdb3064f154bd8cfd48172
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Tue, 11 Sep 2018 19:20:40 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 12 Sep 2018 08:01:16 +0200

kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()

Make reuse_unused_kprobe() to return error code if
it fails to reuse unused kprobe for optprobe instead
of calling BUG_ON().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N . Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/153666124040.21306.14150398706331307654.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 277a6cbe83db..63c342e5e6c3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -700,9 +700,10 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 }
 
 /* Cancel unoptimizing for reusing */
-static void reuse_unused_kprobe(struct kprobe *ap)
+static int reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
+	int ret;
 
 	/*
 	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
@@ -713,8 +714,12 @@ static void reuse_unused_kprobe(struct kprobe *ap)
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
-	BUG_ON(!kprobe_optready(ap));
+	ret = kprobe_optready(ap);
+	if (ret)
+		return ret;
+
 	optimize_kprobe(ap);
+	return 0;
 }
 
 /* Remove optimized instructions */
@@ -939,11 +944,16 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 #define kprobe_disarmed(p)			kprobe_disabled(p)
 #define wait_for_kprobe_optimizer()		do {} while (0)
 
-/* There should be no unused kprobes can be reused without optimization */
-static void reuse_unused_kprobe(struct kprobe *ap)
+static int reuse_unused_kprobe(struct kprobe *ap)
 {
+	/*
+	 * If the optimized kprobe is NOT supported, the aggr kprobe is
+	 * released at the same time that the last aggregated kprobe is
+	 * unregistered.
+	 * Thus there should be no chance to reuse unused kprobe.
+	 */
 	printk(KERN_ERR "Error: There should be no unused kprobe here.\n");
-	BUG_ON(kprobe_unused(ap));
+	return -EINVAL;
 }
 
 static void free_aggr_kprobe(struct kprobe *p)
@@ -1315,9 +1325,12 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 			goto out;
 		}
 		init_aggr_kprobe(ap, orig_p);
-	} else if (kprobe_unused(ap))
+	} else if (kprobe_unused(ap)) {
 		/* This probe is going to die. Rescue it */
-		reuse_unused_kprobe(ap);
+		ret = reuse_unused_kprobe(ap);
+		if (ret)
+			goto out;
+	}
 
 	if (kprobe_gone(ap)) {
 		/*

Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C28BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A852064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWW+Li1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A852064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeKAIGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbeKAIGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F382120838;
        Wed, 31 Oct 2018 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027197;
        bh=5EqJv7ncqkFpEAiGQyfgKvF+NY2jtRsfMi5tulWvSic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWW+Li1E5rJZY84PtZvjVQsd1J2iLV/syt4WSuoT9887/s0NfnBcCGO16Oke8qSBE
         oqAkQxoMqOgVJ7PPy6zdoZogkIZz5UP2t0URAqV056pxjS8oWeddiTL+EqRnalBqka
         XEbLgQw8qIlI/MDfFPEMtqFRRXr8q4J1VUGZG7ko=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 060/146] kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()
Date:   Wed, 31 Oct 2018 19:04:15 -0400
Message-Id: <20181031230541.28822-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 819319fc93461c07b9cdb3064f154bd8cfd48172 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab257be4d924..4344381664cc 100644
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
 
 	BUG_ON(!kprobe_unused(ap));
 	/*
@@ -714,8 +715,12 @@ static void reuse_unused_kprobe(struct kprobe *ap)
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
@@ -940,11 +945,16 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
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
@@ -1318,9 +1328,12 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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
-- 
2.17.1


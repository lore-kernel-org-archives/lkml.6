Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59118208C2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwR4zEW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59118208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbeHUM7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeHUM7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:59:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2789208C2;
        Tue, 21 Aug 2018 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534844392;
        bh=b70k6hylNV4gTFKNqqCQWGr6hs4NFyt8sFzYt9QXHYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwR4zEW9VA2o+Q91qit3FehzUAFt/9IAis0RgftfO0egDrEyPitvo83+RZZjJZSli
         A2r1Cn98rA4EjwMhCTbUpwSb7HyZLRTSEoJ5iLapEanUAIDnyuyOPt7AmQScFkSX3r
         mhvvK27LC9h1P6dCfeRzDc8MICP/eDzAp07kuH4o=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip 4/5] kprobes: Return error if fail to reuse kprobe instead of BUG_ON
Date:   Tue, 21 Aug 2018 18:39:29 +0900
Message-Id: <153484436978.5385.10806549496148012761.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153484425558.5385.1484910606397784412.stgit@devbox>
References: <153484425558.5385.1484910606397784412.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make reuse_unused_kprobe() to return error code if
it fails to reuse unused kprobe for optprobe instead
of calling BUG_ON().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   27 ++++++++++++++++++++-------
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


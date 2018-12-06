Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DAFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31F4214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107261;
	bh=TUsTUKpAcC/P5iAdKWQBGPlVidizanrFNcV3WPVNdks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tTwqrfB76VuiiSPKgKw2cXl7soBLNqQZaWEepPxcLnVAd68zPUnWzXwPTfoXTLvkI
	 lzMNO3UR0mRGLv0sucibqVYMRsz5vLWr9byD22WrUVOFwVqMGmJ62AFI2gKs3XETg6
	 XSPcgLv6eQysAPW4982M4dZELb53WbuTAnEyJdZk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31F4214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbeLFOlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730080AbeLFOk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01A82082B;
        Thu,  6 Dec 2018 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107257;
        bh=TUsTUKpAcC/P5iAdKWQBGPlVidizanrFNcV3WPVNdks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCREoqyFS0DIrpQ93b7b8hE8CwAHVRg4krue13yaiLwQHwBxj7wsncM9pvKrvW2KR
         hK428rCY7Q7f//GKRiqPVPCE27FJ2WCluA8uxhuNQkSPR0fH1K+ETKXc/tmXnZh3jW
         8HL9wJqNhyd6FTWZAhA1i8/Qfv2QJ989IN9Dd2dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, stable@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 05/41] uprobes: Fix handle_swbp() vs. unregister() + register() race once more
Date:   Thu,  6 Dec 2018 15:38:45 +0100
Message-Id: <20181206142950.146291936@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@kernel.org
Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")
Link: http://lkml.kernel.org/r/20181122161031.15179-1-andrea.parri@amarulasolutions.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/uprobes.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -616,7 +616,7 @@ static int prepare_uprobe(struct uprobe
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
@@ -1914,10 +1914,18 @@ static void handle_swbp(struct pt_regs *
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



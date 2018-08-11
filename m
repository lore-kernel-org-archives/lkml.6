Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B51C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E4E21A28
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E4E21A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeHKQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbeHKQY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4124521A2A;
        Sat, 11 Aug 2018 13:50:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHT-00060R-B3; Sat, 11 Aug 2018 09:50:11 -0400
Message-Id: <20180811135011.244166178@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 02/34] srcu: Add notrace variant of srcu_dereference
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In the last patch in this series, we are making lockdep register hooks
onto the irq_{disable,enable} tracepoints. These tracepoints use the
_rcuidle tracepoint variant. In this series we switch the _rcuidle
tracepoint callers to use SRCU instead of sched-RCU. Inorder to
dereference the pointer to the probe functions, we could call
srcu_dereference, however this API will call back into lockdep to check
if the lock is held *before* the lockdep probe hooks have a chance to
run and annotate the IRQ enabled/disabled state.

For this reason we need a notrace variant of srcu_dereference since
otherwise we get lockdep splats. This patch adds the needed
srcu_dereference_notrace variant.

Link: http://lkml.kernel.org/r/20180628182149.226164-3-joel@joelfernandes.org

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/srcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 3e72a291c401..67135d4a8a30 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -169,6 +169,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
  */
 #define srcu_dereference(p, sp) srcu_dereference_check((p), (sp), 0)
 
+/**
+ * srcu_dereference_notrace - no tracing and no lockdep calls from here
+ */
+#define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)
+
 /**
  * srcu_read_lock - register a new reader for an SRCU-protected structure.
  * @sp: srcu_struct in which to register the new reader.
-- 
2.18.0



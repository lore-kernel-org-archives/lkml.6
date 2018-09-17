Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B225ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6BA2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6BA2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeIREUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:20:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeIREUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:20:53 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 12DE6CAE;
        Mon, 17 Sep 2018 22:51:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, sramana@codeaurora.org,
        Ingo Molnar <mingo@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 12/56] locking/osq_lock: Fix osq_lock queue corruption
Date:   Tue, 18 Sep 2018 00:41:45 +0200
Message-Id: <20180917213828.470483080@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prateek Sood <prsood@codeaurora.org>

commit 50972fe78f24f1cd0b9d7bbf1f87d2be9e4f412e upstream.

Fix ordering of link creation between node->prev and prev->next in
osq_lock(). A case in which the status of optimistic spin queue is
CPU6->CPU2 in which CPU6 has acquired the lock.

        tail
          v
  ,-. <- ,-.
  |6|    |2|
  `-' -> `-'

At this point if CPU0 comes in to acquire osq_lock, it will update the
tail count.

  CPU2			CPU0
  ----------------------------------

				       tail
				         v
			  ,-. <- ,-.    ,-.
			  |6|    |2|    |0|
			  `-' -> `-'    `-'

After tail count update if CPU2 starts to unqueue itself from
optimistic spin queue, it will find an updated tail count with CPU0 and
update CPU2 node->next to NULL in osq_wait_next().

  unqueue-A

	       tail
	         v
  ,-. <- ,-.    ,-.
  |6|    |2|    |0|
  `-'    `-'    `-'

  unqueue-B

  ->tail != curr && !node->next

If reordering of following stores happen then prev->next where prev
being CPU2 would be updated to point to CPU0 node:

				       tail
				         v
			  ,-. <- ,-.    ,-.
			  |6|    |2|    |0|
			  `-'    `-' -> `-'

  osq_wait_next()
    node->next <- 0
    xchg(node->next, NULL)

	       tail
	         v
  ,-. <- ,-.    ,-.
  |6|    |2|    |0|
  `-'    `-'    `-'

  unqueue-C

At this point if next instruction
	WRITE_ONCE(next->prev, prev);
in CPU2 path is committed before the update of CPU0 node->prev = prev then
CPU0 node->prev will point to CPU6 node.

	       tail
    v----------. v
  ,-. <- ,-.    ,-.
  |6|    |2|    |0|
  `-'    `-'    `-'
     `----------^

At this point if CPU0 path's node->prev = prev is committed resulting
in change of CPU0 prev back to CPU2 node. CPU2 node->next is NULL
currently,

				       tail
			                 v
			  ,-. <- ,-. <- ,-.
			  |6|    |2|    |0|
			  `-'    `-'    `-'
			     `----------^

so if CPU0 gets into unqueue path of osq_lock it will keep spinning
in infinite loop as condition prev->next == node will never be true.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
[ Added pictures, rewrote comments. ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: sramana@codeaurora.org
Link: http://lkml.kernel.org/r/1500040076-27626-1-git-send-email-prsood@codeaurora.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/locking/osq_lock.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -104,6 +104,19 @@ bool osq_lock(struct optimistic_spin_que
 
 	prev = decode_cpu(old);
 	node->prev = prev;
+
+	/*
+	 * osq_lock()			unqueue
+	 *
+	 * node->prev = prev		osq_wait_next()
+	 * WMB				MB
+	 * prev->next = node		next->prev = prev // unqueue-C
+	 *
+	 * Here 'node->prev' and 'next->prev' are the same variable and we need
+	 * to ensure these stores happen in-order to avoid corrupting the list.
+	 */
+	smp_wmb();
+
 	WRITE_ONCE(prev->next, node);
 
 	/*



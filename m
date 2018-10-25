Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B3AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDFB2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAhsAmTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDFB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeJYWxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730942AbeJYWxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:15 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26202085B;
        Thu, 25 Oct 2018 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477217;
        bh=9CXAaSh5CMkZ5Z1fHYLCLLb/NaGCfCRaAKtFoMrnmZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAhsAmTGkyofTcp7meP4T8DWTSoyApNxFH80NE+nTuj8Sj5PbPW+Dkpr4TD5+n2+r
         wfCyRYMGpd5M6eNaBDLWNVcbU2Li6PXGRYxwQGnZjogQ07/jKqOIaFIqMrewptWpEz
         TVK/vY+UMfbauon9CPNRzyHNmuafRvpjgv8CmoU4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 55/98] rcu: Clear need_qs flag to prevent splat
Date:   Thu, 25 Oct 2018 10:18:10 -0400
Message-Id: <20181025141853.214051-55-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit c0135d07b013fa8f7ba9ec91b4369c372e6a28cb ]

If the scheduling-clock interrupt sets the current tasks need_qs flag,
but if the current CPU passes through a quiescent state in the meantime,
then rcu_preempt_qs() will fail to clear the need_qs flag, which can fool
RCU into thinking that additional rcu_read_unlock_special() processing
is needed.  This commit therefore clears the need_qs flag before checking
for additional processing.

For this problem to occur, we need rcu_preempt_data.passed_quiesce equal
to true and current->rcu_read_unlock_special.b.need_qs also equal to true.
This condition can occur as follows:

1.	CPU 0 is aware of the current preemptible RCU grace period,
	but has not yet passed through a quiescent state.  Among other
	things, this means that rcu_preempt_data.passed_quiesce is false.

2.	Task A running on CPU 0 enters a preemptible RCU read-side
	critical section.

3.	CPU 0 takes a scheduling-clock interrupt, which notices the
	RCU read-side critical section and the need for a quiescent state,
	and thus sets current->rcu_read_unlock_special.b.need_qs to true.

4.	Task A is preempted, enters the scheduler, eventually invoking
	rcu_preempt_note_context_switch() which in turn invokes
	rcu_preempt_qs().

	Because rcu_preempt_data.passed_quiesce is false,
	control enters the body of the "if" statement, which sets
	rcu_preempt_data.passed_quiesce to true.

5.	At this point, CPU 0 takes an interrupt.  The interrupt
	handler contains an RCU read-side critical section, and
	the rcu_read_unlock() notes that current->rcu_read_unlock_special
	is nonzero, and thus invokes rcu_read_unlock_special().

6.	Once in rcu_read_unlock_special(), the fact that
	current->rcu_read_unlock_special.b.need_qs is true becomes
	apparent, so rcu_read_unlock_special() invokes rcu_preempt_qs().
	Recursively, given that we interrupted out of that same
	function in the preceding step.

7.	Because rcu_preempt_data.passed_quiesce is now true,
	rcu_preempt_qs() does nothing, and simply returns.

8.	Upon return to rcu_read_unlock_special(), it is noted that
	current->rcu_read_unlock_special is still nonzero (because
	the interrupted rcu_preempt_qs() had not yet gotten around
	to clearing current->rcu_read_unlock_special.b.need_qs).

9.	Execution proceeds to the WARN_ON_ONCE(), which notes that
	we are in an interrupt handler and thus duly splats.

The solution, as noted above, is to make rcu_read_unlock_special()
clear out current->rcu_read_unlock_special.b.need_qs after calling
rcu_preempt_qs().  The interrupted rcu_preempt_qs() will clear it again,
but this is harmless.  The worst that happens is that we clobber another
attempt to set this field, but this is not a problem because we just
got done reporting a quiescent state.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Fix embarrassing build bug noted by Sasha Levin. ]
Tested-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c1d7f27bd38f..c038831bfa57 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -328,6 +328,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 	special = t->rcu_read_unlock_special;
 	if (special.b.need_qs) {
 		rcu_preempt_qs();
+		t->rcu_read_unlock_special.b.need_qs = false;
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
 			return;
-- 
2.17.1


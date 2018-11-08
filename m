Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BCECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381722089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxl8e2fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381722089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeKIHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbeKIHdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:45 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BCC2089F;
        Thu,  8 Nov 2018 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714177;
        bh=rAKqzMvYNkQTsN5e2+HZLSUUokfyyuV+khIFrNS5obY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxl8e2fsU/2iffJ4LRB75b36P+DfJnLSQSbN+CHhAlbMLTgoGB4PJUQgk94UhAdzx
         oBYdwjGQJKgnG1nJjsrOLyTVjWCjtWch9XUo8n/hI5Ejw7noSCDcmDguEiFN8LeRIP
         7S9FuHoEkEGOnaDCAdzKu2cwEpqDK17XN0MNsAaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 084/144] rcu: Clear need_qs flag to prevent splat
Date:   Thu,  8 Nov 2018 13:50:55 -0800
Message-Id: <20181108215101.510788261@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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




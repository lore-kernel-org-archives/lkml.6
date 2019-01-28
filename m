Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BDC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324F21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695255;
	bh=sk1RafSFJDYo0AMn5wSFwG1OgBWeJlKRV4xSfAVGAzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gOZ87B5CS2CRZOPoJwIL51qtTOfjS5uLtOyfBx6Znu6baoReG7mL5D/RnMWnnZfjV
	 QT2k9xPBNwEpgC3Hqt5neyuZLP6JV6rAuj+h5P9eepnk6Oy6u1TpO5a4WA7a7hNzQR
	 aUhthok/dhIUUYRZnm37fW5T8lh8anhrp83rxXX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfA1QMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:12:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733200AbfA1QMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196912177E;
        Mon, 28 Jan 2019 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691962;
        bh=sk1RafSFJDYo0AMn5wSFwG1OgBWeJlKRV4xSfAVGAzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFwD2hjskL7/8k+HnSZnZOuAWcQK2113zM5nNlHWZlErZa3rD3IWK1TZeGlx16bBO
         6pPSSBI5vlzbm8dPiY3M1RLu8hvRzv3/XX3O4E1lNR/KLwAkIJL5PIgWPpFYGMR/UP
         BBZBame8Xv8BePYwD0HyPUgRDGSORzQml/wkLFLk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 017/170] srcu: Prevent __call_srcu() counter wrap with read-side critical section
Date:   Mon, 28 Jan 2019 11:09:27 -0500
Message-Id: <20190128161200.55107-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit 0607ba8403c4cdb253f8c5200ecf654dfb7790cc ]

Ever since cdf7abc4610a ("srcu: Allow use of Tiny/Tree SRCU from
both process and interrupt context"), it has been permissible
to use SRCU read-side critical sections in interrupt context.
This allows __call_srcu() to use SRCU read-side critical sections to
prevent a new SRCU grace period from ending before the call to either
srcu_funnel_gp_start() or srcu_funnel_exp_start completes, thus preventing
SRCU grace-period counter overflow during that time.

Note that this does not permit removal of the counter-wrap checks in
srcu_gp_end().  These check are necessary to handle the case where
a given CPU does not interact at all with SRCU for an extended time
period.

This commit therefore adds an SRCU read-side critical section to
__call_srcu() in order to prevent grace period counter wrap during
the funnel-locking process.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/srcutree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6d5880089ff6..a3ab10e385e2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -815,6 +815,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		 rcu_callback_t func, bool do_norm)
 {
 	unsigned long flags;
+	int idx;
 	bool needexp = false;
 	bool needgp = false;
 	unsigned long s;
@@ -828,6 +829,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
+	idx = srcu_read_lock(sp);
 	local_irq_save(flags);
 	sdp = this_cpu_ptr(sp->sda);
 	raw_spin_lock_rcu_node(sdp);
@@ -849,6 +851,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		srcu_funnel_gp_start(sp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(sp, sdp->mynode, s);
+	srcu_read_unlock(sp, idx);
 }
 
 /**
-- 
2.19.1


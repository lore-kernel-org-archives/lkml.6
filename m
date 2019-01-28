Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8373C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CF620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697843;
	bh=UTG+Pym3eVJFE5U/jwsn6D6mf/pCJsiUEqQt5GAGKZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qpdcl9jCXgmSeSJBT6+Q7UBzTWheRfUdQu+FHtv2HPJXdQmke5Ri9ZtAFGFybUDsF
	 n3L3+0WxsouWmqrkqW4fOlq/4ahcFtZrNV4BdARQFa7LWLf3Kcw7Gwt3GganYmij86
	 uaV9E/Kzgnc9bGnrDSXYHR3Pxvvrbgr4usYC9owc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfA1Rul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfA1Pof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3AD2147A;
        Mon, 28 Jan 2019 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690274;
        bh=UTG+Pym3eVJFE5U/jwsn6D6mf/pCJsiUEqQt5GAGKZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1Xgm+9P+Ia9KhWYVP3Qk2Xy/FmtLC/m134EGOqv93Dd0JaNR5/teKjJxUkny3RQ1
         UPJ0O7eviucgpogwFwdMydCZ3rFGcyiHe90G1oAALWu0ca+1VBgtqZdC+JdTiZ+k+V
         Wny9rfKkKAE4ebHKC0/Xuc/vIJCfNz6CFyR/Wc/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 028/304] srcu: Prevent __call_srcu() counter wrap with read-side critical section
Date:   Mon, 28 Jan 2019 10:39:05 -0500
Message-Id: <20190128154341.47195-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index a180abc8c925..697a2d7e8e8a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -860,6 +860,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		 rcu_callback_t func, bool do_norm)
 {
 	unsigned long flags;
+	int idx;
 	bool needexp = false;
 	bool needgp = false;
 	unsigned long s;
@@ -873,6 +874,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
+	idx = srcu_read_lock(sp);
 	local_irq_save(flags);
 	sdp = this_cpu_ptr(sp->sda);
 	spin_lock_rcu_node(sdp);
@@ -894,6 +896,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		srcu_funnel_gp_start(sp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(sp, sdp->mynode, s);
+	srcu_read_unlock(sp, idx);
 }
 
 /**
-- 
2.19.1


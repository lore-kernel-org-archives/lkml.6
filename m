Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D01FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93720855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696414;
	bh=d+T4q3J7C/K4rCY+5+UoUXcpQ11m0dOMCGOWeaKkp5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9oUsZVAwK9jYGc1zAx3e8JVZASeubv0Qe3RbUzYb4EuFoGGtuIZaFuEr5whVQDXc
	 RbpshzD/4mUv1INU5Ut+Bmm1DP6xtAFPKebSyJ+WmoaS0ubOPM6je/9ShAyEYI88CY
	 AGrO9xE0wlc1F9XSNY3LYjid+axKe7qCe60/sBhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfA1R0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfA1QAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C464821848;
        Mon, 28 Jan 2019 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691230;
        bh=d+T4q3J7C/K4rCY+5+UoUXcpQ11m0dOMCGOWeaKkp5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR8fOYaOlAyEqDt42Ufhln+oeOKiVeeYE/m9pvDmapIPzWqJs2Bo/5Gri+WuRBFFa
         rdW+nN/OZVmxcWjbXDX3WY2Ur7jwhcBaB1eHkwvKIl5sStwV0n4zWsl/Wee6miG/bg
         sXUHSeYElP30Cl6n1TIuyNFiKORyKp6VHkjtdFo4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 024/258] srcu: Prevent __call_srcu() counter wrap with read-side critical section
Date:   Mon, 28 Jan 2019 10:55:30 -0500
Message-Id: <20190128155924.51521-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 1ff17e297f0c..4b0a6e319b2c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -853,6 +853,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		 rcu_callback_t func, bool do_norm)
 {
 	unsigned long flags;
+	int idx;
 	bool needexp = false;
 	bool needgp = false;
 	unsigned long s;
@@ -866,6 +867,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
+	idx = srcu_read_lock(sp);
 	local_irq_save(flags);
 	sdp = this_cpu_ptr(sp->sda);
 	spin_lock_rcu_node(sdp);
@@ -887,6 +889,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		srcu_funnel_gp_start(sp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(sp, sdp->mynode, s);
+	srcu_read_unlock(sp, idx);
 }
 
 /**
-- 
2.19.1


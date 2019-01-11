Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA81C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F551206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217676;
	bh=9EH/BuI1qT7BNmO0SFPLIzOeYvhtQel8qalD2WkM9Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iJ8yaqoSoBftYECA2ZFHXlsxJ07GOc1fB9SBif4CiX1LDTTarcCtshII6ZoxSWN00
	 lqUr8iPxUSz/mrVEd9yHrUATOQA8FhnOZ9IH7pmuuFV+BgXAYREp7M+ClNH4HGZDAA
	 J1R7h0LruUeMHCNxuUTFTLbOplT0B0UCJyO0mW4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbfAKOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403979AbfAKOlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51CC32063F;
        Fri, 11 Jan 2019 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217670;
        bh=9EH/BuI1qT7BNmO0SFPLIzOeYvhtQel8qalD2WkM9Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7y4zbxzJB5Xu6DyKGSN9m5GKmODulGCPN9Kbm0oGgDBHRBBo4h+fDp8xJTN7oMmP
         t5vhG7zjUe7bKENFZp9KwpGb2nCJuU/6Dh4XfHKB/7ITx8TtOru4RbC1EYZ54NAn4o
         rAdXmzI5MsamN8O36N/Zyueer+XbdqNuGYF0OH3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Kuzminsky <seb.kuzminsky@gmail.com>,
        Dennis Krein <Dennis.Krein@netapp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 4.19 109/148] srcu: Lock srcu_data structure in srcu_gp_start()
Date:   Fri, 11 Jan 2019 15:14:47 +0100
Message-Id: <20190111131118.571242496@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

From: Dennis Krein <Dennis.Krein@netapp.com>

commit eb4c2382272ae7ae5d81fdfa5b7a6c86146eaaa4 upstream.

The srcu_gp_start() function is called with the srcu_struct structure's
->lock held, but not with the srcu_data structure's ->lock.  This is
problematic because this function accesses and updates the srcu_data
structure's ->srcu_cblist, which is protected by that lock.  Failing to
hold this lock can result in corruption of the SRCU callback lists,
which in turn can result in arbitrarily bad results.

This commit therefore makes srcu_gp_start() acquire the srcu_data
structure's ->lock across the calls to rcu_segcblist_advance() and
rcu_segcblist_accelerate(), thus preventing this corruption.

Reported-by: Bart Van Assche <bvanassche@acm.org>
Reported-by: Christoph Hellwig <hch@infradead.org>
Reported-by: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Signed-off-by: Dennis Krein <Dennis.Krein@netapp.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Dennis Krein <Dennis.Krein@netapp.com>
Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/rcu/srcutree.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -448,10 +448,12 @@ static void srcu_gp_start(struct srcu_st
 
 	lockdep_assert_held(&ACCESS_PRIVATE(sp, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
+	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&sp->srcu_gp_seq));
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&sp->srcu_gp_seq));
+	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
 	rcu_seq_start(&sp->srcu_gp_seq);
 	state = rcu_seq_state(READ_ONCE(sp->srcu_gp_seq));



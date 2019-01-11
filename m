Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47122C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4D6206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218041;
	bh=Ex/KFTgNrf1hHYJvb848wwO+/XrA7qOS6iLUqLPThp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xMWfePyMjx1I4MSSYVLMQ3s0HgzYIMj2oV18djQmN8OpOubRUIO4fm4eQ7ueqoCdk
	 M7rJmBjY7SMZIezU52nRrCiQxW4fbyhByRe9IziHObeMGmZXhSH/Fh06uqzgtK2PKr
	 dfeKTk+ZURdvQugO66wY3T2lbpgu2oWIE1CU/Hmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404146AbfAKOmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391375AbfAKOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C604F21848;
        Fri, 11 Jan 2019 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217740;
        bh=Ex/KFTgNrf1hHYJvb848wwO+/XrA7qOS6iLUqLPThp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfxPcc1589wPMi8youkoykDjegGOXT4Bwr+oD9QHkFNN4jw89xufstl0lIY7gpPxp
         6HirejLbD9JmRM7+g7yOlvDRbFA153i2Qt9+9d/SvjBKLOp0/yevbHw54QS+eNRIPn
         aTPPG4pfPbaXV52emeWX37bLY80S7fsyC+c9eeYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Kuzminsky <seb.kuzminsky@gmail.com>,
        Dennis Krein <Dennis.Krein@netapp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 4.20 23/65] srcu: Lock srcu_data structure in srcu_gp_start()
Date:   Fri, 11 Jan 2019 15:15:09 +0100
Message-Id: <20190111131059.607320719@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -451,10 +451,12 @@ static void srcu_gp_start(struct srcu_st
 
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



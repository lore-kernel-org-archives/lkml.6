Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16892C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B98222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403801AbfBMIbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:31:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbfBMIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:31:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D8VO93189390
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 00:31:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D8VOjm189387;
        Wed, 13 Feb 2019 00:31:24 -0800
Date:   Wed, 13 Feb 2019 00:31:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Zhang, Jun" <tipbot@zytor.com>
Message-ID: <tip-13dc7d0c7a2ed438f0ec8e9fb365a1256d87cf87@git.kernel.org>
Cc:     tglx@linutronix.de, jun.zhang@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        paulmck@linux.ibm.com
Reply-To: hpa@zytor.com, jun.zhang@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          paulmck@linux.ibm.com
In-Reply-To: <88DC34334CA3444C85D647DBFA962C2735AD5F77@SHSMSX104.ccr.corp.intel.com>
References: <88DC34334CA3444C85D647DBFA962C2735AD5F77@SHSMSX104.ccr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] rcu: Prevent needless ->gp_seq_needed update in
 __note_gp_changes()
Git-Commit-ID: 13dc7d0c7a2ed438f0ec8e9fb365a1256d87cf87
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  13dc7d0c7a2ed438f0ec8e9fb365a1256d87cf87
Gitweb:     https://git.kernel.org/tip/13dc7d0c7a2ed438f0ec8e9fb365a1256d87cf87
Author:     Zhang, Jun <jun.zhang@intel.com>
AuthorDate: Wed, 19 Dec 2018 10:37:34 -0800
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Fri, 25 Jan 2019 15:30:00 -0800

rcu: Prevent needless ->gp_seq_needed update in __note_gp_changes()

Currently, __note_gp_changes() checks to see if the rcu_node structure's
->gp_seq_needed is greater than or equal to that of the rcu_data
structure, and if so, updates the rcu_data structure's ->gp_seq_needed
field.  This results in a useless store in the case where the two fields
are equal.

This commit therefore carries out this store only in the case where the
rcu_node structure's ->gp_seq_needed is strictly greater than that of
the rcu_data structure.

Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Link: https://lkml.kernel.org/r/88DC34334CA3444C85D647DBFA962C2735AD5F77@SHSMSX104.ccr.corp.intel.com
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21775eebb8f0..9d0e2ac9356e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1758,7 +1758,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		zero_cpu_stall_ticks(rdp);
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
-	if (ULONG_CMP_GE(rnp->gp_seq_needed, rdp->gp_seq_needed) || rdp->gpwrap)
+	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
 		rdp->gp_seq_needed = rnp->gp_seq_needed;
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);

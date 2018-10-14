Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A63C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F72E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F72E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeJNXin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:38:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37589 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727813AbeJNXim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:38:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM6-0004cD-99; Sun, 14 Oct 2018 16:30:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLR-0000IT-B6; Sun, 14 Oct 2018 16:30:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "piaojun" <piaojun@huawei.com>, "Alex Chen" <alex.chen@huawei.com>,
        "Mark Fasheh" <mark@fasheh.com>,
        "Joel Becker" <jlbec@evilplan.org>,
        "Yiwen Jiang" <jiangyiwen@huawei.com>,
        "Changwei Ge" <ge.changwei@h3c.com>,
        "Joseph Qi" <jiangqi903@gmail.com>,
        "Junxiao Bi" <junxiao.bi@oracle.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.997836535@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 115/366] ocfs2/dlm: wait for dlm recovery done when
 migrating all lock resources
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: piaojun <piaojun@huawei.com>

commit 60c7ec9ee4a3410c2cb08850102d363c7e207f48 upstream.

Wait for dlm recovery done when migrating all lock resources in case that
new lock resource left after leaving dlm domain.  And the left lock
resource will cause other nodes BUG.

        NodeA                       NodeB                NodeC

  umount:
    dlm_unregister_domain()
      dlm_migrate_all_locks()

                                   NodeB down

  do recovery for NodeB
  and collect a new lockres
  form other live nodes:

    dlm_do_recovery
      dlm_remaster_locks
        dlm_request_all_locks:

    dlm_mig_lockres_handler
      dlm_new_lockres
        __dlm_insert_lockres

  at last NodeA become the
  master of the new lockres
  and leave domain:
    dlm_leave_domain()

                                                    mount:
                                                      dlm_join_domain()

                                                    touch file and request
                                                    for the owner of the new
                                                    lockres, but all the
                                                    other nodes said 'NO',
                                                    so NodeC decide to be
                                                    the owner, and send do
                                                    assert msg to other
                                                    nodes:
                                                    dlmlock()
                                                      dlm_get_lock_resource()
                                                        dlm_do_assert_master()

                                                    other nodes receive the msg
                                                    and found two masters exist.
                                                    at last cause BUG in
                                                    dlm_assert_master_handler()
                                                    -->BUG();

Link: http://lkml.kernel.org/r/5AAA6E25.7090303@huawei.com
Fixes: bc9838c4d44a ("dlm: allow dlm do recovery during shutdown")
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Acked-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ocfs2/dlm/dlmcommon.h   |  1 +
 fs/ocfs2/dlm/dlmdomain.c   | 15 +++++++++++++++
 fs/ocfs2/dlm/dlmrecovery.c | 13 ++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -140,6 +140,7 @@ struct dlm_ctxt
 	u8 node_num;
 	u32 key;
 	u8  joining_node;
+	u8 migrate_done; /* set to 1 means node has migrated all lock resources */
 	wait_queue_head_t dlm_join_events;
 	unsigned long live_nodes_map[BITS_TO_LONGS(O2NM_MAX_NODES)];
 	unsigned long domain_map[BITS_TO_LONGS(O2NM_MAX_NODES)];
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -460,6 +460,19 @@ redo_bucket:
 		cond_resched_lock(&dlm->spinlock);
 		num += n;
 	}
+
+	if (!num) {
+		if (dlm->reco.state & DLM_RECO_STATE_ACTIVE) {
+			mlog(0, "%s: perhaps there are more lock resources "
+			     "need to be migrated after dlm recovery\n", dlm->name);
+			ret = -EAGAIN;
+		} else {
+			mlog(0, "%s: we won't do dlm recovery after migrating "
+			     "all lock resources\n", dlm->name);
+			dlm->migrate_done = 1;
+		}
+	}
+
 	spin_unlock(&dlm->spinlock);
 	wake_up(&dlm->dlm_thread_wq);
 
@@ -2063,6 +2076,8 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
 	dlm->joining_node = DLM_LOCK_RES_OWNER_UNKNOWN;
 	init_waitqueue_head(&dlm->dlm_join_events);
 
+	dlm->migrate_done = 0;
+
 	dlm->reco.new_master = O2NM_INVALID_NODE_NUM;
 	dlm->reco.dead_node = O2NM_INVALID_NODE_NUM;
 
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -423,12 +423,11 @@ void dlm_wait_for_recovery(struct dlm_ct
 
 static void dlm_begin_recovery(struct dlm_ctxt *dlm)
 {
-	spin_lock(&dlm->spinlock);
+	assert_spin_locked(&dlm->spinlock);
 	BUG_ON(dlm->reco.state & DLM_RECO_STATE_ACTIVE);
 	printk(KERN_NOTICE "o2dlm: Begin recovery on domain %s for node %u\n",
 	       dlm->name, dlm->reco.dead_node);
 	dlm->reco.state |= DLM_RECO_STATE_ACTIVE;
-	spin_unlock(&dlm->spinlock);
 }
 
 static void dlm_end_recovery(struct dlm_ctxt *dlm)
@@ -456,6 +455,13 @@ static int dlm_do_recovery(struct dlm_ct
 
 	spin_lock(&dlm->spinlock);
 
+	if (dlm->migrate_done) {
+		mlog(0, "%s: no need do recovery after migrating all "
+		     "lock resources\n", dlm->name);
+		spin_unlock(&dlm->spinlock);
+		return 0;
+	}
+
 	/* check to see if the new master has died */
 	if (dlm->reco.new_master != O2NM_INVALID_NODE_NUM &&
 	    test_bit(dlm->reco.new_master, dlm->recovery_map)) {
@@ -490,12 +496,13 @@ static int dlm_do_recovery(struct dlm_ct
 	mlog(0, "%s(%d):recovery thread found node %u in the recovery map!\n",
 	     dlm->name, task_pid_nr(dlm->dlm_reco_thread_task),
 	     dlm->reco.dead_node);
-	spin_unlock(&dlm->spinlock);
 
 	/* take write barrier */
 	/* (stops the list reshuffling thread, proxy ast handling) */
 	dlm_begin_recovery(dlm);
 
+	spin_unlock(&dlm->spinlock);
+
 	if (dlm->reco.new_master == dlm->node_num)
 		goto master_here;
 


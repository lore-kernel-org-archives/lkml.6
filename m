Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423457AbeE1LHg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423414AbeE1LHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:07:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Piao <piaojun@huawei.com>,
        Yiwen Jiang <jiangyiwen@huawei.com>, Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 075/272] ocfs2/dlm: dont handle migrate lockres if already in shutdown
Date: Mon, 28 May 2018 12:01:48 +0200
Message-Id: <20180528100247.277820281@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jun Piao <piaojun@huawei.com>

[ Upstream commit bb34f24c7d2c98d0c81838a7700e6068325b17a0 ]

We should not handle migrate lockres if we are already in
'DLM_CTXT_IN_SHUTDOWN', as that will cause lockres remains after leaving
dlm domain.  At last other nodes will get stuck into infinite loop when
requsting lock from us.

The problem is caused by concurrency umount between nodes.  Before
receiveing N1's DLM_BEGIN_EXIT_DOMAIN_MSG, N2 has picked up N1 as the
migrate target.  So N2 will continue sending lockres to N1 even though
N1 has left domain.

        N1                             N2 (owner)
                                       touch file

    access the file,
    and get pr lock

                                       begin leave domain and
                                       pick up N1 as new owner

    begin leave domain and
    migrate all lockres done

                                       begin migrate lockres to N1

    end leave domain, but
    the lockres left
    unexpectedly, because
    migrate task has passed

[piaojun@huawei.com: v3]
  Link: http://lkml.kernel.org/r/5A9CBD19.5020107@huawei.com
Link: http://lkml.kernel.org/r/5A99F028.2090902@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/dlm/dlmdomain.c   |   14 --------------
 fs/ocfs2/dlm/dlmdomain.h   |   25 ++++++++++++++++++++++++-
 fs/ocfs2/dlm/dlmrecovery.c |    9 +++++++++
 3 files changed, 33 insertions(+), 15 deletions(-)

--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -675,20 +675,6 @@ static void dlm_leave_domain(struct dlm_
 	spin_unlock(&dlm->spinlock);
 }
 
-int dlm_shutting_down(struct dlm_ctxt *dlm)
-{
-	int ret = 0;
-
-	spin_lock(&dlm_domain_lock);
-
-	if (dlm->dlm_state == DLM_CTXT_IN_SHUTDOWN)
-		ret = 1;
-
-	spin_unlock(&dlm_domain_lock);
-
-	return ret;
-}
-
 void dlm_unregister_domain(struct dlm_ctxt *dlm)
 {
 	int leave = 0;
--- a/fs/ocfs2/dlm/dlmdomain.h
+++ b/fs/ocfs2/dlm/dlmdomain.h
@@ -28,7 +28,30 @@
 extern spinlock_t dlm_domain_lock;
 extern struct list_head dlm_domains;
 
-int dlm_shutting_down(struct dlm_ctxt *dlm);
+static inline int dlm_joined(struct dlm_ctxt *dlm)
+{
+	int ret = 0;
+
+	spin_lock(&dlm_domain_lock);
+	if (dlm->dlm_state == DLM_CTXT_JOINED)
+		ret = 1;
+	spin_unlock(&dlm_domain_lock);
+
+	return ret;
+}
+
+static inline int dlm_shutting_down(struct dlm_ctxt *dlm)
+{
+	int ret = 0;
+
+	spin_lock(&dlm_domain_lock);
+	if (dlm->dlm_state == DLM_CTXT_IN_SHUTDOWN)
+		ret = 1;
+	spin_unlock(&dlm_domain_lock);
+
+	return ret;
+}
+
 void dlm_fire_domain_eviction_callbacks(struct dlm_ctxt *dlm,
 					int node_num);
 
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -1378,6 +1378,15 @@ int dlm_mig_lockres_handler(struct o2net
 	if (!dlm_grab(dlm))
 		return -EINVAL;
 
+	if (!dlm_joined(dlm)) {
+		mlog(ML_ERROR, "Domain %s not joined! "
+			  "lockres %.*s, master %u\n",
+			  dlm->name, mres->lockname_len,
+			  mres->lockname, mres->master);
+		dlm_put(dlm);
+		return -EINVAL;
+	}
+
 	BUG_ON(!(mres->flags & (DLM_MRES_RECOVERY|DLM_MRES_MIGRATION)));
 
 	real_master = mres->master;

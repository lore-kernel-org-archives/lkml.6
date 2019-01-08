Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381D2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DB2206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977179;
	bh=zBazkn5wMJ6pEBpDUDh3hWLXdSiIQcJNFjg3NPXl4k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lkY1qDYKHHd9vJcv3NtkDEWDVJEejzR9bhqudwd6wWvWKB4Fa9NU1ekcoleMg8OZm
	 6xZ5DCrnipA1QQEVFYwOdFPzPEymAbGCWLxwlPXwWEz9lHx94dSpSB06Zkew6s112l
	 AuNkw+J977gK6KBRDIiPO6Ju/EdH9AEsb8qyl2Ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfAHTw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbfAHTbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3008820665;
        Tue,  8 Jan 2019 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975867;
        bh=zBazkn5wMJ6pEBpDUDh3hWLXdSiIQcJNFjg3NPXl4k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAFPc4zWmcpUxtjGblyud8ZA9KAKSFF8i4mly2dyAoUAsZvDGIRbzrEtLgziT1Qvh
         n4tKIVPqOey7wN3dN0AqtkCeRatJhV2CvJmfevY3i6qRVNulALXa54+56WSZKcaSvM
         fsaY7zfqZxJPtm4uuZjAxpU9NzNGVwg5FWKrCgCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Disseldorp <ddiss@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/97] scsi: target/core: Make sure that target_wait_for_sess_cmds() waits long enough
Date:   Tue,  8 Jan 2019 14:28:56 -0500
Message-Id: <20190108192949.122407-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit ad669505c4e9db9af9faeb5c51aa399326a80d91 ]

A session must only be released after all code that accesses the session
structure has finished. Make sure that this is the case by introducing a
new command counter per session that is only decremented after the
.release_cmd() callback has finished. This patch fixes the following crash:

BUG: KASAN: use-after-free in do_raw_spin_lock+0x1c/0x130
Read of size 4 at addr ffff8801534b16e4 by task rmdir/14805
CPU: 16 PID: 14805 Comm: rmdir Not tainted 4.18.0-rc2-dbg+ #5
Call Trace:
dump_stack+0xa4/0xf5
print_address_description+0x6f/0x270
kasan_report+0x241/0x360
__asan_load4+0x78/0x80
do_raw_spin_lock+0x1c/0x130
_raw_spin_lock_irqsave+0x52/0x60
srpt_set_ch_state+0x27/0x70 [ib_srpt]
srpt_disconnect_ch+0x1b/0xc0 [ib_srpt]
srpt_close_session+0xa8/0x260 [ib_srpt]
target_shutdown_sessions+0x170/0x180 [target_core_mod]
core_tpg_del_initiator_node_acl+0xf3/0x200 [target_core_mod]
target_fabric_nacl_base_release+0x25/0x30 [target_core_mod]
config_item_release+0x9c/0x110 [configfs]
config_item_put+0x26/0x30 [configfs]
configfs_rmdir+0x3b8/0x510 [configfs]
vfs_rmdir+0xb3/0x1e0
do_rmdir+0x262/0x2c0
do_syscall_64+0x77/0x230
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Disseldorp <ddiss@suse.de>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_transport.c | 35 ++++++++++++++++++--------
 drivers/target/target_core_xcopy.c     |  6 ++++-
 include/target/target_core_base.h      |  1 +
 include/target/target_core_fabric.h    |  2 +-
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index fc3093d21b96..3f7aad45d215 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -224,19 +224,28 @@ void transport_subsystem_check_init(void)
 	sub_api_initialized = 1;
 }
 
+static void target_release_sess_cmd_refcnt(struct percpu_ref *ref)
+{
+	struct se_session *sess = container_of(ref, typeof(*sess), cmd_count);
+
+	wake_up(&sess->cmd_list_wq);
+}
+
 /**
  * transport_init_session - initialize a session object
  * @se_sess: Session object pointer.
  *
  * The caller must have zero-initialized @se_sess before calling this function.
  */
-void transport_init_session(struct se_session *se_sess)
+int transport_init_session(struct se_session *se_sess)
 {
 	INIT_LIST_HEAD(&se_sess->sess_list);
 	INIT_LIST_HEAD(&se_sess->sess_acl_list);
 	INIT_LIST_HEAD(&se_sess->sess_cmd_list);
 	spin_lock_init(&se_sess->sess_cmd_lock);
 	init_waitqueue_head(&se_sess->cmd_list_wq);
+	return percpu_ref_init(&se_sess->cmd_count,
+			       target_release_sess_cmd_refcnt, 0, GFP_KERNEL);
 }
 EXPORT_SYMBOL(transport_init_session);
 
@@ -247,6 +256,7 @@ EXPORT_SYMBOL(transport_init_session);
 struct se_session *transport_alloc_session(enum target_prot_op sup_prot_ops)
 {
 	struct se_session *se_sess;
+	int ret;
 
 	se_sess = kmem_cache_zalloc(se_sess_cache, GFP_KERNEL);
 	if (!se_sess) {
@@ -254,7 +264,11 @@ struct se_session *transport_alloc_session(enum target_prot_op sup_prot_ops)
 				" se_sess_cache\n");
 		return ERR_PTR(-ENOMEM);
 	}
-	transport_init_session(se_sess);
+	ret = transport_init_session(se_sess);
+	if (ret < 0) {
+		kfree(se_sess);
+		return ERR_PTR(ret);
+	}
 	se_sess->sup_prot_ops = sup_prot_ops;
 
 	return se_sess;
@@ -581,6 +595,7 @@ void transport_free_session(struct se_session *se_sess)
 		sbitmap_queue_free(&se_sess->sess_tag_pool);
 		kvfree(se_sess->sess_cmd_map);
 	}
+	percpu_ref_exit(&se_sess->cmd_count);
 	kmem_cache_free(se_sess_cache, se_sess);
 }
 EXPORT_SYMBOL(transport_free_session);
@@ -2724,6 +2739,7 @@ int target_get_sess_cmd(struct se_cmd *se_cmd, bool ack_kref)
 	}
 	se_cmd->transport_state |= CMD_T_PRE_EXECUTE;
 	list_add_tail(&se_cmd->se_cmd_list, &se_sess->sess_cmd_list);
+	percpu_ref_get(&se_sess->cmd_count);
 out:
 	spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
 
@@ -2754,8 +2770,6 @@ static void target_release_cmd_kref(struct kref *kref)
 	if (se_sess) {
 		spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
 		list_del_init(&se_cmd->se_cmd_list);
-		if (se_sess->sess_tearing_down && list_empty(&se_sess->sess_cmd_list))
-			wake_up(&se_sess->cmd_list_wq);
 		spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
 	}
 
@@ -2763,6 +2777,8 @@ static void target_release_cmd_kref(struct kref *kref)
 	se_cmd->se_tfo->release_cmd(se_cmd);
 	if (compl)
 		complete(compl);
+
+	percpu_ref_put(&se_sess->cmd_count);
 }
 
 /**
@@ -2891,6 +2907,8 @@ void target_sess_cmd_list_set_waiting(struct se_session *se_sess)
 	spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
 	se_sess->sess_tearing_down = 1;
 	spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
+
+	percpu_ref_kill(&se_sess->cmd_count);
 }
 EXPORT_SYMBOL(target_sess_cmd_list_set_waiting);
 
@@ -2905,17 +2923,14 @@ void target_wait_for_sess_cmds(struct se_session *se_sess)
 
 	WARN_ON_ONCE(!se_sess->sess_tearing_down);
 
-	spin_lock_irq(&se_sess->sess_cmd_lock);
 	do {
-		ret = wait_event_lock_irq_timeout(
-				se_sess->cmd_list_wq,
-				list_empty(&se_sess->sess_cmd_list),
-				se_sess->sess_cmd_lock, 180 * HZ);
+		ret = wait_event_timeout(se_sess->cmd_list_wq,
+				percpu_ref_is_zero(&se_sess->cmd_count),
+				180 * HZ);
 		list_for_each_entry(cmd, &se_sess->sess_cmd_list, se_cmd_list)
 			target_show_cmd("session shutdown: still waiting for ",
 					cmd);
 	} while (ret <= 0);
-	spin_unlock_irq(&se_sess->sess_cmd_lock);
 }
 EXPORT_SYMBOL(target_wait_for_sess_cmds);
 
diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 2718a933c0c6..7cdb5d7f6538 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -480,6 +480,8 @@ static const struct target_core_fabric_ops xcopy_pt_tfo = {
 
 int target_xcopy_setup_pt(void)
 {
+	int ret;
+
 	xcopy_wq = alloc_workqueue("xcopy_wq", WQ_MEM_RECLAIM, 0);
 	if (!xcopy_wq) {
 		pr_err("Unable to allocate xcopy_wq\n");
@@ -497,7 +499,9 @@ int target_xcopy_setup_pt(void)
 	INIT_LIST_HEAD(&xcopy_pt_nacl.acl_list);
 	INIT_LIST_HEAD(&xcopy_pt_nacl.acl_sess_list);
 	memset(&xcopy_pt_sess, 0, sizeof(struct se_session));
-	transport_init_session(&xcopy_pt_sess);
+	ret = transport_init_session(&xcopy_pt_sess);
+	if (ret < 0)
+		return ret;
 
 	xcopy_pt_nacl.se_tpg = &xcopy_pt_tpg;
 	xcopy_pt_nacl.nacl_sess = &xcopy_pt_sess;
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 7a4ee7852ca4..2cfd3b4573b0 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -602,6 +602,7 @@ struct se_session {
 	struct se_node_acl	*se_node_acl;
 	struct se_portal_group *se_tpg;
 	void			*fabric_sess_ptr;
+	struct percpu_ref	cmd_count;
 	struct list_head	sess_list;
 	struct list_head	sess_acl_list;
 	struct list_head	sess_cmd_list;
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index f4147b398431..eb9d0923c55c 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -116,7 +116,7 @@ struct se_session *target_setup_session(struct se_portal_group *,
 				struct se_session *, void *));
 void target_remove_session(struct se_session *);
 
-void transport_init_session(struct se_session *);
+int transport_init_session(struct se_session *se_sess);
 struct se_session *transport_alloc_session(enum target_prot_op);
 int transport_alloc_session_tags(struct se_session *, unsigned int,
 		unsigned int);
-- 
2.19.1


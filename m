Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C6C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498EA20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cYMBUaRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498EA20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeINMrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:47:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41058 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:47:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E7TNxl102249;
        Fri, 14 Sep 2018 07:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=1A4s/nLeeyzhFEWxXzqKNCTTzc7ZjPhZU+G2dnvbbcM=;
 b=cYMBUaRpOgG6LGo0qO7QFFgUF+2vQsYrXZa4kdLm5jhFGWliiRx7PuGuF/vSqmsAi8PF
 9w5TkMpnx0Zl4VjMZx6i6LV/cVtbunaZ2/C/0AdOqPXx6vQEbmGOBMAsvIC1aI+L05Rp
 TXFAM06McLtCbLrpadL6qbI2q9nj7LFd1ZSlDeWqzoEGD9NL3I0VBsOJachcLowna9Wu
 aJ6B4zILrlSLISrxvXVd5MRsHMUrFYHxL4sDke9uYf9VbtdIDRm+P4nsQYR1y5RUK/sN
 2yWL+PPQNdfS/OJL36Eg6grJs1/+QkVk35TClbetX1md0VcDqPXVCfEFcTK+PIA0TQvd SQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mc5utwdy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:33:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7XodZ004933
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:33:50 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7XoX4010161;
        Fri, 14 Sep 2018 07:33:50 GMT
Received: from linux.cn.oracle.com (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:33:49 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
Subject: [PATCH 1/6] xenbus: prepare data structures and parameter for xenwatch multithreading
Date:   Fri, 14 Sep 2018 15:34:11 +0800
Message-Id: <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 1st patch of a (6-patch) patch set.

This patch set of six patches introduces xenwatch multithreading (or
multithreaded xenwatch, abbreviated as 'mtwatch') to dom0 kernel. In
addition to the existing single xenwatch thread, each domU has its own
kernel thread ([xen-mtwatch-<domid>]) to process its xenwatch event.

A kernel parameter 'xen_mtwatch' is introduced to control whether the
feature is enabled or not during dom0 kernel boot. The feature is disabled
by default if 'xen_mtwatch' is not set in grub. In addition, this patch
also introduces the data structures to maintain the status of each per-domU
xenwatch thread. The status of each xenwatch thread (except the default
one) is maintained by a mtwatch domain.

The feature is available only on dom0.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 ++
 drivers/xen/xenbus/xenbus_xs.c                  | 31 ++++++++++++
 include/xen/xenbus.h                            | 65 +++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 64a3bf5..fc295ef 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4992,6 +4992,9 @@
 				the unplug protocol
 			never -- do not unplug even if version check succeeds
 
+	xen_mtwatch     [KNL,XEN]
+			Enables the multithreaded xenwatch (mtwatch).
+
 	xen_nopvspin	[X86,XEN]
 			Disables the ticketlock slowpath using Xen PV
 			optimizations.
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 49a3874..3f137d2 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -95,6 +95,19 @@ static pid_t xenwatch_pid;
 static DEFINE_MUTEX(xenwatch_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(watch_events_waitq);
 
+bool xen_mtwatch;
+EXPORT_SYMBOL_GPL(xen_mtwatch);
+
+struct mtwatch_info *mtwatch_info;
+
+static bool param_xen_mtwatch;
+static __init int xen_parse_mtwatch(char *arg)
+{
+	param_xen_mtwatch = true;
+	return 0;
+}
+early_param("xen_mtwatch", xen_parse_mtwatch);
+
 static void xs_suspend_enter(void)
 {
 	spin_lock(&xs_state_lock);
@@ -929,6 +942,24 @@ int xs_init(void)
 	if (err)
 		return err;
 
+	if (xen_initial_domain() && param_xen_mtwatch) {
+		int i;
+
+		mtwatch_info = kmalloc(sizeof(*mtwatch_info), GFP_KERNEL);
+
+		for (i = 0; i < MTWATCH_HASH_SIZE; i++)
+			INIT_HLIST_HEAD(&mtwatch_info->domain_hash[i]);
+		spin_lock_init(&mtwatch_info->domain_lock);
+		INIT_LIST_HEAD(&mtwatch_info->domain_list);
+
+		spin_lock_init(&mtwatch_info->purge_lock);
+		INIT_LIST_HEAD(&mtwatch_info->purge_list);
+
+		xen_mtwatch = true;
+
+		pr_info("xenwatch multithreading is enabled\n");
+	}
+
 	task = kthread_run(xenwatch_thread, NULL, "xenwatch");
 	if (IS_ERR(task))
 		return PTR_ERR(task);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816..e807114 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -62,6 +62,13 @@ struct xenbus_watch
 	/* Callback (executed in a process context with no locks held). */
 	void (*callback)(struct xenbus_watch *,
 			 const char *path, const char *token);
+
+	/* Callback to help calculate the domid the path belongs to */
+	domid_t (*get_domid)(struct xenbus_watch *watch,
+			     const char *path, const char *token);
+
+	/* The owner's domid if the watch is for a specific domain */
+	domid_t owner_id;
 };
 
 
@@ -93,6 +100,7 @@ struct xenbus_device_id
 struct xenbus_driver {
 	const char *name;       /* defaults to ids[0].devicetype */
 	const struct xenbus_device_id *ids;
+	bool use_mtwatch;
 	int (*probe)(struct xenbus_device *dev,
 		     const struct xenbus_device_id *id);
 	void (*otherend_changed)(struct xenbus_device *dev,
@@ -233,4 +241,61 @@ extern const struct file_operations xen_xenbus_fops;
 extern struct xenstore_domain_interface *xen_store_interface;
 extern int xen_store_evtchn;
 
+extern bool xen_mtwatch;
+
+#define MTWATCH_HASH_SIZE 256
+#define MTWATCH_HASH(_id) ((int)(_id)&(MTWATCH_HASH_SIZE-1))
+
+struct mtwatch_info {
+	/*
+	 * The mtwatch_domain is put on both a hash table and a list.
+	 * domain_list is used to optimize xenbus_watch un-registration.
+	 *
+	 * The mtwatch_domain is removed from domain_hash (with state set
+	 * to MTWATCH_DOMAIN_DOWN) when its refcnt is zero. However, it is
+	 * left on domain_list until all events belong to such
+	 * mtwatch_domain are processed in mtwatch_thread().
+	 *
+	 * While there may exist two mtwatch_domain with the same domid on
+	 * domain_list simultaneously, all mtwatch_domain on hash_hash
+	 * should have unique domid.
+	 */
+	spinlock_t domain_lock;
+	struct hlist_head domain_hash[MTWATCH_HASH_SIZE];
+	struct list_head domain_list;
+
+	/*
+	 * When a per-domU kthread is going to be destroyed, it is put
+	 * on the purge_list, and will be flushed by purge_work later.
+	 */
+	struct work_struct purge_work;
+	spinlock_t purge_lock;
+	struct list_head purge_list;
+};
+
+enum mtwatch_domain_state {
+	MTWATCH_DOMAIN_UP = 1,
+	MTWATCH_DOMAIN_DOWN = 2,
+};
+
+struct mtwatch_domain {
+	domid_t domid;
+	struct task_struct *task;
+	atomic_t refcnt;
+
+	pid_t pid;
+	struct mutex domain_mutex;
+	struct rcu_head rcu;
+
+	struct hlist_node hash_node;
+	struct list_head list_node;
+	struct list_head purge_node;
+
+	wait_queue_head_t events_wq;
+
+	spinlock_t events_lock;
+	struct list_head events;
+	enum mtwatch_domain_state state;
+};
+
 #endif /* _XEN_XENBUS_H */
-- 
2.7.4


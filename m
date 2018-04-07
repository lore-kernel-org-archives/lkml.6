Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDGLZY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 07:25:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33854 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeDGLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 07:25:21 -0400
From: Dongli Zhang <dongli.zhang@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com, ian.jackson@eu.citrix.com,
        wei.liu2@citrix.com, srinivas.eeda@oracle.com
Subject: [PATCH RFC linux 1/2] xenbus: introduce xenwatch multithreading to dom0 linux kernel
Date: Sat,  7 Apr 2018 19:25:54 +0800
Message-Id: <1523100355-27647-2-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804070121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on v4.16-rc7.

This patch introduces xenwatch multithreading (or multithreaded xenwatch,
abbreviated as 'mtwatch') to dom0 kernel. In addition to the existing
single xenwatch thread, each domU has its own kernel thread
([xen-mtwatch-<domid>]) to process its xenwatch event.

The create/destroy of each per-domU mtwatch thread is controlled by
xenstore. The dom0 kernel watches at node '/local/domain/0/mtwatch', under
which each domU has an entry. The node '/local/domain/0/mtwatch/<domid>' is
written to xenstore first during domU creation, while the same node is
removed from xenstore as the last xenstore operation during the domU
destroy. The corresponding watch callback would create or destroy the
per-domU mtwatch thread.

A kernel parameter 'xen_mtwatch' is introduced to control whether the
featue is enabled or not. The feature is disabled by default if
'xen_mtwatch' is not set in grub.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   3 +
 drivers/xen/xenbus/xenbus_probe.c               |  39 ++-
 drivers/xen/xenbus/xenbus_probe_backend.c       |  55 ++++
 drivers/xen/xenbus/xenbus_xs.c                  | 333 +++++++++++++++++++++++-
 include/xen/xenbus.h                            |  55 ++++
 5 files changed, 481 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f..46a484ba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4672,6 +4672,9 @@
 				the unplug protocol
 			never -- do not unplug even if version check succeeds
 
+	xen_mtwatch     [KNL,XEN]
+			Enables the multithreaded xenwatch (mtwatch).
+
 	xen_nopvspin	[X86,XEN]
 			Disables the ticketlock slowpath using Xen PV
 			optimizations.
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index ec9eb4f..5f88db1 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -129,12 +129,34 @@ static int talk_to_otherend(struct xenbus_device *dev)
 }
 
 
+static domid_t otherend_get_domid(struct xenbus_watch *watch,
+				  const char *path,
+				  const char *token)
+{
+	struct xenbus_device *xendev =
+		container_of(watch, struct xenbus_device, otherend_watch);
+
+	return xendev->otherend_id;
+}
+
+
+static domid_t otherend_get_owner(struct xenbus_watch *watch)
+{
+	struct xenbus_device *xendev =
+		container_of(watch, struct xenbus_device, otherend_watch);
+
+	return xendev->otherend_id;
+}
+
 
 static int watch_otherend(struct xenbus_device *dev)
 {
 	struct xen_bus_type *bus =
 		container_of(dev->dev.bus, struct xen_bus_type, bus);
 
+	dev->otherend_watch.get_domid = otherend_get_domid;
+	dev->otherend_watch.get_owner = otherend_get_owner;
+
 	return xenbus_watch_pathfmt(dev, &dev->otherend_watch,
 				    bus->otherend_changed,
 				    "%s/%s", dev->otherend, "state");
@@ -521,7 +543,22 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(xenbus_probe_devices);
 
-static unsigned int char_count(const char *str, char c)
+domid_t path_to_domid(const char *path)
+{
+	const char *p = path;
+	domid_t domid = 0;
+
+	while (*p) {
+		if (*p < '0' || *p > '9')
+			break;
+		domid = (domid << 3) + (domid << 1) + (*p - '0');
+		p++;
+	}
+
+	return domid;
+}
+
+unsigned int char_count(const char *str, char c)
 {
 	unsigned int i, ret = 0;
 
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4f..80be062 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -211,9 +211,61 @@ static void backend_changed(struct xenbus_watch *watch,
 	xenbus_dev_changed(path, &xenbus_backend);
 }
 
+/* path: backend/<pvdev>/<domid>/... */
+static domid_t be_get_domid(struct xenbus_watch *watch,
+			    const char *path,
+			    const char *token)
+{
+	const char *p = path;
+
+	if (char_count(path, '/') < 2)
+		return 0;
+
+	p = strchr(p, '/') + 1;
+	p = strchr(p, '/') + 1;
+
+	return path_to_domid(p);
+}
+
 static struct xenbus_watch be_watch = {
 	.node = "backend",
 	.callback = backend_changed,
+	.get_domid = be_get_domid,
+};
+
+static void mtwatch_changed(struct xenbus_watch *watch,
+			    const char *path, const char *token)
+{
+	domid_t domid;
+	const char *p = path;
+
+	if (char_count(path, '/') != 1)
+		return;
+
+	p = strchr(p, '/') + 1;
+	domid = path_to_domid(p);
+
+	xen_mtwatch_callback(domid, path);
+}
+
+/* path: mtwatch/<domid> */
+static domid_t mtwatch_get_domid(struct xenbus_watch *watch,
+				 const char *path, const char *token)
+{
+	const char *p = path;
+
+	if (char_count(path, '/') != 1)
+		return 0;
+
+	p = strchr(p, '/') + 1;
+
+	return path_to_domid(p);
+}
+
+static struct xenbus_watch mtwatch_watch = {
+	.node = "mtwatch",
+	.callback = mtwatch_changed,
+	.get_domid = mtwatch_get_domid,
 };
 
 static int read_frontend_details(struct xenbus_device *xendev)
@@ -245,6 +297,9 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 	xenbus_probe_devices(&xenbus_backend);
 	register_xenbus_watch(&be_watch);
 
+	if (xen_mtwatch)
+		register_xenbus_watch(&mtwatch_watch);
+
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3f3b293..7f30b7a 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -95,6 +95,242 @@ static pid_t xenwatch_pid;
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
+struct mtwatch_domain *mtwatch_find_domain(domid_t domid)
+{
+	struct mtwatch_domain *domain;
+	int hash = MTWATCH_HASH(domid);
+	struct hlist_head *hash_head = &mtwatch_info->domain_hash[hash];
+
+	hlist_for_each_entry_rcu(domain, hash_head, hash_node) {
+		if (domain->domid == domid)
+			return domain;
+	}
+
+	return NULL;
+}
+
+static int mtwatch_thread(void *arg)
+{
+	struct mtwatch_domain *domain = (struct mtwatch_domain *) arg;
+	struct list_head *ent;
+	struct xs_watch_event *event;
+
+	domain->pid = current->pid;
+
+	for (;;) {
+		wait_event_interruptible(domain->events_wq,
+					 !list_empty(&domain->events) ||
+					 kthread_should_stop());
+
+		/*
+		 * domain->state is already set to MTWATCH_DOMAIN_DOWN (to
+		 * avoid new event to domain->events) when
+		 * kthread_should_stop()==true, so that it is not required
+		 * to cleanup domain->events once the loop breaks.
+		 */
+		if (kthread_should_stop() && list_empty(&domain->events))
+			break;
+
+		mutex_lock(&domain->domain_mutex);
+
+		spin_lock(&domain->events_lock);
+		ent = domain->events.next;
+		if (ent != &domain->events)
+			list_del(ent);
+		spin_unlock(&domain->events_lock);
+
+		if (ent != &domain->events) {
+			event = list_entry(ent, struct xs_watch_event, list);
+			event->handle->callback(event->handle, event->path,
+						event->token);
+						kfree(event);
+		}
+
+		mutex_unlock(&domain->domain_mutex);
+	}
+
+	return 0;
+}
+
+/* protected by xenwatch_mutex so xenbus_watch is always valid */
+static int mtwatch_process(struct xs_watch_event *event)
+{
+	domid_t domid;
+	struct xenbus_watch *watch = event->handle;
+	struct mtwatch_domain *domain;
+	int rc = 1;
+
+	if (!watch->get_domid)
+		return rc;
+
+	domid = watch->get_domid(event->handle, event->path, event->token);
+	if (!domid)
+		return rc;
+
+	rcu_read_lock();
+
+	domain = mtwatch_find_domain(domid);
+	if (!domain) {
+		rcu_read_unlock();
+		return rc;
+	}
+
+	spin_lock(&domain->events_lock);
+	if (domain->state != MTWATCH_DOMAIN_DOWN) {
+		list_add(&event->list, &domain->events);
+		wake_up(&domain->events_wq);
+		rc = 0;
+	}
+	spin_unlock(&domain->events_lock);
+
+	rcu_read_unlock();
+
+	return rc;
+}
+
+
+static void delayed_destroy_domain(struct rcu_head *head)
+{
+	struct mtwatch_domain *domain;
+
+	domain = container_of(head, struct mtwatch_domain, rcu);
+	kfree(domain);
+}
+
+static void xen_mtwatch_purge_domain(struct work_struct *work)
+{
+	struct mtwatch_domain *domain;
+	struct list_head *node;
+
+	while (!list_empty(&mtwatch_info->purge_list)) {
+
+		spin_lock(&mtwatch_info->purge_lock);
+		node = mtwatch_info->purge_list.next;
+		if (node != &mtwatch_info->purge_list)
+			list_del(node);
+		spin_unlock(&mtwatch_info->purge_lock);
+
+		if (node != &mtwatch_info->purge_list) {
+			domain = list_entry(node, struct mtwatch_domain,
+					    purge_node);
+			kthread_stop(domain->task);
+
+			call_rcu(&domain->rcu, delayed_destroy_domain);
+		}
+	}
+}
+
+static void mtwatch_create_domain(domid_t domid)
+{
+	struct mtwatch_domain *domain;
+
+	if (!domid) {
+		pr_warn("default xenwatch thread is for dom0\n");
+		return;
+	}
+
+	spin_lock(&mtwatch_info->domain_lock);
+
+	if (mtwatch_find_domain(domid)) {
+		spin_unlock(&mtwatch_info->domain_lock);
+		return;
+	}
+
+	domain = kzalloc(sizeof(*domain), GFP_ATOMIC);
+	if (!domain) {
+		spin_unlock(&mtwatch_info->domain_lock);
+		return;
+	}
+
+	domain->domid = domid;
+	mutex_init(&domain->domain_mutex);
+	INIT_LIST_HEAD(&domain->purge_node);
+
+	init_waitqueue_head(&domain->events_wq);
+	spin_lock_init(&domain->events_lock);
+	INIT_LIST_HEAD(&domain->events);
+
+	hlist_add_head_rcu(&domain->hash_node,
+			   &mtwatch_info->domain_hash[MTWATCH_HASH(domid)]);
+
+	list_add_tail_rcu(&domain->list_node, &mtwatch_info->domain_list);
+
+	spin_unlock(&mtwatch_info->domain_lock);
+
+	domain->task = kthread_run(mtwatch_thread, domain,
+				   "xen-mtwatch-%d", domid);
+
+	if (!domain->task) {
+		pr_err("mtwatch kthread creation is failed\n");
+
+		spin_lock(&mtwatch_info->domain_lock);
+		hlist_del_rcu(&domain->hash_node);
+		list_del_rcu(&domain->list_node);
+		spin_unlock(&mtwatch_info->domain_lock);
+
+		call_rcu(&domain->rcu, delayed_destroy_domain);
+
+		return;
+	}
+
+	domain->state = MTWATCH_DOMAIN_UP;
+}
+
+static void mtwatch_destroy_domain(domid_t domid)
+{
+	struct mtwatch_domain *domain;
+
+	spin_lock(&mtwatch_info->domain_lock);
+
+	domain = mtwatch_find_domain(domid);
+	if (!domain) {
+		spin_unlock(&mtwatch_info->domain_lock);
+		return;
+	}
+
+	spin_lock(&domain->events_lock);
+	domain->state = MTWATCH_DOMAIN_DOWN;
+	spin_unlock(&domain->events_lock);
+
+	hlist_del_rcu(&domain->hash_node);
+	list_del_rcu(&domain->list_node);
+
+	spin_unlock(&mtwatch_info->domain_lock);
+
+	spin_lock(&mtwatch_info->purge_lock);
+	list_add(&domain->purge_node, &mtwatch_info->purge_list);
+	spin_unlock(&mtwatch_info->purge_lock);
+
+	schedule_work(&mtwatch_info->purge_work);
+}
+
+void xen_mtwatch_callback(domid_t domid, const char *path)
+{
+	int exists;
+
+	exists = xenbus_exists(XBT_NIL, path, "");
+
+	if (!exists) {
+		mtwatch_destroy_domain(domid);
+		return;
+	}
+
+	mtwatch_create_domain(domid);
+}
+
 static void xs_suspend_enter(void)
 {
 	spin_lock(&xs_state_lock);
@@ -778,6 +1014,71 @@ int register_xenbus_watch(struct xenbus_watch *watch)
 }
 EXPORT_SYMBOL_GPL(register_xenbus_watch);
 
+static void __unregister_single_mtwatch(struct xenbus_watch *watch,
+					struct mtwatch_domain *domain)
+{
+	struct xs_watch_event *event, *tmp;
+
+	if (current->pid != domain->pid)
+		mutex_lock(&domain->domain_mutex);
+
+	spin_lock(&domain->events_lock);
+	list_for_each_entry_safe(event, tmp,
+				 &domain->events, list) {
+		if (event->handle != watch)
+			continue;
+		list_del(&event->list);
+		kfree(event);
+	}
+	spin_unlock(&domain->events_lock);
+
+	if (current->pid != domain->pid)
+		mutex_unlock(&domain->domain_mutex);
+}
+
+static void unregister_single_mtwatch(struct xenbus_watch *watch,
+				      domid_t domid)
+{
+	struct mtwatch_domain *domain;
+
+	rcu_read_lock();
+
+	domain = mtwatch_find_domain(domid);
+
+	if (WARN_ON_ONCE(unlikely(!domain))) {
+		rcu_read_unlock();
+		return;
+	}
+
+	__unregister_single_mtwatch(watch, domain);
+
+	rcu_read_unlock();
+}
+
+static void unregister_all_mtwatch(struct xenbus_watch *watch)
+{
+	struct mtwatch_domain *domain;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(domain, &mtwatch_info->domain_list,
+				list_node) {
+		__unregister_single_mtwatch(watch, domain);
+	}
+
+	rcu_read_unlock();
+}
+
+static void unregister_mtwatch(struct xenbus_watch *watch)
+{
+	domid_t domid = watch->get_owner ? watch->get_owner(watch) : 0;
+
+	if (domid)
+		unregister_single_mtwatch(watch, domid);
+	else
+		unregister_all_mtwatch(watch);
+}
+
 void unregister_xenbus_watch(struct xenbus_watch *watch)
 {
 	struct xs_watch_event *event, *tmp;
@@ -816,6 +1117,9 @@ void unregister_xenbus_watch(struct xenbus_watch *watch)
 
 	if (current->pid != xenwatch_pid)
 		mutex_unlock(&xenwatch_mutex);
+
+	if (xen_mtwatch && watch->get_domid)
+		unregister_mtwatch(watch);
 }
 EXPORT_SYMBOL_GPL(unregister_xenbus_watch);
 
@@ -879,9 +1183,13 @@ static int xenwatch_thread(void *unused)
 
 		if (ent != &watch_events) {
 			event = list_entry(ent, struct xs_watch_event, list);
-			event->handle->callback(event->handle, event->path,
-						event->token);
-			kfree(event);
+
+			if (!xen_mtwatch || mtwatch_process(event)) {
+				event->handle->callback(event->handle,
+							event->path,
+							event->token);
+				kfree(event);
+			}
 		}
 
 		mutex_unlock(&xenwatch_mutex);
@@ -927,6 +1235,25 @@ int xs_init(void)
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
+		INIT_WORK(&mtwatch_info->purge_work, xen_mtwatch_purge_domain);
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
index 869c816..917d3ca 100644
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
+	/* Get the owner's domid if the watch is for a specific domain */
+	domid_t (*get_owner)(struct xenbus_watch *watch);
 };
 
 
@@ -229,8 +236,56 @@ const char *xenbus_strstate(enum xenbus_state state);
 int xenbus_dev_is_online(struct xenbus_device *dev);
 int xenbus_frontend_closed(struct xenbus_device *dev);
 
+domid_t path_to_domid(const char *path);
+unsigned int char_count(const char *str, char c);
+void xen_mtwatch_callback(domid_t domid, const char *path);
+
 extern const struct file_operations xen_xenbus_fops;
 extern struct xenstore_domain_interface *xen_store_interface;
 extern int xen_store_evtchn;
 
+extern bool xen_mtwatch;
+
+#define MTWATCH_HASH_SIZE 256
+#define MTWATCH_HASH(_id) ((int)(_id)&(MTWATCH_HASH_SIZE-1))
+
+struct mtwatch_info {
+	/* the mtwatch_domain is put on both a hash table and a list */
+	spinlock_t domain_lock;
+	struct hlist_head domain_hash[MTWATCH_HASH_SIZE];
+	struct list_head domain_list;
+
+	/*
+	 * when a per-domU kthread is going to be destroyed, it would put
+	 * a request on list purge_list, which will be flushed by
+	 * purge_work later.
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
+	spinlock_t events_lock;
+	struct list_head events;
+	enum mtwatch_domain_state state;
+};
+
 #endif /* _XEN_XENBUS_H */
-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeE3Lly (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:41:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60737 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752108AbeE3LHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:00 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Junxiao Bi" <junxiao.bi@oracle.com>,
        "Joseph Qi" <jiangqi903@gmail.com>, "Joel Becker" <jlbec@evilplan.org>,
        "Mark Fasheh" <mfasheh@versity.com>, "Jun Piao" <piaojun@huawei.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "alex chen" <alex.chen@huawei.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.270521014@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 003/153] ocfs2: subsystem.su_mutex is required while
 accessing the  item->ci_parent
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: alex chen <alex.chen@huawei.com>

commit 853bc26a7ea39e354b9f8889ae7ad1492ffa28d2 upstream.

The subsystem.su_mutex is required while accessing the item->ci_parent,
otherwise, NULL pointer dereference to the item->ci_parent will be
triggered in the following situation:

add node                     delete node
sys_write
 vfs_write
  configfs_write_file
   o2nm_node_store
    o2nm_node_local_write
                             do_rmdir
                              vfs_rmdir
                               configfs_rmdir
                                mutex_lock(&subsys->su_mutex);
                                unlink_obj
                                 item->ci_group = NULL;
                                 item->ci_parent = NULL;
	 to_o2nm_cluster_from_node
	  node->nd_item.ci_parent->ci_parent
	  BUG since of NULL pointer dereference to nd_item.ci_parent

Moreover, the o2nm_cluster also should be protected by the
subsystem.su_mutex.

[alex.chen@huawei.com: v2]
  Link: http://lkml.kernel.org/r/59EEAA69.9080703@huawei.com
Link: http://lkml.kernel.org/r/59E9B36A.10700@huawei.com
Signed-off-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ocfs2/cluster/nodemanager.c | 63 +++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 8 deletions(-)

--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -41,6 +41,9 @@ char *o2nm_fence_method_desc[O2NM_FENCE_
 		"panic",	/* O2NM_FENCE_PANIC */
 };
 
+static inline void o2nm_lock_subsystem(void);
+static inline void o2nm_unlock_subsystem(void);
+
 struct o2nm_node *o2nm_get_node_by_num(u8 node_num)
 {
 	struct o2nm_node *node = NULL;
@@ -182,7 +185,10 @@ static struct o2nm_cluster *to_o2nm_clus
 {
 	/* through the first node_set .parent
 	 * mycluster/nodes/mynode == o2nm_cluster->o2nm_node_group->o2nm_node */
-	return to_o2nm_cluster(node->nd_item.ci_parent->ci_parent);
+	if (node->nd_item.ci_parent)
+		return to_o2nm_cluster(node->nd_item.ci_parent->ci_parent);
+	else
+		return NULL;
 }
 
 enum {
@@ -195,7 +201,7 @@ enum {
 static ssize_t o2nm_node_num_write(struct o2nm_node *node, const char *page,
 				   size_t count)
 {
-	struct o2nm_cluster *cluster = to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	unsigned long tmp;
 	char *p = (char *)page;
 
@@ -214,6 +220,13 @@ static ssize_t o2nm_node_num_write(struc
 	    !test_bit(O2NM_NODE_ATTR_PORT, &node->nd_set_attributes))
 		return -EINVAL; /* XXX */
 
+	o2nm_lock_subsystem();
+	cluster = to_o2nm_cluster_from_node(node);
+	if (!cluster) {
+		o2nm_unlock_subsystem();
+		return -EINVAL;
+	}
+
 	write_lock(&cluster->cl_nodes_lock);
 	if (cluster->cl_nodes[tmp])
 		p = NULL;
@@ -223,6 +236,8 @@ static ssize_t o2nm_node_num_write(struc
 		set_bit(tmp, cluster->cl_nodes_bitmap);
 	}
 	write_unlock(&cluster->cl_nodes_lock);
+	o2nm_unlock_subsystem();
+
 	if (p == NULL)
 		return -EEXIST;
 
@@ -262,7 +277,7 @@ static ssize_t o2nm_node_ipv4_address_wr
 					    const char *page,
 					    size_t count)
 {
-	struct o2nm_cluster *cluster = to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	int ret, i;
 	struct rb_node **p, *parent;
 	unsigned int octets[4];
@@ -279,6 +294,13 @@ static ssize_t o2nm_node_ipv4_address_wr
 		be32_add_cpu(&ipv4_addr, octets[i] << (i * 8));
 	}
 
+	o2nm_lock_subsystem();
+	cluster = to_o2nm_cluster_from_node(node);
+	if (!cluster) {
+		o2nm_unlock_subsystem();
+		return -EINVAL;
+	}
+
 	ret = 0;
 	write_lock(&cluster->cl_nodes_lock);
 	if (o2nm_node_ip_tree_lookup(cluster, ipv4_addr, &p, &parent))
@@ -288,6 +310,8 @@ static ssize_t o2nm_node_ipv4_address_wr
 		rb_insert_color(&node->nd_ip_node, &cluster->cl_node_ip_tree);
 	}
 	write_unlock(&cluster->cl_nodes_lock);
+	o2nm_unlock_subsystem();
+
 	if (ret)
 		return ret;
 
@@ -304,7 +328,7 @@ static ssize_t o2nm_node_local_read(stru
 static ssize_t o2nm_node_local_write(struct o2nm_node *node, const char *page,
 				     size_t count)
 {
-	struct o2nm_cluster *cluster = to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	unsigned long tmp;
 	char *p = (char *)page;
 	ssize_t ret;
@@ -322,17 +346,26 @@ static ssize_t o2nm_node_local_write(str
 	    !test_bit(O2NM_NODE_ATTR_PORT, &node->nd_set_attributes))
 		return -EINVAL; /* XXX */
 
+	o2nm_lock_subsystem();
+	cluster = to_o2nm_cluster_from_node(node);
+	if (!cluster) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* the only failure case is trying to set a new local node
 	 * when a different one is already set */
 	if (tmp && tmp == cluster->cl_has_local &&
-	    cluster->cl_local_node != node->nd_num)
-		return -EBUSY;
+	    cluster->cl_local_node != node->nd_num) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* bring up the rx thread if we're setting the new local node. */
 	if (tmp && !cluster->cl_has_local) {
 		ret = o2net_start_listening(node);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (!tmp && cluster->cl_has_local &&
@@ -347,7 +380,11 @@ static ssize_t o2nm_node_local_write(str
 		cluster->cl_local_node = node->nd_num;
 	}
 
-	return count;
+	ret = count;
+
+out:
+	o2nm_unlock_subsystem();
+	return ret;
 }
 
 struct o2nm_node_attribute {
@@ -890,6 +927,16 @@ static struct o2nm_cluster_group o2nm_cl
 	},
 };
 
+static inline void o2nm_lock_subsystem(void)
+{
+	mutex_lock(&o2nm_cluster_group.cs_subsys.su_mutex);
+}
+
+static inline void o2nm_unlock_subsystem(void)
+{
+	mutex_unlock(&o2nm_cluster_group.cs_subsys.su_mutex);
+}
+
 int o2nm_depend_item(struct config_item *item)
 {
 	return configfs_depend_item(&o2nm_cluster_group.cs_subsys, item);

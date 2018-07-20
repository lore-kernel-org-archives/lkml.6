Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1025ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ECB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ECB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389683AbeGTN2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388907AbeGTN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F21E4C7D;
        Fri, 20 Jul 2018 12:32:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Chen <alex.chen@huawei.com>,
        Jun Piao <piaojun@huawei.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 4.14 07/92] ocfs2: subsystem.su_mutex is required while accessing the item->ci_parent
Date:   Fri, 20 Jul 2018 14:13:11 +0200
Message-Id: <20180720121417.610512880@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/cluster/nodemanager.c |   63 +++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 8 deletions(-)

--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -40,6 +40,9 @@ char *o2nm_fence_method_desc[O2NM_FENCE_
 		"panic",	/* O2NM_FENCE_PANIC */
 };
 
+static inline void o2nm_lock_subsystem(void);
+static inline void o2nm_unlock_subsystem(void);
+
 struct o2nm_node *o2nm_get_node_by_num(u8 node_num)
 {
 	struct o2nm_node *node = NULL;
@@ -181,7 +184,10 @@ static struct o2nm_cluster *to_o2nm_clus
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
@@ -194,7 +200,7 @@ static ssize_t o2nm_node_num_store(struc
 				   size_t count)
 {
 	struct o2nm_node *node = to_o2nm_node(item);
-	struct o2nm_cluster *cluster = to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	unsigned long tmp;
 	char *p = (char *)page;
 	int ret = 0;
@@ -214,6 +220,13 @@ static ssize_t o2nm_node_num_store(struc
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
 		ret = -EEXIST;
@@ -226,6 +239,8 @@ static ssize_t o2nm_node_num_store(struc
 		set_bit(tmp, cluster->cl_nodes_bitmap);
 	}
 	write_unlock(&cluster->cl_nodes_lock);
+	o2nm_unlock_subsystem();
+
 	if (ret)
 		return ret;
 
@@ -269,7 +284,7 @@ static ssize_t o2nm_node_ipv4_address_st
 					    size_t count)
 {
 	struct o2nm_node *node = to_o2nm_node(item);
-	struct o2nm_cluster *cluster = to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	int ret, i;
 	struct rb_node **p, *parent;
 	unsigned int octets[4];
@@ -286,6 +301,13 @@ static ssize_t o2nm_node_ipv4_address_st
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
@@ -298,6 +320,8 @@ static ssize_t o2nm_node_ipv4_address_st
 		rb_insert_color(&node->nd_ip_node, &cluster->cl_node_ip_tree);
 	}
 	write_unlock(&cluster->cl_nodes_lock);
+	o2nm_unlock_subsystem();
+
 	if (ret)
 		return ret;
 
@@ -315,7 +339,7 @@ static ssize_t o2nm_node_local_store(str
 				     size_t count)
 {
 	struct o2nm_node *node = to_o2nm_node(item);
-	struct o2nm_cluster *cluster = to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	unsigned long tmp;
 	char *p = (char *)page;
 	ssize_t ret;
@@ -333,17 +357,26 @@ static ssize_t o2nm_node_local_store(str
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
@@ -358,7 +391,11 @@ static ssize_t o2nm_node_local_store(str
 		cluster->cl_local_node = node->nd_num;
 	}
 
-	return count;
+	ret = count;
+
+out:
+	o2nm_unlock_subsystem();
+	return ret;
 }
 
 CONFIGFS_ATTR(o2nm_node_, num);
@@ -738,6 +775,16 @@ static struct o2nm_cluster_group o2nm_cl
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



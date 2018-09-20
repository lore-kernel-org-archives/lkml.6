Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC021529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC021529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbeITS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:24357 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387764AbeITS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820844"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:11 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 01/16] stm class: Rework policy node fallback
Date:   Thu, 20 Sep 2018 15:45:38 +0300
Message-Id: <20180920124553.56978-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if no matching policy node can be found for a trace source,
we'll try to use "default" policy node, then, if that doesn't exist,
we'll pick the first node, in order of creation. If that also fails,
we'll allocate M/C range from the beginning of the device's M/C range.

This makes it difficult to know which node (if any) was used in any
particular case.

In order to make things more deterministic, the new order is as follows:
  * if they supply ID string, use that and nothing else,
  * if they are a task, use their task name (comm),
  * use "default", if it exists,
  * return failure, to let them know there is no suitable rule.

This should provide enough convenience with the "default" catch-all node,
while not leaving *everything* to chance. As a side effect, this relaxes
the requirement of using ioctl() for identification with the possibility of
using task names as policy nodes.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/core.c   | 89 ++++++++++++++++++++--------------
 drivers/hwtracing/stm/policy.c | 12 ++---
 drivers/hwtracing/stm/stm.h    |  2 -
 3 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 10bcb5d73f90..7b1c549d6320 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -293,15 +293,15 @@ static int stm_output_assign(struct stm_device *stm, unsigned int width,
 	if (width > stm->data->sw_nchannels)
 		return -EINVAL;
 
-	if (policy_node) {
-		stp_policy_node_get_ranges(policy_node,
-					   &midx, &mend, &cidx, &cend);
-	} else {
-		midx = stm->data->sw_start;
-		cidx = 0;
-		mend = stm->data->sw_end;
-		cend = stm->data->sw_nchannels - 1;
-	}
+	/* We no longer accept policy_node==NULL here */
+	if (WARN_ON_ONCE(!policy_node))
+		return -EINVAL;
+
+	/*
+	 * Also, the caller holds reference to policy_node, so it won't
+	 * disappear on us.
+	 */
+	stp_policy_node_get_ranges(policy_node, &midx, &mend, &cidx, &cend);
 
 	spin_lock(&stm->mc_lock);
 	spin_lock(&output->lock);
@@ -405,19 +405,30 @@ static int stm_char_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int stm_file_assign(struct stm_file *stmf, char *id, unsigned int width)
+static int
+stm_assign_first_policy(struct stm_device *stm, struct stm_output *output,
+			char **ids, unsigned int width)
 {
-	struct stm_device *stm = stmf->stm;
-	int ret;
+	struct stp_policy_node *pn;
+	int err, n;
 
-	stmf->policy_node = stp_policy_node_lookup(stm, id);
+	/*
+	 * On success, stp_policy_node_lookup() will return holding the
+	 * configfs subsystem mutex, which is then released in
+	 * stp_policy_node_put(). This allows the pdrv->output_open() in
+	 * stm_output_assign() to serialize against the attribute accessors.
+	 */
+	for (n = 0, pn = NULL; ids[n] && !pn; n++)
+		pn = stp_policy_node_lookup(stm, ids[n]);
 
-	ret = stm_output_assign(stm, width, stmf->policy_node, &stmf->output);
+	if (!pn)
+		return -EINVAL;
 
-	if (stmf->policy_node)
-		stp_policy_node_put(stmf->policy_node);
+	err = stm_output_assign(stm, width, pn, output);
 
-	return ret;
+	stp_policy_node_put(pn);
+
+	return err;
 }
 
 static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
@@ -455,16 +466,23 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 		count = PAGE_SIZE - 1;
 
 	/*
-	 * if no m/c have been assigned to this writer up to this
-	 * point, use "default" policy entry
+	 * If no m/c have been assigned to this writer up to this
+	 * point, try to use the task name and "default" policy entries.
 	 */
 	if (!stmf->output.nr_chans) {
-		err = stm_file_assign(stmf, "default", 1);
+		char comm[sizeof(current->comm)];
+		char *ids[] = { comm, "default", NULL };
+
+		get_task_comm(comm, current);
+
+		err = stm_assign_first_policy(stmf->stm, &stmf->output, ids, 1);
 		/*
 		 * EBUSY means that somebody else just assigned this
-		 * output, which is just fine for write()
+		 * output, which is just fine for write(), except for (XXX)
+		 * it doesn't actually return -EBUSY, but -EINVAL and WARNs
+		 * in this case. Hrrr.
 		 */
-		if (err && err != -EBUSY)
+		if (err)
 			return err;
 	}
 
@@ -550,6 +568,7 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 {
 	struct stm_device *stm = stmf->stm;
 	struct stp_policy_id *id;
+	char *ids[] = { NULL, NULL };
 	int ret = -EINVAL;
 	u32 size;
 
@@ -582,7 +601,9 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	    id->width > PAGE_SIZE / stm->data->sw_mmiosz)
 		goto err_free;
 
-	ret = stm_file_assign(stmf, id->id, id->width);
+	ids[0] = id->id;
+	ret = stm_assign_first_policy(stmf->stm, &stmf->output, ids,
+				      id->width);
 	if (ret)
 		goto err_free;
 
@@ -818,8 +839,8 @@ EXPORT_SYMBOL_GPL(stm_unregister_device);
 static int stm_source_link_add(struct stm_source_device *src,
 			       struct stm_device *stm)
 {
-	char *id;
-	int err;
+	char *ids[] = { NULL, "default", NULL };
+	int err = -ENOMEM;
 
 	mutex_lock(&stm->link_mutex);
 	spin_lock(&stm->link_lock);
@@ -833,19 +854,13 @@ static int stm_source_link_add(struct stm_source_device *src,
 	spin_unlock(&stm->link_lock);
 	mutex_unlock(&stm->link_mutex);
 
-	id = kstrdup(src->data->name, GFP_KERNEL);
-	if (id) {
-		src->policy_node =
-			stp_policy_node_lookup(stm, id);
-
-		kfree(id);
-	}
-
-	err = stm_output_assign(stm, src->data->nr_chans,
-				src->policy_node, &src->output);
+	ids[0] = kstrdup(src->data->name, GFP_KERNEL);
+	if (!ids[0])
+		goto fail_detach;
 
-	if (src->policy_node)
-		stp_policy_node_put(src->policy_node);
+	err = stm_assign_first_policy(stm, &src->output, ids,
+				      src->data->nr_chans);
+	kfree(ids[0]);
 
 	if (err)
 		goto fail_detach;
diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 3fd07e275b34..15d35d891643 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -392,7 +392,7 @@ static struct configfs_subsystem stp_policy_subsys = {
 static struct stp_policy_node *
 __stp_policy_node_lookup(struct stp_policy *policy, char *s)
 {
-	struct stp_policy_node *policy_node, *ret;
+	struct stp_policy_node *policy_node, *ret = NULL;
 	struct list_head *head = &policy->group.cg_children;
 	struct config_item *item;
 	char *start, *end = s;
@@ -400,10 +400,6 @@ __stp_policy_node_lookup(struct stp_policy *policy, char *s)
 	if (list_empty(head))
 		return NULL;
 
-	/* return the first entry if everything else fails */
-	item = list_entry(head->next, struct config_item, ci_entry);
-	ret = to_stp_policy_node(item);
-
 next:
 	for (;;) {
 		start = strsep(&end, "/");
@@ -449,13 +445,17 @@ stp_policy_node_lookup(struct stm_device *stm, char *s)
 
 	if (policy_node)
 		config_item_get(&policy_node->group.cg_item);
-	mutex_unlock(&stp_policy_subsys.su_mutex);
+	else
+		mutex_unlock(&stp_policy_subsys.su_mutex);
 
 	return policy_node;
 }
 
 void stp_policy_node_put(struct stp_policy_node *policy_node)
 {
+	lockdep_assert_held(&stp_policy_subsys.su_mutex);
+
+	mutex_unlock(&stp_policy_subsys.su_mutex);
 	config_item_put(&policy_node->group.cg_item);
 }
 
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index 923571adc6f4..e5df08ae59cf 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -57,7 +57,6 @@ struct stm_output {
 
 struct stm_file {
 	struct stm_device	*stm;
-	struct stp_policy_node	*policy_node;
 	struct stm_output	output;
 };
 
@@ -71,7 +70,6 @@ struct stm_source_device {
 	struct stm_device __rcu	*link;
 	struct list_head	link_entry;
 	/* one output per stm_source device */
-	struct stp_policy_node	*policy_node;
 	struct stm_output	output;
 };
 
-- 
2.18.0


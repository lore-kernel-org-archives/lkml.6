Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD76C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020AF2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020AF2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbeITSaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:30:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:24358 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387785AbeITS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820865"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:15 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 04/16] stm class: Introduce framing protocol drivers
Date:   Thu, 20 Sep 2018 15:45:41 +0300
Message-Id: <20180920124553.56978-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, the stm class applies a certain STP framing pattern to
the data as it is written to the underlying STM device. In order to
allow different framing patterns (aka protocols), this patch introduces
the concept of STP protocol drivers, defines data structures and APIs
for the protocol drivers to use.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/core.c   | 142 ++++++++++++++++++++++++++++++++
 drivers/hwtracing/stm/policy.c | 145 ++++++++++++++++++++++++++++++---
 drivers/hwtracing/stm/stm.h    |  52 ++++++++++--
 3 files changed, 321 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 7b1c549d6320..c869a30661ac 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -316,11 +316,26 @@ static int stm_output_assign(struct stm_device *stm, unsigned int width,
 	output->master = midx;
 	output->channel = cidx;
 	output->nr_chans = width;
+	if (stm->pdrv->output_open) {
+		void *priv = stp_policy_node_priv(policy_node);
+
+		if (WARN_ON_ONCE(!priv))
+			goto unlock;
+
+		/* configfs subsys mutex is held by the caller */
+		ret = stm->pdrv->output_open(priv, output);
+		if (ret)
+			goto unlock;
+	}
+
 	stm_output_claim(stm, output);
 	dev_dbg(&stm->dev, "assigned %u:%u (+%u)\n", midx, cidx, width);
 
 	ret = 0;
 unlock:
+	if (ret)
+		output->nr_chans = 0;
+
 	spin_unlock(&output->lock);
 	spin_unlock(&stm->mc_lock);
 
@@ -333,6 +348,8 @@ static void stm_output_free(struct stm_device *stm, struct stm_output *output)
 	spin_lock(&output->lock);
 	if (output->nr_chans)
 		stm_output_disclaim(stm, output);
+	if (stm->pdrv->output_close)
+		stm->pdrv->output_close(output);
 	spin_unlock(&output->lock);
 	spin_unlock(&stm->mc_lock);
 }
@@ -349,6 +366,122 @@ static int major_match(struct device *dev, const void *data)
 	return MAJOR(dev->devt) == major;
 }
 
+/*
+ * Framing protocol management
+ * Modules can implement STM protocol drivers and (un-)register them
+ * with the STM class framework.
+ */
+static struct list_head stm_pdrv_head;
+static struct mutex stm_pdrv_mutex;
+
+struct stm_pdrv_entry {
+	struct list_head			entry;
+	const struct stm_protocol_driver	*pdrv;
+	const struct config_item_type		*node_type;
+};
+
+static const struct stm_pdrv_entry *
+__stm_lookup_protocol(const char *name)
+{
+	struct stm_pdrv_entry *pe;
+
+	list_for_each_entry(pe, &stm_pdrv_head, entry) {
+		if (!name || !*name || !strcmp(name, pe->pdrv->name))
+			return pe;
+	}
+
+	return NULL;
+}
+
+int stm_register_protocol(const struct stm_protocol_driver *pdrv)
+{
+	struct stm_pdrv_entry *pe = NULL;
+	int ret = -ENOMEM;
+
+	mutex_lock(&stm_pdrv_mutex);
+
+	if (__stm_lookup_protocol(pdrv->name)) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
+	if (!pe)
+		goto unlock;
+
+	if (pdrv->policy_attr) {
+		pe->node_type = get_policy_node_type(pdrv->policy_attr);
+		if (!pe->node_type)
+			goto unlock;
+	}
+
+	list_add_tail(&pe->entry, &stm_pdrv_head);
+	pe->pdrv = pdrv;
+
+	ret = 0;
+unlock:
+	mutex_unlock(&stm_pdrv_mutex);
+
+	if (ret)
+		kfree(pe);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm_register_protocol);
+
+void stm_unregister_protocol(const struct stm_protocol_driver *pdrv)
+{
+	struct stm_pdrv_entry *pe, *iter;
+
+	mutex_lock(&stm_pdrv_mutex);
+
+	list_for_each_entry_safe(pe, iter, &stm_pdrv_head, entry) {
+		if (pe->pdrv == pdrv) {
+			list_del(&pe->entry);
+
+			/* XXX: factor out */
+			if (pe->node_type) {
+				kfree(pe->node_type->ct_attrs);
+				kfree(pe->node_type);
+			}
+			kfree(pe);
+			break;
+		}
+	}
+
+	mutex_unlock(&stm_pdrv_mutex);
+}
+EXPORT_SYMBOL_GPL(stm_unregister_protocol);
+
+static bool stm_get_protocol(const struct stm_protocol_driver *pdrv)
+{
+	return try_module_get(pdrv->owner);
+}
+
+void stm_put_protocol(const struct stm_protocol_driver *pdrv)
+{
+	module_put(pdrv->owner);
+}
+
+int stm_lookup_protocol(const char *name,
+			const struct stm_protocol_driver **pdrv,
+			const struct config_item_type **node_type)
+{
+	const struct stm_pdrv_entry *pe;
+
+	mutex_lock(&stm_pdrv_mutex);
+
+	pe = __stm_lookup_protocol(name);
+	if (pe && pe->pdrv && stm_get_protocol(pe->pdrv)) {
+		*pdrv = pe->pdrv;
+		*node_type = pe->node_type;
+	}
+
+	mutex_unlock(&stm_pdrv_mutex);
+
+	return pe ? 0 : -ENOENT;
+}
+
 static int stm_char_open(struct inode *inode, struct file *file)
 {
 	struct stm_file *stmf;
@@ -1178,6 +1311,15 @@ static int __init stm_core_init(void)
 		goto err_src;
 
 	init_srcu_struct(&stm_source_srcu);
+	INIT_LIST_HEAD(&stm_pdrv_head);
+	mutex_init(&stm_pdrv_mutex);
+
+	/*
+	 * So as to not confuse existing users with a requirement
+	 * to load yet another module, do it here.
+	 */
+	if (IS_ENABLED(CONFIG_STM_PROTO_BASIC))
+		(void)request_module_nowait("stm_p_basic");
 
 	stm_core_up++;
 
diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index a505f055f464..894598cfe2b7 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -33,8 +33,18 @@ struct stp_policy_node {
 	unsigned int		last_master;
 	unsigned int		first_channel;
 	unsigned int		last_channel;
+	/* this is the one that's exposed to the attributes */
+	unsigned char		priv[0];
 };
 
+void *stp_policy_node_priv(struct stp_policy_node *pn)
+{
+	if (!pn)
+		return NULL;
+
+	return pn->priv;
+}
+
 static struct configfs_subsystem stp_policy_subsys;
 
 void stp_policy_node_get_ranges(struct stp_policy_node *policy_node,
@@ -68,6 +78,14 @@ to_stp_policy_node(struct config_item *item)
 		NULL;
 }
 
+void *to_pdrv_policy_node(struct config_item *item)
+{
+	struct stp_policy_node *node = to_stp_policy_node(item);
+
+	return stp_policy_node_priv(node);
+}
+EXPORT_SYMBOL_GPL(to_pdrv_policy_node);
+
 static ssize_t
 stp_policy_node_masters_show(struct config_item *item, char *page)
 {
@@ -163,7 +181,9 @@ stp_policy_node_channels_store(struct config_item *item, const char *page,
 
 static void stp_policy_node_release(struct config_item *item)
 {
-	kfree(to_stp_policy_node(item));
+	struct stp_policy_node *node = to_stp_policy_node(item);
+
+	kfree(node);
 }
 
 static struct configfs_item_operations stp_policy_node_item_ops = {
@@ -182,10 +202,61 @@ static struct configfs_attribute *stp_policy_node_attrs[] = {
 static const struct config_item_type stp_policy_type;
 static const struct config_item_type stp_policy_node_type;
 
+/* lifted from arch/x86/events/core.c */
+static struct configfs_attribute **merge_attr(struct configfs_attribute **a, struct configfs_attribute **b)
+{
+	struct configfs_attribute **new;
+	int j, i;
+
+	for (j = 0; a[j]; j++)
+		;
+	for (i = 0; b[i]; i++)
+		j++;
+	j++;
+
+	new = kmalloc_array(j, sizeof(struct configfs_attribute *),
+			    GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	j = 0;
+	for (i = 0; a[i]; i++)
+		new[j++] = a[i];
+	for (i = 0; b[i]; i++)
+		new[j++] = b[i];
+	new[j] = NULL;
+
+	return new;
+}
+
+const struct config_item_type *
+get_policy_node_type(struct configfs_attribute **attrs)
+{
+	struct config_item_type *type;
+	struct configfs_attribute **merged;
+
+	type = kmemdup(&stp_policy_node_type, sizeof(stp_policy_node_type),
+		       GFP_KERNEL);
+	if (!type)
+		return NULL;
+
+	merged = merge_attr(stp_policy_node_attrs, attrs);
+	if (!merged) {
+		kfree(type);
+		return NULL;
+	}
+
+	type->ct_attrs = merged;
+
+	return type;
+}
+
 static struct config_group *
 stp_policy_node_make(struct config_group *group, const char *name)
 {
+	const struct config_item_type *type = &stp_policy_node_type;
 	struct stp_policy_node *policy_node, *parent_node;
+	const struct stm_protocol_driver *pdrv;
 	struct stp_policy *policy;
 
 	if (group->cg_item.ci_type == &stp_policy_type) {
@@ -199,12 +270,20 @@ stp_policy_node_make(struct config_group *group, const char *name)
 	if (!policy->stm)
 		return ERR_PTR(-ENODEV);
 
-	policy_node = kzalloc(sizeof(struct stp_policy_node), GFP_KERNEL);
+	pdrv = policy->stm->pdrv;
+	policy_node =
+		kzalloc(offsetof(struct stp_policy_node, priv[pdrv->priv_sz]),
+			GFP_KERNEL);
 	if (!policy_node)
 		return ERR_PTR(-ENOMEM);
 
-	config_group_init_type_name(&policy_node->group, name,
-				    &stp_policy_node_type);
+	if (pdrv->policy_node_init)
+		pdrv->policy_node_init((void *)policy_node->priv);
+
+	if (policy->stm->pdrv_node_type)
+		type = policy->stm->pdrv_node_type;
+
+	config_group_init_type_name(&policy_node->group, name, type);
 
 	policy_node->policy = policy;
 
@@ -254,8 +333,26 @@ static ssize_t stp_policy_device_show(struct config_item *item,
 
 CONFIGFS_ATTR_RO(stp_policy_, device);
 
+static ssize_t stp_policy_protocol_show(struct config_item *item,
+					char *page)
+{
+	struct stp_policy *policy = to_stp_policy(item);
+	ssize_t count;
+
+	/* XXX: there shouldn't be 'none', ever */
+	count = sprintf(page, "%s\n",
+			(policy && policy->stm) ?
+			policy->stm->pdrv->name :
+			"<none>");
+
+	return count;
+}
+
+CONFIGFS_ATTR_RO(stp_policy_, protocol);
+
 static struct configfs_attribute *stp_policy_attrs[] = {
 	&stp_policy_attr_device,
+	&stp_policy_attr_protocol,
 	NULL,
 };
 
@@ -276,6 +373,7 @@ void stp_policy_unbind(struct stp_policy *policy)
 	stm->policy = NULL;
 	policy->stm = NULL;
 
+	stm_put_protocol(stm->pdrv);
 	stm_put_device(stm);
 }
 
@@ -313,9 +411,12 @@ static const struct config_item_type stp_policy_type = {
 static struct config_group *
 stp_policy_make(struct config_group *group, const char *name)
 {
+	const struct config_item_type *pdrv_node_type;
+	const struct stm_protocol_driver *pdrv;
+	char *devname, *proto, *p;
 	struct config_group *ret;
 	struct stm_device *stm;
-	char *devname, *p;
+	int err;
 
 	devname = kasprintf(GFP_KERNEL, "%s", name);
 	if (!devname)
@@ -326,6 +427,7 @@ stp_policy_make(struct config_group *group, const char *name)
 	 * <device_name> is the name of an existing stm device; may
 	 *               contain dots;
 	 * <policy_name> is an arbitrary string; may not contain dots
+	 * <device_name>:<protocol_name>.<policy_name>
 	 */
 	p = strrchr(devname, '.');
 	if (!p) {
@@ -335,11 +437,28 @@ stp_policy_make(struct config_group *group, const char *name)
 
 	*p = '\0';
 
+	/*
+	 * look for ":<protocol_name>":
+	 *  + no protocol suffix: fall back to whatever is available;
+	 *  + unknown protocol: fail the whole thing
+	 */
+	proto = strrchr(devname, ':');
+	if (proto)
+		*proto++ = '\0';
+
 	stm = stm_find_device(devname);
+	if (!stm) {
+		kfree(devname);
+		return ERR_PTR(-ENODEV);
+	}
+
+	err = stm_lookup_protocol(proto, &pdrv, &pdrv_node_type);
 	kfree(devname);
 
-	if (!stm)
+	if (err) {
+		stm_put_device(stm);
 		return ERR_PTR(-ENODEV);
+	}
 
 	mutex_lock(&stm->policy_mutex);
 	if (stm->policy) {
@@ -349,21 +468,27 @@ stp_policy_make(struct config_group *group, const char *name)
 
 	stm->policy = kzalloc(sizeof(*stm->policy), GFP_KERNEL);
 	if (!stm->policy) {
-		ret = ERR_PTR(-ENOMEM);
-		goto unlock_policy;
+		mutex_unlock(&stm->policy_mutex);
+		stm_put_protocol(pdrv);
+		stm_put_device(stm);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	config_group_init_type_name(&stm->policy->group, name,
 				    &stp_policy_type);
-	stm->policy->stm = stm;
 
+	stm->pdrv = pdrv;
+	stm->pdrv_node_type = pdrv_node_type;
+	stm->policy->stm = stm;
 	ret = &stm->policy->group;
 
 unlock_policy:
 	mutex_unlock(&stm->policy_mutex);
 
-	if (IS_ERR(ret))
+	if (IS_ERR(ret)) {
+		stm_put_protocol(stm->pdrv);
 		stm_put_device(stm);
+	}
 
 	return ret;
 }
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index e5df08ae59cf..921ebd9fd3bd 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -10,20 +10,17 @@
 #ifndef _STM_STM_H_
 #define _STM_STM_H_
 
+#include <linux/configfs.h>
+
 struct stp_policy;
 struct stp_policy_node;
+struct stm_protocol_driver;
 
-struct stp_policy_node *
-stp_policy_node_lookup(struct stm_device *stm, char *s);
-void stp_policy_node_put(struct stp_policy_node *policy_node);
-void stp_policy_unbind(struct stp_policy *policy);
-
-void stp_policy_node_get_ranges(struct stp_policy_node *policy_node,
-				unsigned int *mstart, unsigned int *mend,
-				unsigned int *cstart, unsigned int *cend);
 int stp_configfs_init(void);
 void stp_configfs_exit(void);
 
+void *stp_policy_node_priv(struct stp_policy_node *pn);
+
 struct stp_master {
 	unsigned int	nr_free;
 	unsigned long	chan_map[0];
@@ -40,6 +37,9 @@ struct stm_device {
 	struct mutex		link_mutex;
 	spinlock_t		link_lock;
 	struct list_head	link_list;
+	/* framing protocol in use */
+	const struct stm_protocol_driver	*pdrv;
+	const struct config_item_type		*pdrv_node_type;
 	/* master allocation */
 	spinlock_t		mc_lock;
 	struct stp_master	*masters[0];
@@ -48,11 +48,25 @@ struct stm_device {
 #define to_stm_device(_d)				\
 	container_of((_d), struct stm_device, dev)
 
+struct stp_policy_node *
+stp_policy_node_lookup(struct stm_device *stm, char *s);
+void stp_policy_node_put(struct stp_policy_node *policy_node);
+void stp_policy_unbind(struct stp_policy *policy);
+
+void stp_policy_node_get_ranges(struct stp_policy_node *policy_node,
+				unsigned int *mstart, unsigned int *mend,
+				unsigned int *cstart, unsigned int *cend);
+
+/* XXX: unXXX this! */
+const struct config_item_type *
+get_policy_node_type(struct configfs_attribute **attrs);
+
 struct stm_output {
 	spinlock_t		lock;
 	unsigned int		master;
 	unsigned int		channel;
 	unsigned int		nr_chans;
+	void			*pdrv_private;
 };
 
 struct stm_file {
@@ -76,4 +90,26 @@ struct stm_source_device {
 #define to_stm_source_device(_d)				\
 	container_of((_d), struct stm_source_device, dev)
 
+void *to_pdrv_policy_node(struct config_item *item);
+
+struct stm_protocol_driver {
+	struct module	*owner;
+	const char	*name;
+	ssize_t		(*write)(struct stm_data *data,
+				 struct stm_output *output, unsigned int chan,
+				 const char *buf, size_t count);
+	void		(*policy_node_init)(void *arg);
+	int		(*output_open)(void *priv, struct stm_output *output);
+	void		(*output_close)(struct stm_output *output);
+	ssize_t		priv_sz;
+	struct configfs_attribute	**policy_attr;
+};
+
+int stm_register_protocol(const struct stm_protocol_driver *pdrv);
+void stm_unregister_protocol(const struct stm_protocol_driver *pdrv);
+int stm_lookup_protocol(const char *name,
+			const struct stm_protocol_driver **pdrv,
+			const struct config_item_type **type);
+void stm_put_protocol(const struct stm_protocol_driver *pdrv);
+
 #endif /* _STM_STM_H_ */
-- 
2.18.0


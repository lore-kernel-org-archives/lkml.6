Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629803; cv=none;
        d=google.com; s=arc-20160816;
        b=rVoNspNRUZWzj+HnbVtpizL48FiS8vy4R/OFBRUrPql0cUXgHfLmXLP0XMaysN0NRe
         ozhDOuw/ncc3Mh8l20no7O5SQqVI9taNbUXdBMzQHXrfnaJDA6hQD4RFqPOUOJaf7e4Y
         tpEHJueluXVkQn7hDp8im9npI9QByHEPZlV+vewVEXooJX+0AQDojxwC4s8hiD9vzT26
         xPtxSXnD5peaKt/KZI4C4pTHMbiYsrNEHlfck/pKfcs3+Xz+rNgv5aHkFMIg9bpsv734
         pqj83RMvzJEDQyybuVB6IS2QmCuztiRiX7TwmglQVlbGbYnHSP1wWtg2687PEhg5BezT
         VALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TTad7PNbEU6EV4AG45iZWF9/3D498T8HIfHQi/E9OaQ=;
        b=jT3NHQFDLK/+BI1ctKRDeGDyXUw5qr4JGVnfaFw/uCWcJLILUiiwRTPDvpW90xDT7a
         icRBwQPahd+GwEUzyOM5k/xOs3gsDxaGM+TvTdO70CH0VQny5vRNaFCJplIsvFRw57au
         JjNoET99Oa8XF98HFtzJiGtqnzefigMijmX/ZwjJ9kILdBwrZjfqYWXGy5sJkDRmy0jl
         GHwNC8QZt2ZlxkMKWQVX49/TiRuLSrXDbsNTxtRKZgLHpYpLfC6D7t/lDmjn/kYxMEgN
         a8bPb+8/18+zI5ae/lCZezUpTKzElOcxplStGM1l9ZCI8U5l1iYZEEScUdNYdLnAXz0w
         FdUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HKze1+IQ;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HKze1+IQ;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvuvvyFEWkkHiM0033kofBRgQFs6EqjwRn8fmDALRZUKDNV6mlkZXdIygcFNA6Wjo5AAVUbWA==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net,
	robh+dt@kernel.org,
	mturquette@baylibre.com,
	khilman@baylibre.com,
	vincent.guittot@linaro.org,
	skannan@codeaurora.org,
	bjorn.andersson@linaro.org,
	amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com,
	davidai@quicinc.com,
	mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	georgi.djakov@linaro.org
Subject: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
Date: Fri,  9 Mar 2018 23:09:52 +0200
Message-Id: <20180309210958.16672-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495917367006479?=
X-GMAIL-MSGID: =?utf-8?q?1594495917367006479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduce a new API to get requirements and configure the
interconnect buses across the entire chipset to fit with the current
demand.

The API is using a consumer/provider-based model, where the providers are
the interconnect buses and the consumers could be various drivers.
The consumers request interconnect resources (path) between endpoints and
set the desired constraints on this data flow path. The providers receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/interconnect/interconnect.rst |  96 ++++++
 drivers/Kconfig                             |   2 +
 drivers/Makefile                            |   1 +
 drivers/interconnect/Kconfig                |  10 +
 drivers/interconnect/Makefile               |   1 +
 drivers/interconnect/core.c                 | 489 ++++++++++++++++++++++++++++
 include/linux/interconnect-provider.h       | 109 +++++++
 include/linux/interconnect.h                |  40 +++
 8 files changed, 748 insertions(+)
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/core.c
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h

diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
new file mode 100644
index 000000000000..23eba68e8424
--- /dev/null
+++ b/Documentation/interconnect/interconnect.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+GENERIC SYSTEM INTERCONNECT SUBSYSTEM
+=====================================
+
+Introduction
+------------
+
+This framework is designed to provide a standard kernel interface to control
+the settings of the interconnects on a SoC. These settings can be throughput,
+latency and priority between multiple interconnected devices or functional
+blocks. This can be controlled dynamically in order to save power or provide
+maximum performance.
+
+The interconnect bus is a hardware with configurable parameters, which can be
+set on a data path according to the requests received from various drivers.
+An example of interconnect buses are the interconnects between various
+components or functional blocks in chipsets. There can be multiple interconnects
+on a SoC that can be multi-tiered.
+
+Below is a simplified diagram of a real-world SoC interconnect bus topology.
+
+::
+
+ +----------------+    +----------------+
+ | HW Accelerator |--->|      M NoC     |<---------------+
+ +----------------+    +----------------+                |
+                         |      |                    +------------+
+  +-----+  +-------------+      V       +------+     |            |
+  | DDR |  |                +--------+  | PCIe |     |            |
+  +-----+  |                | Slaves |  +------+     |            |
+    ^ ^    |                +--------+     |         |   C NoC    |
+    | |    V                               V         |            |
+ +------------------+   +------------------------+   |            |   +-----+
+ |                  |-->|                        |-->|            |-->| CPU |
+ |                  |-->|                        |<--|            |   +-----+
+ |     Mem NoC      |   |         S NoC          |   +------------+
+ |                  |<--|                        |---------+    |
+ |                  |<--|                        |<------+ |    |   +--------+
+ +------------------+   +------------------------+       | |    +-->| Slaves |
+   ^  ^    ^    ^          ^                             | |        +--------+
+   |  |    |    |          |                             | V
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+ | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+           |
+       +-------+
+       | Modem |
+       +-------+
+
+Terminology
+-----------
+
+Interconnect provider is the software definition of the interconnect hardware.
+The interconnect providers on the above diagram are M NoC, S NoC, C NoC and Mem
+NoC.
+
+Interconnect node is the software definition of the interconnect hardware
+port. Each interconnect provider consists of multiple interconnect nodes,
+which are connected to other SoC components including other interconnect
+providers. The point on the diagram where the CPUs connects to the memory is
+called an interconnect node, which belongs to the Mem NoC interconnect provider.
+
+Interconnect endpoints are the first or the last element of the path. Every
+endpoint is a node, but not every node is an endpoint.
+
+Interconnect path is everything between two endpoints including all the nodes
+that have to be traversed to reach from a source to destination node. It may
+include multiple master-slave pairs across several interconnect providers.
+
+Interconnect consumers are the entities which make use of the data paths exposed
+by the providers. The consumers send requests to providers requesting various
+throughput, latency and priority. Usually the consumers are device drivers, that
+send request based on their needs. An example for a consumer is a video decoder
+that supports various formats and image sizes.
+
+Interconnect providers
+----------------------
+
+Interconnect provider is an entity that implements methods to initialize and
+configure a interconnect bus hardware. The interconnect provider drivers should
+be registered with the interconnect provider core.
+
+The interconnect framework provider API functions are documented in
+.. kernel-doc:: include/linux/interconnect-provider.h
+
+Interconnect consumers
+----------------------
+
+Interconnect consumers are the clients which use the interconnect APIs to
+get paths between endpoints and set their bandwidth/latency/QoS requirements
+for these interconnect paths.
+
+The interconnect framework consumer API functions are documented in
+.. kernel-doc:: include/linux/interconnect.h
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 879dc0604cba..96a1db022cee 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -219,4 +219,6 @@ source "drivers/siox/Kconfig"
 
 source "drivers/slimbus/Kconfig"
 
+source "drivers/interconnect/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..0cca95740d9b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -185,3 +185,4 @@ obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
+obj-$(CONFIG_INTERCONNECT)	+= interconnect/
diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
new file mode 100644
index 000000000000..a261c7d41deb
--- /dev/null
+++ b/drivers/interconnect/Kconfig
@@ -0,0 +1,10 @@
+menuconfig INTERCONNECT
+	tristate "On-Chip Interconnect management support"
+	help
+	  Support for management of the on-chip interconnects.
+
+	  This framework is designed to provide a generic interface for
+	  managing the interconnects in a SoC.
+
+	  If unsure, say no.
+
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
new file mode 100644
index 000000000000..5edf0ae80818
--- /dev/null
+++ b/drivers/interconnect/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_INTERCONNECT)		+= core.o
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
new file mode 100644
index 000000000000..6306e258b9b9
--- /dev/null
+++ b/drivers/interconnect/core.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework core driver
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+static DEFINE_IDR(icc_idr);
+static LIST_HEAD(icc_provider_list);
+static DEFINE_MUTEX(icc_provider_list_mutex);
+static DEFINE_MUTEX(icc_path_mutex);
+
+/**
+ * struct icc_req - constraints that are attached to each node
+ *
+ * @req_node: entry in list of requests for the particular @node
+ * @node: the interconnect node to which this constraint applies
+ * @avg_bw: an integer describing the average bandwidth in kbps
+ * @peak_bw: an integer describing the peak bandwidth in kbps
+ */
+struct icc_req {
+	struct hlist_node req_node;
+	struct icc_node *node;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+/**
+ * struct icc_path - interconnect path structure
+ * @num_nodes: number of hops (nodes)
+ * @reqs: array of the requests applicable to this path of nodes
+ */
+struct icc_path {
+	size_t num_nodes;
+	struct icc_req reqs[0];
+};
+
+static struct icc_node *node_find(const int id)
+{
+	struct icc_node *node;
+
+	node = idr_find(&icc_idr, id);
+
+	return node;
+}
+
+static struct icc_path *path_allocate(struct icc_node *node, ssize_t num_nodes)
+{
+	struct icc_path *path;
+	size_t i;
+
+	path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
+		       GFP_KERNEL);
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	path->num_nodes = num_nodes;
+
+	for (i = 0; i < num_nodes; i++) {
+		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
+
+		path->reqs[i].node = node;
+		/* reference to previous node was saved during path traversal */
+		node = node->reverse;
+	}
+
+	return path;
+}
+
+static struct icc_path *path_find(struct icc_node *src, struct icc_node *dst)
+{
+	struct icc_node *node = NULL;
+	struct list_head traverse_list;
+	struct list_head edge_list;
+	struct list_head tmp_list;
+	size_t i, number = 0;
+	bool found = false;
+
+	INIT_LIST_HEAD(&traverse_list);
+	INIT_LIST_HEAD(&edge_list);
+	INIT_LIST_HEAD(&tmp_list);
+
+	list_add_tail(&src->search_list, &traverse_list);
+
+	do {
+		list_for_each_entry(node, &traverse_list, search_list) {
+			if (node == dst) {
+				found = true;
+				list_add(&node->search_list, &tmp_list);
+				break;
+			}
+			for (i = 0; i < node->num_links; i++) {
+				struct icc_node *tmp = node->links[i];
+
+				if (!tmp)
+					return ERR_PTR(-ENOENT);
+
+				if (tmp->is_traversed)
+					continue;
+
+				tmp->is_traversed = true;
+				tmp->reverse = node;
+				list_add_tail(&tmp->search_list, &edge_list);
+			}
+		}
+		if (found)
+			break;
+
+		list_splice_init(&traverse_list, &tmp_list);
+		list_splice_init(&edge_list, &traverse_list);
+
+		/* count the number of nodes */
+		number++;
+
+	} while (!list_empty(&traverse_list));
+
+	/* reset the traversed state */
+	list_for_each_entry(node, &tmp_list, search_list)
+		node->is_traversed = false;
+
+	if (found)
+		return path_allocate(dst, number);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int path_init(struct icc_path *path)
+{
+	struct icc_node *node;
+	size_t i;
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+
+		mutex_lock(&node->provider->lock);
+		node->provider->users++;
+		mutex_unlock(&node->provider->lock);
+	}
+
+	return 0;
+}
+
+static void node_aggregate(struct icc_node *node)
+{
+	struct icc_req *r;
+	u32 agg_avg = 0;
+	u32 agg_peak = 0;
+
+	hlist_for_each_entry(r, &node->req_list, req_node) {
+		/* sum(averages) and max(peaks) */
+		agg_avg += r->avg_bw;
+		agg_peak = max(agg_peak, r->peak_bw);
+	}
+
+	node->avg_bw = agg_avg;
+	node->peak_bw = agg_peak;
+}
+
+static void provider_aggregate(struct icc_provider *provider, u32 *avg_bw,
+			       u32 *peak_bw)
+{
+	struct icc_node *n;
+	u32 agg_avg = 0;
+	u32 agg_peak = 0;
+
+	/* aggregate for the interconnect provider */
+	list_for_each_entry(n, &provider->nodes, node_list) {
+		/* sum the average and max the peak */
+		agg_avg += n->avg_bw;
+		agg_peak = max(agg_peak, n->peak_bw);
+	}
+
+	*avg_bw = agg_avg;
+	*peak_bw = agg_peak;
+}
+
+static int constraints_apply(struct icc_path *path)
+{
+	struct icc_node *next, *prev = NULL;
+	int i;
+
+	for (i = 0; i < path->num_nodes; i++, prev = next) {
+		struct icc_provider *provider;
+		u32 avg_bw = 0;
+		u32 peak_bw = 0;
+		int ret;
+
+		next = path->reqs[i].node;
+		/*
+		 * Both endpoints should be valid master-slave pairs of the
+		 * same interconnect provider that will be configured.
+		 */
+		if (!next || !prev)
+			continue;
+
+		if (next->provider != prev->provider)
+			continue;
+
+		provider = next->provider;
+		mutex_lock(&provider->lock);
+
+		/* aggregate requests for the provider */
+		provider_aggregate(provider, &avg_bw, &peak_bw);
+
+		if (provider->set) {
+			/* set the constraints */
+			ret = provider->set(prev, next, avg_bw, peak_bw);
+		}
+
+		mutex_unlock(&provider->lock);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * icc_set() - set constraints on an interconnect path between two endpoints
+ * @path: reference to the path returned by icc_get()
+ * @avg_bw: average bandwidth in kbps
+ * @peak_bw: peak bandwidth in kbps
+ *
+ * This function is used by an interconnect consumer to express its own needs
+ * in term of bandwidth and QoS for a previously requested path between two
+ * endpoints. The requests are aggregated and each node is updated accordingly.
+ *
+ * Returns 0 on success, or an approproate error code otherwise.
+ */
+int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
+{
+	struct icc_node *node;
+	size_t i;
+	int ret;
+
+	if (!path)
+		return 0;
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+
+		mutex_lock(&icc_path_mutex);
+
+		/* update the consumer request for this path */
+		path->reqs[i].avg_bw = avg_bw;
+		path->reqs[i].peak_bw = peak_bw;
+
+		/* aggregate requests for this node */
+		node_aggregate(node);
+
+		mutex_unlock(&icc_path_mutex);
+	}
+
+	ret = constraints_apply(path);
+	if (ret)
+		pr_err("interconnect: error applying constraints (%d)", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_set);
+
+/**
+ * icc_get() - return a handle for path between two endpoints
+ * @src_id: source device port id
+ * @dst_id: destination device port id
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release
+ * constraints when the they are not needed anymore.
+ *
+ * Return: icc_path pointer on success, or ERR_PTR() on error
+ */
+struct icc_path *icc_get(const int src_id, const int dst_id)
+{
+	struct icc_node *src, *dst;
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+
+	src = node_find(src_id);
+	if (!src)
+		goto out;
+
+	dst = node_find(dst_id);
+	if (!dst)
+		goto out;
+
+	mutex_lock(&icc_path_mutex);
+	path = path_find(src, dst);
+	mutex_unlock(&icc_path_mutex);
+	if (IS_ERR(path))
+		goto out;
+
+	path_init(path);
+
+out:
+	return path;
+}
+EXPORT_SYMBOL_GPL(icc_get);
+
+/**
+ * icc_put() - release the reference to the icc_path
+ * @path: interconnect path
+ *
+ * Use this function to release the constraints on a path when the path is
+ * no longer needed. The constraints will be re-aggregated.
+ */
+void icc_put(struct icc_path *path)
+{
+	struct icc_node *node;
+	size_t i;
+	int ret;
+
+	if (!path || WARN_ON_ONCE(IS_ERR(path)))
+		return;
+
+	ret = icc_set(path, 0, 0);
+	if (ret)
+		pr_err("%s: error (%d)\n", __func__, ret);
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+		hlist_del(&path->reqs[i].req_node);
+
+		mutex_lock(&node->provider->lock);
+		node->provider->users--;
+		mutex_unlock(&node->provider->lock);
+	}
+
+	kfree(path);
+}
+EXPORT_SYMBOL_GPL(icc_put);
+
+/**
+ * icc_node_create() - create a node
+ * @id: node id
+ *
+ * Return: icc_node pointer on success, or ERR_PTR() on error
+ */
+struct icc_node *icc_node_create(int id)
+{
+	struct icc_node *node;
+
+	/* check if node already exists */
+	node = node_find(id);
+	if (node)
+		return node;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
+	if (WARN(id < 0, "couldn't get idr"))
+		return ERR_PTR(id);
+
+	node->id = id;
+
+	return node;
+}
+EXPORT_SYMBOL_GPL(icc_node_create);
+
+/**
+ * icc_link_create() - create a link between two nodes
+ * @src_id: source node id
+ * @dst_id: destination node id
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_link_create(struct icc_node *node, const int dst_id)
+{
+	struct icc_node *dst;
+	struct icc_node **new;
+	int ret = 0;
+
+	if (IS_ERR_OR_NULL(node))
+		return PTR_ERR(node);
+
+	mutex_lock(&node->provider->lock);
+
+	dst = node_find(dst_id);
+	if (!dst)
+		dst = icc_node_create(dst_id);
+
+	new = krealloc(node->links,
+		       (node->num_links + 1) * sizeof(*node->links),
+		       GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	node->links = new;
+	node->links[node->num_links++] = dst;
+
+out:
+	mutex_unlock(&node->provider->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_link_create);
+
+/**
+ * icc_add_node() - add an interconnect node to interconnect provider
+ * @node: pointer to the interconnect node
+ * @provider: pointer to the interconnect provider
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_node_add(struct icc_node *node, struct icc_provider *provider)
+{
+	if (WARN_ON(!node))
+		return -EINVAL;
+
+	if (WARN_ON(!provider))
+		return -EINVAL;
+
+	node->provider = provider;
+
+	mutex_lock(&provider->lock);
+	list_add_tail(&node->node_list, &provider->nodes);
+	mutex_unlock(&provider->lock);
+
+	return 0;
+}
+
+/**
+ * icc_add_provider() - add a new interconnect provider
+ * @icc_provider: the interconnect provider that will be added into topology
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_add_provider(struct icc_provider *provider)
+{
+	if (WARN_ON(!provider))
+		return -EINVAL;
+
+	if (WARN_ON(!provider->set))
+		return -EINVAL;
+
+	mutex_init(&provider->lock);
+	INIT_LIST_HEAD(&provider->nodes);
+
+	mutex_lock(&icc_provider_list_mutex);
+	list_add(&provider->provider_list, &icc_provider_list);
+	mutex_unlock(&icc_provider_list_mutex);
+
+	dev_dbg(provider->dev, "interconnect provider added to topology\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_add_provider);
+
+/**
+ * icc_del_provider() - delete previously added interconnect provider
+ * @icc_provider: the interconnect provider that will be removed from topology
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_del_provider(struct icc_provider *provider)
+{
+	mutex_lock(&provider->lock);
+	if (provider->users) {
+		pr_warn("interconnect provider still has %d users\n",
+			provider->users);
+	}
+	mutex_unlock(&provider->lock);
+
+	mutex_lock(&icc_provider_list_mutex);
+	list_del(&provider->provider_list);
+	mutex_unlock(&icc_provider_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_del_provider);
+
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
+MODULE_DESCRIPTION("Interconnect Driver Core");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
new file mode 100644
index 000000000000..779b5b5b1306
--- /dev/null
+++ b/include/linux/interconnect-provider.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef _LINUX_INTERCONNECT_PROVIDER_H
+#define _LINUX_INTERCONNECT_PROVIDER_H
+
+#include <linux/interconnect.h>
+
+struct icc_node;
+
+/**
+ * struct icc_provider - interconnect provider (controller) entity that might
+ * provide multiple interconnect controls
+ *
+ * @provider_list: list of the registered interconnect providers
+ * @nodes: internal list of the interconnect provider nodes
+ * @set: pointer to device specific set operation function
+ * @dev: the device this interconnect provider belongs to
+ * @lock: lock to provide consistency during aggregation/update of constraints
+ * @users: count of active users
+ * @data: pointer to private data
+ */
+struct icc_provider {
+	struct list_head	provider_list;
+	struct list_head	nodes;
+	int (*set)(struct icc_node *src, struct icc_node *dst,
+		   u32 avg_bw, u32 peak_bw);
+	struct device		*dev;
+	struct mutex		lock;
+	int			users;
+	void			*data;
+};
+
+/**
+ * struct icc_node - entity that is part of the interconnect topology
+ *
+ * @id: platform specific node id
+ * @name: node name used in debugfs
+ * @links: a list of targets where we can go next when traversing
+ * @num_links: number of links to other interconnect nodes
+ * @provider: points to the interconnect provider of this node
+ * @node_list: list of interconnect nodes associated with @provider
+ * @search_list: list used when walking the nodes graph
+ * @reverse: pointer to previous node when walking the nodes graph
+ * @is_traversed: flag that is used when walking the nodes graph
+ * @req_list: a list of QoS constraint requests associated with this node
+ * @avg_bw: aggregated value of average bandwidth
+ * @peak_bw: aggregated value of peak bandwidth
+ * @data: pointer to private data
+ */
+struct icc_node {
+	int			id;
+	const char              *name;
+	struct icc_node		**links;
+	size_t			num_links;
+
+	struct icc_provider	*provider;
+	struct list_head	node_list;
+	struct list_head	orphan_list;
+	struct list_head	search_list;
+	struct icc_node		*reverse;
+	bool			is_traversed;
+	struct hlist_head	req_list;
+	u32			avg_bw;
+	u32			peak_bw;
+	void			*data;
+};
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+
+struct icc_node *icc_node_create(int id);
+int icc_node_add(struct icc_node *node, struct icc_provider *provider);
+int icc_link_create(struct icc_node *node, const int dst_id);
+int icc_add_provider(struct icc_provider *provider);
+int icc_del_provider(struct icc_provider *provider);
+
+#else
+
+static inline struct icc_node *icc_node_create(int id)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+int icc_node_add(struct icc_node *node, struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
+static inline int icc_link_create(struct icc_node *node, const int dst_id)
+{
+	return -ENOTSUPP;
+}
+
+static inline int icc_add_provider(struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
+static inline int icc_del_provider(struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
+#endif /* CONFIG_INTERCONNECT */
+
+#endif /* _LINUX_INTERCONNECT_PROVIDER_H */
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
new file mode 100644
index 000000000000..5a7cf72b76a5
--- /dev/null
+++ b/include/linux/interconnect.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef _LINUX_INTERCONNECT_H
+#define _LINUX_INTERCONNECT_H
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+
+struct icc_path;
+struct device;
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+
+struct icc_path *icc_get(const int src_id, const int dst_id);
+void icc_put(struct icc_path *path);
+int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+
+#else
+
+static inline struct icc_path *icc_get(const int src_id, const int dst_id)
+{
+	return NULL;
+}
+
+static inline void icc_put(struct icc_path *path)
+{
+}
+
+static inline int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
+{
+	return 0;
+}
+
+#endif /* CONFIG_INTERCONNECT */
+
+#endif /* _LINUX_INTERCONNECT_H */

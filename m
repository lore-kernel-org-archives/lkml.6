Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4778C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5384020868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1mrLExA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5384020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeLHRCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:02:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLHRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:02:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so6555134wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeTBhfBfzyxVyKb92c1M4ktd+D+3Hu4luMY6labBrj0=;
        b=h1mrLExAt1RwZJW5PX3uL4+GkYl+uQfWR6jmxsTtE1RrSNAlQ4Ql/Q1UCp44fRhcAa
         5ykXuBrqcMfnazlhmxjfGu3TYYO82ZsRyg00z2+PLyyv2tvCl3iFf520eNZwCCkLzk3U
         lpC9CVK4qyQuwOvSd6z8fG0ZJmwi9R2lDjhLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeTBhfBfzyxVyKb92c1M4ktd+D+3Hu4luMY6labBrj0=;
        b=PFD589JeH0k3fN3j/2LyJhgeAglyLFyJuLMVzDTHerbSAtaRuud3rD2BW4JHurUn1f
         SATVBhG77TKIDtZi6Rn9Nbaq5zFH37SAuvfl2f1psn8hRCayRKj3q7N2khpDcB5cXwrK
         FQHBdYTkQudCdNVyD70JdQCVsEcVSkM60oDjIflurp7Wv/sUBw7VqnTKEVUy1QWSVUsz
         7L7OWsQ1Bp4wEYQ2pqU/KUwrOesr0/cyYisaL7ZaiOyrNz3nuDMVCsmDpjisI/Y8EP+N
         NIh8ZC1T6j/yMoOGds2NT7fmzgND9FYMZkpeaEn9xeNWNhXoG9sJqFI2cD2KptJ/Hvvq
         TuLA==
X-Gm-Message-State: AA+aEWa9e6t/2UTbvwRTUNAP/iwJYH5VJHemivkQUj5lGgJm3aJRiTLw
        kzlDPJ7xdKhaTYiHGlqpm9YxXg==
X-Google-Smtp-Source: AFSGD/WX9VXA/8pjoDiC6n7BC1sizodv63YNAgJWrx5QCIw1EO7Wz1Uk38MqAPxkjDmFbyh2Y7aokQ==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr4949477wrp.311.1544288545375;
        Sat, 08 Dec 2018 09:02:25 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Dec 2018 09:02:24 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
        arnd@arndb.de, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v12 3/7] interconnect: Allow endpoints translation via DT
Date:   Sat,  8 Dec 2018 19:02:12 +0200
Message-Id: <20181208170216.32555-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we support only platform data for specifying the interconnect
endpoints. As now the endpoints are hard-coded into the consumer driver
this may lead to complications when a single driver is used by multiple
SoCs, which may have different interconnect topology.
To avoid cluttering the consumer drivers, introduce a translation function
to help us get the board specific interconnect data from device-tree.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 149 ++++++++++++++++++++++++++
 include/linux/interconnect-provider.h |  17 +++
 include/linux/interconnect.h          |   7 ++
 3 files changed, 173 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 33d927758669..d1854dfb1bed 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/overflow.h>
 
 static DEFINE_IDR(icc_idr);
@@ -194,6 +195,152 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
+/* of_icc_xlate_onecell() - Translate function using a single index.
+ * @spec: OF phandle args to map into an interconnect node.
+ * @data: private data (pointer to struct icc_onecell_data)
+ *
+ * This is a generic translate function that can be used to model simple
+ * interconnect providers that have one device tree node and provide
+ * multiple interconnect nodes. A single cell is used as an index into
+ * an array of icc nodes specified in the icc_onecell_data struct when
+ * registering the provider.
+ */
+struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+				      void *data)
+{
+	struct icc_onecell_data *icc_data = data;
+	unsigned int idx = spec->args[0];
+
+	if (idx >= icc_data->num_nodes) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return icc_data->nodes[idx];
+}
+EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
+
+/**
+ * of_icc_get_from_provider() - Look-up interconnect node
+ * @spec: OF phandle args to use for look-up
+ *
+ * Looks for interconnect provider under the node specified by @spec and if
+ * found, uses xlate function of the provider to map phandle args to node.
+ *
+ * Returns a valid pointer to struct icc_node on success or ERR_PTR()
+ * on failure.
+ */
+static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+{
+	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
+	struct icc_provider *provider;
+
+	if (!spec || spec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&icc_lock);
+	list_for_each_entry(provider, &icc_providers, provider_list) {
+		if (provider->dev->of_node == spec->np)
+			node = provider->xlate(spec, provider->data);
+		if (!IS_ERR(node))
+			break;
+	}
+	mutex_unlock(&icc_lock);
+
+	return node;
+}
+
+/**
+ * of_icc_get() - get a path handle from a DT node based on name
+ * @dev: device pointer for the consumer device
+ * @name: interconnect path name
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when they
+ * are not needed anymore.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically,
+ * but they don't have to.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+	struct icc_node *src_node, *dst_node;
+	struct device_node *np = NULL;
+	struct of_phandle_args src_args, dst_args;
+	int idx = 0;
+	int ret;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	np = dev->of_node;
+
+	/*
+	 * When the consumer DT node do not have "interconnects" property
+	 * return a NULL path to skip setting constraints.
+	 */
+	if (!of_find_property(np, "interconnects", NULL))
+		return NULL;
+
+	/*
+	 * We use a combination of phandle and specifier for endpoint. For now
+	 * lets support only global ids and extend this in the future if needed
+	 * without breaking DT compatibility.
+	 */
+	if (name) {
+		idx = of_property_match_string(np, "interconnect-names", name);
+		if (idx < 0)
+			return ERR_PTR(idx);
+	}
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells", idx * 2,
+					 &src_args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_node_put(src_args.np);
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells", idx * 2 + 1,
+					 &dst_args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_node_put(dst_args.np);
+
+	src_node = of_icc_get_from_provider(&src_args);
+
+	if (IS_ERR(src_node)) {
+		if (PTR_ERR(src_node) != -EPROBE_DEFER)
+			dev_err(dev, "error finding src node: %ld\n",
+				PTR_ERR(src_node));
+		return ERR_CAST(src_node);
+	}
+
+	dst_node = of_icc_get_from_provider(&dst_args);
+
+	if (IS_ERR(dst_node)) {
+		if (PTR_ERR(dst_node) != -EPROBE_DEFER)
+			dev_err(dev, "error finding dst node: %ld\n",
+				PTR_ERR(dst_node));
+		return ERR_CAST(dst_node);
+	}
+
+	mutex_lock(&icc_lock);
+	path = path_find(dev, src_node, dst_node);
+	if (IS_ERR(path))
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+	mutex_unlock(&icc_lock);
+
+	return path;
+}
+EXPORT_SYMBOL_GPL(of_icc_get);
+
 /**
  * icc_set() - set constraints on an interconnect path between two endpoints
  * @path: reference to the path returned by icc_get()
@@ -519,6 +666,8 @@ int icc_provider_add(struct icc_provider *provider)
 {
 	if (WARN_ON(!provider->set))
 		return -EINVAL;
+	if (WARN_ON(!provider->xlate))
+		return -EINVAL;
 
 	mutex_lock(&icc_lock);
 
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 78208a754181..63caccadc2db 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -12,6 +12,21 @@
 #define icc_units_to_bps(bw)  ((bw) * 1000ULL)
 
 struct icc_node;
+struct of_phandle_args;
+
+/**
+ * struct icc_onecell_data - driver data for onecell interconnect providers
+ *
+ * @num_nodes: number of nodes in this device
+ * @nodes: array of pointers to the nodes in this device
+ */
+struct icc_onecell_data {
+	unsigned int num_nodes;
+	struct icc_node *nodes[];
+};
+
+struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+				      void *data);
 
 /**
  * struct icc_provider - interconnect provider (controller) entity that might
@@ -21,6 +36,7 @@ struct icc_node;
  * @nodes: internal list of the interconnect provider nodes
  * @set: pointer to device specific set operation function
  * @aggregate: pointer to device specific aggregate operation function
+ * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
  * @data: pointer to private data
@@ -31,6 +47,7 @@ struct icc_provider {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
 			 u32 *agg_avg, u32 *agg_peak);
+	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
 	void			*data;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 348957c6d767..8d4b0009b788 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -27,6 +27,7 @@ struct device;
 
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
+struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -38,6 +39,12 @@ static inline struct icc_path *icc_get(struct device *dev, const int src_id,
 	return NULL;
 }
 
+static inline struct icc_path *of_icc_get(struct device *dev,
+					  const char *name)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }

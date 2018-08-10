Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C938C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3F1223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ea8P/LTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3F1223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeHJRXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:23:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeHJRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:23:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so8579517wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDa6F+JrMAbwz8QNQ6MREvsk7u6fmv3IW/3SwDiD83I=;
        b=Ea8P/LTFFa6AYRg+RuaprWNj/iR6f/cpPyi8WAUaT925QFM0vg32OQGxz3zI7v2/ni
         4jkHXgAqcvcaQ8w2NuIgBRMaGke1laRQY8ipQp++5/JAXkPSm+jKr19zQXkx0veuhXzd
         JI1HviBNCo5nrERkRhIaGtxphJH9pw+GhpeXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fDa6F+JrMAbwz8QNQ6MREvsk7u6fmv3IW/3SwDiD83I=;
        b=J4gHt+dK7Y1NY1irGBfXG7WVsjMHZ8dNdvT+yXiNrcpYNqULMFVR3Oo2QVLKwiKGEz
         iJihOTcqVg3VNvaKCzesg8i//web9HeQnGOufTRpoqfPiHadOjXAyeyCLjlocgrxuNTc
         0s4HwjfOfAFoTSJjedbqbSUjNqFCeVRyqT4ovRtSUUbf7nndgXRYfBOmbqj7ApD3XgIc
         Qq34zfxBrX4wEQfvN0mmv9n85VZlyIrYgoaw+8C5oh5XToW0vP3zURJZfU8CFkDD5TZz
         KmJUNdOXULFAPuC7yaWA2OG4xwDMmg410+ShkzK8tersgaJO0FxRkCZBVJERJQmkAZBe
         SLyQ==
X-Gm-Message-State: AOUpUlGB91y9o192iwP66Eg7rHgyZuJm+sTaCUrHzDCq1T01TYZV70Yk
        Q9Pwqik1tGtZwqUMOm+1Dd1qyg==
X-Google-Smtp-Source: AA+uWPyihDVSqFLmSHsltnp7DcVywhYMERKLrnmQXvwygjcmdH/Ko52MJzAEJahXsTNUVFDBAbCLNQ==
X-Received: by 2002:adf:b2f4:: with SMTP id g107-v6mr4664061wrd.53.1533912768351;
        Fri, 10 Aug 2018 07:52:48 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 9-v6sm19842700wrb.48.2018.08.10.07.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 07:52:47 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 3/8] interconnect: Allow endpoints translation via DT
Date:   Fri, 10 Aug 2018 17:52:28 +0300
Message-Id: <20180810145233.16466-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810145233.16466-1-georgi.djakov@linaro.org>
References: <20180810145233.16466-1-georgi.djakov@linaro.org>
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

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/interconnect/core.c  | 78 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  7 ++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 9ca39aca4982..8f874d1b0a0f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/overflow.h>
 
 static DEFINE_IDR(icc_idr);
@@ -192,6 +193,83 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
+/**
+ * of_icc_get() - get a path handle from a DT node based on name
+ * @dev: device pointer for the consumer device
+ * @name: interconnect path name
+ *
+ * This function will search for a path two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when
+ * they are not needed anymore.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically,
+ * but they don't have to. NULL is also returned when the "interconnects"
+ * DT property is missing.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	struct device_node *np = NULL;
+	struct of_phandle_args src_args, dst_args;
+	u32 src_id, dst_id;
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
+	 * lets support only global ids and extend this is the future if needed
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
+	if (!src_args.args_count || src_args.args_count > 1)
+		return ERR_PTR(-EINVAL);
+
+	src_id = src_args.args[0];
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells", idx * 2 + 1,
+					 &dst_args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_node_put(dst_args.np);
+
+	if (!dst_args.args_count || dst_args.args_count > 1)
+		return ERR_PTR(-EINVAL);
+
+	dst_id = dst_args.args[0];
+
+	return icc_get(dev, src_id, dst_id);
+}
+EXPORT_SYMBOL_GPL(of_icc_get);
+
 /**
  * icc_set() - set constraints on an interconnect path between two endpoints
  * @path: reference to the path returned by icc_get()
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 593215371fd6..ae6744da9bc2 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -17,6 +17,7 @@ struct device;
 
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
+struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -28,6 +29,12 @@ static inline struct icc_path *icc_get(struct device *dev, const int src_id,
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

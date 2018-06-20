Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5907C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771B220872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIXjf1ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771B220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbeFTMMU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:12:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754012AbeFTML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:11:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so22471725wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5E3iJBFFrio7tuGSnWOLbi/y66jhJ612NEom6Tcob3A=;
        b=OIXjf1zeSod9R6cDfvXQ4qE1VQhZoGYaUWJ7evQIMPuUNOmHSeIc+oIEQwB3C8Ahnk
         bpmi88vYtpS4Gdj9jP81RFOeskO/2yJ/hiq/SBIBKvmgpPfRs81x1wpfxIzdpAWV1XW7
         XEumiJfCI+AXzxjY1lvsxRRcKixc4nUUxLi5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5E3iJBFFrio7tuGSnWOLbi/y66jhJ612NEom6Tcob3A=;
        b=HKMmLO1ZkCBQBMdqYNASQsX7XTKn2OuVU62bTTaNGYUjRM1K+0Jx/+VieWR9XMjdm7
         IHzALYojHrJq9q1wjJApKpNGvfz6yhhQpLiJWaJKv09Rz9cs/pStEmwXdWzELcBJKZQq
         hS59haxDq/fnxWRKfo+NP0LgOwJ6x5v5Ymb2oz+qnhOLi3MaXF9PsMPutu1riHeVAJPO
         N3CEHw2Kw+UMQHB7+AW+SmTShtUsxjNjacLV98b59gKh/MsYQzcdwHTVJp570+zcBztk
         M+GUyokTpMcuMiD97wcDX2IgdDePncosWJi6i49RP22OsoUJje9vHNlXV0bMB/vZ+a+z
         ubRg==
X-Gm-Message-State: APt69E3cjZx+ymI48HIWxlQJ1FJotW0iWnm31B+Dy5u5U20w4woL/+j+
        fk4EOf+oGu/cs2WReZrejYqyew==
X-Google-Smtp-Source: ADUXVKKWQSbX/3dr8+QqlWEcJk8dWL8suaGDW29IzUHL/apwNXZZbqyeBx3cOrlUZCUwLzSPQzBwuw==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr1435580wmb.147.1529496717923;
        Wed, 20 Jun 2018 05:11:57 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm1656483wmh.17.2018.06.20.05.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 05:11:57 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v5 8/8] interconnect: Allow endpoints translation via DT
Date:   Wed, 20 Jun 2018 15:11:41 +0300
Message-Id: <20180620121141.15403-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620121141.15403-1-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
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
---
 drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  7 ++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index dafc001ce758..2f07807ca4b4 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
@@ -306,6 +307,67 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
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

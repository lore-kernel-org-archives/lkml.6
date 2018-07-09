Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006BDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BD420835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoAlAP3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BD420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbeGIPvb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:51:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37542 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933868AbeGIPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so21296126wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNr9YSOIuqljr+o8vfQtsz/Q2VakflKl3VDBWnrqcHQ=;
        b=EoAlAP3pfjTeVe6ZNkzjP9lgC9RhNbA88PpqZNF6u8ls6UWmSXfzlUpNPIRpLWpHEh
         D6jgFZfv58HQOYc8wZTtz7c6lJhGJAIRH+AOlV0GS+W9hIAZ5Z9Gv3f3YY00DdHIX2M6
         6G3aWMskqCnxsW+HUYAMSZMTBUpUyGT6y/P5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNr9YSOIuqljr+o8vfQtsz/Q2VakflKl3VDBWnrqcHQ=;
        b=VYOully7n49q5mDpNzlgoD8hRPJ5P9iPkt0U97yeVqvpFtOVbguI/hS3l4B0XFe40h
         QpLTW9+5ViYTlHZmiUAZkxAbmDsEWrZWKQnzDGbe3PzjTINxSuBPFeUqmlf1V4TGO/GE
         0h4rIo1isT2SyMrqZMVHUFr0vWQMEVS/B+XFftVpttZFaxydCDuypcHzZakQzHXrJwRP
         7oICG7Fg0r6hgbF2N+zaxGjTJ0sOY+BKLMVpPvnEKE9OhzdkaGm4ADG3HRW36d0B2jcR
         QodvKFFDZdEU1MiTZ3InX2nBoUU8Dv9i1p4jkBnA9wX93AUzEnr4WIAXGUsw7AZNNNF5
         cJwA==
X-Gm-Message-State: APt69E2t4m+7c+1TxGqy1OXrKZ+EW8mqZfLZc+wzjNtG9ReXLOMnwFH0
        qD0kADAtDmPLSTCC9MII2bk3kA==
X-Google-Smtp-Source: AAOMgpdhNYD4oIxTGRdzl/ibdRMreP5kowF2ddV2LWpSKqytm9hz3dcBbpP9f7ZasG+zN3xBkAVkdg==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr12363995wmh.63.1531151481491;
        Mon, 09 Jul 2018 08:51:21 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o21-v6sm16229202wmg.28.2018.07.09.08.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:51:20 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, abailon@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v6 8/8] interconnect: Allow endpoints translation via DT
Date:   Mon,  9 Jul 2018 18:51:04 +0300
Message-Id: <20180709155104.25528-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709155104.25528-1-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
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
index 3f5001f51bb7..5817f081f6cf 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
@@ -294,6 +295,67 @@ static int apply_constraints(struct icc_path *path)
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

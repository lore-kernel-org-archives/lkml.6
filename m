Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC059C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8706320872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="amUAOkXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8706320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeFTMNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:13:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53856 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:11:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so5604190wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMiG6cM8VBvBAXZfGrxSfXokkjogyEYvlGb3JfwBdAo=;
        b=amUAOkXlniCfXibXy+jGsZmSGD6ZETsVvMsqABtHU6TJaWv+cPaqVbZxo9klgmFDLO
         Cp/GmWzH3c9zDEhTrfpdQRwDYt1u3XG3ZEB7CDuFqjUnCvRrP+MJeajW24Rdrcln/DAP
         hNaTlvkEBBonTN9r0pWH0Wd5rhEEVIWlr1p98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMiG6cM8VBvBAXZfGrxSfXokkjogyEYvlGb3JfwBdAo=;
        b=r7InCvdRQrONNQgVHJ6X96CKTynW5H51a0uDAhBgiOCMmrIYv/87/XQEcxdtUsICRr
         WZDq09umcDx+5/MvtvamR3t7n1pbcVBg1lNLNZj5aOEDJehMAayT7tcvc50tYCPY8DdF
         B+X7JNaX9bYJPhnNMAakV4Dm4V05KxcUhZhhJaqB8/iXu1MC3ik53M2RHkVtOl2qoI5J
         E8yxUr3NPsI46qe0f9h7dU9oa3+kCdjiCK9j/TtpjrFQU9ZtVIT5qXDX0ncM/N37NJeI
         zrQroghvzVYXcF9ZqA/8lkG5F4hJM2Ut6lmh3b6qcjBIMYPk+w0U7oPqT0WbX4eRPkWU
         y/zA==
X-Gm-Message-State: APt69E2f+NnJDMVqRP7PDxM01GIVKbqLgCPYzH25njhFJS0JLwdo0j5I
        9PMQgCqgm7/U61qfWLlODEveKw==
X-Google-Smtp-Source: ADUXVKL5tBABOgyKWh0ins7l1WEB2JCn/AoS4IfFPw0KbW0usHtP+TByU5DJyE9OLMaDRIbK004zgQ==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr1446987wmi.21.1529496709603;
        Wed, 20 Jun 2018 05:11:49 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm1656483wmh.17.2018.06.20.05.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 05:11:48 -0700 (PDT)
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
Subject: [PATCH v5 3/8] interconnect: Add debugfs support
Date:   Wed, 20 Jun 2018 15:11:36 +0300
Message-Id: <20180620121141.15403-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620121141.15403-1-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a functionality to provide information about the current constraints
per each node and provider.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e7f96fc6722e..dafc001ce758 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -15,10 +16,12 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -47,6 +50,81 @@ struct icc_path {
 	struct icc_req reqs[0];
 };
 
+#ifdef CONFIG_DEBUG_FS
+
+static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
+{
+	if (!n)
+		return;
+
+	seq_printf(s, "%-30s %12d %12d\n",
+		   n->name, n->avg_bw, n->peak_bw);
+}
+
+static int icc_summary_show(struct seq_file *s, void *data)
+{
+	struct icc_provider *provider;
+
+	seq_puts(s, " node                                   avg         peak\n");
+	seq_puts(s, "--------------------------------------------------------\n");
+
+	mutex_lock(&icc_lock);
+
+	list_for_each_entry(provider, &icc_provider_list, provider_list) {
+		struct icc_node *n;
+
+		list_for_each_entry(n, &provider->nodes, node_list) {
+			struct icc_req *r;
+
+			icc_summary_show_one(s, n);
+			hlist_for_each_entry(r, &n->req_list, req_node) {
+				if (!r->dev)
+					continue;
+
+				seq_printf(s, "    %-26s %12d %12d\n",
+					   dev_name(r->dev), r->avg_bw,
+					   r->peak_bw);
+			}
+		}
+	}
+
+	mutex_unlock(&icc_lock);
+
+	return 0;
+}
+
+static int icc_summary_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, icc_summary_show, inode->i_private);
+}
+
+static const struct file_operations icc_summary_fops = {
+	.open		= icc_summary_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init icc_debugfs_init(void)
+{
+	struct dentry *file;
+
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	if (!icc_debugfs_dir) {
+		pr_err("interconnect: error creating debugfs directory\n");
+		return -ENODEV;
+	}
+
+	file = debugfs_create_file("interconnect_summary", 0444,
+				   icc_debugfs_dir, NULL, &icc_summary_fops);
+	if (!file)
+		return -ENODEV;
+
+	return 0;
+}
+late_initcall(icc_debugfs_init);
+#endif
+
 static struct icc_node *node_find(const int id)
 {
 	struct icc_node *node;

Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C266C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBB3223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oc9dYoU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBB3223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeHJRXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:23:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34126 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbeHJRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:23:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so8587728wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K5qYFSU+P7Ie0HuaSbBHj2ureU4ns5TmNVNvVaDKFEI=;
        b=Oc9dYoU0IIx5oyfSasJ96vWcCRexjQ9IESwDjDMzi/7iE24sL0+RpUUJPxcQbTnN3l
         B2B4PriMi1Wy9xWikF3BHBPvxuteu2AZjSMn4zRPuk+chyo9w+42MLzxXpu3M4J8EPb1
         bL2C2lDdK9kINRngbQ5J7tppzo/vV+UXjhtZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K5qYFSU+P7Ie0HuaSbBHj2ureU4ns5TmNVNvVaDKFEI=;
        b=X/lSreClkIVhTbLHwZkO+9YmvU1sCIK1cujrTZCyK42gofs9s1AwBlOfMQIrDg5/yE
         YIHBwoO8C+GxdyqHmq9euz2VrT2AKOtw9rb2m4cUifESfuykZptiL0K5o4R/Rk0Jgh/u
         EsQlt58eFOZCRJJQtdlx51EE1lOHQpq4WeEdokZj697y8vZG02wYmtpU1qq/KLcFFNAC
         mb0jwuEn0X8WeiWsP6A/M4khocuA5lOLUAFsOSkjBDxNVpQp23YrHchqw3cPKVxh5LCv
         JQPI7Wvwoo9R5R7qRPgePexfqnsbal3CWUDuT9StwY3xO3KS6yra//tzdMsrg55PkWed
         eNqQ==
X-Gm-Message-State: AOUpUlELo+qD9YmnDLIKrFBno47Vt2QCYCSKLFcj0hWSKMaGsFe/6zUv
        g5/xQvJ6tWTHGdIhPt3yeush7A==
X-Google-Smtp-Source: AA+uWPwPG8JZ+uwAWaTA8PKaZNn8IrBRdx89DB5+g4frnXUbq5xamKzC9FnnF+Tii1bC5h5aYOwzTA==
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr4382476wrc.135.1533912770222;
        Fri, 10 Aug 2018 07:52:50 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 9-v6sm19842700wrb.48.2018.08.10.07.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 07:52:49 -0700 (PDT)
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
Subject: [PATCH v8 4/8] interconnect: Add debugfs support
Date:   Fri, 10 Aug 2018 17:52:29 +0300
Message-Id: <20180810145233.16466-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810145233.16466-1-georgi.djakov@linaro.org>
References: <20180810145233.16466-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a functionality to provide information about the current constraints
per each node and provider.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/interconnect/core.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8f874d1b0a0f..288ef83c3bc0 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -17,10 +18,12 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -49,6 +52,62 @@ struct icc_path {
 	struct icc_req reqs[];
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
+#endif
+
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
@@ -646,6 +705,25 @@ int icc_provider_del(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
+static int __init icc_init(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	debugfs_create_file("interconnect_summary", 0444,
+			    icc_debugfs_dir, NULL, &icc_summary_fops);
+#endif
+	return 0;
+}
+
+static void __exit icc_exit(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(icc_debugfs_dir);
+#endif
+}
+module_init(icc_init);
+module_exit(icc_exit);
+
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
 MODULE_DESCRIPTION("Interconnect Driver Core");
 MODULE_LICENSE("GPL v2");

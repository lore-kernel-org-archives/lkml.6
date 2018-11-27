Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02288C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4492133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpw42Jmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4492133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeK1FCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56153 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbeK1FCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so22691370wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkMXTuwZqeV/O07hI4I9fDkAqqzo6frS5YB6zw60kWU=;
        b=hpw42Jmy5OGTUCFkcIx8yaAzh3EfjJpwAwi2673rsIabw4tpC4PNQSWtWsaQTQu9et
         031oQYBXlzjHPJ3Xu5ZphC/KCSYFHx6qF6NIFivkAgvysp8/0wxA7W3x2T2FRvYva2VO
         1QMq6TN+nBnfDiMVu+T15SwCXUEQ9+XJ7SDpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkMXTuwZqeV/O07hI4I9fDkAqqzo6frS5YB6zw60kWU=;
        b=byxEH+whzgqz0NlS6NZ66UIBqDLc+OaGRdNap8bTSB1Rz6FA22EWdDJbb12Q8x/IqN
         i9CGT8dY9bKHK0H7OE9vWd7e89ArMNNY9LgE1C7hoi9nxZqaoxhWAONeML2VY37SNd0c
         IYg39pafhvq4AxwTKVtbJcyCS7Wwly108lVlEoostvURo+3RA5m/D/VzQ3ZISsJFUM6F
         kVfxgf3iJf8WXXN5o8JxKrwOeZ37Q4J2IBFMMoYmczRVHLbChqq2lSWdLFu7q2gq/0Vt
         nc9G/bT/F7oIUyAy2xUqWs1swLHLJib/9q0sUhPFE571cU9V5ireim41q/F5V03X7WOp
         J/cQ==
X-Gm-Message-State: AA+aEWatiyQiwUi/AlizocrOXd/9YgL5kMzjDnBmVO8IlWQs4+GsxC2V
        QOANG/qmB18HsGuKC4kXRAXUMD4xMZghVw==
X-Google-Smtp-Source: AFSGD/WhwSa29qmb49jysP+xkYrMZwX0rSBHdoX7I1WTK2SvTFQ0tGiFPicVVltbM//m7ykux/ojfw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr10456598wmd.36.1543341839228;
        Tue, 27 Nov 2018 10:03:59 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm6459921wrs.58.2018.11.27.10.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 10:03:58 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 4/7] interconnect: Add debugfs support
Date:   Tue, 27 Nov 2018 20:03:46 +0200
Message-Id: <20181127180349.29997-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181127180349.29997-1-georgi.djakov@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a functionality to provide information about the current constraints
per each node and provider.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/interconnect/core.c | 71 +++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index ebc42ef9fa46..efe39e8934cc 100644
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
 static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -48,6 +51,59 @@ struct icc_path {
 	struct icc_req reqs[];
 };
 
+static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
+{
+	if (!n)
+		return;
+
+	seq_printf(s, "%-30s %12u %12u\n",
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
+	list_for_each_entry(provider, &icc_providers, provider_list) {
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
+				seq_printf(s, "    %-26s %12u %12u\n",
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
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
@@ -720,6 +776,21 @@ int icc_provider_del(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
+static int __init icc_init(void)
+{
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	debugfs_create_file("interconnect_summary", 0444,
+			    icc_debugfs_dir, NULL, &icc_summary_fops);
+	return 0;
+}
+
+static void __exit icc_exit(void)
+{
+	debugfs_remove_recursive(icc_debugfs_dir);
+}
+module_init(icc_init);
+module_exit(icc_exit);
+
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
 MODULE_DESCRIPTION("Interconnect Driver Core");
 MODULE_LICENSE("GPL v2");

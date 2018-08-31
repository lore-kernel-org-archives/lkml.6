Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD45C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB3420837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTwvFAll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB3420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeHaSJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:09:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34346 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeHaSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:09:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so11352614wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ErPFSIw/4GM1+VgS/hfybgYofrFf349AuXGxD3gCkw0=;
        b=DTwvFAllH0XU0RUzsrbald8RDLAE+d8PxpfEDJMBea+zlwqwKnAv6JubLXdkUE/D/Q
         GjOBvBdpSMExTMUUzHLgu09otO23IttspZ+aVbJJmqDHVvbybE9fsDn9/V+Gde60dwKU
         aMrjTMyPXXJ3aGsMQ06yIpekmysFRR52QgbpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ErPFSIw/4GM1+VgS/hfybgYofrFf349AuXGxD3gCkw0=;
        b=M9+iYlRiGDwKcaMjD1uIveuBV8zy4S2LIDaoXH2vmwhuKoFNYMnHYkiYaLxDM3pRD2
         NvB2b4QEBSNolK/0vF5Mp8mBLpSnYRozIotOV4g7yg5NbcQl2uyxSR/fFikATQj0eQNd
         F7KJn1RyuXlQDXZmmJCZgpHP+pLEuW2xdzpFDfVynYofMINdCf6PoWY/me+Li9P6qv9u
         X59GVQhtN9g45RAPw5pj8jrguPFo82YpE44zEZxnwLf0p6aa+hgOfyBXunS/h4BOaNHV
         4k24gATX2gyLLdo5E08hi92fzVLuogjMiTVu1/e0Lnx3RecmpPlteVL3jQetKWwofviD
         UBBQ==
X-Gm-Message-State: APzg51Dqs0XsTyOQrF7SL8lKnGAkWT7trY+L6lbI58x7bIixjpLyG1TB
        hIR174id4EWVojS26It+ThQARQ==
X-Google-Smtp-Source: ANB0VdYzTnT/lHZTDSFtbiXweg+4goI5iyF/5deDT6pjdc75GjsHoMRGs4wuihtcAAri0fctXCJh2g==
X-Received: by 2002:adf:ad47:: with SMTP id p65-v6mr11184733wrc.222.1535724121680;
        Fri, 31 Aug 2018 07:02:01 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm8624513wmb.10.2018.08.31.07.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 07:02:00 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v9 4/8] interconnect: Add debugfs support
Date:   Fri, 31 Aug 2018 17:01:47 +0300
Message-Id: <20180831140151.13972-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831140151.13972-1-georgi.djakov@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
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
index ed0a6783ffc4..2740f1a441d8 100644
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

Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603FDC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DEB20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCvtVu9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DEB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeLHRCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:02:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33152 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLHRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:02:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so3453527wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9WXnWBuhV6priAyhwQEr5olumbkswiCcUF+DIQmTjY=;
        b=NCvtVu9M6ziHrmVHuiuSufksAuT8GyMS29AwqsfHsRrjMV0mCdU8B6tPBre1d9LPI2
         5A0/Nn6W6ASYyBqS1Hh1Vjyl8jqo2O3a4mRcJtRAD5ryiFckIdWRrDLQGFJDFc4MurCm
         uiiMWK5pk0hCaOEvR5EMnf4yCAjAWJqA4fl/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9WXnWBuhV6priAyhwQEr5olumbkswiCcUF+DIQmTjY=;
        b=KaF9FaTEi3XuBicaV7ZtTpv3wLVI7MZWY6UT2M4fnv/u38b1EpMTWxwgJ9S2ZHDolI
         s3fs/ugQi+FJbSwokx8VeXSvesw5LT4wfmn4cfLEXhUImLfuabfYAcCzJg5by+R7OBlS
         vBGeZ/pvR42JWWYPIzPfW8dLGtVaWU4WlwerqLrff6c0mC5MNMmXQ8j2XsBloUgc4vpv
         U56BD6jAgV6QEXAM/3Y5g8imId80gxBsQK610tLR2Po0L1kTDxJUMEOzlvKUwxe23auq
         ygtQhMLXcDfp9ldQE/S5tLGYcmppEy6jJy81BmttO/YkpwQ34p2AoFkMb+KSyBAOg/Ko
         ACOQ==
X-Gm-Message-State: AA+aEWbla3zgm6s5UucV+Sfa3r7jXUz5qAU3ZwH/vmj9Wd8DS1u3IWGW
        I6Ge9hL9pPWy1ChXisFWWNVjOA==
X-Google-Smtp-Source: AFSGD/U0d29KibpT6GlT7YMRTMgshlOwsaNpk2QTfkCRR+TLGZWXDM+gSgfCbYZwxpBwT8UeAx2kTw==
X-Received: by 2002:a1c:f112:: with SMTP id p18mr5206530wmh.83.1544288547644;
        Sat, 08 Dec 2018 09:02:27 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Dec 2018 09:02:26 -0800 (PST)
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
Subject: [PATCH v12 4/7] interconnect: Add debugfs support
Date:   Sat,  8 Dec 2018 19:02:13 +0200
Message-Id: <20181208170216.32555-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a functionality to provide information about the current constraints
per each node and provider.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 71 +++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index d1854dfb1bed..5a98192e92ad 100644
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
@@ -711,6 +767,21 @@ int icc_provider_del(struct icc_provider *provider)
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
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
 MODULE_DESCRIPTION("Interconnect Driver Core");
 MODULE_LICENSE("GPL v2");

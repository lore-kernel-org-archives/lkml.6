Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5289CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096EC21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfW41lWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096EC21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbeIUBEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40205 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbeIUBED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so4791470plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q9mLJUvfHW+9PF2qxnbjTL+mt+UjMYG0sP1kUgTlkaI=;
        b=TfW41lWXkzMpJ0PmNgow0xQEYq8zI9c0HM/9UKI6yuBZc2HJpWvauqB21tF6R8Befe
         hNAoVUre1AYuNE6C04mPAD0B+v07j+CvCnwvdKpw1vC9bs7SIO67/Lr3qaWpEAjb1mf4
         ps1Zq0jSJ3g/XFesSpbmzAB/gpI4r4/38m6F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q9mLJUvfHW+9PF2qxnbjTL+mt+UjMYG0sP1kUgTlkaI=;
        b=o48zUlcrWWgy1nEWHjiaBI/pFms17ejUYBof+YhD8c1ZoJQHI8uMkrEU/MlX51XFG6
         RltteUWbqPqvmiyVvXhpa1y93WW5jAsjaCJgJzgGH84Q25R+8Qu09anubV6+kyVhv9yC
         74ESHC9YFcyK/gtumK6/kV57kEgZsFKve818hpziuI142N/9exET4xn6MMuigJyTL6Em
         psIZA5iQuMBpeOBycl+1QF9Fs7XQ+m99ZWLtWt0W+WuMPloZcQw8Kp5Q6TdruIHASFbR
         SOOyuxoawXeCt8v8/yU4EmWdOiVhVZx8l8E4eSwmIauN3C7Q8dMcwMGTMMgfa/AGzyVV
         oghA==
X-Gm-Message-State: APzg51CKyA6S5wBtydvn32wag5KHr7BboOP4jBvdyL1eXq0kFVo5E264
        l7U2ofLbfr/PSY7uJl+bOeDwjg==
X-Google-Smtp-Source: ANB0Vdbn09kw77lqhT5iCxo0aLeJvTaDWqNIBqbn0N5uyPqjY8AJmcNwGb7SeNnxomdoC17v9blaPQ==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr40541725plb.322.1537471144953;
        Thu, 20 Sep 2018 12:19:04 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 28/44] coresight: Handle failures in enabling a trace path
Date:   Thu, 20 Sep 2018 13:18:03 -0600
Message-Id: <1537471099-19781-29-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

coresight_enable_path() enables the components in a trace
path from a given source to a sink, excluding the source.
The operation is performed in the reverse order; the sink
first and then backwards in the list. However, if we encounter
an error in enabling any of the component, we simply disable
all the components in the given path irrespective of whether
we enabled some of the components in the enable iteration.
This could interfere with another trace session if one of the
link devices is turned off (e.g, TMC-ETF). So, we need to
make sure that we only disable those components which were
actually enabled from the iteration.

This patch achieves the same by refactoring the coresight_disable_path
to accept a "node" to start from in the forward order, which can
then be used from the error path of coresight_enable_path().
With this change, we don't issue a disable call back for a component
which didn't get enabled. This change of behavior triggers
a bug in coresight_enable_link(), where we leave the refcount
on the device and will prevent the device from being enabled
forever. So, we also drop the refcount in the coresight_enable_link()
if the operation failed.

Also, with the refactoring, we always start after the first node (which
is the "SOURCE" device) for disabling the entire path. This implies,
we must not find a "SOURCE" in the middle of the path. Hence, added
a WARN_ON() to make sure the paths we get are sane, rather than
simply ignoring them.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e73ca6af4765..f4f50753cf75 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -187,8 +187,10 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
 		if (link_ops(csdev)->enable) {
 			ret = link_ops(csdev)->enable(csdev, inport, outport);
-			if (ret)
+			if (ret) {
+				atomic_dec(&csdev->refcnt[refport]);
 				return ret;
+			}
 		}
 	}
 
@@ -277,13 +279,21 @@ static bool coresight_disable_source(struct coresight_device *csdev)
 	return !csdev->enable;
 }
 
-void coresight_disable_path(struct list_head *path)
+/*
+ * coresight_disable_path_from : Disable components in the given path beyond
+ * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
+ * disabled.
+ */
+static void coresight_disable_path_from(struct list_head *path,
+					struct coresight_node *nd)
 {
 	u32 type;
-	struct coresight_node *nd;
 	struct coresight_device *csdev, *parent, *child;
 
-	list_for_each_entry(nd, path, link) {
+	if (!nd)
+		nd = list_first_entry(path, struct coresight_node, link);
+
+	list_for_each_entry_continue(nd, path, link) {
 		csdev = nd->csdev;
 		type = csdev->type;
 
@@ -303,7 +313,12 @@ void coresight_disable_path(struct list_head *path)
 			coresight_disable_sink(csdev);
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
-			/* sources are disabled from either sysFS or Perf */
+			/*
+			 * We skip the first node in the path assuming that it
+			 * is the source. So we don't expect a source device in
+			 * the middle of a path.
+			 */
+			WARN_ON(1);
 			break;
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
@@ -316,6 +331,11 @@ void coresight_disable_path(struct list_head *path)
 	}
 }
 
+void coresight_disable_path(struct list_head *path)
+{
+	coresight_disable_path_from(path, NULL);
+}
+
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 {
 
@@ -369,7 +389,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 out:
 	return ret;
 err:
-	coresight_disable_path(path);
+	coresight_disable_path_from(path, nd);
 	goto out;
 }
 
-- 
2.7.4


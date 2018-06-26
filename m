Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41844C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DFB26A4F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDyYULqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DFB26A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935426AbeFZMNV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:13:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36653 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935260AbeFZMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:12:13 -0400
Received: by mail-it0-f68.google.com with SMTP id j135-v6so2001100itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpRBNnuSyudwPjaxcE+Fto06lTyc9rmYe1wAQDQ8ptw=;
        b=JDyYULqAGzh9dv097FnJfnyVfMozvKfKniiHCr1mS+m7s9Rrdesva0LLh/IV/JxBHA
         iCZ54dUR4Mne5qmAu8Myhm/26R1d6qL4QWrLJQ1osp3q8t00fDEOWwj0x1HWtTpoXVzk
         FRfV7dVnmDhBSLONVp6+3SYwmIO7EGVGD8EYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpRBNnuSyudwPjaxcE+Fto06lTyc9rmYe1wAQDQ8ptw=;
        b=KAbYxpCvGoyFsUjXZgCtrX2BCGUwKQ/gYFK6JhzyERggecc3eswzUlomtu4ZSiRtB2
         VQE7zxq2zcGxUqyb9mR+3k7z4/Z/yiqdlglxGx1THy4E0x35pq2l1N8NjLxqusx5dLSb
         CxuqeGRyNX7EF1Jy9tOemnbbbacANVyeEYcJ01cErgqB2xOrL/S31+tReq0s9MuX2NPN
         lkvzGBiNSv52GMnsvWSxu7fzajI696hA80m/AKptDpj0TNfLCP3xK/X5ILmKaS1qOaWE
         lNERKiWU4DT7GqbvwQujEcXFhfb6vhn4TaZ0QOte4+YF/RFm/7y7BCR8CWtMJj94K+SP
         L5IA==
X-Gm-Message-State: APt69E2fKqrH8jo6qpiRiKr5Dt0mFYIhh12s/iFBAMlt4nvdrbbgOM6e
        J/Y6HuGQjuoxY3ZL/5GRHZ3hEQ==
X-Google-Smtp-Source: AAOMgpdTBpuHCgxDUUGMXwQClDGB7T9c+x8E5dUXwzZteRxo+oiXFsyjG05dKs5hnUBDHUXMj1knvA==
X-Received: by 2002:a02:a999:: with SMTP id q25-v6mr982712jam.47.1530015132297;
        Tue, 26 Jun 2018 05:12:12 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id y62-v6sm902309ioy.88.2018.06.26.05.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:12:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] remoteproc: Make client initialize ops in rproc_subdev
Date:   Tue, 26 Jun 2018 07:11:57 -0500
Message-Id: <20180626121159.7267-4-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626121159.7267-1-elder@linaro.org>
References: <20180626121159.7267-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

In preparation of adding the additional prepare and unprepare operations
make the client responsible for filling out the function pointers of the
rproc_subdev. This makes the arguments to rproc_add_subdev() more
manageable, in particular when some of the functions are left out.

Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[elder@linaro.org: added comment about assigning function pointers]
Signed-off-by Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/qcom_common.c     | 18 ++++++++++--------
 drivers/remoteproc/qcom_sysmon.c     |  5 ++++-
 drivers/remoteproc/remoteproc_core.c | 18 +++++++-----------
 include/linux/remoteproc.h           |  5 +----
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index acfc99f82fb8..4ae87c5b8793 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -64,7 +64,10 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink)
 		return;
 
 	glink->dev = dev;
-	rproc_add_subdev(rproc, &glink->subdev, glink_subdev_probe, glink_subdev_remove);
+	glink->subdev.start = glink_subdev_probe;
+	glink->subdev.stop = glink_subdev_remove;
+
+	rproc_add_subdev(rproc, &glink->subdev);
 }
 EXPORT_SYMBOL_GPL(qcom_add_glink_subdev);
 
@@ -157,7 +160,10 @@ void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
 		return;
 
 	smd->dev = dev;
-	rproc_add_subdev(rproc, &smd->subdev, smd_subdev_probe, smd_subdev_remove);
+	smd->subdev.start = smd_subdev_probe;
+	smd->subdev.stop = smd_subdev_remove;
+
+	rproc_add_subdev(rproc, &smd->subdev);
 }
 EXPORT_SYMBOL_GPL(qcom_add_smd_subdev);
 
@@ -202,11 +208,6 @@ void qcom_unregister_ssr_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
 
-static int ssr_notify_start(struct rproc_subdev *subdev)
-{
-	return  0;
-}
-
 static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
@@ -227,8 +228,9 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
 			 const char *ssr_name)
 {
 	ssr->name = ssr_name;
+	ssr->subdev.stop = ssr_notify_stop;
 
-	rproc_add_subdev(rproc, &ssr->subdev, ssr_notify_start, ssr_notify_stop);
+	rproc_add_subdev(rproc, &ssr->subdev);
 }
 EXPORT_SYMBOL_GPL(qcom_add_ssr_subdev);
 
diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index f085545d7da5..e976a602b015 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -469,7 +469,10 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 
 	qmi_add_lookup(&sysmon->qmi, 43, 0, 0);
 
-	rproc_add_subdev(rproc, &sysmon->subdev, sysmon_start, sysmon_stop);
+	sysmon->subdev.start = sysmon_start;
+	sysmon->subdev.stop = sysmon_stop;
+
+	rproc_add_subdev(rproc, &sysmon->subdev);
 
 	sysmon->nb.notifier_call = sysmon_notify;
 	blocking_notifier_chain_register(&sysmon_notifiers, &sysmon->nb);
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 981ae6dff145..ca39fad175f2 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -399,8 +399,10 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	list_add_tail(&rvdev->node, &rproc->rvdevs);
 
-	rproc_add_subdev(rproc, &rvdev->subdev,
-			 rproc_vdev_do_probe, rproc_vdev_do_remove);
+	rvdev->subdev.start = rproc_vdev_do_probe;
+	rvdev->subdev.stop = rproc_vdev_do_remove;
+
+	rproc_add_subdev(rproc, &rvdev->subdev);
 
 	return 0;
 
@@ -1663,17 +1665,11 @@ EXPORT_SYMBOL(rproc_del);
  * rproc_add_subdev() - add a subdevice to a remoteproc
  * @rproc: rproc handle to add the subdevice to
  * @subdev: subdev handle to register
- * @start: function to call after the rproc is started
- * @stop: function to call before the rproc is stopped
+ *
+ * Caller is responsible for populating optional subdevice function pointers.
  */
-void rproc_add_subdev(struct rproc *rproc,
-		      struct rproc_subdev *subdev,
-		      int (*start)(struct rproc_subdev *subdev),
-		      void (*stop)(struct rproc_subdev *subdev, bool crashed))
+void rproc_add_subdev(struct rproc *rproc, struct rproc_subdev *subdev)
 {
-	subdev->start = start;
-	subdev->stop = stop;
-
 	list_add_tail(&subdev->node, &rproc->subdevs);
 }
 EXPORT_SYMBOL(rproc_add_subdev);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index bf55bf2a5ee1..8f1426330cca 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -566,10 +566,7 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
 	return rvdev->rproc;
 }
 
-void rproc_add_subdev(struct rproc *rproc,
-		      struct rproc_subdev *subdev,
-		      int (*start)(struct rproc_subdev *subdev),
-		      void (*stop)(struct rproc_subdev *subdev, bool crashed));
+void rproc_add_subdev(struct rproc *rproc, struct rproc_subdev *subdev);
 
 void rproc_remove_subdev(struct rproc *rproc, struct rproc_subdev *subdev);
 
-- 
2.17.1


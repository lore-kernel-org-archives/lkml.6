Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00924263F0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYETUxHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00924263F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935377AbeFZBez (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:34:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32870 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935232AbeFZBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:34:16 -0400
Received: by mail-it0-f65.google.com with SMTP id k17-v6so13890610ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0D4dgUnxnyFGhUqk+RKwlNaqSx/b5/e3BH+kqEcajM=;
        b=VYETUxHWJnqCGNAh6gMjY3ROfOR+9fimvNDXBSz9KJJe/7t4DS7BpZE6+UGVjNi2qJ
         OwjZa3jtlJTUOPjdSZ5ONKYxhvdztBzXkxrh6qbMX93vud9HgCbzZxAAIWXVWUnMBNXT
         mOEtGKcCUL7CldERpqjNyS5DXYx/UJ+xGBZ7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0D4dgUnxnyFGhUqk+RKwlNaqSx/b5/e3BH+kqEcajM=;
        b=Kp+ZPdIjHRnuCV+QsKYNpynq7mTTsVMEefnw242QnRqwDiosL5FZRV+9kNZYEeBWmy
         chZvmQijJ5uHFJ7HVh74Kp/iunP8LND+amPAD5UqcLb7qqvEMJJxnGwn5kEHq9CQk8C6
         RyVVafNbRGF8xGtgjCemOCBv5Yt0RG0aGtCr4fs2NQDJvMeUR63rRGI15NBIqAhLOBzx
         e5izJ7gkzq6/WALfn6l6Z4BXU0K4OjgAoo3zpmQX/TspWTnBHGpjV16CZBrklzpEeZSU
         GKsRn2l3FetPE0oZKhlyHbHrz2ZlJr3OilDO+NWK2ohv1He4mf2XqiBv9Pfw17IV5Zso
         g+zg==
X-Gm-Message-State: APt69E2hQ+MwYwAvOhFice2GNjEgT+xhf4HEDjWNEuQkN4JkaNe59/gx
        uWN7OgZVzayGnXQ9s5NgGEQmiGi+c2w=
X-Google-Smtp-Source: ADUXVKJSKAZDx+GPaybAmugbhuTeDIgUVMpHI2hXHN+wTi8iyp+MuXY7OhQjhJoYMwobe4JkT+sHpg==
X-Received: by 2002:a02:4c9b:: with SMTP id q27-v6mr6429026jad.38.1529976855201;
        Mon, 25 Jun 2018 18:34:15 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id h62-v6sm184699ioa.22.2018.06.25.18.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 18:34:14 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 3/5] remoteproc: Make client initialize ops in rproc_subdev
Date:   Mon, 25 Jun 2018 20:34:07 -0500
Message-Id: <20180626013409.5125-4-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626013409.5125-1-elder@linaro.org>
References: <20180626013409.5125-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

In preparation of adding the additional prepare and unprepare operations
make the client responsible for filling out the function pointers of the
rproc_subdev. This makes the arguments to rproc_add_subdev() more
manageable, in particular when some of the functions are left out.

[elder@linaro.org: added comment about assigning function pointers]

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alex Elder <elder@linaro.org>
Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
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


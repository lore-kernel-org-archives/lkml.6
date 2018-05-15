Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeEOUyE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:54:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37371 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeEOUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:53:57 -0400
X-Google-Smtp-Source: AB8JxZo7Jc+xVwp8By+NpThKBDIy2oUf4y89Dj/I1Ft+erKudrm4OP4B/2jK7n1Z1sRpMkETG0gYaw==
From: Alex Elder <elder@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] remoteproc: Make client initialize ops in rproc_subdev
Date: Tue, 15 May 2018 15:53:43 -0500
Message-Id: <20180515205345.8090-4-elder@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515205345.8090-1-elder@linaro.org>
References: <20180515205345.8090-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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
2.17.0

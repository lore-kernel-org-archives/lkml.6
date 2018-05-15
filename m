Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeEOUyj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:54:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55167 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeEOUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:53:59 -0400
X-Google-Smtp-Source: AB8JxZqDq9ZS5kHSc0PoCWNHJFiw4EKDdItitx7OtTU3AsA6gjHCr/zB8S8vN2he/OPabHiYjkwyDQ==
From: Alex Elder <elder@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] remoteproc: rename subdev probe and remove functions
Date: Tue, 15 May 2018 15:53:44 -0500
Message-Id: <20180515205345.8090-5-elder@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515205345.8090-1-elder@linaro.org>
References: <20180515205345.8090-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename functions used when subdevices are started and stopped to
reflect the new naming scheme.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/qcom_common.c     | 16 ++++++++--------
 drivers/remoteproc/remoteproc_core.c |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4ae87c5b8793..6f77840140bf 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -33,7 +33,7 @@
 
 static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
 
-static int glink_subdev_probe(struct rproc_subdev *subdev)
+static int glink_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
@@ -42,7 +42,7 @@ static int glink_subdev_probe(struct rproc_subdev *subdev)
 	return PTR_ERR_OR_ZERO(glink->edge);
 }
 
-static void glink_subdev_remove(struct rproc_subdev *subdev, bool crashed)
+static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
@@ -64,8 +64,8 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink)
 		return;
 
 	glink->dev = dev;
-	glink->subdev.start = glink_subdev_probe;
-	glink->subdev.stop = glink_subdev_remove;
+	glink->subdev.start = glink_subdev_start;
+	glink->subdev.stop = glink_subdev_stop;
 
 	rproc_add_subdev(rproc, &glink->subdev);
 }
@@ -129,7 +129,7 @@ int qcom_register_dump_segments(struct rproc *rproc,
 }
 EXPORT_SYMBOL_GPL(qcom_register_dump_segments);
 
-static int smd_subdev_probe(struct rproc_subdev *subdev)
+static int smd_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
@@ -138,7 +138,7 @@ static int smd_subdev_probe(struct rproc_subdev *subdev)
 	return PTR_ERR_OR_ZERO(smd->edge);
 }
 
-static void smd_subdev_remove(struct rproc_subdev *subdev, bool crashed)
+static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
@@ -160,8 +160,8 @@ void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
 		return;
 
 	smd->dev = dev;
-	smd->subdev.start = smd_subdev_probe;
-	smd->subdev.stop = smd_subdev_remove;
+	smd->subdev.start = smd_subdev_start;
+	smd->subdev.stop = smd_subdev_stop;
 
 	rproc_add_subdev(rproc, &smd->subdev);
 }
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ca39fad175f2..2ede7ae6f5bc 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -301,14 +301,14 @@ void rproc_free_vring(struct rproc_vring *rvring)
 	rsc->vring[idx].notifyid = -1;
 }
 
-static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
+static int rproc_vdev_do_start(struct rproc_subdev *subdev)
 {
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
 
 	return rproc_add_virtio_dev(rvdev, rvdev->id);
 }
 
-static void rproc_vdev_do_remove(struct rproc_subdev *subdev, bool crashed)
+static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
 
@@ -399,8 +399,8 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	list_add_tail(&rvdev->node, &rproc->rvdevs);
 
-	rvdev->subdev.start = rproc_vdev_do_probe;
-	rvdev->subdev.stop = rproc_vdev_do_remove;
+	rvdev->subdev.start = rproc_vdev_do_start;
+	rvdev->subdev.stop = rproc_vdev_do_stop;
 
 	rproc_add_subdev(rproc, &rvdev->subdev);
 
-- 
2.17.0

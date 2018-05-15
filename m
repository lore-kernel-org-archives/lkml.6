Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeEOUy5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:54:57 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51785 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeEOUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:53:55 -0400
X-Google-Smtp-Source: AB8JxZog3jlyDHh5Df1yvcW0duzqhfivtiOu/Kdgw8LtXfNshKN24jhKY15hoUJzZBpyryHcX1sVUA==
From: Alex Elder <elder@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] remoteproc: Rename subdev functions to start/stop
Date: Tue, 15 May 2018 15:53:41 -0500
Message-Id: <20180515205345.8090-2-elder@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515205345.8090-1-elder@linaro.org>
References: <20180515205345.8090-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

"start" and "stop" are more suitable names for how these two operations
are used, and they fit better with the upcoming introduction of two
additional operations in the struct.

[elder@linaro.org: minor comment edits]

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 30 ++++++++++++++--------------
 include/linux/remoteproc.h           | 14 ++++++-------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a9609d971f7f..5dd58e6bea88 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -774,13 +774,13 @@ static int rproc_handle_resources(struct rproc *rproc,
 	return ret;
 }
 
-static int rproc_probe_subdevices(struct rproc *rproc)
+static int rproc_start_subdevices(struct rproc *rproc)
 {
 	struct rproc_subdev *subdev;
 	int ret;
 
 	list_for_each_entry(subdev, &rproc->subdevs, node) {
-		ret = subdev->probe(subdev);
+		ret = subdev->start(subdev);
 		if (ret)
 			goto unroll_registration;
 	}
@@ -789,17 +789,17 @@ static int rproc_probe_subdevices(struct rproc *rproc)
 
 unroll_registration:
 	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node)
-		subdev->remove(subdev, true);
+		subdev->stop(subdev, true);
 
 	return ret;
 }
 
-static void rproc_remove_subdevices(struct rproc *rproc, bool crashed)
+static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
 {
 	struct rproc_subdev *subdev;
 
 	list_for_each_entry_reverse(subdev, &rproc->subdevs, node)
-		subdev->remove(subdev, crashed);
+		subdev->stop(subdev, crashed);
 }
 
 /**
@@ -901,8 +901,8 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 		return ret;
 	}
 
-	/* probe any subdevices for the remote processor */
-	ret = rproc_probe_subdevices(rproc);
+	/* Start any subdevices for the remote processor */
+	ret = rproc_start_subdevices(rproc);
 	if (ret) {
 		dev_err(dev, "failed to probe subdevices for %s: %d\n",
 			rproc->name, ret);
@@ -1014,8 +1014,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	struct device *dev = &rproc->dev;
 	int ret;
 
-	/* remove any subdevices for the remote processor */
-	rproc_remove_subdevices(rproc, crashed);
+	/* Stop any subdevices for the remote processor */
+	rproc_stop_subdevices(rproc, crashed);
 
 	/* the installed resource table is no longer accessible */
 	rproc->table_ptr = rproc->cached_table;
@@ -1657,16 +1657,16 @@ EXPORT_SYMBOL(rproc_del);
  * rproc_add_subdev() - add a subdevice to a remoteproc
  * @rproc: rproc handle to add the subdevice to
  * @subdev: subdev handle to register
- * @probe: function to call when the rproc boots
- * @remove: function to call when the rproc shuts down
+ * @start: function to call after the rproc is started
+ * @stop: function to call before the rproc is stopped
  */
 void rproc_add_subdev(struct rproc *rproc,
 		      struct rproc_subdev *subdev,
-		      int (*probe)(struct rproc_subdev *subdev),
-		      void (*remove)(struct rproc_subdev *subdev, bool crashed))
+		      int (*start)(struct rproc_subdev *subdev),
+		      void (*stop)(struct rproc_subdev *subdev, bool crashed))
 {
-	subdev->probe = probe;
-	subdev->remove = remove;
+	subdev->start = start;
+	subdev->stop = stop;
 
 	list_add_tail(&subdev->node, &rproc->subdevs);
 }
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index dfdaede9139e..bf55bf2a5ee1 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -477,15 +477,15 @@ struct rproc {
 /**
  * struct rproc_subdev - subdevice tied to a remoteproc
  * @node: list node related to the rproc subdevs list
- * @probe: probe function, called as the rproc is started
- * @remove: remove function, called as the rproc is being stopped, the @crashed
- *	    parameter indicates if this originates from the a recovery
+ * @start: start function, called after the rproc has been started
+ * @stop: stop function, called before the rproc is stopped; the @crashed
+ *	    parameter indicates if this originates from a recovery
  */
 struct rproc_subdev {
 	struct list_head node;
 
-	int (*probe)(struct rproc_subdev *subdev);
-	void (*remove)(struct rproc_subdev *subdev, bool crashed);
+	int (*start)(struct rproc_subdev *subdev);
+	void (*stop)(struct rproc_subdev *subdev, bool crashed);
 };
 
 /* we currently support only two vrings per rvdev */
@@ -568,8 +568,8 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
 
 void rproc_add_subdev(struct rproc *rproc,
 		      struct rproc_subdev *subdev,
-		      int (*probe)(struct rproc_subdev *subdev),
-		      void (*remove)(struct rproc_subdev *subdev, bool crashed));
+		      int (*start)(struct rproc_subdev *subdev),
+		      void (*stop)(struct rproc_subdev *subdev, bool crashed));
 
 void rproc_remove_subdev(struct rproc *rproc, struct rproc_subdev *subdev);
 
-- 
2.17.0

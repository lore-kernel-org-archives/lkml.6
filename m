Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeEOUyT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:54:19 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34370 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeEOUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:54:00 -0400
X-Google-Smtp-Source: AB8JxZqYD77SbqDtfGnqphCJ7kJsQzIR6KXCK9IWjjWeSk2G1aQ16zgHlv1vPTopvEKrWNi1HBK59Q==
From: Alex Elder <elder@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] remoteproc: Introduce prepare and unprepare for subdevices
Date: Tue, 15 May 2018 15:53:45 -0500
Message-Id: <20180515205345.8090-6-elder@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515205345.8090-1-elder@linaro.org>
References: <20180515205345.8090-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

On rare occasions a subdevice might need to prepare some hardware
resources before a remote processor is booted, and clean up some
state after it has been shut down.

One such example is the IP Accelerator found in various Qualcomm
platforms, which is accessed directly from both the modem remoteproc
and the application subsystem and requires an intricate lockstep
process when bringing the modem up and down.

[elder@linaro.org: minor description and comment edits]

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 56 ++++++++++++++++++++++++++--
 include/linux/remoteproc.h           |  4 ++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 2ede7ae6f5bc..283b258f5e0f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -776,6 +776,30 @@ static int rproc_handle_resources(struct rproc *rproc,
 	return ret;
 }
 
+static int rproc_prepare_subdevices(struct rproc *rproc)
+{
+	struct rproc_subdev *subdev;
+	int ret;
+
+	list_for_each_entry(subdev, &rproc->subdevs, node) {
+		if (subdev->prepare) {
+			ret = subdev->prepare(subdev);
+			if (ret)
+				goto unroll_preparation;
+		}
+	}
+
+	return 0;
+
+unroll_preparation:
+	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->unprepare)
+			subdev->unprepare(subdev);
+	}
+
+	return ret;
+}
+
 static int rproc_start_subdevices(struct rproc *rproc)
 {
 	struct rproc_subdev *subdev;
@@ -810,6 +834,16 @@ static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
 	}
 }
 
+static void rproc_unprepare_subdevices(struct rproc *rproc)
+{
+	struct rproc_subdev *subdev;
+
+	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->unprepare)
+			subdev->unprepare(subdev);
+	}
+}
+
 /**
  * rproc_coredump_cleanup() - clean up dump_segments list
  * @rproc: the remote processor handle
@@ -902,11 +936,18 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 		rproc->table_ptr = loaded_table;
 	}
 
+	ret = rproc_prepare_subdevices(rproc);
+	if (ret) {
+		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
+			rproc->name, ret);
+		return ret;
+	}
+
 	/* power up the remote processor */
 	ret = rproc->ops->start(rproc);
 	if (ret) {
 		dev_err(dev, "can't start rproc %s: %d\n", rproc->name, ret);
-		return ret;
+		goto unprepare_subdevices;
 	}
 
 	/* Start any subdevices for the remote processor */
@@ -914,8 +955,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	if (ret) {
 		dev_err(dev, "failed to probe subdevices for %s: %d\n",
 			rproc->name, ret);
-		rproc->ops->stop(rproc);
-		return ret;
+		goto stop_rproc;
 	}
 
 	rproc->state = RPROC_RUNNING;
@@ -923,6 +963,14 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	dev_info(dev, "remote processor %s is now up\n", rproc->name);
 
 	return 0;
+
+stop_rproc:
+	rproc->ops->stop(rproc);
+
+unprepare_subdevices:
+	rproc_unprepare_subdevices(rproc);
+
+	return ret;
 }
 
 /*
@@ -1035,6 +1083,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 		return ret;
 	}
 
+	rproc_unprepare_subdevices(rproc);
+
 	rproc->state = RPROC_OFFLINE;
 
 	dev_info(dev, "stopped remote processor %s\n", rproc->name);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 8f1426330cca..e3c5d856b6da 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -477,15 +477,19 @@ struct rproc {
 /**
  * struct rproc_subdev - subdevice tied to a remoteproc
  * @node: list node related to the rproc subdevs list
+ * @prepare: prepare function, called before the rproc is started
  * @start: start function, called after the rproc has been started
  * @stop: stop function, called before the rproc is stopped; the @crashed
  *	    parameter indicates if this originates from a recovery
+ * @unprepare: unprepare function, called after the rproc has been stopped
  */
 struct rproc_subdev {
 	struct list_head node;
 
+	int (*prepare)(struct rproc_subdev *subdev);
 	int (*start)(struct rproc_subdev *subdev);
 	void (*stop)(struct rproc_subdev *subdev, bool crashed);
+	void (*unprepare)(struct rproc_subdev *subdev);
 };
 
 /* we currently support only two vrings per rvdev */
-- 
2.17.0

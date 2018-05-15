Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeEOUyB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:54:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38933 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeEOUx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:53:56 -0400
X-Google-Smtp-Source: AB8JxZoWuHeiBLSEE+8RPnGidI1F5dAjNwYSe2bsRWuWtiX6sN9EfyGJX1/hf1tQ1QALS46w7gcFdA==
From: Alex Elder <elder@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] remoteproc: Make start and stop in subdev optional
Date: Tue, 15 May 2018 15:53:42 -0500
Message-Id: <20180515205345.8090-3-elder@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515205345.8090-1-elder@linaro.org>
References: <20180515205345.8090-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Some subdevices, such as glink ssr only care about the stop operation,
so make the operations optional to reduce client code.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5dd58e6bea88..981ae6dff145 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -780,16 +780,20 @@ static int rproc_start_subdevices(struct rproc *rproc)
 	int ret;
 
 	list_for_each_entry(subdev, &rproc->subdevs, node) {
-		ret = subdev->start(subdev);
-		if (ret)
-			goto unroll_registration;
+		if (subdev->start) {
+			ret = subdev->start(subdev);
+			if (ret)
+				goto unroll_registration;
+		}
 	}
 
 	return 0;
 
 unroll_registration:
-	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node)
-		subdev->stop(subdev, true);
+	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->stop)
+			subdev->stop(subdev, true);
+	}
 
 	return ret;
 }
@@ -798,8 +802,10 @@ static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
 {
 	struct rproc_subdev *subdev;
 
-	list_for_each_entry_reverse(subdev, &rproc->subdevs, node)
-		subdev->stop(subdev, crashed);
+	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->stop)
+			subdev->stop(subdev, crashed);
+	}
 }
 
 /**
-- 
2.17.0

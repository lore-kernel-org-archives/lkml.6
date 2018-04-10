Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeDJI6K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:58:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14026 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751504AbeDJI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:58:08 -0400
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH] remoteproc: fix crashed parameter logic on stop call.
Date: Tue, 10 Apr 2018 10:57:25 +0200
Message-ID: <1523350645-19073-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.162]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix rproc_add_subdev parameter name and inverse the crashed logic.

Fixes: "remoteproc: Pass type of shutdown to subdev remove"

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++--
 include/linux/remoteproc.h           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 6d9c583..a9609d9 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1163,7 +1163,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
 	if (ret)
 		return ret;
 
-	ret = rproc_stop(rproc, false);
+	ret = rproc_stop(rproc, true);
 	if (ret)
 		goto unlock_mutex;
 
@@ -1316,7 +1316,7 @@ void rproc_shutdown(struct rproc *rproc)
 	if (!atomic_dec_and_test(&rproc->power))
 		goto out;
 
-	ret = rproc_stop(rproc, true);
+	ret = rproc_stop(rproc, false);
 	if (ret) {
 		atomic_inc(&rproc->power);
 		goto out;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index d09a9c7..dfdaede9 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -569,7 +569,7 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
 void rproc_add_subdev(struct rproc *rproc,
 		      struct rproc_subdev *subdev,
 		      int (*probe)(struct rproc_subdev *subdev),
-		      void (*remove)(struct rproc_subdev *subdev, bool graceful));
+		      void (*remove)(struct rproc_subdev *subdev, bool crashed));
 
 void rproc_remove_subdev(struct rproc *rproc, struct rproc_subdev *subdev);
 
-- 
2.7.4

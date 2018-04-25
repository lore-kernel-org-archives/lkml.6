Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeDYNgx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:36:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40067 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeDYNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:36:50 -0400
X-Google-Smtp-Source: AB8JxZoP0gOD1MnVTQwdNtKejYeQV5HSOuskjnSA8Gx9i1MbfqUi8/noOhLAVbdHcNwvQ/u7jxEk0Q==
From: Alex Elder <elder@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: rename "crashed" parameter
Date: Wed, 25 Apr 2018 08:36:26 -0500
Message-Id: <20180425133626.11781-1-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last commit to "remoteproc_core.c":
  880f5b388252 remoteproc: Pass type of shutdown to subdev remove
added a Boolean flag to the subdevice remove method, to distinguish
between graceful shutdown and a crash.  Unfortunately, the names of
the parameters were inconsistent, and in fact have opposite meanings.

In most cases, the parameter is named "crashed", but rproc_add_subdev()
names the parameter "graceful" in the prototype for the remove method.

The remove method is ultimately called (and supplied with the Boolean
flag value) by rproc_remove_subdevices().  That is only called by
rproc_stop(), and in the two spots where that is used, "graceful" is
the right name for the flag:
  rproc_shutdown() passes true, indicating a graceful shutdown
  rproc_trigger_recovery() passes false, indicating a crash

The fix is to make the parameter name consistent, and making the
name and sense of the parameter to always be "crashed" produces the
smallest change.  So that's what this patch does.

To verify this change, rproc_add_subdev() is called in five spots:
  - qcom_add_glink_subdev() passes glink_subdev_remove()
  - qcom_add_smd_subdev() passes smd_subdev_remove()
  - qcom_add_ssr_subdev() passes ssr_notify_stop()
  - qcom_add_sysmon_subdev() passes sysmon_stop()
  - rproc_handle_vdev() passes rproc_vdev_do_remove()

Of these, only sysmon_stop() uses its "crashed" parameter.  And it
clearly assumes that "crashed" is the intended meaning:

        /* Don't request graceful shutdown if we've crashed */
        if (crashed)
                return;

So this function (added after the "crashed" parameter was added)
exhibited buggy behavior, which is now fixed by this patch.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++--
 include/linux/remoteproc.h           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 6d9c5832ce47..a9609d971f7f 100644
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
index d09a9c7af109..dfdaede9139e 100644
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
2.14.1

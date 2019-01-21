Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D362CC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44521019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfAUNzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:51 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35595 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731758AbfAUNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:49 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LDtcR0026548;
        Mon, 21 Jan 2019 14:55:43 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2q3wv3k3kn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 21 Jan 2019 14:55:43 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F98538;
        Mon, 21 Jan 2019 13:55:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B8BD2B45;
        Mon, 21 Jan 2019 13:55:43 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 21 Jan
 2019 14:55:43 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 21 Jan 2019 14:55:42
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, <xiaoxiang781216@gmail.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 1/1] remoteproc: fix recovery procedure
Date:   Mon, 21 Jan 2019 14:55:15 +0100
Message-ID: <1548078915-4437-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7e83cab824a87e83cab824a8 ("remoteproc: Modify recovery path
to use rproc_{start,stop}()") replaces rproc_{shutdown,boot}() with
rproc_{stop,start}(), which skips destroy the virtio device at stop
but re-initializes it again at start.

Issue is that struct virtio_dev is not correctly reinitialized like done
at initial allocation thanks to kzalloc() and kobject is considered as
already initialized by kernel. That is due to the fact struct virtio_dev
is allocated and released at vdev resource handling level managed and
virtio device is registered and unregistered at rproc subdevices level.

Moreover kernel documentation mentions that device struct must be
zero initialized before calling device_initialize().

This patch disentangles struct virtio_dev from struct rproc_vdev as
the two struct don't have the same life-cycle.

struct virtio_dev is now allocated on rproc_start() and released
on rproc_stop().

This patch applies on top of patch
remoteproc: create vdev subdevice with specific dma memory pool [1]

[1]: https://patchwork.kernel.org/patch/10755781/

Fixes: 7e83cab824a8 ("remoteproc: Modify recovery path to use rproc_{start,stop}()")

Reported-by: Xiang Xiao <xiaoxiang781216@gmail.com>
Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

---
Changes from V1:
- Remove memset of a specific part of vdev
- Disentangle struct virtio_dev from struc rproc_dev which have
  different life-cycles
- Update commit header according to new implementation
---
 drivers/remoteproc/remoteproc_core.c     |  5 ++++-
 drivers/remoteproc/remoteproc_internal.h |  2 +-
 drivers/remoteproc/remoteproc_virtio.c   | 20 ++++++++++++++++----
 include/linux/remoteproc.h               |  3 +--
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 821dbedef18e..454a601d63c9 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -421,8 +421,11 @@ static int rproc_vdev_do_start(struct rproc_subdev *subdev)
 static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
+	int ret;
 
-	rproc_remove_virtio_dev(rvdev);
+	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
+	if (ret)
+		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
 }
 
 /**
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index bfeacfd40947..2698775c5005 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -32,7 +32,7 @@ void rproc_vdev_release(struct kref *ref);
 
 /* from remoteproc_virtio.c */
 int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
-void rproc_remove_virtio_dev(struct rproc_vdev *rvdev);
+int rproc_remove_virtio_dev(struct device *dev, void *data);
 
 /* from remoteproc_debugfs.c */
 void rproc_remove_trace_file(struct dentry *tfile);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d08b2cfd875b..b7a987d1b962 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -313,6 +313,8 @@ static void rproc_virtio_dev_release(struct device *dev)
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct rproc *rproc = vdev_to_rproc(vdev);
 
+	kfree(vdev);
+
 	kref_put(&rvdev->refcount, rproc_vdev_release);
 
 	put_device(&rproc->dev);
@@ -331,7 +333,7 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 {
 	struct rproc *rproc = rvdev->rproc;
 	struct device *dev = &rvdev->dev;
-	struct virtio_device *vdev = &rvdev->vdev;
+	struct virtio_device *vdev;
 	struct rproc_mem_entry *mem;
 	int ret;
 
@@ -372,6 +374,12 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 		}
 	}
 
+	/* Allocate virtio device */
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	vdev->id.device	= id,
 	vdev->config = &rproc_virtio_config_ops,
 	vdev->dev.parent = dev;
@@ -405,11 +413,15 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 
 /**
  * rproc_remove_virtio_dev() - remove an rproc-induced virtio device
- * @rvdev: the remote vdev
+ * @dev: the virtio device
+ * @data: must be null
  *
  * This function unregisters an existing virtio device.
  */
-void rproc_remove_virtio_dev(struct rproc_vdev *rvdev)
+int rproc_remove_virtio_dev(struct device *dev, void *data)
 {
-	unregister_virtio_device(&rvdev->vdev);
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	unregister_virtio_device(vdev);
+	return 0;
 }
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index beecd8cf2eb5..1ec66f7519f5 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -559,7 +559,6 @@ struct rproc_vdev {
 	unsigned int id;
 	struct list_head node;
 	struct rproc *rproc;
-	struct virtio_device vdev;
 	struct rproc_vring vring[RVDEV_NUM_VRINGS];
 	u32 rsc_offset;
 	u32 index;
@@ -602,7 +601,7 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
 
 static inline struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
-	return container_of(vdev, struct rproc_vdev, vdev);
+	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
 }
 
 static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
-- 
2.7.4


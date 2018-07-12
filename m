Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF054213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF054213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeGLOVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:21:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:62688 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732506AbeGLOVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:21:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 07:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="57137159"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2018 07:11:12 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/3] mei: fix ssize_t to int assignment in read and write ops.
Date:   Thu, 12 Jul 2018 17:10:10 +0300
Message-Id: <20180712141010.11277-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180712141010.11277-1-tomas.winkler@intel.com>
References: <20180712141010.11277-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ssize_t for rets variables in mei_write(), mei_read(), and
mei_cl_write() as well as change the return type of mei_cl_write()
to ssize_t, to prevent assignment of possible 64bit size_t
to int 32 bit variable.

As by product also eliminate warning
drivers/misc/mei/client.c:1702:11: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 22 +++++++++++-----------
 drivers/misc/mei/client.h |  2 +-
 drivers/misc/mei/main.c   | 10 +++++-----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index f8fb7589192e..5a673d09585f 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1644,13 +1644,13 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
  *
  * Return: number of bytes sent on success, <0 on failure.
  */
-int mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
+ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 {
 	struct mei_device *dev;
 	struct mei_msg_data *buf;
 	struct mei_msg_hdr mei_hdr;
-	int size;
-	int rets;
+	size_t len;
+	ssize_t rets;
 	bool blocking;
 
 	if (WARN_ON(!cl || !cl->dev))
@@ -1662,15 +1662,15 @@ int mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	dev = cl->dev;
 
 	buf = &cb->buf;
-	size = buf->size;
+	len = buf->size;
 	blocking = cb->blocking;
 
-	cl_dbg(dev, cl, "size=%d\n", size);
+	cl_dbg(dev, cl, "len=%zd\n", len);
 
 	rets = pm_runtime_get(dev->dev);
 	if (rets < 0 && rets != -EINPROGRESS) {
 		pm_runtime_put_noidle(dev->dev);
-		cl_err(dev, cl, "rpm: get failed %d\n", rets);
+		cl_err(dev, cl, "rpm: get failed %zd\n", rets);
 		goto free;
 	}
 
@@ -1689,21 +1689,21 @@ int mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	if (rets == 0) {
 		cl_dbg(dev, cl, "No flow control credentials: not sending.\n");
-		rets = size;
+		rets = len;
 		goto out;
 	}
 	if (!mei_hbuf_acquire(dev)) {
 		cl_dbg(dev, cl, "Cannot acquire the host buffer: not sending.\n");
-		rets = size;
+		rets = len;
 		goto out;
 	}
 
 	/* Check for a maximum length */
-	if (size > mei_hbuf_max_len(dev)) {
+	if (len > mei_hbuf_max_len(dev)) {
 		mei_hdr.length = mei_hbuf_max_len(dev);
 		mei_hdr.msg_complete = 0;
 	} else {
-		mei_hdr.length = size;
+		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
 	}
 
@@ -1745,7 +1745,7 @@ int mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		}
 	}
 
-	rets = size;
+	rets = len;
 err:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 5371df4d8af3..64e318f589b4 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -202,7 +202,7 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 int mei_cl_irq_connect(struct mei_cl *cl, struct mei_cl_cb *cb,
 		       struct list_head *cmpl_list);
 int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp);
-int mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb);
+ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb);
 int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 		     struct list_head *cmpl_list);
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 302ba7a63bd2..4d77a6ae183a 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -137,7 +137,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 	struct mei_device *dev;
 	struct mei_cl_cb *cb = NULL;
 	bool nonblock = !!(file->f_flags & O_NONBLOCK);
-	int rets;
+	ssize_t rets;
 
 	if (WARN_ON(!cl || !cl->dev))
 		return -ENODEV;
@@ -170,7 +170,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 
 	rets = mei_cl_read_start(cl, length, file);
 	if (rets && rets != -EBUSY) {
-		cl_dbg(dev, cl, "mei start read failure status = %d\n", rets);
+		cl_dbg(dev, cl, "mei start read failure status = %zd\n", rets);
 		goto out;
 	}
 
@@ -204,7 +204,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 	/* now copy the data to user space */
 	if (cb->status) {
 		rets = cb->status;
-		cl_dbg(dev, cl, "read operation failed %d\n", rets);
+		cl_dbg(dev, cl, "read operation failed %zd\n", rets);
 		goto free;
 	}
 
@@ -236,7 +236,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 	*offset = 0;
 
 out:
-	cl_dbg(dev, cl, "end mei read rets = %d\n", rets);
+	cl_dbg(dev, cl, "end mei read rets = %zd\n", rets);
 	mutex_unlock(&dev->device_lock);
 	return rets;
 }
@@ -256,7 +256,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	struct mei_cl *cl = file->private_data;
 	struct mei_cl_cb *cb;
 	struct mei_device *dev;
-	int rets;
+	ssize_t rets;
 
 	if (WARN_ON(!cl || !cl->dev))
 		return -ENODEV;
-- 
2.14.4


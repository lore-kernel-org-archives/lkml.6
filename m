Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8DBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9EB263F2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/LFOPtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9EB263F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935392AbeFZBfN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:35:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55539 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935055AbeFZBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:34:14 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so15278095itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=At01+zlppAHzv2kYNufv49tmZevIJdLwkZ64Y6dFay8=;
        b=j/LFOPtU8DO+umrMStbSSiJJyGGkMv8gTUlqLY2mq5CUHX9yfxJ4FrOvlZ0fJFrrHZ
         cym8K1fkEXi0kho12D0kxRm0+ULifCwOPBDBP0HJ+J0WUy6SdjCF4bVgxZ/iqbm2zG9b
         x22qod9rdXQqvhEMWcJ0PLT0Nb0qOxGp3LSIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=At01+zlppAHzv2kYNufv49tmZevIJdLwkZ64Y6dFay8=;
        b=ffqnEgDYXko405qfWZy3w5OWN4Xydz7m2INoLjc9yhgDL1+PFFRHWX7u98bOs9+Lhj
         7apvqlIr+xqoW/VgpsF54+PBZmD4/9lPwTvjvfr42NKzmtNVKnNZLKm1LQdiFahnOq4Q
         zsBEJ9nbNB9LJvrUOPQwSHguU7Yk4CiRVUrIpL3vdwh85pYGxyTxN1+IusZcm3VuViRv
         ziZFTVuJJJA5FpJrKiVWxELJPGIFSyMwd+PSlUV7wi7CWzyjOuGAuT0PNDxI+lKHt8HW
         cobGUwfZJhfp/0JewSSjE10tcAcTkpDHCyzrEBhsCM8gPoOP1skwELQOPfH/Xqgs032p
         GVjQ==
X-Gm-Message-State: APt69E2Q9Wwy4Cqonbqo+dda0b8bf0LeLJWdvq3Odcu+zfzaY1dxE4EQ
        2Hhd4DDC41tHWZGn+/M0s+qupA==
X-Google-Smtp-Source: ADUXVKIaPbZ2kONVZpbnKYsfo/snyrWAafYunW8QHCBx8pINSZxnhUpA/bfq4F9k0cOsBVm4mDW85Q==
X-Received: by 2002:a02:105:: with SMTP id c5-v6mr3912816jad.139.1529976853301;
        Mon, 25 Jun 2018 18:34:13 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id h62-v6sm184699ioa.22.2018.06.25.18.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 18:34:12 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 1/5] remoteproc: Rename subdev functions to start/stop
Date:   Mon, 25 Jun 2018 20:34:05 -0500
Message-Id: <20180626013409.5125-2-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626013409.5125-1-elder@linaro.org>
References: <20180626013409.5125-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

"start" and "stop" are more suitable names for how these two operations
are used, and they fit better with the upcoming introduction of two
additional operations in the struct.

[elder@linaro.org: minor comment edits]

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alex Elder <elder@linaro.org>
Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
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
2.17.1


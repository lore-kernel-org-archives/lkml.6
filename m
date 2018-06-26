Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56079C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B5826A4A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvwOA5v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B5826A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935324AbeFZMMQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:12:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36533 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935251AbeFZMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:12:11 -0400
Received: by mail-io0-f194.google.com with SMTP id k3-v6so15758533iog.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KUWr3sUam7AxtX0IcmLHuD9btenxzAh1xvCRgQlImR0=;
        b=fvwOA5v8tpw0xv0m35CcoOsJWbPOnvkn1SCUOX4abcUGDAMYuGm2ZE3CK+R8ayXMrF
         V8xaTHYtThBspjtLcMHb58wjnRGwbzWJkjZuqZRXXZ2a1iDn9xzGvqW9iVL9HiTkC8m/
         CWCniReO3bTFntgEID4TEXsjaAK8VS1RYHR2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KUWr3sUam7AxtX0IcmLHuD9btenxzAh1xvCRgQlImR0=;
        b=RTY+/guiN4kqYz9UkTDk8//KxIvF6RptiSZgAzEjAidLonNXNBHFfPo0hHVvXB+Jfe
         izD6sDP6a4YcSqKT5bR404W1odB69DLATvedXcboalaukYjZ+ryz7oSUe9u0Gi5cvwZA
         4Hc6SOoj0wG9+krP/sqsm1rbDxoS2XweaAriLiGEmEcqzmIsi0lY/jAnHsZwDd0gKHq3
         Wja4Ptp87RqCG6OBCOcVb1IrK/CpbdXNCPV0Kfdq/Mw1QKEc0OyPDbntvePWJ9tBP9ew
         gmWEtVneIe3NQKFLU3gFtsnOkB70eXrOALyO6t+Sp7hJicThtm+u0YaPvU/oeY+EkaqL
         8Taw==
X-Gm-Message-State: APt69E0iDkAKfpUT/GSnaatgwrhSPwwDIrH4mXyKlhGlL2gKb18DG8UC
        /V3ByYjEm8wG7wMh99lzydSxeg==
X-Google-Smtp-Source: AAOMgpd+KMejISB7fnlJ8Ttc8d5yueWdfc/2P0sgnOU+VEmEMi2j+g0tEKvoLeqS6M09PT1tSp8x1g==
X-Received: by 2002:a6b:bd43:: with SMTP id n64-v6mr1041947iof.254.1530015130282;
        Tue, 26 Jun 2018 05:12:10 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id y62-v6sm902309ioy.88.2018.06.26.05.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:12:09 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] remoteproc: Rename subdev functions to start/stop
Date:   Tue, 26 Jun 2018 07:11:55 -0500
Message-Id: <20180626121159.7267-2-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626121159.7267-1-elder@linaro.org>
References: <20180626121159.7267-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

"start" and "stop" are more suitable names for how these two operations
are used, and they fit better with the upcoming introduction of two
additional operations in the struct.

Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[elder@linaro.org: minor comment edits]
Signed-off-by Alex Elder <elder@linaro.org>
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


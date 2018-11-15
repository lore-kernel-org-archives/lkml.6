Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A72C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9B32146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVyirmtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9B32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeKPFAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:00:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40382 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeKPFAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:00:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so13170355wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVVVJRDtxWCbkosUADu0QKnN/SDpjii7tg+i5cBf3Lk=;
        b=WVyirmtlchID+UnXV5f+lxKXJnx3fxBoyq5vdwsOpDucEkBZwZKk9mUAR8G+TbEHVy
         nFAClMmedwSfhn0rNvwCCFiWIWgPYZSVl27NAzehwoK8/+Npu+IXHPTNUIMd6tW6ZH62
         i8XpBJJyTnN+gfsiGKEfx+Kc5Lb/TYnCibN38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVVVJRDtxWCbkosUADu0QKnN/SDpjii7tg+i5cBf3Lk=;
        b=DYS0qEY9UAWs2IH7jee/nNIwBqkl1Q23tjOVznIQX1le4HopMeg/jWOlZq+KaS3UOm
         gHLAw5g+bIWSpiwfTOIgdmCyWe1Tk438A/06I2VawFXzI3yj7yvoLIPsUoIi2DjOLhEA
         nmtb+0XnbqO8DCsJftEDxmVnIXXVK5ygocY0eJSLuuT2f/WJDkD4ZZccXsZq1ehdAe+O
         E4d2PIClk8r1tULBRvVFq18WHiwhBeOltOpuNMCvsNNrwUV+hpzLCRHUlbV0nUuCgTTC
         5o5+4KSMIL2ZtWYkszREQBkNpKezGFhtcqTHRYbjuFbjeaVZrV9WN1yMw6UKEoY63EOO
         /Ubg==
X-Gm-Message-State: AA+aEWbWHl4zUg0k8iPRVTwEqvcIy13kA7Fn15UXbkJQnn/gyu+/H20B
        qE4+5K4hzauSGM8xauXa3+3YQQ==
X-Google-Smtp-Source: AFSGD/WWCEPe++diLiCS2wV4k/enEqliF2oiw0QoV5KqjlhP/12lqKbCi1Vj/bmqnmGosYa/u2wm1w==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr268596wrr.97.1542307878468;
        Thu, 15 Nov 2018 10:51:18 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id y138sm16529481wmc.16.2018.11.15.10.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 10:51:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] qcom: apr: Make apr callbacks in non-atomic context
Date:   Thu, 15 Nov 2018 18:49:04 +0000
Message-Id: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APR communication with DSP is not atomic in nature.
Its request-response type. Trying to pretend that these are atomic
and invoking apr client callbacks directly under atomic/irq context has
endless issues with soundcard. It makes more sense to convert these
to nonatomic calls. This also coverts all the dais to be nonatomic.

All the callbacks are now invoked as part of rx work queue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soc/qcom/apr.c | 74 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 74f8b9607daa..8cfa825fce81 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <linux/of_device.h>
 #include <linux/soc/qcom/apr.h>
 #include <linux/rpmsg.h>
@@ -17,8 +18,18 @@ struct apr {
 	struct rpmsg_endpoint *ch;
 	struct device *dev;
 	spinlock_t svcs_lock;
+	spinlock_t rx_lock;
 	struct idr svcs_idr;
 	int dest_domain_id;
+	struct workqueue_struct *rxwq;
+	struct work_struct rx_work;
+	struct list_head rx_list;
+};
+
+struct apr_rx_buf {
+	struct list_head node;
+	int len;
+	uint8_t buf[];
 };
 
 /**
@@ -62,11 +73,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 				  int len, void *priv, u32 addr)
 {
 	struct apr *apr = dev_get_drvdata(&rpdev->dev);
-	uint16_t hdr_size, msg_type, ver, svc_id;
-	struct apr_device *svc = NULL;
-	struct apr_driver *adrv = NULL;
-	struct apr_resp_pkt resp;
-	struct apr_hdr *hdr;
+	struct apr_rx_buf *abuf;
 	unsigned long flags;
 
 	if (len <= APR_HDR_SIZE) {
@@ -75,6 +82,34 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 		return -EINVAL;
 	}
 
+	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
+	if (!abuf)
+		return -ENOMEM;
+
+	abuf->len = len;
+	memcpy(abuf->buf, buf, len);
+
+	spin_lock_irqsave(&apr->rx_lock, flags);
+	list_add_tail(&abuf->node, &apr->rx_list);
+	spin_unlock_irqrestore(&apr->rx_lock, flags);
+
+	queue_work(apr->rxwq, &apr->rx_work);
+
+	return 0;
+}
+
+
+static int apr_do_rx_callback(struct apr *apr, struct apr_rx_buf *abuf)
+{
+	uint16_t hdr_size, msg_type, ver, svc_id;
+	struct apr_device *svc = NULL;
+	struct apr_driver *adrv = NULL;
+	struct apr_resp_pkt resp;
+	struct apr_hdr *hdr;
+	unsigned long flags;
+	void *buf = abuf->buf;
+	int len = abuf->len;
+
 	hdr = buf;
 	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
 	if (ver > APR_PKT_VER + 1)
@@ -132,6 +167,23 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 	return 0;
 }
 
+static void apr_rxwq(struct work_struct *work)
+{
+	struct apr *apr = container_of(work, struct apr, rx_work);
+	struct apr_rx_buf *abuf, *b;
+	unsigned long flags;
+
+	if (!list_empty(&apr->rx_list)) {
+		list_for_each_entry_safe(abuf, b, &apr->rx_list, node) {
+			apr_do_rx_callback(apr, abuf);
+			spin_lock_irqsave(&apr->rx_lock, flags);
+			list_del(&abuf->node);
+			spin_unlock_irqrestore(&apr->rx_lock, flags);
+			kfree(abuf);
+		}
+	}
+}
+
 static int apr_device_match(struct device *dev, struct device_driver *drv)
 {
 	struct apr_device *adev = to_apr_device(dev);
@@ -285,6 +337,14 @@ static int apr_probe(struct rpmsg_device *rpdev)
 	dev_set_drvdata(dev, apr);
 	apr->ch = rpdev->ept;
 	apr->dev = dev;
+	apr->rxwq = create_singlethread_workqueue("qcom_apr_rx");
+	if (!apr->rxwq) {
+		dev_err(apr->dev, "Failed to start Rx WQ\n");
+		return -ENOMEM;
+	}
+	INIT_WORK(&apr->rx_work, apr_rxwq);
+	INIT_LIST_HEAD(&apr->rx_list);
+	spin_lock_init(&apr->rx_lock);
 	spin_lock_init(&apr->svcs_lock);
 	idr_init(&apr->svcs_idr);
 	of_register_apr_devices(dev);
@@ -303,6 +363,10 @@ static int apr_remove_device(struct device *dev, void *null)
 
 static void apr_remove(struct rpmsg_device *rpdev)
 {
+	struct apr *apr = dev_get_drvdata(&rpdev->dev);
+
+	flush_workqueue(apr->rxwq);
+	destroy_workqueue(apr->rxwq);
 	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
 }
 
-- 
2.19.1


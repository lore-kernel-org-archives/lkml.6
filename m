Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D4AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6132086D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6132086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeIDPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:55:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46196 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeIDPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:55:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so3528663wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WB1TW8MQOIIaVMO7optC93NOQh2/hSLfCLv/mRuXx44=;
        b=F5LMtBHM/iTvxMxdbgmXcDpoNJ8iAeSfXCsPGt7y3Jgl9zVLxNs50RRJ5SkTghqLQM
         vWcxW6DWZkICFoZ6dj0WjZIpSP2MuzYj2rNw12KruZQ6kHz2lVgE9IVpU3+GJQs6GCyP
         ccrK69pJoH1qu9PCCtRgYpnVA6fSP4EEduzuJAin/vyNRrryp1G0X4yd1nS2Njd9tqgO
         arfQnBI/3nSl3KME7ZiJJoF8hGrImJVRwhxoUnSnLpvrQl/ylNPgqTkHnK7/ve4g9Vyj
         hsNhBSjUDFLUY0VKQRIhd7zvMEWG01r0hx3rJ6wQJ5BzQ4i64dlM0dsb7DmKehy2s5xq
         2CcA==
X-Gm-Message-State: APzg51DD/4kzugUo7nNyLrCgPxsLJknUYYaYDmyuoDUQwpetUl17ViPt
        2bO8bxaLdBHD2tOYXJVurHbEm6Sv5qo=
X-Google-Smtp-Source: ANB0Vdbmar8GK3LUlZBYm4tyYeRy6GpHPDvYprvgxx6IQ0TQ0XBmYbPkCHo25inwAWGOJ1VgLigsZg==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr15660808wrp.202.1536060631528;
        Tue, 04 Sep 2018 04:30:31 -0700 (PDT)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id s13-v6sm22574155wrq.39.2018.09.04.04.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 04:30:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: [PATCH 2/2] media: intel-ipu3: create pad links and register subdev nodes at bound time
Date:   Tue,  4 Sep 2018 13:30:18 +0200
Message-Id: <20180904113018.14428-3-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904113018.14428-1-javierm@redhat.com>
References: <20180904113018.14428-1-javierm@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver create the pad links and registers the device nodes for bound
subdevices in the v4l2 async notififer .complete callback. But that will
prevent the media graph to be usable if for example one of the drivers
for a subdevice fails to probe.

In that case, the media entity will be registered but there will be not
pad links created nor the subdev device node will be registered.

So do these operations in the .bound callback instead of doing it at
.complete time.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 66 ++++++++----------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 29027159eced..4eb80b690e3f 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1403,6 +1403,8 @@ static int cio2_notifier_bound(struct v4l2_async_notifier *notifier,
 	struct sensor_async_subdev *s_asd = container_of(asd,
 					struct sensor_async_subdev, asd);
 	struct cio2_queue *q;
+	unsigned int pad;
+	int ret;
 
 	if (cio2->queue[s_asd->csi2.port].sensor)
 		return -EBUSY;
@@ -1413,7 +1415,26 @@ static int cio2_notifier_bound(struct v4l2_async_notifier *notifier,
 	q->sensor = sd;
 	q->csi_rx_base = cio2->base + CIO2_REG_PIPE_BASE(q->csi2.port);
 
-	return 0;
+	for (pad = 0; pad < q->sensor->entity.num_pads; pad++)
+		if (q->sensor->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE)
+			break;
+
+	if (pad == q->sensor->entity.num_pads) {
+		dev_err(&cio2->pci_dev->dev,
+			"failed to find src pad for %s\n",
+			q->sensor->name);
+		return -ENXIO;
+	}
+
+	ret = media_create_pad_link(&q->sensor->entity, pad, &q->subdev.entity,
+				    CIO2_PAD_SINK, 0);
+	if (ret) {
+		dev_err(&cio2->pci_dev->dev, "failed to create link for %s\n",
+			q->sensor->name);
+		return ret;
+	}
+
+	return v4l2_device_register_subdev_node(&cio2->v4l2_dev, sd);
 }
 
 /* The .unbind callback */
@@ -1429,52 +1450,9 @@ static void cio2_notifier_unbind(struct v4l2_async_notifier *notifier,
 	cio2->queue[s_asd->csi2.port].sensor = NULL;
 }
 
-/* .complete() is called after all subdevices have been located */
-static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
-{
-	struct cio2_device *cio2 = container_of(notifier, struct cio2_device,
-						notifier);
-	struct sensor_async_subdev *s_asd;
-	struct cio2_queue *q;
-	unsigned int i, pad;
-	int ret;
-
-	for (i = 0; i < notifier->num_subdevs; i++) {
-		s_asd = container_of(cio2->notifier.subdevs[i],
-				     struct sensor_async_subdev, asd);
-		q = &cio2->queue[s_asd->csi2.port];
-
-		for (pad = 0; pad < q->sensor->entity.num_pads; pad++)
-			if (q->sensor->entity.pads[pad].flags &
-						MEDIA_PAD_FL_SOURCE)
-				break;
-
-		if (pad == q->sensor->entity.num_pads) {
-			dev_err(&cio2->pci_dev->dev,
-				"failed to find src pad for %s\n",
-				q->sensor->name);
-			return -ENXIO;
-		}
-
-		ret = media_create_pad_link(
-				&q->sensor->entity, pad,
-				&q->subdev.entity, CIO2_PAD_SINK,
-				0);
-		if (ret) {
-			dev_err(&cio2->pci_dev->dev,
-				"failed to create link for %s\n",
-				cio2->queue[i].sensor->name);
-			return ret;
-		}
-	}
-
-	return v4l2_device_register_subdev_nodes(&cio2->v4l2_dev);
-}
-
 static const struct v4l2_async_notifier_operations cio2_async_ops = {
 	.bound = cio2_notifier_bound,
 	.unbind = cio2_notifier_unbind,
-	.complete = cio2_notifier_complete,
 };
 
 static int cio2_fwnode_parse(struct device *dev,
-- 
2.17.1


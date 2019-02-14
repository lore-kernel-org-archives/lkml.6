Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6542C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C80222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FGkq8uFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfBNBa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:30:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46870 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbfBNBa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:30:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id o6so2171006pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GsKUef20fAh07gfu78gOpr0DjYw/ko20eGV0n0JBmK0=;
        b=FGkq8uFlHwkBTIIdmp61J0sT/E2AoufEZBgiUVgOfGl1IJq1vgzHtk89MLVZ9ChNE6
         Lu6NkZrK/S4kXAEWkN82Vxp2jIQ++s43HLRESAWUipffbH/ezxz8Esato/IWUohJmugo
         3Q4S3Qg9SUuLwBTxiZm2LtORx9cS0VkAPdm7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsKUef20fAh07gfu78gOpr0DjYw/ko20eGV0n0JBmK0=;
        b=FI1XZjXsPRhVnYGaZfyKufaSx12VblVk45rPkm+JTtKKaAz3DFhYhBqCBeQZuN0csU
         cmBtHZe0pdcnkt+/eA1IfdhoA+EOYndIOgdAPtGWnueMb37nDNrLzV8Bsn5Zj/r9abEk
         PN6YlObg67eI99TWtaYSXC9L0jRjqTkA82MUx2fxJJjAW1mwUFIPOORFuqOQF0656Hqf
         OiLkAyW7YVi3o9hz7/+uZWIFLvzIvNj+nLSZhY67HBAIGWZChSH0XjU+IBttWW3KHGd0
         GwJ5EWFj3X/RREu71XM+yW3FOFt+k6yDt0ogEQNNp6Kh3oiuK9z24hh1yMdNQwAIZuvw
         25Ig==
X-Gm-Message-State: AHQUAuZ88KKUdNVtbVKCb/1zUrBDsf2AqgiJQZHA76PVnFg8SEkAC/ag
        vi3x5kkzcwY7AbyDD4haHj01WQ==
X-Google-Smtp-Source: AHgI3Iawq8vLr9FK/kXBVRcj1L9gwW2DAP72ex0uB2sqO6q1P3TxM8FsANVXz6YDF7YZ5GVK/KlsOg==
X-Received: by 2002:a17:902:7086:: with SMTP id z6mr1345620plk.125.1550107856301;
        Wed, 13 Feb 2019 17:30:56 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p64sm811072pfi.56.2019.02.13.17.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 17:30:55 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
Date:   Wed, 13 Feb 2019 17:30:41 -0800
Message-Id: <20190214013042.254790-4-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190214013042.254790-1-mka@chromium.org>
References: <20190214013042.254790-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following pattern is repeated multiple times:

- call governor event handler with DEVFREQ_GOV_START/STOP
- check return value
- in case of error log a message

Add devfreq_governor_start/stop() helper functions with this code
and call them instead.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 96 +++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7fab6c4cf719b..eb86461648d74 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -580,6 +580,53 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 	return ret;
 }
 
+/**
+ * devfreq_governor_start() - Start the devfreq governor of the device.
+ * @devfreq:	the devfreq instance
+ */
+static int devfreq_governor_start(struct devfreq *devfreq)
+{
+	struct device *dev = devfreq->dev.parent;
+	int err;
+
+	if (WARN(mutex_is_locked(&devfreq->lock),
+		 "mutex must *not* be held by the caller\n"))
+		return -EINVAL;
+
+	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
+					       NULL);
+	if (err) {
+		dev_err(dev, "Governor %s not started: %d\n",
+			devfreq->governor->name, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * devfreq_governor_stop() - Stop the devfreq governor of the device.
+ * @devfreq:	the devfreq instance
+ */
+static int devfreq_governor_stop(struct devfreq *devfreq)
+{
+	struct device *dev = devfreq->dev.parent;
+	int err;
+
+	if (WARN(mutex_is_locked(&devfreq->lock),
+		 "mutex must *not* be held by the caller\n"))
+		return -EINVAL;
+
+	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STOP, NULL);
+	if (err) {
+		dev_warn(dev, "%s: Governor %s not stopped: %d\n",
+			 devfreq->governor->name, err);
+		return err;
+	}
+
+	return 0;
+}
+
 /**
  * devfreq_dev_release() - Callback for struct device to release the device.
  * @dev:	the devfreq device
@@ -720,13 +767,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	devfreq->governor = governor;
-	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
-						NULL);
-	if (err) {
-		dev_err(dev, "%s: Unable to start governor for the device\n",
-			__func__);
+	err = devfreq_governor_start(devfreq);
+	if (err)
 		goto err_init;
-	}
 
 	list_add(&devfreq->node, &devfreq_list);
 
@@ -1029,24 +1072,13 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 				dev_warn(dev,
 					 "%s: Governor %s already present\n",
 					 __func__, devfreq->governor->name);
-				ret = devfreq->governor->event_handler(devfreq,
-							DEVFREQ_GOV_STOP, NULL);
-				if (ret) {
-					dev_warn(dev,
-						 "%s: Governor %s stop = %d\n",
-						 __func__,
-						 devfreq->governor->name, ret);
-				}
+				ret = devfreq_governor_stop(devfreq);
+
 				/* Fall through */
 			}
+
 			devfreq->governor = governor;
-			ret = devfreq->governor->event_handler(devfreq,
-						DEVFREQ_GOV_START, NULL);
-			if (ret) {
-				dev_warn(dev, "%s: Governor %s start=%d\n",
-					 __func__, devfreq->governor->name,
-					 ret);
-			}
+			devfreq_governor_start(devfreq);
 		}
 	}
 
@@ -1081,7 +1113,6 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		goto err_out;
 	}
 	list_for_each_entry(devfreq, &devfreq_list, node) {
-		int ret;
 		struct device *dev = devfreq->dev.parent;
 
 		if (!strncmp(devfreq->governor_name, governor->name,
@@ -1093,13 +1124,8 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 				continue;
 				/* Fall through */
 			}
-			ret = devfreq->governor->event_handler(devfreq,
-						DEVFREQ_GOV_STOP, NULL);
-			if (ret) {
-				dev_warn(dev, "%s: Governor %s stop=%d\n",
-					 __func__, devfreq->governor->name,
-					 ret);
-			}
+
+			devfreq_governor_stop(devfreq);
 			devfreq->governor = NULL;
 		}
 	}
@@ -1149,19 +1175,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	if (df->governor) {
-		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
-		if (ret) {
-			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-				 __func__, df->governor->name, ret);
+		ret = devfreq_governor_stop(df);
+		if (ret)
 			goto out;
-		}
 	}
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
-	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-	if (ret)
-		dev_warn(dev, "%s: Governor %s not started(%d)\n",
-			 __func__, df->governor->name, ret);
+	ret = devfreq_governor_start(df);
 out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
2.20.1.791.gb4d0f1c61a-goog


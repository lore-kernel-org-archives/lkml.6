Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07CCC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8CD21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="D+XgDzTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfAXGe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:34:57 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:48660 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfAXGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kho+gD1EsdrQf5jWVJBtKgxpUrWxq0DUaYFuyaIqJGE=; b=D+XgDzTeTs2PvrOqB34MeQPJR
        rk3M0nTixm4ZCcRDiit3/+ddEV8icfR6pTU0h/hvQa6xe005/lVuWa8WWuBq4tHByhyCnY3QA/bMN
        H7oM5H+l2thrury3Uuy0XkrfTGn2piiyhIMthDVnp9hqqkJRojITXQ9XeYeoOVQeTcoaQ=;
Received: from [77.247.85.78] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYbB-0000vI-8Y; Thu, 24 Jan 2019 07:34:49 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb5-0007rN-Hi; Thu, 24 Jan 2019 07:34:43 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 1/5] gnss: sirf: write data to gnss only when the gnss device is open
Date:   Thu, 24 Jan 2019 07:34:35 +0100
Message-Id: <20190124063439.29897-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190124063439.29897-1-andreas@kemnade.info>
References: <20190124063439.29897-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The api forbids writing data there otherwise. Prepare for the
serdev_open()/close() being a part of sirf_set_active.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
No changes in v4
Changes in v3:
 - add more locking
 - style cleanup 
 - mutex *not* renamed since we need a second one

Changes in v2:
 - add locking

 drivers/gnss/sirf.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 59cde7e923b8..49bc021325e9 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -35,6 +35,10 @@ struct sirf_data {
 	struct gpio_desc *wakeup;
 	int irq;
 	bool active;
+
+	struct mutex gdev_mutex;
+	bool open;
+
 	wait_queue_head_t power_wait;
 };
 
@@ -44,9 +48,18 @@ static int sirf_open(struct gnss_device *gdev)
 	struct serdev_device *serdev = data->serdev;
 	int ret;
 
+	mutex_lock(&data->gdev_mutex);
+	data->open = true;
+	mutex_unlock(&data->gdev_mutex);
+
 	ret = serdev_device_open(serdev);
-	if (ret)
+	if (ret) {
+		mutex_lock(&data->gdev_mutex);
+		data->open = false;
+		mutex_unlock(&data->gdev_mutex);
 		return ret;
+	}
+
 
 	serdev_device_set_baudrate(serdev, data->speed);
 	serdev_device_set_flow_control(serdev, false);
@@ -63,6 +76,10 @@ static int sirf_open(struct gnss_device *gdev)
 err_close:
 	serdev_device_close(serdev);
 
+	mutex_lock(&data->gdev_mutex);
+	data->open = false;
+	mutex_unlock(&data->gdev_mutex);
+
 	return ret;
 }
 
@@ -74,6 +91,10 @@ static void sirf_close(struct gnss_device *gdev)
 	serdev_device_close(serdev);
 
 	pm_runtime_put(&serdev->dev);
+
+	mutex_lock(&data->gdev_mutex);
+	data->open = false;
+	mutex_unlock(&data->gdev_mutex);
 }
 
 static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
@@ -105,8 +126,14 @@ static int sirf_receive_buf(struct serdev_device *serdev,
 {
 	struct sirf_data *data = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = data->gdev;
+	int ret = 0;
 
-	return gnss_insert_raw(gdev, buf, count);
+	mutex_lock(&data->gdev_mutex);
+	if (data->open)
+		ret = gnss_insert_raw(gdev, buf, count);
+	mutex_unlock(&data->gdev_mutex);
+
+	return ret;
 }
 
 static const struct serdev_device_ops sirf_serdev_ops = {
@@ -275,6 +302,7 @@ static int sirf_probe(struct serdev_device *serdev)
 	data->serdev = serdev;
 	data->gdev = gdev;
 
+	mutex_init(&data->gdev_mutex);
 	init_waitqueue_head(&data->power_wait);
 
 	serdev_device_set_drvdata(serdev, data);
-- 
2.11.0


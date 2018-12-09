Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDCC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5128420672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="AHH1UqYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5128420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeLITwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:52:05 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40568 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeLITwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ut/8c9YFJfU+elcZAGNLhrWmsHsQosbLOl9ws4x5Z4c=; b=AHH1UqYQXMFO8dkB0WARvglqS
        iMja9k2bpIddx98XeNihmTlL1A8/g0GY8Zzu+pctGkbWYPn8d9/IAf8IcNhk9mNyAEVTMDUhHOJOD
        IKrzJ9nXONEUYhnj910x5MgBDQLqqzqZ7xWOt34a4f7wTzZUQUUAHzopGTN51gwmuD4j4=;
Received: from p200300ccfbead7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbea:d700:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57M-0008JA-Vr; Sun, 09 Dec 2018 20:51:57 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57M-0001NI-LK; Sun, 09 Dec 2018 20:51:56 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 1/5] gnss: sirf: write data to gnss only when the gnss device is open
Date:   Sun,  9 Dec 2018 20:51:46 +0100
Message-Id: <20181209195150.5192-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181209195150.5192-1-andreas@kemnade.info>
References: <20181209195150.5192-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The api forbids writing data there otherwise. Prepare for the
serdev_open()/close() being a part of runtime pm.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 add locking

 drivers/gnss/sirf.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 2c22836d3ffd..ba663de1db49 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -35,6 +35,12 @@ struct sirf_data {
 	struct gpio_desc *wakeup;
 	int irq;
 	bool active;
+	/*
+	 * There might be races between returning data and closing the gnss
+	 * device.
+	 */
+	struct mutex gdev_mutex;
+	bool opened;
 	wait_queue_head_t power_wait;
 };
 
@@ -44,6 +50,7 @@ static int sirf_open(struct gnss_device *gdev)
 	struct serdev_device *serdev = data->serdev;
 	int ret;
 
+	data->opened = true;
 	ret = serdev_device_open(serdev);
 	if (ret)
 		return ret;
@@ -55,6 +62,7 @@ static int sirf_open(struct gnss_device *gdev)
 	if (ret < 0) {
 		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
 		pm_runtime_put_noidle(&serdev->dev);
+		data->opened = false;
 		goto err_close;
 	}
 
@@ -74,6 +82,9 @@ static void sirf_close(struct gnss_device *gdev)
 	serdev_device_close(serdev);
 
 	pm_runtime_put(&serdev->dev);
+	mutex_lock(&data->gdev_mutex);
+	data->opened = false;
+	mutex_unlock(&data->gdev_mutex);
 }
 
 static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
@@ -105,8 +116,22 @@ static int sirf_receive_buf(struct serdev_device *serdev,
 {
 	struct sirf_data *data = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = data->gdev;
+	int ret = 0;
+
+	/*
+	 * we might come here everytime when runtime is resumed
+	 * and data is received. Two cases are possible
+	 * 1. device is opened during initialisation
+	 * 2. kernel is compiled without runtime pm
+	 *    and device is opened all the time
+	 */
+	mutex_lock(&data->gdev_mutex);
+	if (data->opened)
+		ret = gnss_insert_raw(gdev, buf, count);
 
-	return gnss_insert_raw(gdev, buf, count);
+	mutex_unlock(&data->gdev_mutex);
+
+	return ret;
 }
 
 static const struct serdev_device_ops sirf_serdev_ops = {
@@ -275,6 +300,7 @@ static int sirf_probe(struct serdev_device *serdev)
 	data->serdev = serdev;
 	data->gdev = gdev;
 
+	mutex_init(&data->gdev_mutex);
 	init_waitqueue_head(&data->power_wait);
 
 	serdev_device_set_drvdata(serdev, data);
-- 
2.11.0


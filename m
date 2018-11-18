Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2DCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D795020817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="NZhmoH4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D795020817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeKSITv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:19:51 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52512 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeKSITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KcUtf6IIe7tljv8qFWV5sd3d4b3PxsRBB5ajA7A5YgQ=; b=NZhmoH4qFraHaUthmh/PegAIJ
        2VpyPnGrJZJnqIp22PiWpHs9s1JUXv0TMxZqvPSXR8acTMKzgjZSheQxxwcoGzss/WwXAJziBca7t
        TSEMntveMULbBUU1BO39m2fIQlxjjhE+FEk0c5TxzaRIcU8qrzyxAyeGTQiwX+C6k0TyQ=;
Received: from p200300ccfbe8ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbe8:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV55-00077s-UJ; Sun, 18 Nov 2018 22:58:16 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV55-0003DB-Lf; Sun, 18 Nov 2018 22:58:15 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/5] gnss: sirf: power on logic for devices without wakeup signal
Date:   Sun, 18 Nov 2018 22:57:58 +0100
Message-Id: <20181118215801.12280-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181118215801.12280-1-andreas@kemnade.info>
References: <20181118215801.12280-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Wi2Wi devices do not have a wakeup output, so device state can
only be indirectly detected by looking whether there is communitcation
over the serial lines.
Additionally it checks for the initial state of the device during
probing to ensure it is off.
Timeout values need to be increased, because the reaction on serial line
is slower and are in line  with previous patches by
Neil Brown <neilb@suse.de> and  H. Nikolaus Schaller <hns@goldelico.com>.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gnss/sirf.c | 97 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index b5efbb062316..6a0e5c0a2d62 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -22,8 +22,8 @@
 
 #define SIRF_BOOT_DELAY			500
 #define SIRF_ON_OFF_PULSE_TIME		100
-#define SIRF_ACTIVATE_TIMEOUT		200
-#define SIRF_HIBERNATE_TIMEOUT		200
+#define SIRF_ACTIVATE_TIMEOUT		1000
+#define SIRF_HIBERNATE_TIMEOUT		1000
 
 struct sirf_data {
 	struct gnss_device *gdev;
@@ -45,26 +45,14 @@ static int sirf_open(struct gnss_device *gdev)
 	int ret;
 
 	data->opened = true;
-	ret = serdev_device_open(serdev);
-	if (ret)
-		return ret;
-
-	serdev_device_set_baudrate(serdev, data->speed);
-	serdev_device_set_flow_control(serdev, false);
 
 	ret = pm_runtime_get_sync(&serdev->dev);
 	if (ret < 0) {
 		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
 		pm_runtime_put_noidle(&serdev->dev);
 		data->opened = false;
-		goto err_close;
 	}
 
-	return 0;
-
-err_close:
-	serdev_device_close(serdev);
-
 	return ret;
 }
 
@@ -73,8 +61,6 @@ static void sirf_close(struct gnss_device *gdev)
 	struct sirf_data *data = gnss_get_drvdata(gdev);
 	struct serdev_device *serdev = data->serdev;
 
-	serdev_device_close(serdev);
-
 	pm_runtime_put(&serdev->dev);
 	data->opened = false;
 }
@@ -109,6 +95,11 @@ static int sirf_receive_buf(struct serdev_device *serdev,
 	struct sirf_data *data = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = data->gdev;
 
+	if ((!data->wakeup) && (!data->active)) {
+		data->active = 1;
+		wake_up_interruptible(&data->power_wait);
+	}
+
 	/*
 	 * we might come here everytime when runtime is resumed
 	 * and data is received. Two cases are possible
@@ -149,6 +140,25 @@ static int sirf_wait_for_power_state(struct sirf_data *data, bool active,
 {
 	int ret;
 
+	/* no wakeup pin, success condition is that
+	 * no byte comes in in the period
+	 */
+	if ((!data->wakeup) && (!active) && (data->active)) {
+		/* some bytes might come, so sleep a bit first */
+		msleep(timeout);
+		data->active = false;
+		ret = wait_event_interruptible_timeout(data->power_wait,
+			data->active == true, msecs_to_jiffies(timeout));
+
+		if (ret < 0)
+			return ret;
+
+		/* we are still getting woken up -> timeout */
+		if (ret > 0)
+			return -ETIMEDOUT;
+		return 0;
+	}
+
 	ret = wait_event_interruptible_timeout(data->power_wait,
 			data->active == active, msecs_to_jiffies(timeout));
 	if (ret < 0)
@@ -203,21 +213,48 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 static int sirf_runtime_suspend(struct device *dev)
 {
 	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret;
 
 	if (!data->on_off)
 		return regulator_disable(data->vcc);
+	ret = sirf_set_active(data, false);
 
-	return sirf_set_active(data, false);
+	if (ret)
+		dev_err(dev, "failed to deactivate");
+
+	/* we should close it anyways, so the following receptions
+	 * will not run into the empty
+	 */
+	serdev_device_close(data->serdev);
+	return 0;
 }
 
 static int sirf_runtime_resume(struct device *dev)
 {
+	int ret;
 	struct sirf_data *data = dev_get_drvdata(dev);
+	ret = serdev_device_open(data->serdev);
+	if (ret)
+		return ret;
 
-	if (!data->on_off)
-		return regulator_enable(data->vcc);
+	serdev_device_set_baudrate(data->serdev, data->speed);
+	serdev_device_set_flow_control(data->serdev, false);
+
+	if (!data->on_off) {
+		ret = regulator_enable(data->vcc);
+		if (ret)
+			goto err_close_serdev;
+	}
+	ret = sirf_set_active(data, true);
+
+	if (!ret)
+		return 0;
 
-	return sirf_set_active(data, true);
+	if (!data->on_off)
+		regulator_disable(data->vcc);
+err_close_serdev:
+	serdev_device_close(data->serdev);
+	return ret;
 }
 
 static int __maybe_unused sirf_suspend(struct device *dev)
@@ -311,18 +348,6 @@ static int sirf_probe(struct serdev_device *serdev)
 	if (data->on_off) {
 		data->wakeup = devm_gpiod_get_optional(dev, "sirf,wakeup",
 				GPIOD_IN);
-		if (IS_ERR(data->wakeup))
-			goto err_put_device;
-
-		/*
-		 * Configurations where WAKEUP has been left not connected,
-		 * are currently not supported.
-		 */
-		if (!data->wakeup) {
-			dev_err(dev, "no wakeup gpio specified\n");
-			ret = -ENODEV;
-			goto err_put_device;
-		}
 	}
 
 	if (data->wakeup) {
@@ -352,6 +377,13 @@ static int sirf_probe(struct serdev_device *serdev)
 	if (IS_ENABLED(CONFIG_PM)) {
 		pm_runtime_set_suspended(dev);	/* clear runtime_error flag */
 		pm_runtime_enable(dev);
+		/* device might be enabled at boot, so lets first enable it,
+		 * then disable it to bring it into a clear state
+		 */
+		ret = pm_runtime_get_sync(dev);
+		if (ret)
+			goto err_disable_rpm;
+		pm_runtime_put(dev);
 	} else {
 		ret = sirf_runtime_resume(dev);
 		if (ret < 0)
@@ -401,6 +433,7 @@ static const struct of_device_id sirf_of_match[] = {
 	{ .compatible = "linx,r4" },
 	{ .compatible = "wi2wi,w2sg0008i" },
 	{ .compatible = "wi2wi,w2sg0084i" },
+	{ .compatible = "wi2wi,w2sg0004" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sirf_of_match);
-- 
2.11.0


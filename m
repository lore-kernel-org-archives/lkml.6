Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B6C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEB220672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Vo5hcnUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEB220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeLITwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:52:10 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40614 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeLITwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fX9gUF/YfecMychWLmrPdo3yKn0f+STiXPyq0ksLbQU=; b=Vo5hcnUOSy4JkBIvhHvPYFrAp
        6hLwQwOsQWPFpX8RH3i1D5YmnlIYFjd/guEP1KVpwttsHpInNk6EGGbNOsSoqPSW0dZSTmJlQZhCm
        ZTwoX0p+bPCt1q2qX9/+++LsLB6gGHAx6xXTxEJeRMHTY9HY0Rf+ZTrptXDP3N3cmHlDs=;
Received: from p200300ccfbead7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbea:d700:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57U-0008Jm-Eq; Sun, 09 Dec 2018 20:52:04 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57U-0001NO-5s; Sun, 09 Dec 2018 20:52:04 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/5] gnss: sirf: power on logic for devices without wakeup signal
Date:   Sun,  9 Dec 2018 20:51:47 +0100
Message-Id: <20181209195150.5192-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181209195150.5192-1-andreas@kemnade.info>
References: <20181209195150.5192-1-andreas@kemnade.info>
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
Changes in v2:
 - style cleanup
 - do not keep serdev open just because runtime is active,
   only when needed (gnss device is opened or state is changed)
 - clearer timeout semantics

 drivers/gnss/sirf.c | 114 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 23 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index ba663de1db49..c64369494afb 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -23,8 +23,13 @@
 
 #define SIRF_BOOT_DELAY			500
 #define SIRF_ON_OFF_PULSE_TIME		100
+/* activate till reaction of wakeup pin */
 #define SIRF_ACTIVATE_TIMEOUT		200
+/* activate till reception of data */
+#define SIRF_ACTIVATE_TILL_OUTPUT_TIMEOUT	1000
 #define SIRF_HIBERNATE_TIMEOUT		200
+/* If no data arrives for this time, we expect the chip to be off. */
+#define SIRF_MIN_SILENCE	1000
 
 struct sirf_data {
 	struct gnss_device *gdev;
@@ -41,9 +46,44 @@ struct sirf_data {
 	 */
 	struct mutex gdev_mutex;
 	bool opened;
+	int serdev_usecount;
+	/*
+	 * serdev will be opened for power state changing and when userspace
+	 * needs it, so we have a usecount and need locking.
+	 */
+	struct mutex serdev_mutex;
 	wait_queue_head_t power_wait;
 };
 
+static int sirf_dev_get(struct sirf_data *data)
+{
+	int ret = 0;
+
+	mutex_lock(&data->serdev_mutex);
+	data->serdev_usecount++;
+	if (data->serdev_usecount == 1) {
+		ret = serdev_device_open(data->serdev);
+		if (ret)
+			data->serdev_usecount--;
+
+		serdev_device_set_baudrate(data->serdev, data->speed);
+		serdev_device_set_flow_control(data->serdev, false);
+	}
+
+	mutex_unlock(&data->serdev_mutex);
+	return ret;
+}
+
+static void sirf_dev_put(struct sirf_data *data)
+{
+	mutex_lock(&data->serdev_mutex);
+	data->serdev_usecount--;
+	if (data->serdev_usecount == 0)
+		serdev_device_close(data->serdev);
+
+	mutex_unlock(&data->serdev_mutex);
+}
+
 static int sirf_open(struct gnss_device *gdev)
 {
 	struct sirf_data *data = gnss_get_drvdata(gdev);
@@ -51,13 +91,10 @@ static int sirf_open(struct gnss_device *gdev)
 	int ret;
 
 	data->opened = true;
-	ret = serdev_device_open(serdev);
+	ret = sirf_dev_get(data);
 	if (ret)
 		return ret;
 
-	serdev_device_set_baudrate(serdev, data->speed);
-	serdev_device_set_flow_control(serdev, false);
-
 	ret = pm_runtime_get_sync(&serdev->dev);
 	if (ret < 0) {
 		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
@@ -69,7 +106,7 @@ static int sirf_open(struct gnss_device *gdev)
 	return 0;
 
 err_close:
-	serdev_device_close(serdev);
+	sirf_dev_put(data);
 
 	return ret;
 }
@@ -78,9 +115,7 @@ static void sirf_close(struct gnss_device *gdev)
 {
 	struct sirf_data *data = gnss_get_drvdata(gdev);
 	struct serdev_device *serdev = data->serdev;
-
-	serdev_device_close(serdev);
-
+	sirf_dev_put(data);
 	pm_runtime_put(&serdev->dev);
 	mutex_lock(&data->gdev_mutex);
 	data->opened = false;
@@ -118,12 +153,16 @@ static int sirf_receive_buf(struct serdev_device *serdev,
 	struct gnss_device *gdev = data->gdev;
 	int ret = 0;
 
+	if (!data->wakeup && !data->active) {
+		data->active = true;
+		wake_up_interruptible(&data->power_wait);
+	}
+
 	/*
-	 * we might come here everytime when runtime is resumed
-	 * and data is received. Two cases are possible
-	 * 1. device is opened during initialisation
-	 * 2. kernel is compiled without runtime pm
-	 *    and device is opened all the time
+	 * We might come here everytime when runtime is resumed
+	 * and data is received. Two cases are possible:
+	 * 1. during power state change
+	 * 2. userspace has opened the gnss device
 	 */
 	mutex_lock(&data->gdev_mutex);
 	if (data->opened)
@@ -161,6 +200,24 @@ static int sirf_wait_for_power_state(struct sirf_data *data, bool active,
 {
 	int ret;
 
+	if (!data->wakeup && !active && data->active) {
+		/* Wait for the chip to turn off. */
+		msleep(timeout);
+		data->active = false;
+		/* Now check if it is really off. */
+		ret = wait_event_interruptible_timeout(data->power_wait,
+			data->active,
+			msecs_to_jiffies(SIRF_MIN_SILENCE));
+
+		if (ret < 0)
+			return ret;
+
+		/* We are still getting data. -> state change timeout */
+		if (ret > 0)
+			return -ETIMEDOUT;
+		return 0;
+	}
+
 	ret = wait_event_interruptible_timeout(data->power_wait,
 			data->active == active, msecs_to_jiffies(timeout));
 	if (ret < 0)
@@ -189,13 +246,23 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 	int ret;
 
 	if (active)
-		timeout = SIRF_ACTIVATE_TIMEOUT;
+		timeout = data->wakeup ?
+			SIRF_ACTIVATE_TIMEOUT :
+			SIRF_ACTIVATE_TILL_OUTPUT_TIMEOUT;
 	else
 		timeout = SIRF_HIBERNATE_TIMEOUT;
 
 	do {
+		/* Open the serdev of wakeup-less devices to check for input. */
+		if (!data->wakeup) {
+			ret = sirf_dev_get(data);
+			if (ret)
+				return ret;
+		}
 		sirf_pulse_on_off(data);
 		ret = sirf_wait_for_power_state(data, active, timeout);
+		if (!data->wakeup)
+			sirf_dev_put(data);
 		if (ret < 0) {
 			if (ret == -ETIMEDOUT)
 				continue;
@@ -301,6 +368,7 @@ static int sirf_probe(struct serdev_device *serdev)
 	data->gdev = gdev;
 
 	mutex_init(&data->gdev_mutex);
+	mutex_init(&data->serdev_mutex);
 	init_waitqueue_head(&data->power_wait);
 
 	serdev_device_set_drvdata(serdev, data);
@@ -327,15 +395,6 @@ static int sirf_probe(struct serdev_device *serdev)
 		if (IS_ERR(data->wakeup))
 			goto err_put_device;
 
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
@@ -365,6 +424,14 @@ static int sirf_probe(struct serdev_device *serdev)
 	if (IS_ENABLED(CONFIG_PM)) {
 		pm_runtime_set_suspended(dev);	/* clear runtime_error flag */
 		pm_runtime_enable(dev);
+		/*
+		 * Device might be enabled at boot, so lets first enable it,
+		 * then disable it to bring it into a clear state.
+		 */
+		ret = pm_runtime_get_sync(dev);
+		if (ret)
+			goto err_disable_rpm;
+		pm_runtime_put(dev);
 	} else {
 		ret = sirf_runtime_resume(dev);
 		if (ret < 0)
@@ -412,6 +479,7 @@ static void sirf_remove(struct serdev_device *serdev)
 static const struct of_device_id sirf_of_match[] = {
 	{ .compatible = "fastrax,uc430" },
 	{ .compatible = "linx,r4" },
+	{ .compatible = "wi2wi,w2sg0004" },
 	{ .compatible = "wi2wi,w2sg0008i" },
 	{ .compatible = "wi2wi,w2sg0084i" },
 	{},
-- 
2.11.0


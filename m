Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CD6C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1C521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="QQtoJEoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfAXGe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:34:57 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:48658 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfAXGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4yp7H4VLBoKtCQBxC7WyQpSz8GevTpiv+Wl8gdB4KWY=; b=QQtoJEoJwV7S6YdBt4x5lCb1G
        B1w1fPJ70X7MnNKxIgnj8LhSRsA4Dn7aYAFPnb14aQHnPKWzRj0hEfxvLM67bHP9QuWtKL74KTtEl
        /5vQUD7snanz9jIdPuii5ZNwcZ+jgfOkBthTGACFcjaMcu1LFnpCK+1r04luyQqBGG30w=;
Received: from [77.247.85.78] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb8-0000um-M9; Thu, 24 Jan 2019 07:34:46 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb6-0007rP-GE; Thu, 24 Jan 2019 07:34:44 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 2/5] gnss: sirf: add support for configurations without wakeup signal
Date:   Thu, 24 Jan 2019 07:34:36 +0100
Message-Id: <20190124063439.29897-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190124063439.29897-1-andreas@kemnade.info>
References: <20190124063439.29897-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Wi2Wi devices do not have a wakeup output, so device state can
only be indirectly detected by looking whether there is communication
over the serial lines.
This approach requires a report cycle set to a value less than 2 seconds
to be reliable.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v4:
 - was 3/6 earlier
 - more cleanup
 - separate no wakeup version for sirf_wait_for_power_state
 - cleaned up optimisation for initial power off

Changes in v3:
 - was 2/5 earlier
 - changed commit headline
 - more style cleanup
 - split out initial power off as 2/6
 - introduced SIRF_REPORT_CYCLE constant
 - added documentation about limitations
 - ignore first data after power state on so no
   shutdown meassages are treated as power on success
 - clearer logic in sirf_wait_for_power_state

Changes in v2:
 - style cleanup
 - do not keep serdev open just because runtime is active,
   only when needed (gnss device is opened or state is changed)
 - clearer timeout semantics

 drivers/gnss/sirf.c | 124 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 19 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 49bc021325e9..b42a383e26e0 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -25,6 +25,15 @@
 #define SIRF_ON_OFF_PULSE_TIME		100
 #define SIRF_ACTIVATE_TIMEOUT		200
 #define SIRF_HIBERNATE_TIMEOUT		200
+/*
+ * If no data arrives for this time, we assume that the chip is off.
+ * REVISIT: The report cycle is configurable and can be several minutes long,
+ * so this will only work reliably if the report cycle is set to a reasonable
+ * low value. Also power saving settings (like send data only on movement)
+ * might things work even worse.
+ * Workaround might be to parse shutdown or bootup messages.
+ */
+#define SIRF_REPORT_CYCLE	2000
 
 struct sirf_data {
 	struct gnss_device *gdev;
@@ -39,9 +48,42 @@ struct sirf_data {
 	struct mutex gdev_mutex;
 	bool open;
 
+	struct mutex serdev_mutex;
+	int serdev_count;
+
 	wait_queue_head_t power_wait;
 };
 
+static int sirf_serdev_open(struct sirf_data *data)
+{
+	int ret = 0;
+
+	mutex_lock(&data->serdev_mutex);
+	if (++data->serdev_count == 1) {
+		ret = serdev_device_open(data->serdev);
+		if (ret) {
+			data->serdev_count--;
+			goto out_unlock;
+		}
+
+		serdev_device_set_baudrate(data->serdev, data->speed);
+		serdev_device_set_flow_control(data->serdev, false);
+	}
+
+out_unlock:
+	mutex_unlock(&data->serdev_mutex);
+
+	return ret;
+}
+
+static void sirf_serdev_close(struct sirf_data *data)
+{
+	mutex_lock(&data->serdev_mutex);
+	if (--data->serdev_count == 0)
+		serdev_device_close(data->serdev);
+	mutex_unlock(&data->serdev_mutex);
+}
+
 static int sirf_open(struct gnss_device *gdev)
 {
 	struct sirf_data *data = gnss_get_drvdata(gdev);
@@ -52,7 +94,7 @@ static int sirf_open(struct gnss_device *gdev)
 	data->open = true;
 	mutex_unlock(&data->gdev_mutex);
 
-	ret = serdev_device_open(serdev);
+	ret = sirf_serdev_open(data);
 	if (ret) {
 		mutex_lock(&data->gdev_mutex);
 		data->open = false;
@@ -60,10 +102,6 @@ static int sirf_open(struct gnss_device *gdev)
 		return ret;
 	}
 
-
-	serdev_device_set_baudrate(serdev, data->speed);
-	serdev_device_set_flow_control(serdev, false);
-
 	ret = pm_runtime_get_sync(&serdev->dev);
 	if (ret < 0) {
 		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
@@ -74,7 +112,7 @@ static int sirf_open(struct gnss_device *gdev)
 	return 0;
 
 err_close:
-	serdev_device_close(serdev);
+	sirf_serdev_close(data);
 
 	mutex_lock(&data->gdev_mutex);
 	data->open = false;
@@ -88,7 +126,7 @@ static void sirf_close(struct gnss_device *gdev)
 	struct sirf_data *data = gnss_get_drvdata(gdev);
 	struct serdev_device *serdev = data->serdev;
 
-	serdev_device_close(serdev);
+	sirf_serdev_close(data);
 
 	pm_runtime_put(&serdev->dev);
 
@@ -128,6 +166,11 @@ static int sirf_receive_buf(struct serdev_device *serdev,
 	struct gnss_device *gdev = data->gdev;
 	int ret = 0;
 
+	if (!data->wakeup && !data->active) {
+		data->active = true;
+		wake_up_interruptible(&data->power_wait);
+	}
+
 	mutex_lock(&data->gdev_mutex);
 	if (data->open)
 		ret = gnss_insert_raw(gdev, buf, count);
@@ -158,11 +201,40 @@ static irqreturn_t sirf_wakeup_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int sirf_wait_for_power_state_nowakeup(struct sirf_data *data,
+						bool active,
+						unsigned long timeout)
+{
+	int ret;
+
+	/* Wait for state change change (including any shutdown messages). */
+	msleep(timeout);
+	data->active = false;
+	/* Wait for data reception or timeout. */
+	ret = wait_event_interruptible_timeout(data->power_wait,
+				data->active,
+				msecs_to_jiffies(SIRF_REPORT_CYCLE));
+	if (ret < 0)
+		return ret;
+
+	if (ret > 0 && !active)
+		return -ETIMEDOUT;
+
+	if (ret == 0 && active)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int sirf_wait_for_power_state(struct sirf_data *data, bool active,
 					unsigned long timeout)
 {
 	int ret;
 
+	if (!data->wakeup)
+		return sirf_wait_for_power_state_nowakeup(data, active,
+							  timeout);
+
 	ret = wait_event_interruptible_timeout(data->power_wait,
 			data->active == active, msecs_to_jiffies(timeout));
 	if (ret < 0)
@@ -195,6 +267,12 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 	else
 		timeout = SIRF_HIBERNATE_TIMEOUT;
 
+	if (!data->wakeup) {
+		ret = sirf_serdev_open(data);
+		if (ret)
+			return ret;
+	}
+
 	do {
 		sirf_pulse_on_off(data);
 		ret = sirf_wait_for_power_state(data, active, timeout);
@@ -202,12 +280,17 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 			if (ret == -ETIMEDOUT)
 				continue;
 
-			return ret;
 		}
-
 		break;
+
 	} while (retries--);
 
+	if (!data->wakeup)
+		sirf_serdev_close(data);
+
+	if (ret)
+		return ret;
+
 	if (retries < 0)
 		return -ETIMEDOUT;
 
@@ -303,6 +386,7 @@ static int sirf_probe(struct serdev_device *serdev)
 	data->gdev = gdev;
 
 	mutex_init(&data->gdev_mutex);
+	mutex_init(&data->serdev_mutex);
 	init_waitqueue_head(&data->power_wait);
 
 	serdev_device_set_drvdata(serdev, data);
@@ -329,16 +413,6 @@ static int sirf_probe(struct serdev_device *serdev)
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
-
 		ret = regulator_enable(data->vcc);
 		if (ret)
 			goto err_put_device;
@@ -366,6 +440,17 @@ static int sirf_probe(struct serdev_device *serdev)
 	}
 
 	if (data->on_off) {
+		if (!data->wakeup) {
+			data->active = false;
+
+			ret = sirf_serdev_open(data);
+			if (ret)
+				goto err_disable_vcc;
+
+			msleep(SIRF_REPORT_CYCLE);
+			sirf_serdev_close(data);
+		}
+
 		/* Force hibernate mode if already active. */
 		if (data->active) {
 			ret = sirf_set_active(data, false);
@@ -433,6 +518,7 @@ static void sirf_remove(struct serdev_device *serdev)
 static const struct of_device_id sirf_of_match[] = {
 	{ .compatible = "fastrax,uc430" },
 	{ .compatible = "linx,r4" },
+	{ .compatible = "wi2wi,w2sg0004" },
 	{ .compatible = "wi2wi,w2sg0008i" },
 	{ .compatible = "wi2wi,w2sg0084i" },
 	{},
-- 
2.11.0


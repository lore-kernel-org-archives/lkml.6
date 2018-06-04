Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeFDHFD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753886AbeFDHFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:05:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.16 26/47] iio: hid-sensor-trigger: Fix sometimes not powering up the sensor after resume
Date: Mon,  4 Jun 2018 08:58:38 +0200
Message-Id: <20180604065550.580372107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 6f92253024d9d947a4f454654840ce479e251376 upstream.

hid_sensor_set_power_work() powers the sensors back up after a resume
based on the user_requested_state atomic_t.

But hid_sensor_power_state() treats this as a boolean flag, leading to
the following problematic scenario:

1) Some app starts using the iio-sensor in buffered / triggered mode,
   hid_sensor_data_rdy_trigger_set_state(true) gets called, setting
   user_requested_state to 1.
2) Something directly accesses a _raw value through sysfs, leading
   to a call to hid_sensor_power_state(true) followed by
   hid_sensor_power_state(false) call, this sets user_requested_state
   to 1 followed by setting it to 0.
3) Suspend/resume the machine, hid_sensor_set_power_work() now does
   NOT power the sensor back up because user_requested_state (wrongly)
   is 0. Which stops the app using the sensor in buffered mode from
   receiving any new values.

This commit changes user_requested_state to a counter tracking how many
times hid_sensor_power_state(true) was called instead, fixing this.

Cc: Bastien Nocera <hadess@hadess.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -178,14 +178,14 @@ int hid_sensor_power_state(struct hid_se
 #ifdef CONFIG_PM
 	int ret;
 
-	atomic_set(&st->user_requested_state, state);
-
 	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
 		pm_runtime_enable(&st->pdev->dev);
 
-	if (state)
+	if (state) {
+		atomic_inc(&st->user_requested_state);
 		ret = pm_runtime_get_sync(&st->pdev->dev);
-	else {
+	} else {
+		atomic_dec(&st->user_requested_state);
 		pm_runtime_mark_last_busy(&st->pdev->dev);
 		pm_runtime_use_autosuspend(&st->pdev->dev);
 		ret = pm_runtime_put_autosuspend(&st->pdev->dev);

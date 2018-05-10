Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934976AbeEJKtM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:49:12 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:32277 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:49:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="14726559"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 2/9] iio: Add channel for Position Relative
Date: Thu, 10 May 2018 13:45:07 +0300
Message-ID: <1525949114-29263-3-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new channel type for relative position on a pad.

These type of analog sensor offers the position of a pen
on a touchpad, and is represented as a voltage, which can be
converted to a position on X and Y axis on the pad.
The channel will hand the relative position on the pad in both directions.

The channel can then be consumed by a touchscreen driver or
read as-is for a raw indication of the touchpen on a touchpad.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
 - modified channel name to relative position as suggested.
 - modified kernel version to 4.18 (presumable)

 Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6a5f34b..42a9287 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -190,6 +190,18 @@ Description:
 		but should match other such assignments on device).
 		Units after application of scale and offset are m/s^2.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
+KernelVersion:	4.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Relative position in direction x or y on a pad (may be
+		arbitrarily assigned but should match other such assignments on
+		device).
+		Units after application of scale and offset are milli percents
+		from the pad's size in both directions. Should be calibrated by
+		the consumer.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d..14bf3d24 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_COUNT] = "count",
 	[IIO_INDEX] = "index",
 	[IIO_GRAVITY]  = "gravity",
+	[IIO_POSITIONRELATIVE]  = "positionrelative",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 4213cdf..033c7d2 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -44,6 +44,7 @@ enum iio_chan_type {
 	IIO_COUNT,
 	IIO_INDEX,
 	IIO_GRAVITY,
+	IIO_POSITIONRELATIVE,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b61245e..148f69d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_GRAVITY] = "gravity",
+	[IIO_POSITIONRELATIVE] = "positionrelative",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_PH:
 	case IIO_UVINDEX:
 	case IIO_GRAVITY:
+	case IIO_POSITIONRELATIVE:
 		break;
 	default:
 		return false;
-- 
2.7.4

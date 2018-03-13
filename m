Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeCMBhQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:37:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46839 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCMBhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:37:14 -0400
X-Google-Smtp-Source: AG47ELv2hWzxRAplvjnM8JU5Zr8GfzBbP/DE4PcJz1k7k/QHwtDNMLnGmQRG/2DinWDVk6JRmNVClg==
Date: Mon, 12 Mar 2018 22:37:09 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio:magnetometer: Remove duplications in iio_chan_spec
Message-ID: <20180313013709.ca7hxb5q56rbghch@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magn_3d_channels array has multiple declarations of iio_chan_spec.
Most of the iio_chan_spec are very similar, changing only by the .type
and .channel2 field. This patch reduces the code duplication by adding a
macro that can replace the iio_chan_spec  repetitions in the
magn_3d_channels array.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
 - Change IIO_MOD_NORTH_MAGN in the last element of iio_chan_info for
   IIO_MOD_NORTH_TRUE in the last parameter.

 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 83 ++++++---------------------
 1 file changed, 19 insertions(+), 64 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index d55c4885211a..cdbcfc61a180 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -74,72 +74,27 @@ static const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_ORIENT_TRUE_NORTH,
 };
 
+#define HID_SENSOR_MAGN_3D_AXIS_CHANNEL(channel_type, characteristic)	\
+	{								\
+		.type = channel_type,					\
+		.modified = 1,						\
+		.channel2 = characteristic,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) | \
+					BIT(IIO_CHAN_INFO_SCALE) |	\
+					BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+					BIT(IIO_CHAN_INFO_HYSTERESIS),	\
+	}								\
+
 /* Channel definitions */
 static const struct iio_chan_spec magn_3d_channels[] = {
-	{
-		.type = IIO_MAGN,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}, {
-		.type = IIO_MAGN,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}, {
-		.type = IIO_MAGN,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}, {
-		.type = IIO_ROT,
-		.modified = 1,
-		.channel2 = IIO_MOD_NORTH_MAGN_TILT_COMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}, {
-		.type = IIO_ROT,
-		.modified = 1,
-		.channel2 = IIO_MOD_NORTH_TRUE_TILT_COMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}, {
-		.type = IIO_ROT,
-		.modified = 1,
-		.channel2 = IIO_MOD_NORTH_MAGN,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}, {
-		.type = IIO_ROT,
-		.modified = 1,
-		.channel2 = IIO_MOD_NORTH_TRUE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS),
-	}
+	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_X),
+	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Y),
+	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Z),
+	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_MAGN_TILT_COMP),
+	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_TRUE_TILT_COMP),
+	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_MAGN),
+	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_TRUE),
 };
 
 /* Adjust channel real bits based on report descriptor */
-- 
2.16.2

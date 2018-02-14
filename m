Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966360AbeBNBJP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:09:15 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56082 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:09:13 -0500
X-Google-Smtp-Source: AH8x226tC4HU3790d7oGoVe7rZ2A84JWKkuGzgDgIzf2VKvt/EQhh5A2CtEHshhTnbAlzgh6zS/2ag==
From: Richard Lai <richard@richardman.com>
Cc: richard@richardman.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: chemical: ccs811: Renamed resistance member in ccs811_reading struct
Date: Wed, 14 Feb 2018 01:08:35 +0000
Message-Id: <1518570519-1117-1-git-send-email-richard@richardman.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resistance member in ccs811_reading struct is an unsigned 16-bit
integer variable used to store RAW_DATA register bytes read from CCS811.
It is kind of misleading to name this struct member as resistance.

About the RAW_DATA register bytes, the CCS811 datasheet states that:
-----
Two byte read only register which contains the latest readings from the
sense resistor.

The most significant 6 bits of the Byte 0 contain the value of the current
through the sensor (0μA to 63μA).

The lower 10 bits contain (as computed from the ADC) the readings of the
voltage across the sensor with the selected current (1023 = 1.65V)"
-----

Hence, the RAW_DATA register byte contains information about electric
current and voltage of the CCS811 sensor. Calling this struct member
'resistance' is kind of misleading, although both electric current and
voltage are needed to calculate the electrical resistance of the sensor
using Ohm's law, V = I x R, in which a new channel type of IIO_RESISTANCE
may be added to the driver in the future.

Signed-off-by: Richard Lai <richard@richardman.com>
---
 drivers/iio/chemical/ccs811.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 8e8beb7..e6f6bc4 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -66,7 +66,7 @@ struct ccs811_reading {
 	__be16 voc;
 	u8 status;
 	u8 error;
-	__be16 resistance;
+	__be16 raw_data;
 } __attribute__((__packed__));
 
 struct ccs811_data {
@@ -202,12 +202,12 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			*val = be16_to_cpu(data->buffer.resistance) &
+			*val = be16_to_cpu(data->buffer.raw_data) &
 					   CCS811_VOLTAGE_MASK;
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_CURRENT:
-			*val = be16_to_cpu(data->buffer.resistance) >> 10;
+			*val = be16_to_cpu(data->buffer.raw_data) >> 10;
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_CONCENTRATION:
-- 
2.7.4

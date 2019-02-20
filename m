Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A2D21902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfBTPDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:03:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48630 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBTPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:03:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0B72A26394C
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH] iio: cros_ec: Fix gyro scale calculation
Date:   Wed, 20 Feb 2019 16:03:00 +0100
Message-Id: <20190220150300.3302-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

Calculation was copied from IIO_DEGREE_TO_RAD, but offset added to avoid
rounding error is wrong. It should be only half of the divider.

Fixes: c14dca07a31d ("iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 89cb0066a6e0..600942af9f9c 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -103,7 +103,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 			 * Do not use IIO_DEGREE_TO_RAD to avoid precision
 			 * loss. Round to the nearest integer.
 			 */
-			*val = div_s64(val64 * 314159 + 9000000ULL, 1000);
+			*val = div_s64(val64 * 314159 + 500ULL, 1000);
 			*val2 = 18000 << (CROS_EC_SENSOR_BITS - 1);
 			ret = IIO_VAL_FRACTIONAL;
 			break;
-- 
2.20.1


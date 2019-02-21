Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97532086D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBUCGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:06:36 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.9]:49542 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfBUCGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 21:06:35 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id DD01CCB863
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 20:06:34 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wdkwgL2Yd2PzOwdkwgnRZ3; Wed, 20 Feb 2019 20:06:34 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=50666 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gwdkv-001AYf-SQ; Wed, 20 Feb 2019 20:06:34 -0600
Date:   Wed, 20 Feb 2019 20:06:33 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec_accel_legacy: Refactor code in
 cros_ec_accel_legacy_probe
Message-ID: <20190221020633.GA4195@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gwdkv-001AYf-SQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:50666
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor some code in order to fix both the technical implementation
and the following warnings:

drivers/iio/accel/cros_ec_accel_legacy.c: In function ‘cros_ec_accel_legacy_probe’:
drivers/iio/accel/cros_ec_accel_legacy.c:387:36: warning: this statement may fall through [-Wimplicit-fallthrough=]
    ec_accel_channels[X].scan_index = Y;
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/iio/accel/cros_ec_accel_legacy.c:388:3: note: here
   case Y:
   ^~~~
drivers/iio/accel/cros_ec_accel_legacy.c:389:36: warning: this statement may fall through [-Wimplicit-fallthrough=]
    ec_accel_channels[Y].scan_index = X;
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/iio/accel/cros_ec_accel_legacy.c:390:3: note: here
   case Z:
   ^~~~

Notice that neither the for loop nor the switch statement is needed.
Also, "state->sign[Y] = 1" should be unconditional.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 27 +++++++++++-------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 063e89eff791..021f9f5cd3bb 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -353,7 +353,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct cros_ec_accel_legacy_state *state;
-	int ret, i;
+	int ret;
 
 	if (!ec || !ec->ec_dev) {
 		dev_warn(&pdev->dev, "No EC device found.\n");
@@ -381,20 +381,17 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 	 * Present the channel using HTML5 standard:
 	 * need to invert X and Y and invert some lid axis.
 	 */
-	for (i = X ; i < MAX_AXIS; i++) {
-		switch (i) {
-		case X:
-			ec_accel_channels[X].scan_index = Y;
-		case Y:
-			ec_accel_channels[Y].scan_index = X;
-		case Z:
-			ec_accel_channels[Z].scan_index = Z;
-		}
-		if (state->sensor_num == MOTIONSENSE_LOC_LID && i != Y)
-			state->sign[i] = -1;
-		else
-			state->sign[i] = 1;
-	}
+	ec_accel_channels[X].scan_index = Y;
+	ec_accel_channels[Y].scan_index = X;
+	ec_accel_channels[Z].scan_index = Z;
+
+	state->sign[Y] = 1;
+
+	if (state->sensor_num == MOTIONSENSE_LOC_LID)
+		state->sign[X] = state->sign[Z] = -1;
+	else
+		state->sign[X] = state->sign[Z] = 1;
+
 	indio_dev->num_channels = ARRAY_SIZE(ec_accel_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &cros_ec_accel_legacy_info;
-- 
2.20.1


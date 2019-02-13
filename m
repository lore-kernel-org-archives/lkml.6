Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B943C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D76222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfBMHly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:41:54 -0500
Received: from jax4mhob18.registeredsite.com ([64.69.218.106]:58458 "EHLO
        jax4mhob18.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728543AbfBMHly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:41:54 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob18.registeredsite.com (8.14.4/8.14.4) with ESMTP id x1D7fp2K185975
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:41:52 -0500
Received: (qmail 27927 invoked by uid 0); 13 Feb 2019 07:41:51 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 13 Feb 2019 07:41:51 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] iio/gyro/bmg160: Use millidegrees for temperature scale
Date:   Wed, 13 Feb 2019 08:41:47 +0100
Message-Id: <1550043707-13040-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
References: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard unit for temperature is millidegrees Celcius, whereas this driver
was reporting in degrees. Fix the scale factor in the driver.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Don't touch val2 when returning IIO_VAL_INT
    Only touch val when returning a value

 drivers/iio/gyro/bmg160_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 63ca316..92c07ab 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -582,11 +582,10 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return bmg160_get_filter(data, val);
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val2 = 500000;
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = 500;
+			return IIO_VAL_INT;
 		case IIO_ANGL_VEL:
 		{
 			int i;
@@ -594,6 +593,7 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
 			for (i = 0; i < ARRAY_SIZE(bmg160_scale_table); ++i) {
 				if (bmg160_scale_table[i].dps_range ==
 							data->dps_range) {
+					*val = 0;
 					*val2 = bmg160_scale_table[i].scale;
 					return IIO_VAL_INT_PLUS_MICRO;
 				}
-- 
1.9.1


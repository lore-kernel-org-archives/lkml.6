Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbeE3STp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:19:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41720 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeE3STm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:19:42 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: tsl2x7x/tsl2772: avoid potential division by zero
Date: Wed, 30 May 2018 19:19:36 +0100
Message-Id: <20180530181936.17902-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It may be possible for tsl2772_get_lux to return a zero lux value
and hence a division by zero can occur when lux_val is zero. Check
for this case and return -ERANGE to avoid the division by zero.

Detected by CoverityScan, CID#1469484 ("Division or modulo by zero")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/tsl2772.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 34d42a2504c9..df5b2a0da96c 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -582,6 +582,8 @@ static int tsl2772_als_calibrate(struct iio_dev *indio_dev)
 			"%s: failed to get lux\n", __func__);
 		return lux_val;
 	}
+	if (lux_val == 0)
+		return -ERANGE;
 
 	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
 			lux_val;
-- 
2.17.0

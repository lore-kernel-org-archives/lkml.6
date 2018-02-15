Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165812AbeBORwx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:52:53 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59406 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1165799AbeBORws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:52:48 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 4/5] iio: accel: bcm150: Remove handling for regmap raw_read_max
Date: Thu, 15 Feb 2018 17:52:19 +0000
Message-ID: <20180215175220.2691-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802150215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap core now handles splitting up transactions according to
max_raw_read, so this code is no longer required in client drivers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 870f92ef61c2..3d2e6b501bf9 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -838,29 +838,12 @@ static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
 	int sample_length = 3 * 2;
 	int ret;
 	int total_length = samples * sample_length;
-	int i;
-	size_t step = regmap_get_raw_read_max(data->regmap);
-
-	if (!step || step > total_length)
-		step = total_length;
-	else if (step < total_length)
-		step = sample_length;
-
-	/*
-	 * Seems we have a bus with size limitation so we have to execute
-	 * multiple reads
-	 */
-	for (i = 0; i < total_length; i += step) {
-		ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
-				      &buffer[i], step);
-		if (ret)
-			break;
-	}
 
+	ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
+			      buffer, total_length);
 	if (ret)
 		dev_err(dev,
-			"Error transferring data from fifo in single steps of %zu\n",
-			step);
+			"Error transferring data from fifo: %d\n", ret);
 
 	return ret;
 }
-- 
2.11.0

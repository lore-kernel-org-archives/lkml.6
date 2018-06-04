Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeFDJIy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:08:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41645 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbeFDJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:08:46 -0400
X-Google-Smtp-Source: ADUXVKLz+1j/RcOK5piJhJ2LGShaJBvCdIwCHcDwfkwRK5dTSoueeCJZQQzlcXCvU0SfNJaQnwMq3A==
From: Baolin Wang <baolin.wang@linaro.org>
To: jic23@kernel.org
Cc: baolin.wang@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, arnd@arndb.de, broonie@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Convert to use timespec64 variables to get a time stamp
Date: Mon,  4 Jun 2018 17:07:39 +0800
Message-Id: <8ab19b1665b51364c1f7e607f9a69a86fe084d0d.1528102909.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct timespec is not y2038 safe on 32bit machines, thus this patch
converts to use timespec64 variables and related APIs to get a time stamp
for events etc.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/iio/industrialio-core.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d..8d2b93b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -207,35 +207,35 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
  */
 s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 {
-	struct timespec tp;
+	struct timespec64 tp;
 
 	switch (iio_device_get_clock(indio_dev)) {
 	case CLOCK_REALTIME:
-		ktime_get_real_ts(&tp);
+		ktime_get_real_ts64(&tp);
 		break;
 	case CLOCK_MONOTONIC:
-		ktime_get_ts(&tp);
+		ktime_get_ts64(&tp);
 		break;
 	case CLOCK_MONOTONIC_RAW:
-		getrawmonotonic(&tp);
+		getrawmonotonic64(&tp);
 		break;
 	case CLOCK_REALTIME_COARSE:
-		tp = current_kernel_time();
+		tp = current_kernel_time64();
 		break;
 	case CLOCK_MONOTONIC_COARSE:
-		tp = get_monotonic_coarse();
+		tp = get_monotonic_coarse64();
 		break;
 	case CLOCK_BOOTTIME:
-		get_monotonic_boottime(&tp);
+		get_monotonic_boottime64(&tp);
 		break;
 	case CLOCK_TAI:
-		timekeeping_clocktai(&tp);
+		timekeeping_clocktai64(&tp);
 		break;
 	default:
 		BUG();
 	}
 
-	return timespec_to_ns(&tp);
+	return timespec64_to_ns(&tp);
 }
 EXPORT_SYMBOL(iio_get_time_ns);
 
-- 
1.7.9.5

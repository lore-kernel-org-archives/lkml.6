Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB323C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A39820852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A39820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeFRPct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:32:49 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbeFRPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:32:47 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MMWH0-1fZssn3R3G-008KPX; Mon, 18 Jun 2018 17:31:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Matt Fornero <matt.fornero@mathworks.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: use timespec64 based interfaces for iio_get_time_ns()
Date:   Mon, 18 Jun 2018 17:31:36 +0200
Message-Id: <20180618153153.1903178-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:mcVjUPaouPYX8LBmLB4N/DAIM1SQrK8yU+5IYHU2SjZwChs2ZYp
 1YUoMQTfpYGViNv4kmfDzuSoXobf9YThAYUMXCTQDDnJR5e/bN0JzbGX77cJgof0Cf9ZZNW
 tbCfO2SaYDZODmNXgGzeMYLlJ/EOeT2UTY5RCZn9KQR1PbTiFzl5406goiYEXAS4F9UCULI
 OJBlOUkmhhkmUT/NpBbyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mrrPjxwudeo=:Nq6hfxiNernp9T9dXexccy
 +Ilo5cxXNpGft7uMsmoSJxf1F0cOJOHM/vyKZUqXcD1M7aR+oI3ksVhrnAU+T1kRxYRBsHhHu
 62qjBzVLZLLMkDjX0diI/f3ICheCk8E3WF8LYJTzFMmbck9sMmtuImv4ktURPr+oBwyiBS3ii
 LYSpsHxGMDf+smzavNhcdzMpD+/7kyU+F4WEqmNx+jUFATCifZ/UyAmzLqk/dKmgArXOFJa/C
 KM/eRjN2tTeI/lpku/TmWpLatFBGzmd+hWxjc2wX5puVDVV5udYc1sJ2gV84gLsm4JBitSify
 K5wSuT3ru0ukvP0Qm+44T6QfbKhhwVlBhKtah6gtfvPjc3WfGtsdxdXlUo9U2zf0nCUxiEsNA
 4VopLqh7SJj7v29cj3kHoWw8g4AhCdADHBF6xJtbU4qv0njXf50y39d+ZQZpK7GbyVCUknIG7
 /XzU6M4rdVWs9uTJLCxECas+u3Oiu2whlLBQpheKYQppFaILEEupwgHZR5560WhJZl1Iuiehb
 abXpwkuJTJgbM2m+HnVpKRRVo1tr1cy0oblqS/tjyuy81U+rbbIieOnQ8Tyjnihdg5t2GKKyv
 E07kFF8CZc3yelXZcAblhcJILhKdOzp6AWSQBHryT1YqVXCld9taZthxSu/twU5daPvPI/EJB
 tRG1GZF6Y5NX/3F+o6tJqEd79qdDDQTnmPnoK7gI7NnMq5xt/edW1mxDx2i+iUZaJyvw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have replacements for all the deprecated timespec based interfaces now,
so this can finally convert iio_get_time_ns() to consistently use the
nanosecond or timespec64 based interfaces instead, avoiding the y2038
overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/industrialio-core.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d2962a..fcbe92c34a3d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -207,35 +207,27 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
  */
 s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 {
-	struct timespec tp;
+	struct timespec64 tp;
 
 	switch (iio_device_get_clock(indio_dev)) {
 	case CLOCK_REALTIME:
-		ktime_get_real_ts(&tp);
-		break;
+		return ktime_get_real_ns();
 	case CLOCK_MONOTONIC:
-		ktime_get_ts(&tp);
-		break;
+		return ktime_get_ns();
 	case CLOCK_MONOTONIC_RAW:
-		getrawmonotonic(&tp);
-		break;
+		return ktime_get_raw_ns();
 	case CLOCK_REALTIME_COARSE:
-		tp = current_kernel_time();
-		break;
+		return ktime_to_ns(ktime_get_coarse_real());
 	case CLOCK_MONOTONIC_COARSE:
-		tp = get_monotonic_coarse();
-		break;
+		ktime_get_coarse_ts64(&tp);
+		return timespec64_to_ns(&tp);
 	case CLOCK_BOOTTIME:
-		get_monotonic_boottime(&tp);
-		break;
+		return ktime_get_boot_ns();
 	case CLOCK_TAI:
-		timekeeping_clocktai(&tp);
-		break;
+		return ktime_get_tai_ns();
 	default:
 		BUG();
 	}
-
-	return timespec_to_ns(&tp);
 }
 EXPORT_SYMBOL(iio_get_time_ns);
 
-- 
2.9.0


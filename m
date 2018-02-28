Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeB1GNC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:13:02 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38492 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeB1GNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:13:01 -0500
X-Google-Smtp-Source: AH8x2250OFYb6pox6spdPX6UrPibthB6/x0EDAyOLIYk6FFVQhE6wuIocv+BRyUt5cVPoIRbu0uhBw==
From: Baolin Wang <baolin.wang@linaro.org>
To: john.stultz@linaro.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] frv: Use read_persistent_clock64() instead of read_persistent_clock()
Date: Wed, 28 Feb 2018 14:12:21 +0800
Message-Id: <f2de8f61dbab9a2c0aeb246084c90c528f32dc0e.1519798148.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct timespec is not y2038 safe on 32bit systems, thus this patch
converts the read_persistent_clock() to read_persistent_clock64() with
using struct timespec64. We also use time64_t type to record system time
by converting the mktime() to mktime64() .

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/frv/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
index 332e00b..5f5e90e 100644
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -85,7 +85,7 @@ void time_divisor_init(void)
 }
 
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
@@ -101,7 +101,7 @@ void read_persistent_clock(struct timespec *ts)
 
 	if ((year += 1900) < 1970)
 		year += 100;
-	ts->tv_sec = mktime(year, mon, day, hour, min, sec);
+	ts->tv_sec = mktime64(year, mon, day, hour, min, sec);
 	ts->tv_nsec = 0;
 }
 
-- 
1.7.9.5

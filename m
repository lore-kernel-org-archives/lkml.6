Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9842BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB6720852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB6720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934879AbeFROYB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:24:01 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:32857 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934281AbeFROX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:23:59 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MKqyu-1fUv4V12zw-0001kL; Mon, 18 Jun 2018 16:23:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: ab8500: stop using getnstimeofday64()
Date:   Mon, 18 Jun 2018 16:23:29 +0200
Message-Id: <20180618142352.3556062-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:usRvYXqg3weoB0ZzPzIKN316WP1UyIzsZNUcxBIDxp7+csDeW+C
 yTnfsmoPIglqmOztZDRnbVSuKKngen/iWCb10JQ6n3YG9nAepp1Ase+yd856loIxTy59lVu
 sW8Yy+zfzJQSK3boDO5jn0NJ6mmq/PxN93qX8LXCzAVr7tzebRsbgk7OM+9kPvK0mhXSpxn
 vu2D2cFbx3rR8A8w6IctQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J5ecXc/FrVk=:XYUVjA4jUXNoLP1IkG0SGf
 wiHkuxMJsYdh1wopTbJpPxM/EYRWRoGLPZOxp3kjrb9XCK3A0ufJLShKvlMUOVrDHG3hQSvcF
 5AFYOB5ZCh2Lv+g3bV93+B3tiV/oW+zQPKWHDYeTF4CDzyu6XkTvvSnp60sDPSKuOzX2mNCD2
 9czYGVFNSQMhmgZkpMzZdJHdPw0x+ci0zbDFcE9XLEP006j95TMdSx8a57hiuhzAJiS9C6eWs
 no5druOwOLxsvnPprAtrHQkaSS6fGbjTQopieFu+IABjh90DTmMKALxddWoX/pTfZyGT9cFFE
 E0iExzDhX7Xi8j0bUpFSApCOhpUMvFbPXfYwl6vM7Vgwd9CWoECff/B7r8Jp7DCfMKlfwY/27
 RFOrLhUjeB0tcsj5D5rL7p4yUsnfsPcq+O8sbWHU3ev3BPLidf527n2Ax9IVedS6X1IrNjUmO
 yN1PcPIJzLS+hbRtXUD3bh/A3TF8Wmcj95PZd6EReRXMMa74gikK4ElI75rou4wMOvOOfLkYa
 pwvwmG5YT+Yg8hnUHdUlVUvKfffK6/L+WQK02sIVXtC4UlvElXK8HfyG1ywlyczFc5RwaSoi+
 gfqEO/wjbSOzv37/P4BvlvefYF9MXLbf4AGHQta6KSaohxXDyouxw+zrabUVYj4PgXp9Uz1vS
 ZAuL5B635c9n78iLKNGdpuSfoyJ5eaeGs3/AVn6FAkgjcoEmGzouR7Xyxx1Qbo2ykhrk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getnstimeofday64() is deprecated in favor of the ktime_get() family.

The direct replacement would be ktime_get_real_ts64(), but we only need
the seconds value, and it seems better to use boottime than real time
to avoid unexpected behavior with a concurrent settimeofday().

ktime_get_seconds() might also work, but it seems better to use
boottime than monotonic time since I assume that the charging
process continues during suspend.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/ab8500_fg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index d9c6c7bedd85..02356f9b5f22 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -379,15 +379,13 @@ static int ab8500_fg_is_low_curr(struct ab8500_fg *di, int curr)
  */
 static int ab8500_fg_add_cap_sample(struct ab8500_fg *di, int sample)
 {
-	struct timespec64 ts64;
+	time64_t now = ktime_get_boottime_seconds();
 	struct ab8500_fg_avg_cap *avg = &di->avg_cap;
 
-	getnstimeofday64(&ts64);
-
 	do {
 		avg->sum += sample - avg->samples[avg->pos];
 		avg->samples[avg->pos] = sample;
-		avg->time_stamps[avg->pos] = ts64.tv_sec;
+		avg->time_stamps[avg->pos] = now;
 		avg->pos++;
 
 		if (avg->pos == NBR_AVG_SAMPLES)
@@ -400,7 +398,7 @@ static int ab8500_fg_add_cap_sample(struct ab8500_fg *di, int sample)
 		 * Check the time stamp for each sample. If too old,
 		 * replace with latest sample
 		 */
-	} while (ts64.tv_sec - VALID_CAPACITY_SEC > avg->time_stamps[avg->pos]);
+	} while (now - VALID_CAPACITY_SEC > avg->time_stamps[avg->pos]);
 
 	avg->avg = avg->sum / avg->nbr_samples;
 
@@ -439,14 +437,14 @@ static void ab8500_fg_clear_cap_samples(struct ab8500_fg *di)
 static void ab8500_fg_fill_cap_sample(struct ab8500_fg *di, int sample)
 {
 	int i;
-	struct timespec64 ts64;
+	time64_t now;
 	struct ab8500_fg_avg_cap *avg = &di->avg_cap;
 
-	getnstimeofday64(&ts64);
+	now = ktime_get_boottime_seconds();
 
 	for (i = 0; i < NBR_AVG_SAMPLES; i++) {
 		avg->samples[i] = sample;
-		avg->time_stamps[i] = ts64.tv_sec;
+		avg->time_stamps[i] = now;
 	}
 
 	avg->pos = 0;
-- 
2.9.0


Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE69AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7723A20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7723A20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeGKMvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:51:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKMvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:51:52 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LxLzO-1gAW863Lqc-016tLb; Wed, 11 Jul 2018 14:47:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Stultz <john.stultz@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] rtc: use ktime_get_real_ts64() instead of getnstimeofday64()
Date:   Wed, 11 Jul 2018 14:47:12 +0200
Message-Id: <20180711124723.1114803-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:sIg3VFIe/kxFS7TzZf0XZAAdA6o3MkTkVBLkgVKw9hbAqM+p5/s
 g9ncHOwPQv14GsRhsb0jAfD1KOYoT+uewvs6oYTIuPvtE+QxddPxQ0pdRcjjtKocZDV8v8V
 k93sAiu2p9AD7ehZjEg/hCow/gyb+mYS8deE9KjCMz2xsnDmqkCXhB0qUqCxQLOSKadfA1q
 Mk5qN3KyWqSpoFxDVRDGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:989l6+6AYpw=:h9ioO5utxpWXAvOCZt9Bvz
 soVqRJsQ+EAx2MZYK0bPVqCVjTfOeawBVbvjA53yPgr2wMGKbclC1zuZxH39mCGwXGwv+/FJq
 P0GiQO6+FvT38WTECe45uUoYuf695kO77epPg3ziXKlOT2QxDnU/MbZW0dT3FBLAtbcLUruHb
 QhIwhVg65F8/VgyIAtIMHCp2GEyXZCwAy+rytgiea+fSH4uHYtXIm//iuWq1StHopi5pQdmTn
 MHiTGJlwF5WVuHCUZ/gpzocW5jRzHNgO9+vswaNxuMpurIkenlaUfBMhQMYGl6CwMlY5TNaGy
 aI2aU2Du7YCDiwGeuZ03KbwEw4iJRii/ikfJGcdUyE7aK5IE1ve9q/3aQlEjZ0lTHMYLih+kd
 5wyYwMa+Hd1iyPHYcvru++avTqE3z3sc3u9glv5PUNUkmWvFi6JWlu1Ttkea0j6/5dZPqU5Fb
 LCen4zTokNze8lajhc+i12FrBHqKu5OP8rnG4IkczcZ4VqbO4L8MGOOAPkh1d0BSNuc0u61LR
 AC45ycDmnj69tbaqQeMu4iNxIXbEg8/Fbd0y19ooruGWUMqodwcWN8X/5KSKJ5jkhgvwFZThF
 2S4vBA6N+ut7resYuZA2dnVAyOtuNwDMR25tD5T7VMSwIDWeklywT2VjefGuN3CtI5PqgZfpp
 Ot6V9eA90sosndLOwzbg04edpJDlh7q2ztxxetmv2XVCYluG7XArrWm4wr7gosqd1DWA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getnstimeofday64() is just a wrapper around the ktime accessor, so
we should use that directly.

I considered using ktime_get_boottime_ts64() (to avoid leap second
problems) or ktime_get_real_seconds() (to simplify the calculation,
but in the end concluded that the existing interface is probably
the most appropriate in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent on Jun 18, but got no reply

Alexandre, could you pick this up into the rtc tree?
---
 drivers/rtc/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index d37588f08055..7fa32c922617 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -68,7 +68,7 @@ static int rtc_suspend(struct device *dev)
 		return 0;
 	}
 
-	getnstimeofday64(&old_system);
+	ktime_get_real_ts64(&old_system);
 	old_rtc.tv_sec = rtc_tm_to_time64(&tm);
 
 
@@ -110,7 +110,7 @@ static int rtc_resume(struct device *dev)
 		return 0;
 
 	/* snapshot the current rtc and system time at resume */
-	getnstimeofday64(&new_system);
+	ktime_get_real_ts64(&new_system);
 	err = rtc_read_time(rtc, &tm);
 	if (err < 0) {
 		pr_debug("%s:  fail to read rtc time\n", dev_name(&rtc->dev));
-- 
2.9.0


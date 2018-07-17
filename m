Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7436DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299FC2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGvWeulj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299FC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeGQL52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:57:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41398 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731194AbeGQL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:57:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so311343pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=h5pyTBJ057uXRLaH+mRr4AZ+5BautkbuTr1+Xl62gvQ=;
        b=BGvWeuljeongoABnA5xSmIk38nlKLK/kumQ2OXXnH6PothQvKj5Ov9wKXqBUx1yw5C
         P21E/0H8ri+8CrvYPFjmbBC0r5K0BRMqi5iYxdp7ad8RR1ixq1kymhdeTT7QE+U+v+6y
         5GFiO6AfosnoEC2veisRX7kST2pGKkxsPOIKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=h5pyTBJ057uXRLaH+mRr4AZ+5BautkbuTr1+Xl62gvQ=;
        b=SMZq2eueXjRYdw+CdXwUl0APEjC0V34IQgCBbdmg0oIbEIJkK9ViPdjE2oSVsgDf59
         iHFS67aqhOkcqtLgy6nilhY9BVL8FgYe9mFZuMpU+kNw2vlA/5UEzeEChssWGLk4epgd
         aSY66CMbVnmHEIZDv9hEijIs74vo2w6zwqJBA+m00vXXuVkK0g2DchEy6+13jqU1kwyz
         2YLySDN4Eq4mP/ko2Pn5Fz7FuHgqqPc0erSGMI63TFFQoOnW6gNZm8N4WTP1e/+WZKhC
         o64QqdTIlEvmMVTUhypV3xyMNqsDUAS1vA+Ju1S1OanKzs7uAc01300WGa0hcp2I4Og/
         YlOg==
X-Gm-Message-State: AOUpUlHXy9ToK35+HK78PjWEIzamT5EsbEjBJ+tj49fG0FLHUQkdlHeV
        Kq77yKX69NCwVDYYzKGpWkDP2Q==
X-Google-Smtp-Source: AAOMgpcqo65mJuS0JOHoycEmNoSSysehi88+Kks0bC3V30jrKvFMpkP3I9eh17JhP4TKOWn8zysZIw==
X-Received: by 2002:a65:6258:: with SMTP id q24-v6mr1193561pgv.131.1531826716845;
        Tue, 17 Jul 2018 04:25:16 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y3-v6sm1391207pge.29.2018.07.17.04.25.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 04:25:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ysato@users.sourceforge.jp, dalias@libc.org, corbet@lwn.net
Cc:     baolin.wang@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 3/4] sh: remove unused rtc_sh_get/set_time infrastructure
Date:   Tue, 17 Jul 2018 19:24:26 +0800
Message-Id: <b4cd85cb5f115b52ac24b237d681e543aec0edf7.1531826106.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
References: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
In-Reply-To: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
References: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All platforms are now converted to RTC drivers, so this has become
obsolete. The board_time_init() callback still has one caller, but
could otherwise also get killed.

This removes one more usage of the deprecated timespec structure,
which overflows in y2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/sh/include/asm/rtc.h |    2 --
 arch/sh/kernel/time.c     |   69 ---------------------------------------------
 2 files changed, 71 deletions(-)

diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index c63555e..fe55fbb 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -4,8 +4,6 @@
 
 void time_init(void);
 extern void (*board_time_init)(void);
-extern void (*rtc_sh_get_time)(struct timespec *);
-extern int (*rtc_sh_set_time)(const time_t);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index fcd5e41..eb0a912 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,75 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-/* Dummy RTC ops */
-static void null_rtc_get_time(struct timespec *tv)
-{
-	tv->tv_sec = mktime(2000, 1, 1, 0, 0, 0);
-	tv->tv_nsec = 0;
-}
-
-static int null_rtc_set_time(const time_t secs)
-{
-	return 0;
-}
-
-void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
-int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
-
-void read_persistent_clock(struct timespec *ts)
-{
-	rtc_sh_get_time(ts);
-}
-
-#ifdef CONFIG_GENERIC_CMOS_UPDATE
-int update_persistent_clock(struct timespec now)
-{
-	return rtc_sh_set_time(now.tv_sec);
-}
-#endif
-
-static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
-{
-	struct timespec tv;
-
-	rtc_sh_get_time(&tv);
-	rtc_time_to_tm(tv.tv_sec, tm);
-	return 0;
-}
-
-static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-{
-	unsigned long secs;
-
-	rtc_tm_to_time(tm, &secs);
-	if ((rtc_sh_set_time == null_rtc_set_time) ||
-	    (rtc_sh_set_time(secs) < 0))
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static const struct rtc_class_ops rtc_generic_ops = {
-	.read_time = rtc_generic_get_time,
-	.set_time = rtc_generic_set_time,
-};
-
-static int __init rtc_generic_init(void)
-{
-	struct platform_device *pdev;
-
-	if (rtc_sh_get_time == null_rtc_get_time)
-		return -ENODEV;
-
-	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
-					     &rtc_generic_ops,
-					     sizeof(rtc_generic_ops));
-
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-device_initcall(rtc_generic_init);
-
 void (*board_time_init)(void);
 
 static void __init sh_late_time_init(void)
-- 
1.7.9.5


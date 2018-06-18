Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411D0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110C208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F110C208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934931AbeFROVU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:21:20 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933445AbeFROVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:21:19 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MP3gp-1fXMvo3hZ9-006SEP; Mon, 18 Jun 2018 16:21:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Cochran <richardcochran@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <fabio.estevam@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: replace getnstimeofday64() with ktime_get_real_ts64()
Date:   Mon, 18 Jun 2018 16:20:39 +0200
Message-Id: <20180618142109.3445025-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:DyjzbJGryhQxvJQc2aQ48knZXBAaUySvgqWgTCV1ih6dJJVXN2v
 Yg0TEgh5qeFayPMpvvEueyRhuFupmjG6bXsSfWxNGuCc+RyBLF9D0VhNvFtk7tYslqjzfT6
 e6EE8vrW5P4+W4qwbLQq22wO27FLIZgHnXGafyFkgNIDJ2ZD8mdqHV05nX2N9/jikYO9vPR
 7PIJbMhv5+LdH8eIRmzoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BSYMvt0trUQ=:z0Y6m1VZk5HcmOW7uN4wlv
 DyqnxhmhFJQo5E0Nn7AEw+sqkel/S5WhbApyM6rMG6s7rnJFjeWO1iofIOgAmxL7Cu6Yl/a6y
 pUI7AFAVRbGLIVDbwAG7cQ3VmqpshB8ktmVEStMnDUsPD8yWJ/KoZQqa3j0J6+xqfyGR5H6F5
 YFlQuBgY7PDx8Yn+hQrF4CVVawUazabUmzwPaA7mYo7Iv0D+PDqAoVgvOJ+Q+YcH2/gKmvuuE
 VENWSb4kk4IiBRLC8ymRxI9cM3fGHVpwt/cS4jBA4UmmVNeNUvx6HQwGCwuDjdY12XM7pbabe
 Zfy9rsJqVR6E1ihvhsntbXur9JDVyvEFT4+sOR3ThiGoIfTNOSC6ie7QZ+HeuBpsbeQpvIzH+
 hRRY6QQ4gxKWYDE7F7EiLwwyNye6P0d9DVvZ+eQcIiN0Kw/WacmSVJHjXDqwSNvTJDobRmCfV
 A1g6vHwJtRtL84vFU+GuKtSlkiaxIm9B3CBwW/H+Yxt33K1RuJop1D8DRF5/Zqqu0VjT1T83T
 ssu6dKgwoUGe0b52srldtLNRfRL+KFX3wHSgf0nmu5eRbT1YLdbW+Wze3HgWD0kCnHR0cuIYa
 1luSEKrWLMfBfLRAWXvoxEDkqW0Z9QbQfxAoUhnoFBs1OTYYzfMZhy5QOgOng6paUT+zFXrJ9
 +j5Jg9HtUnZIT51R5XR2SbgNUvm7K0nhtb7pqCV5P+V0bqlTViNsQBNpjABcRxts/vfs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getnstimeofday64() is deprecated and getting replaced throughout
the kernel with ktime_get_*() based helpers for a more consistent
interface.

The two functions do the exact same thing, so this is just
a cosmetic change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ptp/ptp_chardev.c | 4 ++--
 drivers/ptp/ptp_qoriq.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 767c485af59b..547dbdac9d54 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -221,7 +221,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 		}
 		pct = &sysoff->ts[0];
 		for (i = 0; i < sysoff->n_samples; i++) {
-			getnstimeofday64(&ts);
+			ktime_get_real_ts64(&ts);
 			pct->sec = ts.tv_sec;
 			pct->nsec = ts.tv_nsec;
 			pct++;
@@ -230,7 +230,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 			pct->nsec = ts.tv_nsec;
 			pct++;
 		}
-		getnstimeofday64(&ts);
+		ktime_get_real_ts64(&ts);
 		pct->sec = ts.tv_sec;
 		pct->nsec = ts.tv_nsec;
 		if (copy_to_user((void __user *)arg, sysoff, sizeof(*sysoff)))
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 1468a1642b49..e8652c148c52 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -374,7 +374,7 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 		pr_err("ioremap ptp registers failed\n");
 		goto no_ioremap;
 	}
-	getnstimeofday64(&now);
+	ktime_get_real_ts64(&now);
 	ptp_qoriq_settime(&qoriq_ptp->caps, &now);
 
 	tmr_ctrl =
-- 
2.9.0


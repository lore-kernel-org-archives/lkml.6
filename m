Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeE1SCM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:02:12 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39484 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932655AbeE1SCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:02:04 -0400
X-Google-Smtp-Source: ADUXVKKrEzWBPVUHujvO3Jprwy68x1G3AuiItl92fJoSMvgyjrxxmXHedjYQHSvZ7JExBlRDuM+y3g==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 3/6] watchdog: sp805: add 'timeout-sec' DT property support
Date: Mon, 28 May 2018 11:01:34 -0700
Message-Id: <1527530497-10392-4-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for optional devicetree property 'timeout-sec'.
'timeout-sec' is used in the driver if specified in devicetree.
Otherwise, fall back to driver default, i.e., 60 seconds

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp805_wdt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 03805bc..1484609 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -230,7 +230,14 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	spin_lock_init(&wdt->lock);
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
-	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
+
+	/*
+	 * If 'timeout-sec' devicetree property is specified, use that.
+	 * Otherwise, use DEFAULT_TIMEOUT
+	 */
+	wdt->wdd.timeout = DEFAULT_TIMEOUT;
+	watchdog_init_timeout(&wdt->wdd, 0, &adev->dev);
+	wdt_setload(&wdt->wdd, wdt->wdd.timeout);
 
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
-- 
2.1.4

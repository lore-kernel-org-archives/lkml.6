Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeENOwz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:52:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39985 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeENOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:52:53 -0400
X-Google-Smtp-Source: AB8JxZoX7az944KsOBTtqjkopidkgffOaFrnCUb15gpktdGjToA7WPhCVAvHJvAzz0uxv/bNoMAX4g==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc @ vger . kernel . org"
        <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM domain exists
Date: Mon, 14 May 2018 16:52:37 +0200
Message-Id: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
to devices, clearly we must allow a device to have the pointer already
being assigned. For this reason, return 0 instead of -EEXIST.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Krzysztof reported problems for an Exynos5 board, where some devices are added
to their PM domains (genpd) via calling of_genpd_add_device(). As also pointed
out by Sylvester, this leads to probe failure when dev_pm_domain_attach()
returns -EXISTS.

Rafael, potentially this change could be squashed with the recently queued
patch: "PM / Domains: Check for existing PM domain in dev_pm_domain_attach()",
but perhaps its too late for that and the fix is better applied on top!?

---
 drivers/base/power/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 5e4b481..390868c 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -106,7 +106,7 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 	int ret;
 
 	if (dev->pm_domain)
-		return -EEXIST;
+		return 0;
 
 	ret = acpi_dev_pm_attach(dev, power_on);
 	if (!ret)
-- 
2.7.4

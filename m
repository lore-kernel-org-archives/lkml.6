Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2403FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C4A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749568;
	bh=DDiRvtPJqkBjJTbTwZbH4UyrKTh1xz3PTGlChDmk9Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wAtU2DjQuFFUfJuWC1ynUywc8a6LNCM8A3MpXpYwOcx0lIeMeNk+wlejHUlMCfLL6
	 fIDLnIyKlVfZsErMg7oELb/CQhkzDjcvVre2kfOVcpRZroczkL9H1nrlWSZnF2SGd5
	 z16RK2+K0NR80oKHESXcPaq8M1EsCirYoZn92VUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfBULqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfBULqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:46:04 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7319D2147A;
        Thu, 21 Feb 2019 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550749563;
        bh=DDiRvtPJqkBjJTbTwZbH4UyrKTh1xz3PTGlChDmk9Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9YLZiZymjeeHf4vGZAeZNVfhGzXgQ8Ri7LEn4S3ROGgZvskNXNL7BGYc+uAHcQAJ
         0yAQn3VoOvcb3HJ0hADwAJGjUafEvvllAyd4EmyQZPmvXYS4unPB5mQt+GZYRS16qe
         gJgyEjZnkOO1Oq3lB+34CqPl/Sp6lAlGCEGtZ/JA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH v2 2/2] clk: samsung: exynos5: Fix kfree() of const memory on setting driver_override
Date:   Thu, 21 Feb 2019 12:45:52 +0100
Message-Id: <1550749552-8133-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550749552-8133-1-git-send-email-krzk@kernel.org>
References: <1550749552-8133-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform driver driver_override field should not be initialized from
const memory because the core later kfree() it.  If driver_override is
manually set later through sysfs, kfree() of old value leads to:

    $ echo "new_value" > /sys/bus/platform/drivers/.../driver_override

    kernel BUG at ../mm/slub.c:3960!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
    ...
    (kfree) from [<c058e8c0>] (platform_set_driver_override+0x84/0xac)
    (platform_set_driver_override) from [<c058e908>] (driver_override_store+0x20/0x34)
    (driver_override_store) from [<c031f778>] (kernfs_fop_write+0x100/0x1dc)
    (kernfs_fop_write) from [<c0296de8>] (__vfs_write+0x2c/0x17c)
    (__vfs_write) from [<c02970c4>] (vfs_write+0xa4/0x188)
    (vfs_write) from [<c02972e8>] (ksys_write+0x4c/0xac)
    (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

The clk-exynos5-subcmu driver uses override only for the purpose of
creating meaningful names for children devices (matching names of power
domains, e.g. DISP, MFC).  The driver_override was not developed for
this purpose so just switch to default names of devices to fix the
issue.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index d07ef26bd052..8ae44b5db4c2 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -138,12 +138,11 @@ static int __init exynos5_clk_register_subcmu(struct device *parent,
 	struct platform_device *pdev;
 	int ret;
 
-	pdev = platform_device_alloc(info->pd_name, -1);
+	pdev = platform_device_alloc("exynos5-subcmu", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return -ENOMEM;
 
 	pdev->dev.parent = parent;
-	pdev->driver_override = "exynos5-subcmu";
 	platform_set_drvdata(pdev, (void *)info);
 	of_genpd_add_device(&genpdspec, &pdev->dev);
 	ret = platform_device_add(pdev);
-- 
2.7.4


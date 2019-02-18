Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A95C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341112175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550485011;
	bh=ddJqJt7L1B19SoK0shSpKHfK4DacqUl0AdkTNtfUPec=;
	h=From:To:Subject:Date:List-ID:From;
	b=oUeH65zE/PCaEU3//qn+VDxH4G81WlcRQY62f9uUvZvn99KGSRi4qhL1Zx5gn5HL2
	 FyFHuNUGUgBYamix8SmwWKJIadlPOQD3rqDW1F6HZO54UuuzQWw6Jt9XyHL+Usr6ka
	 I0G2+OqrKUXRScb/uxcG7kaKUFeWLQhwE0wjpsHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfBRKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:16:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfBRKQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:16:49 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B854B21736;
        Mon, 18 Feb 2019 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550485009;
        bh=ddJqJt7L1B19SoK0shSpKHfK4DacqUl0AdkTNtfUPec=;
        h=From:To:Subject:Date:From;
        b=fhEyw7A+rYG2d125tPjdiE1N0SW2Qrl8r7RweaM6UQmZ8IAr9oTmyIASpJx/Tl7dz
         K0sQcn4ieyfLy2WdcM2j/0sl2vtujVIgB2tMkZ4w4kKgUFZrpWinGMF2ke0Hbn1fOX
         oBO+PSeFxX44hdHyi/lyiG6OSSiqWsOIE95e/EWQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on setting driver_override
Date:   Mon, 18 Feb 2019 11:15:56 +0100
Message-Id: <1550484960-2392-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The problem
===========
Several device types (platform, amba, spi etc.) provide a driver_override
field.  On sysfs store or during device removal, they kfree() the
existing value.

However the users are unaware of this and set the driver_override like:

 	pdev->driver_override = "exynos5-subcmu";

which obviously leads to error.

Solution
========
I provided simple helper for platform device.  If this approach is
acceptable, I can convert also other buses, like AMBA, SPI.


Dependencies and pick up order
==============================
Patch 1: please pick it as is through clock tree
Patch 3: Depends on patch 1 (merge conflict) and 2.
Patch 4: Depends on patch 2.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  clk: samsung: exynos5: Fix possible NULL pointer exception on
    platform_device_alloc() failure
  driver: platform: Provide helper for safer setting of driver_override
  clk: samsung: exynos5: Fix kfree() of const memory on setting
    driver_override
  slimbus: ngd: Fix kfree() of const memory on setting driver_override

 drivers/base/platform.c                  | 63 ++++++++++++++++++++++----------
 drivers/clk/samsung/clk-exynos5-subcmu.c | 12 ++++--
 drivers/slimbus/qcom-ngd-ctrl.c          |  2 +-
 include/linux/platform_device.h          |  9 ++++-
 4 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.7.4


Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD6A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749564;
	bh=tG8WG6JLvjiga0m3PXtQzUYRvGvnMVYjtxeMvSz9qvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flEkqDpNnym1jI7Lhhp5sd49GYQdnSIBEsZF6oWRRZZkYOeODoqURo7gvXh2VQ4/0
	 p89V0U6C+YWl+BSSxEbPRH8A7oLkGPyeEOKw3Uur1anmS1oLmAesxGQxiiStPMgofp
	 6/sLQzmj+fPvGhZylnRdffZEqntkmpjzxuZTV7Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBULqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfBULqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:46:01 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104B02148D;
        Thu, 21 Feb 2019 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550749561;
        bh=tG8WG6JLvjiga0m3PXtQzUYRvGvnMVYjtxeMvSz9qvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZthLHshe9B5RyQqem0wd2tlKcJIiil5pMXO1Q57UQaqcaOik8LknXMuoFUap6Q1OJ
         KzC53cnbIpZQKDakUbQ6OAPoS2Jz4rasjbSMHrNdipIIfkkjZbrmRa9puBUlSFOPvd
         EVax4flRmHnJf8+6EZEJpBj0QeJU141ClyiEcPoQ=
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
Subject: [PATCH v2 1/2] clk: samsung: exynos5: Fix possible NULL pointer exception on platform_device_alloc() failure
Date:   Thu, 21 Feb 2019 12:45:51 +0100
Message-Id: <1550749552-8133-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550749552-8133-1-git-send-email-krzk@kernel.org>
References: <1550749552-8133-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During initialization of subdevices if platform_device_alloc() failed,
returned NULL pointer will be later dereferenced.  Add proper error
paths to exynos5_clk_register_subcmu().  The return value of this
function is still ignored because at this stage of init there is nothing
we can do.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 93306283d764..d07ef26bd052 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -136,15 +136,21 @@ static int __init exynos5_clk_register_subcmu(struct device *parent,
 {
 	struct of_phandle_args genpdspec = { .np = pd_node };
 	struct platform_device *pdev;
+	int ret;
 
 	pdev = platform_device_alloc(info->pd_name, -1);
+	if (!pdev)
+		return -ENOMEM;
+
 	pdev->dev.parent = parent;
 	pdev->driver_override = "exynos5-subcmu";
 	platform_set_drvdata(pdev, (void *)info);
 	of_genpd_add_device(&genpdspec, &pdev->dev);
-	platform_device_add(pdev);
+	ret = platform_device_add(pdev);
+	if (ret)
+		platform_device_put(pdev);
 
-	return 0;
+	return ret;
 }
 
 static int __init exynos5_clk_probe(struct platform_device *pdev)
-- 
2.7.4


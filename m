Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45FB21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550485028;
	bh=gNf/5Uk/N77EbTBib61uKhWZvxLozaD5/JezwNFwHzw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hd4RJ1fHENUoMG1mZV1sSKMaeA4rYDl63oMEbBacb138p6IPJB+845ai1Fn85hW9I
	 DJAUihUYeDyYsSu0cXmJ7iRHTwBKnNMVEZbzCqwfijOOrsIoaSZA090Q8y/Ob6s50M
	 sIAHRQI3bN+Xqe0qaYEba8WrmDNM7jpVLuzLhE2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfBRKRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:32854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfBRKRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:17:04 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A3421848;
        Mon, 18 Feb 2019 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550485024;
        bh=gNf/5Uk/N77EbTBib61uKhWZvxLozaD5/JezwNFwHzw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vAsukM95NUgr4qNKVk5IRNPMc2r5dElrspwsCt8JStKBTfiYNP5AERGeI9p5RtiUF
         LYAcQEOMzfWkf4CX30NXtxkz314WbP7KT8GfziSgzDJICueG5P0YRpxkOBrsYvI0VG
         RUX8kQuIyNfWmaFiSxDaCUEs2v8BaYM1apg82I6I=
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
Subject: [RFC 4/4] slimbus: ngd: Fix kfree() of const memory on setting driver_override
Date:   Mon, 18 Feb 2019 11:16:00 +0100
Message-Id: <1550484960-2392-5-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550484960-2392-1-git-send-email-krzk@kernel.org>
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
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

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec68..fc46bf6ec903 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1344,7 +1344,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
-		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
+		platform_set_driver_override(ngd->pdev, QCOM_SLIM_NGD_DRV_NAME);
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
 		platform_set_drvdata(ngd->pdev, ctrl);
-- 
2.7.4


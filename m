Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23876C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF4D218DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549669176;
	bh=9ubX/au2dWVjytwhvCV+q9GXk0eeWyNXhgEMCJ9CNSE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y7/YYcfO4HghGSr1miEOB4T644m79xZPv+j24kVwwOP8TL8S8IHL0ZGLIRJ8EzNAo
	 6L6BSya8OfcRD4jSE6qMDkCAs3GyxkW7Zqdg3IcY9RhypEIyR4ofTVY9qw0vEl5dZw
	 lKZ3VDmu9EytvNQqPTBFnzRa9GGII0GV0gMvxrAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBHXjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfBHXjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:39:35 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BDE21841;
        Fri,  8 Feb 2019 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549669174;
        bh=9ubX/au2dWVjytwhvCV+q9GXk0eeWyNXhgEMCJ9CNSE=;
        h=From:To:Cc:Subject:Date:From;
        b=jt9t/toj2uHZUHNa6wKwZ7Ti1eePDNZUVB4vaYk0+JMfOJYpNto7F5G/pvWKr5Avi
         Ezi2jIkukYXSNn1TS/ZPiP+ge6PVOwWf76IqUAu6unORnN2WoMlReWD0WSFxOV/8iF
         gMcvGiEppUv6N5AglpYxVmtE2VHX2M/UWqoc8se0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH]  iio: adc: exynos-adc: Fix NULL pointer exception on unbind
Date:   Sat,  9 Feb 2019 00:39:27 +0100
Message-Id: <20190208233927.5392-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer exception on device unbind when device tree does not
contain "has-touchscreen" property.  In such case the input device is
not registered so it should not be unregistered.

    $ echo "12d10000.adc" > /sys/bus/platform/drivers/exynos-adc/unbind

    Unable to handle kernel NULL pointer dereference at virtual address 00000474
    ...
    (input_unregister_device) from [<c0772060>] (exynos_adc_remove+0x20/0x80)
    (exynos_adc_remove) from [<c0587d5c>] (platform_drv_remove+0x20/0x40)
    (platform_drv_remove) from [<c05860f0>] (device_release_driver_internal+0xdc/0x1ac)
    (device_release_driver_internal) from [<c0583ecc>] (unbind_store+0x60/0xd4)
    (unbind_store) from [<c031b89c>] (kernfs_fop_write+0x100/0x1e0)
    (kernfs_fop_write) from [<c029709c>] (__vfs_write+0x2c/0x17c)
    (__vfs_write) from [<c0297374>] (vfs_write+0xa4/0x184)
    (vfs_write) from [<c0297594>] (ksys_write+0x4c/0xac)
    (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index fa2d2b5767f3..41da522fc673 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -929,7 +929,7 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	if (IS_REACHABLE(CONFIG_INPUT)) {
+	if (IS_REACHABLE(CONFIG_INPUT) && info->input) {
 		free_irq(info->tsirq, info);
 		input_unregister_device(info->input);
 	}
-- 
2.17.1


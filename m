Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB17C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774682082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2kcGKFpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774682082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeLEKMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeLEJhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:37:34 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B8F20850;
        Wed,  5 Dec 2018 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002653;
        bh=HR1cO4J51+ardDHb2i7e6cHJE6RkAn6CM6plKeHba+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2kcGKFptd3IXkJdDxFGzrBY3v1t27ZhohQ8ho+bmaxH/LxAXIRj2PID7SHrK1Xy/Q
         s4GYE5JqqNKk5OVncSEZxXTh9sclgRJB7uG5hiZgLZ93dtO4HJ+9w/ikkUBNqyjS5M
         K0hsPmqPaIB0DZUF2WPrsawXbOEnuRmFtp+gkW6g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 028/123] hwmon: (raspberrypi) Fix initial notify
Date:   Wed,  5 Dec 2018 04:34:20 -0500
Message-Id: <20181205093555.5386-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 35fdc3902179366489a12cae4cb3ccc3b95f0afe ]

In case an under-voltage happens before probing the driver wont
write the critical warning into the kernel log. So don't init
of last_throttled during probe and fix this issue.

Fixes: 74d1e007915f ("hwmon: Add support for RPi voltage sensor")
Reported-by: "Noralf Trønnes" <noralf@tronnes.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/raspberrypi-hwmon.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
index be5ba4690895..0d0457245e7d 100644
--- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -115,7 +115,6 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpi_hwmon_data *data;
-	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -124,11 +123,6 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 	/* Parent driver assure that firmware is correct */
 	data->fw = dev_get_drvdata(dev->parent);
 
-	/* Init throttled */
-	ret = rpi_firmware_property(data->fw, RPI_FIRMWARE_GET_THROTTLED,
-				    &data->last_throttled,
-				    sizeof(data->last_throttled));
-
 	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, "rpi_volt",
 							       data,
 							       &rpi_chip_info,
-- 
2.17.1


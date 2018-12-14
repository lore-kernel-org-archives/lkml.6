Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CB5C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B421204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791246;
	bh=tQ2YPL0/rbTqRWllxU3t/H0HwAeqhLOXZy66eIMQm+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D/nEnb7+pIjv8MKNm5aC53j6/EOsnrCGovTMQNZv9EYL6QLSkq8l5ZYGnFrGoj5wy
	 UkYLOwAJTmvte3IE34Lu+wYkaduIIbJCEdZ97ZKthvXBlumeoG7Es//Wp1iC8QO6rW
	 PrglayL5nRFNrSgoE7GY60PJbPbw+HPn0bQmgoOg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B421204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbeLNMkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730404AbeLNMD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A282145D;
        Fri, 14 Dec 2018 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789037;
        bh=tQ2YPL0/rbTqRWllxU3t/H0HwAeqhLOXZy66eIMQm+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz/enLSGuMvv3kzwnfwU6syQdNtiSspT7NpYWXGRfEe4oPOj4IpR7VCoYjiangydR
         tXUi5967SmEdhZRguxv8mjLcMb7VNMkJPhjTJeJtim4eJ4j6EOyBnXaZlZxeCFUemF
         O4Cs0V1ks4VB4VSAmTLHQwTvTb9Ge1dCSxFI5AKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/142] hwmon: (raspberrypi) Fix initial notify
Date:   Fri, 14 Dec 2018 12:58:52 +0100
Message-Id: <20181214115748.940358262@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1




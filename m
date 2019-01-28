Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F9221841
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691105;
	bh=KqiB6gvNbqn+PPSoljFqt6gvPdNwlItCDGyiKpEbLGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RE/2emx/COMMmRPwRMr5kb5gr3FB1vXDoe14y944ciACPQfcPxDz6iHSIVuEObokM
	 UX9+aMzKefqcPIAVt1EWwhI6OBGC6W2oDMDvb7TfRN3paql6djgn7aOFN33njA/sWu
	 6rangsx6mHCzcqnp/Y7CVo+BS/MSTJSTlG6O20GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfA1P6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbfA1P6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8632175B;
        Mon, 28 Jan 2019 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691100;
        bh=KqiB6gvNbqn+PPSoljFqt6gvPdNwlItCDGyiKpEbLGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioTizA82IdSv3FQAjsGwc2BPqoVHOWWemCbGpAFL+mTFV1QB8AJiYGyFFMWdjfczF
         1ZZPIS5zDmLXmQv0kTgf7MnPBDKskQd7EZmhhP+me8UDYd500yFj/38gmBH6t8VFla
         EqJntUF98OmfAEdieUHXsmwdEGBUpfAwcQeOJo/4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Brugger <mbrugger@suse.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 287/304] thermal: bcm2835: enable hwmon explicitly
Date:   Mon, 28 Jan 2019 10:43:24 -0500
Message-Id: <20190128154341.47195-287-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

[ Upstream commit d56c19d07e0bc3ceff366a49b7d7a2440c967b1b ]

By defaul of-based thermal driver do not enable hwmon.
This patch does this explicitly, so that the temperature can be read
through the common hwmon sysfs.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index b9d90f0ed504..720760cd493f 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
 
+#include "../thermal_hwmon.h"
+
 #define BCM2835_TS_TSENSCTL			0x00
 #define BCM2835_TS_TSENSSTAT			0x04
 
@@ -266,6 +268,15 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tz);
 
+	/*
+	 * Thermal_zone doesn't enable hwmon as default,
+	 * enable it here
+	 */
+	tz->tzp->no_hwmon = false;
+	err = thermal_add_hwmon_sysfs(tz);
+	if (err)
+		goto err_tz;
+
 	bcm2835_thermal_debugfs(pdev);
 
 	return 0;
-- 
2.19.1


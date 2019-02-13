Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0432C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F73920835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026572;
	bh=87Su++THVUbylBEst4T4Ns9gXIlih5RDN65mB1oshZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0aa4DIKYpSgfOFUrKWdHUsfuZp1ZXeiXQLjQasDmjZLUxf76JMfcdQUIzyngL5YrQ
	 oxwsnWtKfEMity77elnlmWyVY/8mm/hj02yTvFLiuehP16RZpL+QVJdqOL4VkdKMAq
	 OTrplk3P/5J1IikATUm00zruHs4/8mG7LzpxEr/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbfBMC4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388285AbfBMChW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F8A206B6;
        Wed, 13 Feb 2019 02:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025441;
        bh=87Su++THVUbylBEst4T4Ns9gXIlih5RDN65mB1oshZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfjKXOSEZVR3nIpttM3s9940QbDtX1Yr4aG+yMBpHDqri9zNVr7Ku+od3UtuTxVv2
         SxKQWGI6/FLEwvdlZ2dDokhkQ6x4P0zs0aeSBvKBXr62LGL35x2ffcQv0EOx1i0jF4
         s/+btGh3jvg216UR62KDEukqnoP2IxBKvRCVRomI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 17/83] mfd: cros_ec_dev: Add missing mfd_remove_devices() call in remove
Date:   Tue, 12 Feb 2019 21:35:55 -0500
Message-Id: <20190213023701.20286-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[ Upstream commit 18e294ddafaeb80a1e2e10c9bd750a6cb8388d5b ]

The driver adds different MFD child devices via mfd_add_devices() and
hence it is required to call mfd_remove_devices() to remove MFD child
devices.

Fixes: 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6b22d54a540d..bccde3eac92c 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -499,6 +499,7 @@ static int ec_device_remove(struct platform_device *pdev)
 
 	cros_ec_debugfs_remove(ec);
 
+	mfd_remove_devices(ec->dev);
 	cdev_del(&ec->cdev);
 	device_unregister(&ec->class_dev);
 	return 0;
-- 
2.19.1


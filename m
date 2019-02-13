Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7B0C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACD421934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025978;
	bh=8E+7059xRbmV189cNvMUwjiHKAtXN39+NDwbrKU2wLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfwrDStNwTZE0Qkr2NcAYxRCkQWPpaoNNkNd6q4HRQbP2RRZuNWfUGgWxxU/kMJ3a
	 6bP4iKL4lTW+VMp6LWhvU8raHEhT+z+Nj0tR+Gmnqs1wKAIOkWgbzXNYFdATKLBXQG
	 Zw92A5OiHdvLX+C45Gmv+UG/pTt8PxiTKc9Na9iU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbfBMCqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389096AbfBMCku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0372B222C2;
        Wed, 13 Feb 2019 02:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025649;
        bh=8E+7059xRbmV189cNvMUwjiHKAtXN39+NDwbrKU2wLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOI3YInWw320JMgkPxcnm4nT9ftlKkSL57ZehV/rgnqmRXwq6yK29Np/5dzatVX7g
         glNSM2th7oQ1IhN7Q2kP+OXh4lQKNkCABRuBWYkpC2Go4xaHqjadtliBZ5bpBi2Z15
         8ycvSak9pfApp63Kd0I+fscR9CYIT3D2usKiI82o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 08/21] mfd: mc13xxx: Fix a missing check of a register-read failure
Date:   Tue, 12 Feb 2019 21:40:27 -0500
Message-Id: <20190213024040.21740-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024040.21740-1-sashal@kernel.org>
References: <20190213024040.21740-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 9e28989d41c0eab57ec0bb156617a8757406ff8a ]

When mc13xxx_reg_read() fails, "old_adc0" is uninitialized and will
contain random value. Further execution uses "old_adc0" even when
mc13xxx_reg_read() fails.
The fix checks the return value of mc13xxx_reg_read(), and exits
the execution when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mc13xxx-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index d7f54e492aa6..6c16f170529f 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -274,7 +274,9 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
 
-	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	if (ret)
+		goto out;
 
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
 	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
-- 
2.19.1


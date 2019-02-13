Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB12C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627DB207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027131;
	bh=2sJDMnYdUvKehIT/tPh79N1tH/jECItYct89O1O5qcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQIzxtzYpziyX5DS86wMg8XYuQGgSU7P/MfsgPbcshdpwPEluh/Q9ligz0GmsKeZe
	 mCCxW5RBKhVWyHRF24+1xh2kNWVh4CU6yX7mxSHNcRvC5XNBeri+fqnHfXnyJCDR5G
	 IlTQ8ZuFVzd2fNxIBlsxibG7BxTfn4arL3L5QqLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbfBMDF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387521AbfBMCd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0A1222C7;
        Wed, 13 Feb 2019 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025237;
        bh=2sJDMnYdUvKehIT/tPh79N1tH/jECItYct89O1O5qcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppulg8go0Rhn4GIapRPAhWd8vWKlhPH35aUaqUdBK6BF2keDWn3xgZS1o/mlxmllf
         PGdtaiIumevtM/qFxexxTe1fM85HJ8t9XYb/FABZOcdlRcKa0XBfSd8PiXyBHlaPcK
         IHLXKqTsprmO2y/pkpm65MqCx2Zi23Q2vc/3lUvE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 020/105] mfd: mc13xxx: Fix a missing check of a register-read failure
Date:   Tue, 12 Feb 2019 21:32:11 -0500
Message-Id: <20190213023336.19019-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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
index f475e848252f..d0bf50e3568d 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -274,7 +274,9 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
 
-	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	if (ret)
+		goto out;
 
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
 	       MC13XXX_ADC0_CHRGRAWDIV;
-- 
2.19.1


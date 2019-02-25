Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DE22173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129310;
	bh=1/31XcU7A7igzrxDj+1sCglD3Ehn7EmbeZsy6QBmrdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1f1JKwIhHlEmeAJ7QJZTtzopfhxpPbPVB5u5z1/oG1NkEJ9tcKJfvbXnqmr2kY+mZ
	 f3t1m2Dcw9+OeLmRfJmKBzP98P7AHVBVMnuBtreqzVnytN6IbunCoTTNewY+IfK2dR
	 +zLQaj2N5SKhVqtV3VmoFfKkATBShcXck6Y3JRQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfBYVPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbfBYVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85392173C;
        Mon, 25 Feb 2019 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129305;
        bh=1/31XcU7A7igzrxDj+1sCglD3Ehn7EmbeZsy6QBmrdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLThIU23bTQt7q/Ius0fU7UJljPmeHGspybfg132e5gGOUg4aR8qqc64wjiZ0EaHN
         qKRpxyWTfBjyhfyjCDA9ZsSVvii6AIY0dfR7hFz2K7ACJW6iv0NeunxTgunjl2CmDJ
         qgdg98mVZqf8NB5uwNlt1skq58zOKKNX+7QcXdwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/63] mfd: mc13xxx: Fix a missing check of a register-read failure
Date:   Mon, 25 Feb 2019 22:11:14 +0100
Message-Id: <20190225195036.795199089@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d7f54e492aa61..6c16f170529f5 100644
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




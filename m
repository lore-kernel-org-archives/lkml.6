Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E25020821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Tpe26hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E25020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeKAIGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeKAIGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283502081B;
        Wed, 31 Oct 2018 23:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027154;
        bh=ixUZkOVKcxgbGYsuykHXlGnNiMl6OJKGDCgw9JPoNjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Tpe26hvuOmIiJZ2JnUKFBNohqafOIj/neAjBgMfVnz8/7uemFKBwd63tXweQIg/g
         17r8SJ/8EdLLCRQ0euLRsEb2rA7fctBPPJiWHWIR+47NjtDr9IStShwmogBZC/UL03
         62DElRsy8nmSuwk8tIF1BMvN4vJpDqfP2RNvJYxI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 013/146] hwmon: (pwm-fan) Set fan speed to 0 on suspend
Date:   Wed, 31 Oct 2018 19:03:28 -0400
Message-Id: <20181031230541.28822-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 95dcd64bc5a27080beaa344edfe5bdcca3d2e7dc ]

Technically this is not required because disabling the PWM should be
enough. However, when support for atomic operations was implemented in
the PWM subsystem, only actual changes to the PWM channel are applied
during pwm_config(), which means that during after resume from suspend
the old settings won't be applied.

One possible solution is for the PWM driver to implement its own PM
operations such that settings from before suspend get applied on resume.
This has the disadvantage of completely ignoring any particular ordering
requirements that PWM user drivers might have, so it is best to leave it
up to the user drivers to apply the settings that they want at the
appropriate time.

Another way to solve this would be to read back the current state of the
PWM at the time of resume. That way, in case the configuration was lost
during suspend, applying the old settings in PWM user drivers would
actually get them applied because they differ from the current settings.
However, not all PWM drivers support reading the hardware state, and not
all hardware may support it.

The best workaround at this point seems to be to let PWM user drivers
tell the PWM subsystem that the PWM is turned off by, in addition to
disabling it, also setting the duty cycle to 0. This causes the resume
operation to apply a configuration that is different from the current
configuration, resulting in the proper state from before suspend getting
restored.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pwm-fan.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7838af58f92d..9d611dd268e1 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -290,9 +290,19 @@ static int pwm_fan_remove(struct platform_device *pdev)
 static int pwm_fan_suspend(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	struct pwm_args args;
+	int ret;
+
+	pwm_get_args(ctx->pwm, &args);
+
+	if (ctx->pwm_value) {
+		ret = pwm_config(ctx->pwm, 0, args.period);
+		if (ret < 0)
+			return ret;
 
-	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
+	}
+
 	return 0;
 }
 
-- 
2.17.1


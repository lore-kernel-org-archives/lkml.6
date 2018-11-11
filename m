Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1FCC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012D5223C6
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8ezfrxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012D5223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbeKLITs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388027AbeKLITr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:47 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56A021508;
        Sun, 11 Nov 2018 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975390;
        bh=h3TfSEbPPYDqdqieFDKom+AkJz3eoMQivGVzzsT6Sck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8ezfrxmiOGRdl+Bi41esO2Ciz7NIibN+NS34q+oydMnv2I6rJrCVuCrEsHXf0i2h
         cJo8rnrZlJP1iCYhS21cgwH6SEQgRtVHQplT5EMqfu81UglOqIz7Uj33ACKFn+NHzI
         irTGz0eI0NImnrNoXzUITcY1Xo9EmDQ1unQi0ojc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 073/350] hwmon: (pwm-fan) Set fan speed to 0 on suspend
Date:   Sun, 11 Nov 2018 14:18:57 -0800
Message-Id: <20181111221710.183426835@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pwm-fan.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -290,9 +290,19 @@ static int pwm_fan_remove(struct platfor
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
 



Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A92EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ED7217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130174;
	bh=cCbrXsng21KtWN0ZpcDzLS2arC7JKI/AdsZwnthd04k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKGKkrM6ebMGUOVklNxA4UR7mFAHjjen8NktL3UpUuzEbdfkGdICdUHAzWr0DQtrh
	 n3tvOX0T2OygVpTTjGYSItJQL7M6gE2D7iyVhWXipNdRgh8IyT7IvMmurQPJSBiNIE
	 Hqig310m5X/L8g6p9mRPGw25J1cpXNuWdeU1onmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfBYV3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbfBYV3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD58E2146F;
        Mon, 25 Feb 2019 21:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130170;
        bh=cCbrXsng21KtWN0ZpcDzLS2arC7JKI/AdsZwnthd04k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/J6J69orwnHKesVur5VDEATRrlW3qeFm0N/vvKF6sUjlm1+TEEGfkIfE3STUZoAP
         izvXOxjGt3Pwj9OE1rYj6PC/j/zvj1VKGBNJWWDCl5g21ENLnUOMboxKjcGVBVd++u
         tRhZvoTebtk6Dyl44HiGo6d4Vi8pamErdMDejlts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko.stuebner@bq.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 019/183] backlight: pwm_bl: Fix devicetree parsing with auto-generated brightness tables
Date:   Mon, 25 Feb 2019 22:09:52 +0100
Message-Id: <20190225195057.957382086@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 61170ee9386888f1e6f7e9cc58e8d9a8c2a3c1dd ]

Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly
to human eye") made the parse-dt function return early when using an auto-
generated brightness-table, but didn't take into account that some more
settings were handled below the brightness handling, like power-on-delays
and also setting the pdata enable-gpio to -EINVAL.

This surfaces for example in the case of a backlight without any
enable-gpio which then tries to use gpio-0 in error.

Fix this by simply moving the trailing settings above the brightness
handling.

Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/pwm_bl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f9ef0673a083c..aded3213bfb51 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -268,6 +268,16 @@ static int pwm_backlight_parse_dt(struct device *dev,
 
 	memset(data, 0, sizeof(*data));
 
+	/*
+	 * These values are optional and set as 0 by default, the out values
+	 * are modified only if a valid u32 value can be decoded.
+	 */
+	of_property_read_u32(node, "post-pwm-on-delay-ms",
+			     &data->post_pwm_on_delay);
+	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
+
+	data->enable_gpio = -EINVAL;
+
 	/*
 	 * Determine the number of brightness levels, if this property is not
 	 * set a default table of brightness levels will be used.
@@ -380,15 +390,6 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		data->max_brightness--;
 	}
 
-	/*
-	 * These values are optional and set as 0 by default, the out values
-	 * are modified only if a valid u32 value can be decoded.
-	 */
-	of_property_read_u32(node, "post-pwm-on-delay-ms",
-			     &data->post_pwm_on_delay);
-	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
-
-	data->enable_gpio = -EINVAL;
 	return 0;
 }
 
-- 
2.19.1




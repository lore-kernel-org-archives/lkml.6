Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21B9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902D3222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025220;
	bh=j2Obfknby1/JUvOBb2SaB+q4tjNlQIBc/xuSiukqnmA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xSVlWRnW7aTaP9VAR5uzDLUfTujy2LNhfbCx95GT+Pbm+hxCol2NdG22gRZSYjITE
	 V4XGn6dAQneRyTN7qDlfzraGV6WP8nBxNdZBRx5TdBKL+WPjVDcFP0RvmMiCU7vvSA
	 WdNxmY2jNm2Dwdolwrsd3EqAb95YHBBXNZVEisBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfBMCdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbfBMCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9594222BA;
        Wed, 13 Feb 2019 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025218;
        bh=j2Obfknby1/JUvOBb2SaB+q4tjNlQIBc/xuSiukqnmA=;
        h=From:To:Cc:Subject:Date:From;
        b=c8eYeSRU7Lg2X9Hf5ME2mx3JTzJdesnlniaDIyuXt0xwxoMpRy2iFNnBH1fHJctqk
         S2e/LnKX3L9xNFp1LU7Ikc/PAc/rONNEz8cmlVVQ8Nm5/Xg31zcJhytExFa1eLtgr3
         zyGOIYChjfVvtPcPFTRbZvjDY7T3xv4hZHgINTkw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Stuebner <heiko.stuebner@bq.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 001/105] backlight: pwm_bl: Fix devicetree parsing with auto-generated brightness tables
Date:   Tue, 12 Feb 2019 21:31:52 -0500
Message-Id: <20190213023336.19019-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

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
index f9ef0673a083..aded3213bfb5 100644
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


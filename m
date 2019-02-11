Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2A0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC3020700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896412;
	bh=rU3yQ/yiG5N4lrQTEIw8EI0OGxM19J2T5onwbG3jSxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ryggomi1bitI7NS02K9aTSjkdn4frwmOK8RKoYwDNtfa172GIQuLrInGp3URvYFdY
	 E5cZnvzaKXJiRThuOAQ2UadqErk28/G6iGo0v2k7a6jqXSJzFE99XukGlZzM+B+9Xl
	 ZysuUNnECecWQ08wxFM1rjR0pTR+WduBrrS6nBG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfBKOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbfBKOqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC12B2081B;
        Mon, 11 Feb 2019 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896409;
        bh=rU3yQ/yiG5N4lrQTEIw8EI0OGxM19J2T5onwbG3jSxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0+riih2eD1TkSbU4GyLQebT0bmfNeeMciX2fqYNaZR0siH1+DbCgKSfIcDdImLCN
         AgCABgUVTbIHEX1lM6Cp1A5CLfT/dXOWwsPazskmVeqZx4nYJlK2I5/Sa9Dv1R6o5a
         UzahkU9gikjDSLsbxYG8L1/DYHiaMoxRCDvPcLhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Hsieh <paul.hsieh@amd.com>,
        Eric Yang <eric.yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 174/313] drm/amd/display: Add retry to read ddc_clock pin
Date:   Mon, 11 Feb 2019 15:17:34 +0100
Message-Id: <20190211141904.996940611@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit bd4905a9583c760da31ded7256dca6f71483c3dc ]

[WHY]
On customer board, there is one pluse (1v , < 1ms) on
DDC_CLK pin when plug / unplug DP cable. Driver will read
it and config DP to HDMI/DVI dongle.

[HOW]
If there is a real dongle, DDC_CLK should be always pull high.
Try to read again to recovery this special case. Retry times = 3.
Need additional 3ms to detect DP passive dongle(3 failures)

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7c89785fd731..23a7ef97afdd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -324,7 +324,7 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 {
 	enum gpio_result gpio_result;
 	uint32_t clock_pin = 0;
-
+	uint8_t retry = 0;
 	struct ddc *ddc;
 
 	enum connector_id connector_id =
@@ -353,11 +353,22 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 		return present;
 	}
 
-	/* Read GPIO: DP sink is present if both clock and data pins are zero */
-	/* [anaumov] in DAL2, there was no check for GPIO failure */
-
-	gpio_result = dal_gpio_get_value(ddc->pin_clock, &clock_pin);
-	ASSERT(gpio_result == GPIO_RESULT_OK);
+	/*
+	 * Read GPIO: DP sink is present if both clock and data pins are zero
+	 *
+	 * [W/A] plug-unplug DP cable, sometimes customer board has
+	 * one short pulse on clk_pin(1V, < 1ms). DP will be config to HDMI/DVI
+	 * then monitor can't br light up. Add retry 3 times
+	 * But in real passive dongle, it need additional 3ms to detect
+	 */
+	do {
+		gpio_result = dal_gpio_get_value(ddc->pin_clock, &clock_pin);
+		ASSERT(gpio_result == GPIO_RESULT_OK);
+		if (clock_pin)
+			udelay(1000);
+		else
+			break;
+	} while (retry++ < 3);
 
 	present = (gpio_result == GPIO_RESULT_OK) && !clock_pin;
 
-- 
2.19.1




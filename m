Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46429C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CD920989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691685;
	bh=ld7pbqgxEhgM6nFJUyr+6nZ/445YS85GwL8BJ/zm5tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CQG47K5v+FeKfJpNWvNEConkgslnGmJsqWtYgs2PjfIFZ2mc/MYzxsqLk/hmgiyVN
	 RifShj/jVOi5UT2IPrWooaCKnKi2b3OrkdocAhaAIEGOIUVODiElKg4bzkP8H3zS1l
	 j2WUiSudIG2Wt0/Vs86b0R4s1xF64Rzm30qcVqdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfA1QID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732293AbfA1QIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3952520989;
        Mon, 28 Jan 2019 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691680;
        bh=ld7pbqgxEhgM6nFJUyr+6nZ/445YS85GwL8BJ/zm5tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J43yEF4iCoI8FKHtX9eLLvdpbYaJ6GE4RHkIeNJmKu8ba8Y741wSXJ8ZoK+hRTfZX
         eYIn6igwbQwKxOTYuMABz1ffRgy63qNa1YmLQUiFhRpV1BI6OPzpOssfkOKrH6q+uW
         YVYjtl+XTq3/Z3GsyhHcq2jjWLV4rvDvTXDBOAFs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Hsieh <paul.hsieh@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 183/258] drm/amd/display: Add retry to read ddc_clock pin
Date:   Mon, 28 Jan 2019 10:58:09 -0500
Message-Id: <20190128155924.51521-183-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Hsieh <paul.hsieh@amd.com>

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


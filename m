Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F620855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690875;
	bh=bMj8qaKxvY4JOO+wl57mbdcLXtMvn+gcpzQv/7F2XvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFUgICpYHnSPzJd0peU2BZqy6FAAzk9zYm2jG1En9j3h9Sj/FSZHbsI1cBTSL9GSU
	 xxJsrtx8FsTxGFDvrkzMuTPet5XSQONazeTSUI1IJjc496PAc9QdZPPRVcKWuD6DXX
	 anI+3Yts4KjGD6Inu2D9wA5kzOtArKnc2o8VRAB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfA1Pyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfA1Pya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F9020855;
        Mon, 28 Jan 2019 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690870;
        bh=bMj8qaKxvY4JOO+wl57mbdcLXtMvn+gcpzQv/7F2XvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=If3cVqlvIZ6UztG/601o+B/zwrZ8SkNX4JiLKSGcfOgC9BDlgK+Qn7Y8jRPdJKYfI
         8GJhMW06We5jcWikBH3Tz2mCDt/Tacm5N4MgNkzEDhHZNIFw8JDw8kXEBJKTekzF83
         +h1Jibt6ms43jCGrY8e3j5hAjFwK9jOUCV5k1KZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Hsieh <paul.hsieh@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 218/304] drm/amd/display: Add retry to read ddc_clock pin
Date:   Mon, 28 Jan 2019 10:42:15 -0500
Message-Id: <20190128154341.47195-218-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index 5141c1401889..ef1b350a45e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -332,7 +332,7 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 {
 	enum gpio_result gpio_result;
 	uint32_t clock_pin = 0;
-
+	uint8_t retry = 0;
 	struct ddc *ddc;
 
 	enum connector_id connector_id =
@@ -361,11 +361,22 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
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


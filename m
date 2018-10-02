Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB47C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3B6206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3B6206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJBUKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeJBUKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:08 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4846266;
        Tue,  2 Oct 2018 13:26:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 025/228] drm/amd/display/dc/dce: Fix multiple potential integer overflows
Date:   Tue,  2 Oct 2018 06:22:02 -0700
Message-Id: <20181002132500.774246821@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 6f3472a993e7cb63cde5d818dcabc8e42fc03744 ]

Add suffix ULL to constant 5 and cast variables target_pix_clk_khz and
feedback_divider to uint64_t in order to avoid multiple potential integer
overflows and give the compiler complete information about the proper
arithmetic to use.

Notice that such constant and variables are used in contexts that
expect expressions of type uint64_t (64 bits, unsigned). The current
casts to uint64_t effectively apply to each expression as a whole,
but they do not prevent them from being evaluated using 32-bit
arithmetic instead of 64-bit arithmetic.

Also, once the expressions are properly evaluated using 64-bit
arithmentic, there is no need for the parentheses that enclose
them.

Addresses-Coverity-ID: 1460245 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1460286 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1460401 ("Unintentional integer overflow")
Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -133,7 +133,7 @@ static bool calculate_fb_and_fractional_
 	uint64_t feedback_divider;
 
 	feedback_divider =
-		(uint64_t)(target_pix_clk_khz * ref_divider * post_divider);
+		(uint64_t)target_pix_clk_khz * ref_divider * post_divider;
 	feedback_divider *= 10;
 	/* additional factor, since we divide by 10 afterwards */
 	feedback_divider *= (uint64_t)(calc_pll_cs->fract_fb_divider_factor);
@@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_
  * of fractional feedback decimal point and the fractional FB Divider precision
  * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))*/
 
-	feedback_divider += (uint64_t)
-			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
+	feedback_divider += 5ULL *
+			    calc_pll_cs->fract_fb_divider_precision_factor;
 	feedback_divider =
 		div_u64(feedback_divider,
 			calc_pll_cs->fract_fb_divider_precision_factor * 10);
@@ -203,8 +203,8 @@ static bool calc_fb_divider_checking_tol
 			&fract_feedback_divider);
 
 	/*Actual calculated value*/
-	actual_calc_clk_khz = (uint64_t)(feedback_divider *
-					calc_pll_cs->fract_fb_divider_factor) +
+	actual_calc_clk_khz = (uint64_t)feedback_divider *
+					calc_pll_cs->fract_fb_divider_factor +
 							fract_feedback_divider;
 	actual_calc_clk_khz *= calc_pll_cs->ref_freq_khz;
 	actual_calc_clk_khz =



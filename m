Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD34EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A0E208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A0E208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeGDNWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:22:44 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.12]:39376 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752732AbeGDNWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:22:43 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id A9A14400DA8BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 07:23:29 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ahjcf226IBcCXahjsflMuQ; Wed, 04 Jul 2018 08:22:42 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=55390 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fahjb-003auB-Pd; Wed, 04 Jul 2018 08:22:15 -0500
Date:   Wed, 4 Jul 2018 08:22:11 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] drm/amd/display/dc/dce: Fix multiple potential integer
 overflows
Message-ID: <20180704132211.GA6764@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fahjb-003auB-Pd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:55390
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes in v2:
 - Add suffix ULL to constant 5 instead of UL. Thanks to Michel Dänzer
   for pointing this out.

 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 88b09dd..ca13775 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -133,7 +133,7 @@ static bool calculate_fb_and_fractional_fb_divider(
 	uint64_t feedback_divider;
 
 	feedback_divider =
-		(uint64_t)(target_pix_clk_khz * ref_divider * post_divider);
+		(uint64_t)target_pix_clk_khz * ref_divider * post_divider;
 	feedback_divider *= 10;
 	/* additional factor, since we divide by 10 afterwards */
 	feedback_divider *= (uint64_t)(calc_pll_cs->fract_fb_divider_factor);
@@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_fb_divider(
  * of fractional feedback decimal point and the fractional FB Divider precision
  * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))*/
 
-	feedback_divider += (uint64_t)
-			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
+	feedback_divider += 5ULL *
+			    calc_pll_cs->fract_fb_divider_precision_factor;
 	feedback_divider =
 		div_u64(feedback_divider,
 			calc_pll_cs->fract_fb_divider_precision_factor * 10);
@@ -203,8 +203,8 @@ static bool calc_fb_divider_checking_tolerance(
 			&fract_feedback_divider);
 
 	/*Actual calculated value*/
-	actual_calc_clk_khz = (uint64_t)(feedback_divider *
-					calc_pll_cs->fract_fb_divider_factor) +
+	actual_calc_clk_khz = (uint64_t)feedback_divider *
+					calc_pll_cs->fract_fb_divider_factor +
 							fract_feedback_divider;
 	actual_calc_clk_khz *= calc_pll_cs->ref_freq_khz;
 	actual_calc_clk_khz =
-- 
2.7.4


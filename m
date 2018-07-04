Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D61C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B58321CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BKU6GmaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B58321CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeGDR1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:27:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45816 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:27:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id bi1-v6so64036plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SzLd4PuifEW6TplbKQ3BmovPHZPt1RJMWIXP+2KxwSI=;
        b=BKU6GmaNF3vW7I5x+2cq+vyW/ZtgqRKfuQd8my5qzTBMBdeYEVBI8+jm+n/vOluwU7
         VYe5YpFd2tFAq2OqA4AwXWrdsWO8rRFguIJnWVixf41yIaDAMyvzsAsqwbkZpv1pOVIR
         EE/kz5V64Q+3+UlHH23gYKPMKQ66LfZFDzWpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SzLd4PuifEW6TplbKQ3BmovPHZPt1RJMWIXP+2KxwSI=;
        b=aoxreEkEw7muNPR3e6TC1GSAHhCPNFGpuYiNYWeA4ih0N3E04q0NSB7HDdqiCuF2vR
         85THoJefTS5HoqjH8uR8b1dBEA0NZolwpGIMls4jBMiSQbYtRsBY7Oz1J2AB1w631Izk
         uUHi+HTkU67snaL1xKsYDA1Lg7URSILN6WAnLiUh8xfx4tcZQuH8ZmerlYAAc8pA7lmJ
         y1/iPOT0DbN/CLicGf+2ZQyO+M0tHFoUqLIoeQrU/Huy0kMM3KkTWtMtFR5j30XJPas8
         DqWp7pyG5s+6iqqicTjS8MurvwWT6vt1xzZ0TjsDfII/gx2wM9g5l9u7XdB88KEQWTKE
         H2og==
X-Gm-Message-State: APt69E2cR3z+wAMbSEItvGo4arGoCGN/nl77hulrqZm9at6IhQprMhW7
        3L+BJH5WToppJec25HO3CuluVQ==
X-Google-Smtp-Source: AAOMgpe2G6xrjkS3y8QMk5EaTQtCQ5wYPm/bh4vjXtWocBahpfMbmscwFs7kgQZr97r8xGwDNfziLg==
X-Received: by 2002:a17:902:5501:: with SMTP id f1-v6mr2942884pli.108.1530725252202;
        Wed, 04 Jul 2018 10:27:32 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v1-v6sm8670349pfg.101.2018.07.04.10.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:27:30 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:27:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Vitaly Prosyak <vitaly.prosyak@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Use 2-factor allocator calls
Message-ID: <20180704172730.GA33562@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done treewide, switch from open-coded multiplication to
2-factor allocation helper.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 98edaefa2b47..ee69c949bfbf 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1723,8 +1723,8 @@ bool  mod_color_calculate_curve(enum dc_transfer_func_predefined trans,
 		kvfree(rgb_regamma);
 	} else if (trans == TRANSFER_FUNCTION_HLG ||
 		trans == TRANSFER_FUNCTION_HLG12) {
-		rgb_regamma = kvzalloc(sizeof(*rgb_regamma) *
-				       (MAX_HW_POINTS + _EXTRA_POINTS),
+		rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
+				       sizeof(*rgb_regamma),
 				       GFP_KERNEL);
 		if (!rgb_regamma)
 			goto rgb_regamma_alloc_fail;
@@ -1802,8 +1802,8 @@ bool  mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
 		kvfree(rgb_degamma);
 	} else if (trans == TRANSFER_FUNCTION_HLG ||
 		trans == TRANSFER_FUNCTION_HLG12) {
-		rgb_degamma = kvzalloc(sizeof(*rgb_degamma) *
-				       (MAX_HW_POINTS + _EXTRA_POINTS),
+		rgb_degamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
+				       sizeof(*rgb_degamma),
 				       GFP_KERNEL);
 		if (!rgb_degamma)
 			goto rgb_degamma_alloc_fail;
-- 
2.17.1


-- 
Kees Cook
Pixel Security

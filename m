Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC33C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1854420645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="vzlIhNc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1854420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJCVNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:13:54 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:37094 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJCVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:13:53 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 8F6D9B015F2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 16:25:14 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1538576714; x=1539440715; bh=7U
        wdoFW2CQdKadRJsmaRWXkSXt2cuY/sccYjH4avVRo=; b=vzlIhNc5KplcNGUvf7
        EhrcDLvqnL9A7k6ba/jADSy44mrB1eo08nZ4LQuqPMAKmaOolEERpnlI2B7lX/f9
        ex0c9h9py+W/0loO32eUBh7ow4viz7sQdQ3iIfSGMPx9El2cphVXuXqGl7UOO19N
        O18ikEn/a+9mFOrVch7E9Cz3w=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R2eMN_B0VV6O for <linux-kernel@vger.kernel.org>;
        Wed,  3 Oct 2018 16:25:14 +0200 (CEST)
Received: from localhost.localdomain (host128-8-dynamic.21-79-r.retail.telecomitalia.it [79.21.8.128])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 36D6BB00C6C;
        Wed,  3 Oct 2018 16:25:12 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 2/2] drm/sun4i: tcon: prevent tcon->panel dereference if null
Date:   Wed,  3 Oct 2018 16:24:58 +0200
Message-Id: <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using tcon with VGA, tcon->panel will be null(0), this will cause
segmentation fault when trying to dereference tcon->panel->connector.

Add tcon->panel null check before calling
sun4i_tcon0_mode_set_dithering().

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
                      RGB565/RGB666 LCD panels")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes V1->V2:
* none

 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e4b3bd0307ef..f949287d926c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -491,7 +491,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Set dithering if needed */
-	sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
+	if (tcon->panel)
+		sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
-- 
2.17.1


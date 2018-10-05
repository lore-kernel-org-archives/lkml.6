Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD83C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DA9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="PfA88pu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DA9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJFFAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:00:38 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45194 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJFFAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:00:37 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 57B17B00748
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 23:59:56 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1538776795; x=1539640796; bh=RT
        dTDc9aj5yU4rsjgtCJV/wCZutXTyJKHh4YN8AE/DM=; b=PfA88pu1Ubco24Rq4B
        YjfcW7+gNS4SfYi8Q2xN1YAVMHa1hsjytQGdXv70DoDQviZmIjOkt3cCCDPpey9j
        Ncor0XJ9F0dyqKJ07EYls3SPbMM0i5Ar9+/NS5uSv3SrHu1JvSz+utO0hPImu4mN
        1Oi38+4mfOzUDVVVJXK41XX1g=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Aq0_FqgMUU96 for <linux-kernel@vger.kernel.org>;
        Fri,  5 Oct 2018 23:59:55 +0200 (CEST)
Received: from ubuntu.localdomain (unknown [192.168.123.60])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 29F3FB0040F;
        Fri,  5 Oct 2018 23:59:54 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference if NULL
Date:   Fri,  5 Oct 2018 23:59:51 +0200
Message-Id: <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
References: <20181004195605.txvbkshvxklyzxyb@flea>
 <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tcon->panel pointer is NULL, trying to dereference from it
(i.e. tcon->panel->connector) will cause a null pointer dereference.

Add tcon->panel null pointer check before calling
sun4i_tcon0_mode_set_dithering().

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
                      RGB565/RGB666 LCD panels")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes V1->V2:
* None

Changes V2->V3:
* Rewrite commit log

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


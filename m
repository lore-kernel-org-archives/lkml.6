Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC40BC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0372083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="DAtr3yRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0372083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeJCEoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:44:54 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:35798 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJCEox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:44:53 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id B81C0B00750
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 23:59:22 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1538517562; x=1539381563; bh=4F
        HVT5NrrG/QTe2Mj+ppLwr5ncrmz/fzttP4uUPdogc=; b=DAtr3yRK22EQBy7xQq
        pDYfF6I6uvGA9K+e3Y/nczV/VeNDsWkPoLVDYKZdd9wJf0y+mzy0S1heaqBNZZyp
        0PfJCJuWaD+rwgbiVno0XgskYT/3xkDNAwDsp8RuZxKUl5eYsz/1FlEgmqQz0zWi
        U75I01TLX6fClc4zdedvkaqjI=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2b80q05x1Ukd for <linux-kernel@vger.kernel.org>;
        Tue,  2 Oct 2018 23:59:22 +0200 (CEST)
Received: from ubuntu.localdomain (146-241-101-147.dyn.eolo.it [146.241.101.147])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id B4A03B00A71;
        Tue,  2 Oct 2018 23:59:20 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 2/2] drm/sun4i: tcon: prevent tcon->panel dereference if null
Date:   Tue,  2 Oct 2018 23:59:17 +0200
Message-Id: <20181002215917.1849-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
References: <20181001093612.GA13672@mwanda>
 <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using tcon with VGA, tcon->panel will be null(0), this will cause
segmentation fault when trying to dereference tcon->panel->connector.

Add tcon->panel null check before calling
sun4i_tcon0_mode_set_dithering().

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
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


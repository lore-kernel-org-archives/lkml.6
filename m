Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF594C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824F520652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="IqN8RKyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824F520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJCDeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:34:18 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:36338 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCDeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:34:18 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 5CA2BB00C6C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 22:49:04 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1538513343; x=1539377344; bh=0a
        zMu6Ww48q352jv+MAfjeImAqkhQeep+ozCDFqNfv8=; b=IqN8RKyC2OmkbT0Y29
        fV9HT2AAv2h0j8vm/Gygm7JE1YqZqc7uGCLcz+IxlEKpdz4HUd+79+9IBhK/7Rzg
        50Z9FFxekDwx+tShp07XBKdzkpCXd2psc/zLH/KYTgWP//x6Kwu/AvSjfZ5/Bve7
        zdeQ77RsWGiaUmgXwzAc+tUI8=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n2NSBXYMnKqD for <linux-kernel@vger.kernel.org>;
        Tue,  2 Oct 2018 22:49:03 +0200 (CEST)
Received: from ubuntu.localdomain (146-241-101-147.dyn.eolo.it [146.241.101.147])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id D3145B00765;
        Tue,  2 Oct 2018 22:49:02 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
Date:   Tue,  2 Oct 2018 22:48:59 +0200
Message-Id: <20181002204900.82118-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001093612.GA13672@mwanda>
References: <20181001093612.GA13672@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
has been used, but that macro doesn't check if tcon->panel pointer is
null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).

Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
condition to check if it's a pointer not null.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c78cd35a1294..e4b3bd0307ef 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -555,7 +555,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	 * Following code is a way to avoid quirks all around TCON
 	 * and DOTCLOCK drivers.
 	 */
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		struct drm_panel *panel = tcon->panel;
 		struct drm_connector *connector = panel->connector;
 		struct drm_display_info display_info = connector->display_info;
-- 
2.17.1


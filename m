Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D56EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6FA21B18
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738204;
	bh=923VAq5wfmrlWu4BdlknfhQsjN27obEOgf7TviYoBcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vAQchtx3f1WefDVWLhHe1MAyVDrKphCeDcs+LkFWNfo/R18UCdMzIL5Io25LJfISL
	 eSGsNBhOk9M/BX2GlY9octgyhn/sgCT1qskEVKgoCdPsa704OIf2iRjiZraEaxzuHq
	 yHm5zam945TviyomIu8AZ0OZW/FZm9VthJ2qRUbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfBISuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfBISuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:50:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2407B2192D;
        Sat,  9 Feb 2019 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738199;
        bh=923VAq5wfmrlWu4BdlknfhQsjN27obEOgf7TviYoBcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H5/+3IqWjkcGK5n/gqfQRa74beNel6KD10MmIs0eRV0oNVpT+z5zw5IM/awc/EI8i
         xhAeUsqAGzVcXvchiW9S/7k0Rp3DKqJmAcn4F4qUePTLIQJdQGwvZtjFqwxttTojVn
         F9BQzngpdoDgB0gd5Ah8QSiNFWwGWBkk83ndnIhE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 06/12] drm/bridge: tc358767: reject modes which require too much BW
Date:   Sat,  9 Feb 2019 13:49:46 -0500
Message-Id: <20190209184952.127009-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184952.127009-1-sashal@kernel.org>
References: <20190209184952.127009-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 51b9e62eb6950c762162ab7eb8390990179be067 ]

The current driver accepts any videomode with pclk < 154MHz. This is not
correct, as with 1 lane and/or 1.62Mbps speed not all videomodes can be
supported.

Add code to reject modes that require more bandwidth that is available.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-6-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index dbe403ea130d..16fa42984c50 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1118,10 +1118,20 @@ static bool tc_bridge_mode_fixup(struct drm_bridge *bridge,
 static int tc_connector_mode_valid(struct drm_connector *connector,
 				   struct drm_display_mode *mode)
 {
+	struct tc_data *tc = connector_to_tc(connector);
+	u32 req, avail;
+	u32 bits_per_pixel = 24;
+
 	/* DPI interface clock limitation: upto 154 MHz */
 	if (mode->clock > 154000)
 		return MODE_CLOCK_HIGH;
 
+	req = mode->clock * bits_per_pixel / 8;
+	avail = tc->link.base.num_lanes * tc->link.base.rate;
+
+	if (req > avail)
+		return MODE_BAD;
+
 	return MODE_OK;
 }
 
-- 
2.19.1


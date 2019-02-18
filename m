Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE2720842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498381;
	bh=RRILu61irN4bFL2WiU+tmrp12Sb8Z1ma6krtLXf/SwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CcWy08xzJ5xmUNOgv1Z7gR4oR7xZ8RAGIhR89NJ4bbNuxtGgEu5sgl2YkwgETcL/e
	 OZW31iIDwg0clg6nPOOagqCLYF7oH5RI7qLdi/7FypB0oycE0zqeWv+QeHXp9NFKLn
	 ibTVI+uBWACYkrxvhNJFxZKV9h3QMUZeJkttjq/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbfBRN7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731082AbfBRN7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1672070D;
        Mon, 18 Feb 2019 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498376;
        bh=RRILu61irN4bFL2WiU+tmrp12Sb8Z1ma6krtLXf/SwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzizNkE1C82F/T5EKNmCe60nOVpIcabJJI9KpYIGLx6h3nJsDCeiMmJ4cu0APOwOk
         iIa4O7fnRoZvI0oCWKK9AzqqNPeX196QyoxDsVTJcC0c0q0beTfaCOX4usPWDMeI0V
         fPfctfMhzcCEfZ+IAMXgdgmWfavyIRQY31X3cUhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/58] drm/bridge: tc358767: reject modes which require too much BW
Date:   Mon, 18 Feb 2019 14:43:48 +0100
Message-Id: <20190218133510.679505608@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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




Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B98C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDF621736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500904;
	bh=pPQfWv93NPWxErr5ZZ5SDttthYS9Uk0v1kDK7/WX54A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EckLfh+q2Fxmur8v/ceniVwVfqOTTtViiGRIxhCbF/u667JheVePS62ZiYrBD9DoB
	 PmK5wcw+0ra8WFR+AtA6i+YWT+mj2F17j2sQHlLGj/fzzf0cFE2wWoCL0IXo7NuALH
	 xe663BzYqXUzw8c2xe+zbsE5kqT0xHLnEa5kyVvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfBROln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfBRNu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D8120842;
        Mon, 18 Feb 2019 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497857;
        bh=pPQfWv93NPWxErr5ZZ5SDttthYS9Uk0v1kDK7/WX54A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMtosAvPrcGGSqIEWXD2Oq6Mkljb/WKHfHH1LvWuZ0dYeOQLzDJb+cc1zl3oaISGW
         3CMtiSvdQq5yKWNrMYQ9X0hylhwIpnDm0ceOkqKFx3WDhy9uuoRLiCfsSS8sFVPDCf
         MekoaBE5jUARbIqL9DnFWAgf7NeyvR9elRiVvHCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 32/85] drm/bridge: tc358767: reject modes which require too much BW
Date:   Mon, 18 Feb 2019 14:42:58 +0100
Message-Id: <20190218133503.314243905@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index ab299f4debfa..a1f3dd2afbb1 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1114,10 +1114,20 @@ static bool tc_bridge_mode_fixup(struct drm_bridge *bridge,
 static enum drm_mode_status tc_connector_mode_valid(struct drm_connector *connector,
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




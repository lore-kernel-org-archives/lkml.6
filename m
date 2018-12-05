Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF09EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD601206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD601206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeLEIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:38:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36363 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbeLEIiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:38:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE97A20EDE; Wed,  5 Dec 2018 09:38:01 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 89B7220E20;
        Wed,  5 Dec 2018 09:37:30 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 22/22] drm/sun4i: frontend: Add A20-specific device-tree compatible and quirks
Date:   Wed,  5 Dec 2018 09:37:03 +0100
Message-Id: <20181205083703.21488-23-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the appropriate device-tree compatible and quirk data for
hooking frontend support for the A20. It supports the FIR coefficients
ready bit but not the access control bit. It also takes different phase
values than the A33 for these coefficients.

The compatible is already used in the A20 device-tree and already
documented in the device-tree bindings.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 4a215d5202e2..a1a4108f226e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -682,6 +682,20 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 	.runtime_suspend	= sun4i_frontend_runtime_suspend,
 };
 
+static const struct sun4i_frontend_data sun7i_a20_frontend = {
+	.ch_phase		= {
+		{
+			.horzphase = 0,
+			.vertphase = { 0, 0 },
+		},
+		{
+			.horzphase = 0xfc000,
+			.vertphase = { 0xfc000, 0xfc000 },
+		},
+	},
+	.has_coef_rdy		= true,
+};
+
 static const struct sun4i_frontend_data sun8i_a33_frontend = {
 	.ch_phase		= {
 		{
@@ -697,6 +711,10 @@ static const struct sun4i_frontend_data sun8i_a33_frontend = {
 };
 
 const struct of_device_id sun4i_frontend_of_table[] = {
+	{
+		.compatible = "allwinner,sun7i-a20-display-frontend",
+		.data = &sun7i_a20_frontend
+	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-frontend",
 		.data = &sun8i_a33_frontend
-- 
2.19.2


Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC28AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F120867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Qo6CwF6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640F120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIEJuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:50:15 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56352 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeIEJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:50:14 -0400
Received: from trochilidae.hsd1.wa.comcast.net (unknown [IPv6:2601:602:8700:fb00:81ae:bc59:4e6c:42ca])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C25985C08EA;
        Wed,  5 Sep 2018 07:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536124907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KIBq2se+BEfphiFB7pouI3zXyQllgVDMISiFCoVJ98=;
        b=Qo6CwF6r8bjJMOCthyFZrw1WEMtUIekqZhQXqXcWGIfL72XfArVZqDG0YC4UwdyBLyqUvF
        et7LD85/vr4W4tweccmVgvAPC0k8oa6EJ+cEx41eoymnL4pt3my23ZBjMWlcTRVpp2XBtP
        cLWcCh4KFk4CYE4fGZwGYC1HNuVBhaI=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 4/6] drm/imx: support handling bridge timings bus flags
Date:   Tue,  4 Sep 2018 22:21:11 -0700
Message-Id: <20180905052113.21262-4-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905052113.21262-1-stefan@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bridge might require specific settings for the pixel data on
the bus. Copy the bus flags from the bridge timings if a bridge
is in use.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/imx/parallel-display.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index aefd04e18f93..ee5840cdb9ab 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -239,6 +239,13 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret && ret != -ENODEV)
 		return ret;
 
+	if (imxpd->bridge) {
+		const struct drm_bridge_timings *btimings = imxpd->bridge->timings;
+
+		if (btimings)
+			imxpd->bus_flags = btimings->bus_flags;
+	}
+
 	imxpd->dev = dev;
 
 	ret = imx_pd_register(drm, imxpd);
-- 
2.18.0


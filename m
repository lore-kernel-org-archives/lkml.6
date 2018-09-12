Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF19DC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1520854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="S0mkYjfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB1520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeILXir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:47 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52632 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeILXiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:46 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7CA805C1C76;
        Wed, 12 Sep 2018 20:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcX/PdCdJQ3pDOqukhkEsmqARVtOTh31TZdX94BkiFg=;
        b=S0mkYjfvLl70FLxbvz7DvbtK7Y4lhV0Vmz8SkdcuU7LQvyXGIvE1KRRLrt5nhgOMt43Rbc
        /+gXszVwpDAp0SO7pZGAZlSbj5gEksRnApVujSiPywedxEswXLHleZeLKAPnCOHa13f0/o
        ulWMA4gMDUSeRYXg8nThq8CRJgFF5mc=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 6/8] drm/imx: support handling bridge timings bus flags
Date:   Wed, 12 Sep 2018 11:32:20 -0700
Message-Id: <20180912183222.25414-7-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bridge might require specific settings for the pixel data on
the bus. Copy the bus flags from the bridge timings if a bridge
is in use.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/imx/parallel-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index aefd04e18f93..7798a0621df7 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -239,6 +239,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret && ret != -ENODEV)
 		return ret;
 
+	if (imxpd->bridge && imxpd->bridge->timings)
+		imxpd->bus_flags = imxpd->bridge->timings->input_bus_flags;
+
 	imxpd->dev = dev;
 
 	ret = imx_pd_register(drm, imxpd);
-- 
2.18.0


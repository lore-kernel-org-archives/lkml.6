Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06B92146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06B92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeGQJYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:24:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57579 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbeGQJYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:24:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A74062093A; Tue, 17 Jul 2018 10:53:12 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 64B7F20733;
        Tue, 17 Jul 2018 10:53:02 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/2] drm/sun4i: sun4i: Register quirks with the backend structure
Date:   Tue, 17 Jul 2018 10:52:29 +0200
Message-Id: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prevision for introducing a new quirk that will be used at atomic
plane check time, register the quirks structure with the backend
structure. This way, it can easily be grabbed where needed.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 ++
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 17dca4df00f2..a3cc398d4d80 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -909,6 +909,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 				    : SUN4I_BACKEND_MODCTL_OUT_LCD0));
 	}
 
+	backend->quirks = quirks;
+
 	return 0;
 
 err_disable_ram_clk:
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index e33be2307c67..71de6147b483 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -187,6 +187,8 @@ struct sun4i_backend {
 	/* Protects against races in the frontend teardown */
 	spinlock_t		frontend_lock;
 	bool			frontend_teardown;
+
+	const struct sun4i_backend_quirks	*quirks;
 };
 
 static inline struct sun4i_backend *
-- 
2.17.1


Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF3820856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF3820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbeGSIvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:51:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54117 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbeGSIvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:51:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 27DD0207B4; Thu, 19 Jul 2018 10:09:15 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id DBEB9206EE;
        Thu, 19 Jul 2018 10:09:14 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH RESEND v2 1/2] drm/sun4i: sun4i: Register quirks with the backend structure
Date:   Thu, 19 Jul 2018 10:08:37 +0200
Message-Id: <20180719080838.31598-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prevision for introducing a new quirk that will be used at atomic
plane check time, register the quirks structure with the backend
structure. This way, it can easily be grabbed where needed.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---

Version 2 of this series was resent to include this patch, that was
missing from the original v2 submission but is still very much needed.

 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 ++
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index de0a76dfa1a2..075cb0ff56ca 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -882,6 +882,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 				    : SUN4I_BACKEND_MODCTL_OUT_LCD0));
 	}
 
+	backend->quirks = quirks;
+
 	return 0;
 
 err_disable_ram_clk:
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 4caee0392fa4..ad6609323f0e 100644
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
2.18.0

